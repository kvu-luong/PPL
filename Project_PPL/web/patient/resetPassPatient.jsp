<%-- 
    Document   : resetpass
    Created on : May 26, 2018, 5:14:16 PM
    Author     : PC
--%>

<%@page import="MODEL.Hospital"%>
<%@page import="MODEL.Patient"%>
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
        <!--Start Header -->
        <nav class="navbar navbar-default  navbar-fixed-top wow fadeInDown" data-wow-duration="2s" role="navigation">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <a class="navbar-brand" href="../index_1.jsp"><img class="logo" src="../img/logo.png" alt="logo"></a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse navbar-ex1-collapse">
                    <ul class="nav navbar-nav">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Hospital <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                                <li><a href="#">Separated link</a></li>
                            </ul>
                        </li>
                        <% if (session.getAttribute("hospital") == null) { %>
                        <li><a href="./doctor/viewdoctor.jsp">Doctor Profile</a></li>
                            <% }%>
                        <li><a href="#">Appointment</a></li>


                    </ul>
                    <form action="../UserServlet" method="get" class="navbar-form navbar-left" role="search"
                          onsubmit="return checkDoctorForm()">
                        <div class="form-group">
                            <input require type="text" class="form-control" placeholder="Search Doctor" name="searchDoctor" id="searchDoctor">
                        </div>
                        <button name="action" value="SearchDoctor" type="submit" class="btn btn-default"><span class="fa fa-search "></span></button>
                    </form>

                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <%  if (session.getAttribute("patient") != null) {
                                                Patient patient = (Patient) session.getAttribute("patient");%>
                                <%= patient.getFirstName()%>
                                <% } else if (session.getAttribute("hospital") != null) {
                                            Hospital hospital = (Hospital) session.getAttribute("hospital");%>
                                <%= hospital.getName()%>
                                <% } else { %>
                                LogIn
                                <% } %>
                                <b class="caret"></b></a>
                                <%if (session.getAttribute("patient") != null) { %>
                            <a class="goin" href="./patient/patient.jsp" >Profile</a>
                            <%}%>
                            <%if (session.getAttribute("hospital") != null) { %>
                            <a class="goin" href="./doctor/hospital.jsp" >Profile</a>
                            <%}%>
                            <ul class="dropdown-menu">
                                <%if (session.getAttribute("patient") == null) { %>
                                <li> <a class="btn btn-success" data-toggle="modal" href='#logPatient' data-dismiss="modal">Login as Patient</a></li>
                                    <%}%>
                                    <%if (session.getAttribute("hospital") == null) { %>
                                <li> <a class="btn btn-success" data-toggle="modal" href='#logHospital' data-dismiss="modal">Login as Hospital</a></li>
                                    <%}%>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Register <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <%if (session.getAttribute("patient") == null) { %>
                                <li> <a class="btn btn-success" data-toggle="modal" href='#asPatients' data-dismiss="modal">Register as Patient</a></li>
                                    <%}%>
                                    <%if (session.getAttribute("hospital") == null) { %>
                                <li> <a class="btn btn-success" data-toggle="modal" href='#asHospital' data-dismiss="modal">Register as Hospital</a></li>
                                    <%}%>
                            </ul>
                        </li>
                        <li><a href="../UserServlet?action=logout">Logout</a></li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div>
        </nav>
        <!--End Header -->
            <div class="col-sm-6 col-sm-push-3 resetpass">
                <form id="resetPass" action="../UserServlet" method="post" role="form" style="display: block;" onsubmit="return checkValid();">
                    <div class="form-group">
                        <input type="password" name="oldPasswordReset" id="oldPasswordReset" tabindex="3" class="form-control" placeholder="Old Password" required>
                    </div>
                    <div class="form-group">
                        <input type="password" name="newPasswordReset" id="newPasswordReset" tabindex="2" class="form-control" placeholder="New Password" required>
                    </div>
                    <div class="form-group">
                        <input type="password" name="confirmPassReset" id="confirmPassReset" tabindex="2" class="form-control" placeholder="Confirm Password" required>
                        <% if(session.getAttribute("patient") != null ){ 
                        Patient patient = (Patient)session.getAttribute("patient"); %>
                        <input type="hidden" name="email" value="<%=patient.getEmail() %>">
                    <%} %>
                    </div>
                    <div class="form-group">
                        <div class="row">
                            <div class="col-sm-6 col-sm-offset-3">
                                <input type="submit" name="action" id="login-submit" tabindex="4" class="form-control btn btn-success" value="Reset Password As Patient">
                            </div>
                        </div>
                    </div>
                </form>
                        <% if(request.getAttribute("changePass") != null){ %>
               <p style="color:red"><%= request.getAttribute("changePass")%></p>
               <% } %>
            </div>
        <script type="text/javascript" src="../vendor/bootstrap.js"></script>
        <script type="text/javascript" src="../1.js"></script>
        <script src="../vendor/jquery-3.3.1.min.js" type="text/javascript"></script>
           <script type="text/javascript" src="./vendor/bootstrap.js"></script>
        <script type="text/javascript" src="./1.js"></script>
        <script src="./vendor/jquery-3.3.1.min.js" type="text/javascript"></script>
        <script>
            function checkValid(){
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
