<%-- 
    Document   : changPassword
    Created on : May 26, 2018, 5:12:05 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
           <link href="vendor/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="1.css" rel="stylesheet" type="text/css"/>
        <link href="vendor/font-awesome.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
            <jsp:include page="header.jsp"></jsp:include>
            <div class="col-sm-6 col-sm-push-3 resetpass">
                <form id="changePassHospital" action="./UserServlet" method="post" role="form" style="display: block;">
                    <div class="form-group">
                        <label for="remember"> Please provide your email address to reset your address</label>
                        <input type="email" class="form-control"  placeholder="Your Email Address" name="Email" id="changeEmailHospital" required>
                        <input type="hidden" name="table" value="hospital"/>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-6 col-sm-offset-3">
                                <input type="submit" name="action" id="login-submit" tabindex="4" class="form-control btn btn-success" value="Change Password Hospital">
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
    </body>
</html>
