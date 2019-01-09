class Group < ApplicationRecord

    has_many :groups_user
    has_many :users, through: :groups_user
    has_many :posts, dependent: :destroy

    validates :name, presence: :true
    validates :summary, presence: :true

    before_save :update_recent_activity
    after_create :make_admin


    scope :active_in_last_hour, -> { where('recent_activity > ?', 1.hour.ago)}
    scope :active_in_last_day, -> { where('recent_activity > ?', 1.day.ago)}

    
    def update_recent_activity
        self.recent_activity = Time.now
    end
    
    def make_admin
        self.groups_user[0].admin = true
        self.groups_user[0].save
    end
end
