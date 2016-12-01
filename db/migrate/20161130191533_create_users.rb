class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.timestamps
      t.string :email
    end

    add_index :users, :email
  end
end
