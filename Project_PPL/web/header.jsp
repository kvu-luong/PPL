<%-- 
    Document   : header
    Created on : May 25, 2018, 11:58:24 PM
    Author     : PC
--%>

<%@page import="MODEL.Hospital"%>
<%@page import="MODEL.Patient"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>header</title>
          <link href="vendor/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="1.css" rel="stylesheet" type="text/css"/>
        <link href="vendor/font-awesome.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>

        <!--Start Header -->
        <nav class="navbar navbar-default  navbar-fixed-top wow fadeInDown" data-wow-duration="2s" role="navigation">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <a class="navbar-brand" href="./index_1.jsp"><img class="logo" src="img/logo.png" alt="logo"></a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse navbar-ex1-collapse">
                    <ul class="nav navbar-nav">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">BookMark <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <% if(session.getAttribute("patient") != null){ %>
                                <li><a href="./hospital/viewAllHospitalForBookMark.jsp">Hospital</a></li>
                                <li><a href="./doctor/viewAllDoctorForBookMark.jsp">Doctor</a></li>
                               <% } %>
                            </ul>
                        </li>
                        <% if (session.getAttribute("hospital") == null) { %>
                        <li><a href="./doctor/viewdoctor.jsp">Doctor Profile</a></li>
                            <% }else{%>
                        <li><a href="./doctor/doctor.jsp">Doctor Profile</a></li>
                        <%} %>
                    </ul>
                    <form action="UserServlet" method="get" class="navbar-form navbar-left" role="search"
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
                            <a class="goin" href="./hospital/hospital.jsp" >Profile</a>
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
                        <li><a href="UserServlet?action=logout">Logout</a></li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div>
        </nav>
        <!--End Header -->
            <script type="text/javascript" src="vendor/bootstrap.js"></script>
            <script type="text/javascript" src="1.js"></script>
            <script src="vendor/jquery-3.3.1.min.js" type="text/javascript"></script>
    </body>
</html>
