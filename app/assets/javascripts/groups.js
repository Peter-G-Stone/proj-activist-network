// will get the group data, allow display of posts and comments 

function appendPost(post, groupId, currentUserId){
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
                    // previously did this strftime
                    // <%= post.created_at.strftime("%A, %d %b %Y %l:%M %p") %> UTC
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
}

function renderNewPostForm(groupId) {
    $('#new-post-link').on('click', function (event){
        event.preventDefault()
        console.log('you clikced me')
        console.log(this)
        $('#new-post-link').text('')
        const postingUrl = '/groups/' + groupId + '/posts/new'
        const newPostForm = '<form><input type="text" name="content" placeholder="New Post" method="post" action="' +
            postingUrl +
            '"><input type="submit"></form>'
        $(newPostForm).insertAfter(this)
    })
}



$(() => {
   
   
    // the following is to render the group and posts data on the page!
    let groupId = $('.groupId').data("id")
    let currentUserId = $('.currentUserId').data("id")
    $.get("/groups/" + groupId + ".json", function(group) {
        $("#group-show-group-name").html('<h1>' + group.name + '</h1>')
        $("#group-show-group-summary").html(group.summary)

        const posts = group.posts
        posts.forEach( post => {
            appendPost(post, groupId, currentUserId)                    
        })        
    })

    ///////////////////

    // the following renders the form when new post is clicked:
    renderNewPostForm(groupId)

    
})







// this is popped in here cause I was curious about it and want to look at it later:

// $(document).ready( () => {

// })