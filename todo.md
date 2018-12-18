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
    event-admins?
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
        enoch says
            this could have the role attribute of the user's role in the group
            this table could hold a boolean - admin
            or could hold a role variable - admin vs group owner vs default
    events_users
        belongs_to user
        belongs_to event
        rsvp? bool




Class User
    has_many :events, through: :groups, source: group_events
end


user.events = ALL THE EVENTS I RSVPd
user.all_events = ALL MY GRPUPS EVENTS



    
        



# Any Unusual Controller Actions? What does each model need?
    added Registrations controller with enoch, it's part of using devise

# Permissions/Authorization etc

# Validations?

# Scope method?




# MVP
    admin stuff might not be a part of the MVP

# use devise
    read the documentation duh

