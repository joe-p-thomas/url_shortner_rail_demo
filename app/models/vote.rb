# == Schema Information
#
# Table name: votes
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#  shortened_url_id :integer
#  vote             :integer
#

class Vote < ActiveRecord::Base
  validates_uniqueness_of :shortened_url_id, scope: :user_id
  validates :shortened_url_id, :user_id, presence: true
  validate :not_cool_to_brag

  belongs_to :voters,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id

  belongs_to :urls,
    class_name: :ShortenedUrl,
    primary_key: :id,
    foreign_key: :shortened_url_id

  def self.upvote(user, shortened_url)
    Vote.create!(user_id: user.id, shortened_url_id: shortened_url.id, vote: 1)
  end

  def self.downvote(user, shortened_url)
    Vote.create!(user_id: user.id, shortened_url_id: shortened_url.id, vote: -1)
  end

  private
  def not_cool_to_brag
    shortened_url = ShortenedUrl.find_by_id(shortened_url_id)
    errors[:not_cool] << "because you are voting on yourself" if
      shortened_url.user_id == user_id
  end
end
