<%-- 
    Document   : allPatient
    Created on : May 27, 2018, 8:39:50 PM
    Author     : PC
--%>

<%@page import="MODEL.Hospital"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MODEL.Patient"%>
<%@page import="MODEL.Doctor"%>
<%@page import="DAO.Connect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All Patient</title>
         <link href="../vendor/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../1.css" rel="stylesheet" type="text/css"/>
        <link href="../vendor/font-awesome.css" rel="stylesheet" type="text/css"/>
         <link href="./vendor/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="./1.css" rel="stylesheet" type="text/css"/>
        <link href="./vendor/font-awesome.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
            <div class="container doctorProfile">
                <table class="table">
                    <thead>
                        <tr>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Gender</th>
                            <th>Email</th>
                            <th>Password</th>
                            <th>Address</th>
                            <th>Language</th>
                            <th>Register Day</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%Connect con = new Connect();
                        con.open("ppl", "3306");
                        ArrayList<Patient> arr = con.getAllPatient();
                        for (Patient patient : arr) {%>
                    <tr>
                        <td><%= patient.getFirstName()%></td>
                        <td><%=patient.getLastName()%></td>
                        <td><%=patient.getGender()%></td>
                        <td><%= patient.getEmail() %></td>
                        <td><%= patient.getPassword() %></td>
                        <td><%=  patient.getAddress() %></td>
                        <td><%= patient.getLanguage() %></td>
                        <td><%= patient.getRegisterDay() %></td>
                        <td><%= patient.getStatus() %></td>
                        <td>
                            <a href="./updatePatientAdmin.jsp?id=<%=patient.getId()%>">Update</a>
                            <a href="../PatientServlet?action=Remove&id=<%=patient.getId()%>">Remove</a>
                        </td>
                    </tr> 
                    <%  } con.close();
                    %>
                </tbody>
            </table>
                <a href="./addPatient.jsp">Add</a><br>
                  <a href="../page/admin.jsp">Admin Page</a>
        </div>
                   <script type="text/javascript" src="../vendor/bootstrap.js"></script>
        <script type="text/javascript" src="../1.js"></script>
        <script src="../vendor/jquery-3.3.1.min.js" type="text/javascript"></script>
           <script type="text/javascript" src="./vendor/bootstrap.js"></script>
        <script type="text/javascript" src="./1.js"></script>
        <script src="./vendor/jquery-3.3.1.min.js" type="text/javascript"></script>
        <script>
    </body>
</html>
