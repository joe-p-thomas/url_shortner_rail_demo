class CreateTagTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_topics do |t|
      t.timestamps
      t.string :topic
    end
  end
end
