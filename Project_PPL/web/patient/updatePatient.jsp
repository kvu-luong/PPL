<%-- 
    Document   : updatePatient
    Created on : May 27, 2018, 8:41:15 PM
    Author     : PC
--%>

<%@page import="MODEL.Hospital"%>
<%@page import="MODEL.Patient"%>
<%@page import="DAO.Connect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Patient</title>
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
            <div class="container doctorProfile">
            <% Connect con = new Connect();
                con.open("ppl", "3306");
                Patient patient = con.getPatientById(Integer.parseInt(request.getParameter("id")));
                con.close();%>
            <form class="form-horizontal" name="patient" action='../PatientServlet' method="POST">
                <fieldset>
                    <div class="control-group">
                        <!-- Username -->
                        <label class="control-label"  for="username">First Name</label>
                        <div class="controls">
                            <input type="text"  name="firstName" placeholder=""
                                   tabindex="2" class="form-control" value="<%= patient.getFirstName()%>">
                            <p class="help-block">Username can contain any letters or numbers, without spaces</p>
                        </div>
                    </div>
                    <div class="control-group">
                        <!-- Username -->
                        <label class="control-label"  for="username">Last Name</label>
                        <div class="controls">
                            <input type="text"  name="lastName" placeholder="" 
                                   tabindex="2" class="form-control" value="<%= patient.getLastName()%>">
                            <p class="help-block">Username can contain any letters or numbers, without spaces</p>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label"  for="Gender" style="padding-right:20px">Gender</label><br>
                        <%if (patient.getGender().equals("Male")) { %>
                        <input class="radio-inline" type="radio" name="gender" value="Male" checked>Male
                        <input class="radio-inline" type="radio" name="gender" value="Female" style="margin-left:20px">Female
                        <%} else { %>
                        <input class="radio-inline" type="radio" name="gender" value="Male" >Male
                        <input class="radio-inline" type="radio" name="gender" value="Female" style="margin-left:20px" checked>Female
                        <% }%>
                    </div>
                    <div class="control-group">
                        <!-- E-mail -->
                        <label class="control-label" for="email">E-mail</label>
                        <div class="controls">
                            <input type="text"  name="email" 
                                   placeholder="" tabindex="2" class="form-control" 
                                   pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" value="<%=patient.getEmail()%>" >
                            <input type="hidden" id="table" value="patient">
                            <button id="ckmail">Check</button> <p id="checkshow" class="help-block"></p>
                        </div>
                    </div>

                    <div class="control-group">
                        <!-- Password-->
                        <label class="control-label" for="password">Password</label>
                        <div class="controls">
                            <input type="text" name="oldpass" value="<%=patient.getPassword()%>" disabled>
                            <input type="password" id="passwordRegister"
                                   name="password" placeholder="" tabindex="2" class="form-control"
                                   pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"required>
                            <p class="help-block">Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters</p>
                        </div>
                    </div>

                    <div class="control-group">
                        <!-- Password -->
                        <label class="control-label"  for="password_confirm">Password (Confirm)</label>
                        <div class="controls">
                            <input type="password" id="passwordConfirm"
                                   name="passwordConfirm" placeholder="" tabindex="2" class="form-control"
                                   required>
                            <p class="help-block">Please confirm password</p>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label"  for="Address">Address</label>
                        <div class="controls">
                            <input type="text"  name="address" placeholder="" tabindex="2" 
                                   class="form-control" required value="<%= patient.getAddress()%>">
                        </div>
                    </div>
                    <div class="control-group">
                        <!-- Password -->
                        <label class="control-label"  for="Languages">Languages</label>
                        <select class="form-control" name="language">
                            <option>VN</option>
                            <option>EN</option>
                        </select>
                    </div>
                    <div class="control-group">
                        <!-- Button -->
                        <div class="controls">
                            <input type="submit" class="btn btn-success" name='action' value='Update Patient'>
                            <input type="hidden" name ="id"  value="<%= patient.getId()%>">
                            <%if (request.getParameter("page").equals("patient")) {%>
                            <input type="hidden" name="page" value="<%= request.getParameter("page")%>">
                                   <%  } else { %>
                                   <input type="hidden" name="page" value="allPatient">
                            <%  }%>

                        </div>
                    </div>
                </fieldset>
            </form>
        </div>
                            <script type="text/javascript" src="../vendor/bootstrap.js"></script>
        <script type="text/javascript" src="../1.js"></script>
        <script src="../vendor/jquery-3.3.1.min.js" type="text/javascript"></script>
           <script type="text/javascript" src="./vendor/bootstrap.js"></script>
        <script type="text/javascript" src="./1.js"></script>
        <script src="./vendor/jquery-3.3.1.min.js" type="text/javascript"></script>
    </body>
</html>
