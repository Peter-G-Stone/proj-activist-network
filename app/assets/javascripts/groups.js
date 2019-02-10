


class Post {
    constructor(post, groupId, currentUserId){
        this.content = post.content
        this.id = post.id 
        this.created_at = post.created_at
        this.user = {
            name: post.user.name,
            id: post.user.id
        }
        this.currentUserId = currentUserId
        this.groupId = groupId
    }

    // prototype function will be to generate post card
    prependPost() {
        let postCardHtml = '<div class="card blue-grey darken-4">' +
            '<div class="card-content white-text">' +
            '<span class="card-title"><a href="//localhost:3000/profiles/' +
            this.user.id +
            '" >' +
            this.user.name +
            '</a></span>' +
            '<p><br><a href="//localhost:3000/groups/' +
            this.groupId +
            '/posts/' +
            this.id +
            '">' +
            this.content +
            '</a><br>Created: ' + 
                        // previously did this strftime
                        // <%= post.created_at.strftime("%A, %d %b %Y %l:%M %p") %> UTC
            this.created_at +
            '</p></div>' +
            '<div class="card-action">'
            
             // if the post belongs to current user, add edit and delete to card:
            if (this.currentUserId === this.user.id){
                const editUrl = "/posts/" + this.id + '/edit'            
                const editAndDelete = '<p><a href="//localhost:3000/groups/'+
                    this.groupId +
                    editUrl +
                    '">Edit Post</a></p>' +
                    '<button>Delete</button>'
                    // make this button actually do something pete!
                postCardHtml += editAndDelete
            }
        postCardHtml += '</div></div>'
        $('#group-show-post-list').prepend(postCardHtml)
    }
}


// will get the group data, allow display of posts and comments 



// function prependPost(post, groupId, currentUserId){    
//     let postObj = new Post(post, groupId, currentUserId)
//     let postCard = postObj.postCard()   
// }

function newPostListener() {
    $('#new-post-link').on('click', function (event){
        event.preventDefault()
        $('form').show()
        $('#new-post-link').hide()
    })
}

function newPostSubmitter(groupId, currentUserId) {
    $('#new_post').submit(function (event) {
        event.preventDefault()
        const newPost = $('#new_post').serialize()
        // const content = $('#post_content').val()
        // console.log(content)
        let posting = $.post('/groups/' + groupId + '/posts', newPost)
        
        posting.done( function(post){
            postObj = new Post (post, groupId, currentUserId)
            postObj.prependPost()
            $('input[type="text"], textarea').val('')
            $('#new-post-link').show()
            $('form').hide()
        })
        return false // this is what you were missing for the longest time pete!
    })
}

function renderGroupAndPosts(groupId, currentUserId){
    $.get("/groups/" + groupId + ".json", function(group) { // get the group data
        $("#group-show-group-name").html('<h1>' + group.name + '</h1>')
        $("#group-show-group-summary").html(group.summary)
        
        const posts = group.posts
        posts.forEach( post => { 
            postObj = new Post (post, groupId, currentUserId) 
            postObj.prependPost()                    
        })        
    })
}


$(document).on('turbolinks:load', function () { //had to change to turbolinks:load 
                                                // listener because of Rails' turbolinks breaking 
                                                // jquery's ready - explained here: 
                                                // https://stackoverflow.com/questions/18769109/rails-4-turbo-link-prevents-jquery-scripts-from-working/18770219#18770219
    
    
    if ($('.groupShowPage').data("id") === true){ 
        // if this page is the group Show page, render group data, post list and handle new post submissions:
        const groupId = $('.groupId').data("id") // this is id of the current group page being shown
        const currentUserId = $('.currentUserId').data("id")  // id of the current logged on user     
        
        renderGroupAndPosts(groupId, currentUserId)                
        $('#new_post').hide() // hide the new post form (until it is summoned with 'new post' link via newPostListener())
        newPostListener()

        newPostSubmitter(groupId, currentUserId) //  handles new post submission
    }   
})