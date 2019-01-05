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
end
