class CreatePostsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :content
      t.datetime :date_posted
      t.integer :user_id
    end
  end
end