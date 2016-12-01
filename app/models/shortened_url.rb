# == Schema Information
#
# Table name: shortened_urls
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  long_url   :string
#  short_url  :string
#  user_id    :integer
#

class ShortenedUrl < ActiveRecord::Base
  validates :long_url, length: { maximum: 1024 }
  validates :long_url, :short_url, :user_id, presence: true
  validates :short_url, uniqueness: true
  validate :too_frequent_url_submissions

  belongs_to :submitter,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id

  has_many :visits,
    Proc.new { distinct },
    class_name: :Visit,
    primary_key: :id,
    foreign_key: :shortened_url_id

  has_many :visitors,
    through: :visits,
    source: :visitor

  has_many :taggings,
    class_name: :Tagging,
    primary_key: :id,
    foreign_key: :shortened_url_id

  has_many :tag_topics,
    through: :taggings,
    source: :tag_topic

  has_many :votes,
    class_name: :Vote,
    primary_key: :id,
    foreign_key: :shortened_url_id

  def self.random_code
    while true
      code = SecureRandom::urlsafe_base64
      return code unless self.exists?(:short_url => code)
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    url = user.premium ? RandomWordGenerator.word : self.random_code
    self.create!(user_id: user.id, long_url: long_url, short_url: url)
  end

  # TODO ShortenedUrl#num_clicks, #num_uniques, #num_recent_uniques

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visits.select(:user_id).count
  end

  def num_recent_uniques
    self.visits.select(:user_id)
    .where("created_at >= ?", 10.minutes.ago)
    .count
  end

  def self.purge
    # ShortenedUrl.where("created_at <= ?", 1.minutes.ago).destroy_all
    ShortenedUrl.joins("LEFT OUTER JOIN users ON users.id = shortened_urls.user_id")
    .where("shortened_urls.created_at <= ? AND users.premium IS FALSE", 1.minutes.ago).destroy_all
  end

  def self.top
    Vote
    .joins("LEFT OUTER JOIN shortened_urls ON votes.shortened_url_id = shortened_urls.id")
    .group("shortened_urls.long_url")
    .order("SUM(votes.vote) DESC")
    .sum(:vote)
  end

  def self.hot
    Vote
    .joins("LEFT OUTER JOIN shortened_urls ON votes.shortened_url_id = shortened_urls.id")
    .where("votes.created_at >= ?", 5.minutes.ago)
    .group("shortened_urls.long_url")
    .order("SUM(votes.vote) DESC")
    .sum(:vote)
  end

  private

  def too_frequent_url_submissions
    return true if User.find_by_id(user_id).premium
    count = ShortenedUrl
    .select(:user_id)
    .where("created_at >= ? AND user_id = ?", 1.minutes.ago, user_id)
    .count

    if count >= 5
      errors[:frequency] << "too high (no more than 5 urls per minute)"
    end
  end
end
