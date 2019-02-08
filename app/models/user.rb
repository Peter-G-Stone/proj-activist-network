class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :groups_user
  has_many :groups, through: :groups_user

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy







  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]


         # note - the following method, as well as the last two omniauth options just added to the above devise command, are on the rec of a tutorial from digital ocean - 
         # How To Configure Devise and OmniAuth for Your Rails Application
  def self.from_omniauth(auth)
    where(uid: auth.uid).first_or_create do |user|
      # user.provider = auth.provider
      user.name = auth.info.name
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end




# the below returns the item in the join table that connects a user to a group to which they belong, 
# allowing editing of the admin variable
  def group_link(group)
    self.groups_user.find{|g_u| g_u.group_id == group.id} 
  end


# the below returns the value of the admin var on a group connection, but can't be used to edit the 
# admin value
  def admin?(group)
    return false unless group.users.include?(self)
    !!self.groups_user.find{|g_u| g_u.group_id == group.id}.admin
  end


  
end
