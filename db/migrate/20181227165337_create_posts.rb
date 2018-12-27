class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.belongs_to :user
      t.belongs_to :group
      t.text :content
      t.timestamps
    end
  end
end
