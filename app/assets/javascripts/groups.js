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
        $('form').show()
        $('#new-post-link').hide()
    })
}



$(document).ready( () => {
    $('#new_post').hide()
})


$(() => {
   
    
    // the following is to render the group and posts data on the page!
    let groupId = $('.groupId').data("id")
    let currentUserId = $('.currentUserId').data("id")
    $.get("/groups/" + groupId + ".json", function(group) {
        $("#group-show-group-name").html('<h1>' + group.name + '</h1>')
        $("#group-show-group-summary").html(group.summary)

        const posts = group.posts
        posts.forEach( post => { //can I make this a reverse each?
            appendPost(post, groupId, currentUserId)                    
        })        
    })

    ///////////////////

    // the following renders the form when new post is clicked:
    renderNewPostForm(groupId)

    // this handles new post submission from that previously mentioned new_post form
    $('#new_post').submit(function (event) {
        event.preventDefault()
        const newPost = $(this).serialize()
        $.post('/groups/' + groupId + '/posts', newPost).done(() => {
            console.log(newPost)
            // this is logging undefined and also it's refreshing the page on submit STILL
            // also when the page refreshes the posts and group data doesn't show
        })

    })
    
})