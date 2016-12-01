class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.timestamps
      t.integer :user_id
      t.integer :shortened_url_id
      t.integer :vote
    end
    add_index :votes, :user_id
    add_index :votes, :shortened_url_id
  end
end
