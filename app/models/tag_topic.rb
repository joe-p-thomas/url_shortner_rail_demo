# == Schema Information
#
# Table name: tag_topics
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic      :string
#

class TagTopic < ActiveRecord::Base

  has_many :taggings,
    class_name: :Tagging,
    primary_key: :id,
    foreign_key: :tag_topic_id

  has_many :urls,
    through: :taggings,
    source: :url

end
