


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
    postCard() {
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
        return postCardHtml
    }
}


// will get the group data, allow display of posts and comments 



function prependPost(post, groupId, currentUserId){    
    let postObj = new Post(post, groupId, currentUserId)
    let postCard = postObj.postCard()   
    $('#group-show-post-list').prepend(postCard)
}

function newPostListener() {
    $('#new-post-link').on('click', function (event){
        event.preventDefault()
        $('form').show()
        $('#new-post-link').hide()
    })
}



$(document).on('turbolinks:load', function () { //had to change to turbolinks:load 
                                                // listener because of turbolinks breaking 
                                                // jquery's ready - explained here: 
                                                // https://stackoverflow.com/questions/18769109/rails-4-turbo-link-prevents-jquery-scripts-from-working/18770219#18770219
    
    
    
    
    if ($('.groupShowPage').data("id") === true){ 
        // if this page is the group Show page, create post list and handle new post submissions:
        
        
        
        // the following is to render the group and posts data on the page!
        
        const groupId = $('.groupId').data("id") // this is id of the current group page being shown
        const currentUserId = $('.currentUserId').data("id")  // id of the current logged on user        
        $.get("/groups/" + groupId + ".json", function(group) { // get the group data
            $("#group-show-group-name").html('<h1>' + group.name + '</h1>')
            $("#group-show-group-summary").html(group.summary)
            
            const posts = group.posts
            posts.forEach( post => { 
                prependPost(post, groupId, currentUserId)                    
            })        
        })
        
        
        $('#new_post').hide() // hide the new post form (until it is summoned with 'new post' link)
        newPostListener()
    
        // this handles new post submission from that previously mentioned new_post form
        $('#new_post').submit(function (event) {
            event.preventDefault()
            const newPost = $('#new_post').serialize()
            // const content = $('#post_content').val()
            // console.log(content)
            let posting = $.post('/groups/' + groupId + '/posts', newPost)
            
            posting.done( function(post){
                prependPost(post, groupId, currentUserId)
                $('input[type="text"], textarea').val('')
                $('#new-post-link').show()
                $('form').hide()
            })
            return false // this is what you were missing for the longest time pete!
        })
    }
    
})