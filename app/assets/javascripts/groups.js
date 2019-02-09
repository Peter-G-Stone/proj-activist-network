// will get the group data, allow display of posts and comments 

$(() => {
   
   
    // the following is to render the posts on the page!

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
                '<p><br><a href="//localhost:3000/groups/' +
                groupId +
                '/posts/' +
                post.id +
                '">' +
                post.content +
                '</a><br>Created: ' + 
                post.created_at +
                '</p></div>' +
                '<div class="card-action">'
            if (currentUserId === post.user.id){
                const editAndDelete = '<p><a href="//localhost:3000/groups/'+
                    groupId +
                    editUrl +
                    '">Edit Post</a></p>' +
                    '<button>Delete</button>'
                    // make this button actually do something pete!
                    postCard += editAndDelete
            }
            postCard += '</div></div>'
            $('#group-show-post-list').append(postCard)        
        })        
    })

    // the following handles the form for new post:
    
})





// this is popped in here cause I was curious about it and want to look at it later:
// $(document).ready( () => {

// })