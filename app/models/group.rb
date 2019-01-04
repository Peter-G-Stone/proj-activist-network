class Group < ApplicationRecord

    has_and_belongs_to_many :users
    has_and_belongs_to_many :admins, class_name: "User"
    has_many :posts

end
