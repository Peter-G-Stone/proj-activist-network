// will get the group data, allow display of posts and comments 

$(() => {
    let groupId = $('.groupId').data("id")
    $.get("/groups/" + groupId + ".json", function(group) {
        $("#group-show-group-name").html('<h1>' + group.name + ' from js!</h1>')
        $("#group-show-group-summary").html(group.summary + ' from js!')
        $("#group-show-group-summary").html(group.summary + ' from js!')
    })
})


// $(() => {
//     $(".groupId").on("click", function() {
//         let groupId = $(this).data("id")
//         $.get("/groups/" + groupId + ".json", function(group) {
//             console.log(group.name)
//         })
//     })
// })






// $(function() {
//     $(".js-more").on("click", function() {
//       var id = $(this).data("id");
//       $.get("/products/" + id + ".json", function(data) {
//         var product = data;
//         var inventoryText = "<strong>Available</strong>";
//         if(product["inventory"] === 0){
//           inventoryText = "<strong>Sold Out</strong>";
//         }
//         var descriptionText = "<p>" + product["description"] + "</p><p>" + inventoryText + "</p>";
//         $("#product-" + id).html(descriptionText);
//         var orders = product["orders"];
//         var orderList = "";
//         orders.forEach(function(order) {
//           orderList += '<li class="js-order" data-id="' + order["id"] + '">' + order["id"] + ' - ' + order["created_at"] + '</li>';
//         });
//         $("#product-" + id + "-orders").html(orderList);
//       });
//     });
//   });





// this is popped in here cause I was curious about it and want to look at it later:
// $(document).ready( () => {

// })