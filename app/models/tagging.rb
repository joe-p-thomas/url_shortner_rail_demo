# == Schema Information
#
# Table name: taggings
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  shortened_url_id :integer
#  tag_topic_id     :integer
#

class Tagging < ActiveRecord::Base
  validates_uniqueness_of :shortened_url_id, scope: :tag_topic_id
  validates :shortened_url_id, :tag_topic_id, presence: true

  belongs_to :tag_topic,
    class_name: :TagTopic,
    primary_key: :id,
    foreign_key: :tag_topic_id

  belongs_to :url,
    class_name: :ShortenedUrl,
    primary_key: :id,
    foreign_key: :shortened_url_id

  def self.create_taggings!(tag_topic, shortened_url)
    Tagging.create!(tag_topic_id: tag_topic.id, shortened_url_id: shortened_url.id)
  end
end
