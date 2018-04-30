$(document).ready(function(){
   $("#Send").click(function(){
       var email = $("#Email").val();
       var userName = $("#UserName").val();
       var comments = $("#Comments").val();
       $.ajax({
          type:'POST',
          data: {
              e : email,
              u : userName,
              c : comments
          },
          url:'/Project_PPL/MailServlet',
          success: function(result){
              alert(result);
          }
       });
   }) 
});
