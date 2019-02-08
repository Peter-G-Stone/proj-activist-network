// will get the group data, allow display of posts and comments 

$(() => {
    let groupId = $('.groupId').data("id")
    $.get("/groups/" + groupId + ".json", function(group) {
        $("#group-show-group-name").html('<h1>' + group.name + ' from js!</h1>')
        $("#group-show-group-summary").html(group.summary + ' from js!')
        $("#group-show-group-summary").html(group.summary + ' from js!')

        const posts = group.posts
        posts.forEach( post => {
            console.log(post)
            
            // got user and comment info in json! yay!
            const postCard = '<div class="card blue-grey darken-4">' +
                '<div class="card-content white-text">' +
                    '<span class="card-title">this is content<%= link_to post.user.name, profile_path(post.user) %></span>' +
                    '<p><%= link_to post.content, group_post_path(@group.id, post.id) %> <br>' +
                    'Created: <%= post.created_at.strftime("%A, %d %b %Y %l:%M %p") %> UTC</p>' +
                '</div>' +
                '<div class="card-action">' +        
                    '<% if post.user == current_user %>' +
                        '<p><%= link_to "Edit Post", edit_group_post_path(@group.id, post.id) %>' +
                        '<%= button_to "Delete Post", group_post_path(@group.id, post.id), method: :delete %> </p>' +
                    '<% end %>' +
                '</div>' +
            '</div>'
            
            $('#group-show-post-list').append(postCard)
        })        
    })
})





// this is popped in here cause I was curious about it and want to look at it later:
// $(document).ready( () => {

// })