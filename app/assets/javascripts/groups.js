$(document).ready( () => {

})


$(() => {
    $(".username").on("click", function() {
        let groupId = $(this).data("id")
        console.log(groupId)
    })
})






// $.get("/groups/" + @group.id + ".json", function(data) {
//     console.log(data)
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