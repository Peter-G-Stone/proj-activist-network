class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.belongs_to :user, index: true
      t.belongs_to :group, index: true
      t.text :content
      t.timestamps
    end
  end
end
