<%-- 
    Document   : updateSepecialty
    Created on : May 28, 2018, 9:41:26 AM
    Author     : PC
--%>

<%@page import="MODEL.Specialty"%>
<%@page import="DAO.Connect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Sepecialty</title>
    </head>
    <body>
        <div class="container doctorProfile">
            <% Connect con = new Connect();
                con.open("ppl", "3306");
               Specialty spec = con.getSpecById(Integer.parseInt(request.getParameter("id")));
                con.close();%>
            <form class="form-horizontal" name="patient" action='../SpecialtyServlet' method="POST">
                <fieldset>
                    <div class="control-group">
                        <!-- Username -->
                        <label class="control-label"  for="Specialty">Specialty</label>
                        <div class="controls">
                            <input type="text"  name="specialty" placeholder=""
                                   tabindex="2" class="form-control" value="<%= spec.getSpec()%>">
                        </div>
                    </div>
                    <div class="control-group">
                        <!-- Button -->
                        <div class="controls">
                            <input type="submit" class="btn btn-success" name='action' value='Update Specialty'>
                            <input type="hidden" name ="id"  value="<%= spec.getId()%>">
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>
    </body>
</html>
