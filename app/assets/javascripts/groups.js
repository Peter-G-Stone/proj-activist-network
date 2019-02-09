// will get the group data, allow display of posts and comments 

$(() => {
    let groupId = $('.groupId').data("id")
    let currentUserId = $('.currentUserId').data("id")
    $.get("/groups/" + groupId + ".json", function(group) {
        $("#group-show-group-name").html('<h1>' + group.name + '</h1>')
        $("#group-show-group-summary").html(group.summary)

        const posts = group.posts
        posts.forEach( post => {
            
            // previously the post content linked to the post show page
            // <%= link_to post.content, group_post_path(@group.id, post.id) %> 
            // now I refactor to get rid of post show pages?

            // previously did this strftime
            // <%= post.created_at.strftime("%A, %d %b %Y %l:%M %p") %> UTC
            const editUrl = "/posts/" + post.id + '/edit'
            let postCard = '<div class="card blue-grey darken-4">' +
                '<div class="card-content white-text">' +
                '<span class="card-title"><a href="//localhost:3000/profiles/' +
                post.user.id +
                '" >' +
                post.user.name +
                '</a></span>' +
                '<p><br><a href="/posts/' +
                post.id +
                '">' +
                post.content +
                '</a><br>Created: ' + 
                post.created_at +
                '</p></div>' +
                '<div class="card-action">'
            if (currentUserId === post.user.id){
                const editAndDelete = '<p><a href="' +
                    editUrl +
                    '">Edit Post</a></p>' +
                    '<button>Delete</button>'
                    // make this button actually do something pete!
                    postCard += editAndDelete
            }
            postCard += '</div></div>'
            console.log(postCard)
            $('#group-show-post-list').append(postCard)
        })        
    })
})





// this is popped in here cause I was curious about it and want to look at it later:
// $(document).ready( () => {

// })