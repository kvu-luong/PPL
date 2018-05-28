<%-- 
    Document   : viewAllHospital
    Created on : May 28, 2018, 8:29:55 AM
    Author     : PC
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="MODEL.Hospital"%>
<%@page import="DAO.Connect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View All Hospital</title>
         <link href="../vendor/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../1.css" rel="stylesheet" type="text/css"/>
        <link href="../vendor/font-awesome.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
             <div class="container doctorProfile">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Address</th>
                            <th>Website</th>
                            <th>Admin Name</th>
                            <th>Admin Email</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%Connect con = new Connect();
                        con.open("ppl", "3306");
                        ArrayList<Hospital> arr = con.getAllHospital();
                        con.close();
                        for(Hospital hospital: arr){
                       %>
                    <tr>
                        <td><%= hospital.getName()%></td>
                        <td><%=hospital.getAddress()%></td>
                        <td><%=hospital.getWebsite()%></td>
                        <td><%=hospital.getAdminName()%></td>
                        <td><%= hospital.getEmail() %></td>
                    </tr> 
                    <% }
                    %>
                </tbody>
            </table>
        </div>
    </body>
</html>
