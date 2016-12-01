# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  email      :string
#  premium    :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_many :visited_urls,
    Proc.new { distinct },
    through: :visits,
    source: :visited_url

  has_many :visits,
    class_name: :Visit,
    primary_key: :id,
    foreign_key: :user_id

  has_many :submitted_urls,
           class_name: :ShortenedUrl,
           primary_key: :id,
           foreign_key: :user_id

end
