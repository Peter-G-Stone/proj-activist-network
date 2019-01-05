class AddRecentActivityToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :recent_activity, :datetime
  end
end
