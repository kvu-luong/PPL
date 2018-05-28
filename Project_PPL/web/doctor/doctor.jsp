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
        <title>View all doctor addmin</title>
         <link href="../vendor/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../1.css" rel="stylesheet" type="text/css"/>
        <link href="../vendor/font-awesome.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>

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
                        ArrayList<Doctor> arr = con.getAllDoctor();
                        for (Doctor doctor : arr) {%>
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
                            <a href="./updateDoctor.jsp?id=<%=doctor.getId()%>">Update</a>
                            <a href="../DoctorServlet?action=Remove&id=<%=doctor.getId()%>">Remove</a>
                        </td>
                    </tr> 
                    <%  } con.close();
                    %>
                </tbody>
            </table>
                <a href="./addDoctor.jsp">Add</a><br>
               <% if(session.getAttribute("admin") != null){ %>
                <a href="../page/admin.jsp">Admin Page</a>
                <%}else{ %>
                 <a href="../index_1.jsp">Home Page</a>
               <% } %>
        </div>
                  <script type="text/javascript" src="../vendor/bootstrap.js"></script>
            <script type="text/javascript" src="../1.js"></script>
            <script src="vendor/jquery-3.3.1.min.js" type="../text/javascript"></script>
    </body>
</html>
