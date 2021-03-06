let groupId; 
let currentUserId;
let posts;



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

    prependPost() {
        let postCardHtml = '<div id="postCard' +
            this.id +
            '" class="card grey darken-2">' +
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
                    '<button class="postDeleteButton" id="deletePost' +
                    this.id +
                    '">Delete</button>'
                    // make this delete button actually do something pete!
                postCardHtml += editAndDelete
            }
        postCardHtml += '</div></div>'
        $('#group-show-post-list').prepend(postCardHtml)
        
        // once the post is prepended add an event listener to the posts delete button if it has one:
        if (this.currentUserId === this.user.id){
            this.addDeleteListener()       
        }
    }
    
    addDeleteListener() {
        const buttonIdQuery = '#deletePost' + this.id
        $(buttonIdQuery).on('click',  (event) => {
            // on click remove post from DB and DOM
            event.preventDefault()
            this.deletePost()
            this.removePostHtml()
        })
    }
    deletePost(){
        const urlForDelete = '/groups/' + this.groupId + '/posts/' + this.id
        $.ajax({
            url: urlForDelete,
            type: 'DELETE',
            success: function(result) {
                //do something with result?
            }
        })
    }
    removePostHtml(){
        const postCardQuery = '#postCard' + this.id
        $(postCardQuery).remove()
    }

}



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
        let posting = $.post('/groups/' + groupId + '/posts', newPost)
        
        posting.done( function(post){
            postObj = new Post (post, groupId, currentUserId)
            postObj.prependPost()
            $('input[type="text"], textarea').val('')
            $('#new-post-link').show()
            $('#new_post').hide()
        })
        return false // this is what you were missing for the longest time pete!
    })
}

function renderGroupAndPosts(groupId, currentUserId){
    $.get("/groups/" + groupId + ".json", function(group) { // get the group data
        $("#group-show-group-name").html('<h1>' + group.name + '</h1>')
        $("#group-show-group-summary").html(group.summary)
        
        posts = group.posts
        posts.forEach( post => { 
            postObj = new Post (post, groupId, currentUserId) 
            postObj.prependPost()                                            
        })        
    })
}

function userPostQListener(){
    $('#userPostQForm').on('submit', function (event) {
        event.preventDefault()
        $('#group-show-post-list').html('')
        
        const userPostQ = $('#userPostQ').val().toLowerCase()
        const postRespList = posts.filter(post => {
            return post.user.name.toLowerCase().includes(userPostQ)
        })
        postRespList.forEach( post => {
            postObj = new Post (post, groupId, currentUserId) 
            postObj.prependPost()    
        })
        return false
    })
}   


$(document).ready(function () { //had to change to turbolinks:load 
    // listener because of Rails' turbolinks breaking 
    // jquery's ready - explained here: 
    // https://stackoverflow.com/questions/18769109/rails-4-turbo-link-prevents-jquery-scripts-from-working/18770219#18770219
    
    
    if ($('.groupShowPage').data("id") === true){ 
        

        // if this page is the group Show page, render group data, post list and handle new post submissions:
        
        
        // ~~~~~~~~~~~ TODO ~~~~~~~~~~
        currentUserId = $('.currentUserId').data("id")  // id of the current logged on user --- this seems unsecure, come back to change this to making a request to the api instead ~~~~~~~~~~~~~~~

        groupId = window.location.href.split('/')[4]

        userPostQListener()
        renderGroupAndPosts(groupId, currentUserId)                
        
        $('#new_post').hide() // hide the new post form (until it is summoned with 'new post' link via newPostListener())
        
        newPostListener()

        newPostSubmitter(groupId, currentUserId) //  handles new post submission

    }   
})