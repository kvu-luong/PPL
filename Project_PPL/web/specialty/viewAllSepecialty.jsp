<%-- 
    Document   : viewAllSepecialty
    Created on : May 28, 2018, 9:41:09 AM
    Author     : PC
--%>

<%@page import="MODEL.Specialty"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.Connect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View All Specialty</title>
    </head>
    <body>
         <div class="container doctorProfile">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Index</th>
                            <th>Specialty Category</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%Connect con = new Connect();
                        con.open("ppl", "3306");
                        ArrayList<Specialty> arr = con.getAllSpecialty();
                        con.close();
                        int i = 1;
                        for(Specialty spec : arr){
                            i++;
                       %>
                    <tr>
                        <td><%= i %></td>
                        <td><%= spec.getSpec() %></td>
                        <td>
                            <a href="./updateSepecialty.jsp?id=<%= spec.getId() %>" >Update </a>
                            <a href="../SpecialtyServlet?action=Remove&id=<%= spec.getId()%>">Remove </a>
                        </td>
                    </tr> 
                    <% }
                    %>
                </tbody>
            </table>
                <a href="./addSpecialty.jsp">Add Hospital</a>
        </div>
    </body>
    </body>
</html>
