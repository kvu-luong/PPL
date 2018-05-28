<%-- 
    Document   : patient
    Created on : May 26, 2018, 5:33:51 PM
    Author     : PC
--%>

<%@page import="MODEL.Hospital"%>
<%@page import="DAO.Connect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hospital Profile page</title>
            <link href="../vendor/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../1.css" rel="stylesheet" type="text/css"/>
        <link href="../vendor/font-awesome.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="hospitalProfile">
        <div class="container">
            <div clas="row">
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
                       Hospital hos = (Hospital)session.getAttribute("hospital");
                       Hospital hospital = con.getHospitalById(hos.getId());
                        con.close();
                       %>
                    <tr>
                        <td><%= hospital.getName()%></td>
                        <td><%=hospital.getAddress()%></td>
                        <td><%=hospital.getWebsite()%></td>
                        <td><%=hospital.getAdminName()%></td>
                        <td><%= hospital.getEmail() %></td>
                    </tr> 
                </tbody>
            </table>
                <div class="col-sm-3 leftProfilePatient">
                    <a href="./resetPassHospital.jsp">Change Password</a><br>
                    <a href="./updateHospital.jsp?id=<%= hospital.getId() %>">Update Hospital Profile</a><br>
                     <a href="../index_1.jsp">HomePage</a>
                </div>
            </div>
        </div>
        </div>
                
    </body>
</html>
