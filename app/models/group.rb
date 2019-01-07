class Group < ApplicationRecord

    has_many :groups_user
    has_many :users, through: :groups_user
    has_many :posts, dependent: :destroy

    scope :active_in_last_hour, -> { where('recent_activity > ?', 1.hour.ago)}
    scope :active_in_last_day, -> { where('recent_activity > ?', 1.day.ago)}
end
