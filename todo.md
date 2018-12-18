# Models

User
    Admin?
    group-admin- ie manages group profile?
    has many groups
    has many commented on posts thru comments
Group
    has many users
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
    


# Any Unusual Controller Actions? What does each model need?

# Permissions/Authorization etc

# 

