<%-- 
    Document   : resetpass
    Created on : May 26, 2018, 5:14:16 PM
    Author     : PC
--%>

<%@page import="MODEL.Hospital"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset Pass</title>
        <link href="../vendor/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../1.css" rel="stylesheet" type="text/css"/>
        <link href="../vendor/font-awesome.css" rel="stylesheet" type="text/css"/>
        <link href="./vendor/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="./1.css" rel="stylesheet" type="text/css"/>
        <link href="./vendor/font-awesome.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
            <div class="col-sm-6 col-sm-push-3 resetpass">
                <form id="resetPass" action="../UserServlet" method="post" role="form" style="display: block;" onsubmit="return checkValidHospital();">
                    <div class="form-group">
                        <input type="password" name="oldPasswordReset" id="oldPasswordReset" tabindex="3" class="form-control" placeholder="Old Password">
                    </div>
                    <div class="form-group">
                        <input type="password" name="newPasswordReset" id="newPasswordReset" tabindex="2" class="form-control" placeholder="New Password">
                    </div>
                    <div class="form-group">
                        <input type="password" name="confirmPassReset" id="confirmPassReset" tabindex="2" class="form-control" placeholder="Confirm Password">
                            <% if(session.getAttribute("hospital") != null ){ 
                        Hospital hospital = (Hospital)session.getAttribute("hospital"); %>
                        <input type="hidden" name="email" value="<%=hospital.getEmail() %>">
                    <%} %>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-6 col-sm-offset-3">
                                <input type="submit" name="action" id="login-submit" tabindex="4" class="form-control btn btn-success" value="Reset Password As Hospital">
                            </div>
                        </div>
                    </div>
                </form>
                   <% if(request.getAttribute("changePass") != null){ %>
               <p style="color:red"><%= request.getAttribute("changePass")%></p>
               <% } %>
            </div>
        <script type="text/javascript" src="vendor/bootstrap.js"></script>
        <script type="text/javascript" src="1.js"></script>
        <script src="vendor/jquery-3.3.1.min.js" type="text/javascript"></script>
        <script>
                 function checkValidHospital(){
                let pass = $("#newPasswordReset").val();
                let confirm = $("#confirmPassReset").val();
                if(pass != confirm){
                    alert("your new password must be the same as confirm password");
                    return false;
                }
                
            }
        </script>
    </body>
</html>
