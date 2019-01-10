class Post < ApplicationRecord
    belongs_to :user
    belongs_to :group
    has_many :comments

    validates :content, presence: true

    before_save :update_recent_activity


    #the below allows us to keep track of the group's recent activity to which the post belongs
  def update_recent_activity
    self.group.update(recent_activity:  Time.now)
  end
end
