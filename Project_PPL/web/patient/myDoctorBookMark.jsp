<%-- 
    Document   : doctor
    Created on : May 27, 2018, 3:10:13 PM
    Author     : PC
--%>

<%@page import="MODEL.Hospital"%>
<%@page import="MODEL.Patient"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MODEL.Doctor"%>
<%@page import="DAO.Connect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <link href="../vendor/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../1.css" rel="stylesheet" type="text/css"/>
        <link href="../vendor/font-awesome.css" rel="stylesheet" type="text/css"/>
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
                        <li><a href="./doctor/doctor.jsp">Doctor Profile</a></li>
                            <% }%>
                        <li><a href="#">Appointment</a></li>


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
                        <li><a href="UserServlet?action=logout">Logout</a></li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div>
        </nav>
        <!--End Header -->
            <div class="container doctorProfile">
                <table class="table">
                    <thead>
                        <tr>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Gender</th>
                            <th>Degree</th>
                            <th>Insurance</th>
                            <th>Spec</th>
                            <th>Office Hours</th>
                            <th>Language</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%Connect con = new Connect();
                        con.open("ppl", "3306");
                        Patient patient = (Patient) session.getAttribute("patient");
                        int patientId = patient.getId();
                        //get doctorid from bookmark
                        ArrayList<Integer> doctorId = con.getPeopleIdbyPatientId(patientId, "DoctorID");
                        for (Integer id : doctorId) {
                    Doctor doctor = con.getDoctorBookMark(id);
                    if(doctor.getFirstName() != null){
                    %>
                    <tr>
                        <td><%= doctor.getFirstName()%></td>
                        <td><%=doctor.getLastName()%></td>
                        <td><%=doctor.getGender()%></td>
                        <td><%=doctor.getDegree()%></td>
                        <td><%= doctor.getInsurance()%></td>
                        <td><%= doctor.getSpec()%></td>
                        <td><%= doctor.getOfficeHours()%></td>
                        <td><%= doctor.getLanguage()%></td>
                        <td>
                            <a href="../BookMarkServlet?action=DoctorDisLike&doctorId=<%=doctor.getId()%>&patientId=<%=patient.getId()%>">DisLike</a>
                        </td>
                    </tr> 
                    <%  }} con.close();
                    %>
                </tbody>
            </table>
                <a href="../doctor/viewAllDoctorForBookMark.jsp">View List Doctor</a>
        </div>
                  <script type="text/javascript" src="../vendor/bootstrap.js"></script>
            <script type="text/javascript" src="../1.js"></script>
            <script src="vendor/jquery-3.3.1.min.js" type="../text/javascript"></script>
    </body>
</html>
