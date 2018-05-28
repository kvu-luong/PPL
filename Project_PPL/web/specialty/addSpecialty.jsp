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
        <title>Add Specialty</title>
    </head>
    <body>
        <div class="container doctorProfile">
            <form class="form-horizontal" name="" action='../SpecialtyServlet' method="POST">
                <fieldset>
                    <div class="control-group">
                        <!-- Username -->
                        <label class="control-label"  for="Specialty">Specialty</label>
                        <div class="controls">
                            <input type="text"  name="specialty" placeholder=""
                                   tabindex="2" class="form-control">
                        </div>
                    </div>
                    <div class="control-group">
                        <!-- Button -->
                        <div class="controls">
                            <input type="submit" class="btn btn-success" name='action' value='Add Specialty'>
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>
    </body>
</html>
