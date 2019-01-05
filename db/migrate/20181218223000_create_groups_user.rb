class CreateGroupsUser < ActiveRecord::Migration[5.2]
  def change
    create_table :groups_users do |t|
      t.timestamps
      t.integer :group_id
      t.integer :user_id
      t.boolean :admin, default: false
    end
  end
end
