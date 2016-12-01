class ChangeShortenedUrlAddUserId < ActiveRecord::Migration[5.0]
  def change
    add_column :shortened_urls, :user_id, :integer
  end
end
