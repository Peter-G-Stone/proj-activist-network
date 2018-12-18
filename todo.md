# Models

User
    Admin?
    group-admin- ie manages group profile?
    has_and_belongs_to_many :groups (need join table: groups_users)
        https://guides.rubyonrails.org/association_basics.html#the-has-and-belongs-to-many-association
    has many commented on posts thru comments
Group
    has_and_belongs_to_many :users
    has many events
    ensure only group-admins can edit event?
Event
    belongs to group
Post
    has many commenters thru comments
    belongs to author/user
Comment
    belongs to post
    belongs to user

    

# DB structure
    Users
        name
        email
        password_digest
        bio
    Groups
        name
        summary
    Event
        title
        datetime
        summary
    post
        content
    comment
        content
        user_id
        post_id
    groups_users
        belongs_to user
        belongs_to group
        



# Any Unusual Controller Actions? What does each model need?

# Permissions/Authorization etc

# Validations?

# Scope method?


