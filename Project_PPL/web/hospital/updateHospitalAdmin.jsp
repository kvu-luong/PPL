<%-- 
    Document   : updateHospital
    Created on : May 28, 2018, 8:30:56 AM
    Author     : PC
--%>

<%@page import="MODEL.Hospital"%>
<%@page import="DAO.Connect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Hospital</title>
    </head>
    <body>
        <div class="container">
             <form class="form-horizontal" action='../HospitalServlet' method="POST" name="hospital" onsubmit="return validateFormHospital();">
                        <fieldset>
                            <% Connect con = new Connect();
                            con.open("ppl","3306");
    Hospital hospital = con.getHospitalById(Integer.parseInt(request.getParameter("id")));
    con.close();%>
                            <div class="control-group">
                                <!-- Username -->
                                <label class="control-label"  for="username">Name</label>
                                <div class="controls">
                                    <input type="text" id="name" name="nameH" placeholder="" tabindex="2"
                                           class="form-control" value="<%= hospital.getName() %>">
                                    <p class="help-block">Username can contain any letters or numbers, without spaces</p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"  for="Address">Address</label>
                                <div class="controls">
                                    <input type="text"  name="addressH" placeholder="" tabindex="2" 
                                           class="form-control" required value="<%= hospital.getAddress() %>">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"  for="Website">Website</label>
                                <div class="controls">
                                    <input type="text"  name="websiteH" placeholder="" tabindex="2" 
                                           class="form-control" required value="<%= hospital.getWebsite() %>">
                                </div>
                            </div>
                            <div class="control-group">
                                <!-- Username -->
                                <label class="control-label"  for="Admin Name">Hospital Admin Name</label>
                                <div class="controls">
                                    <input type="text" id="adminName" name="adminNameH" placeholder="" 
                                           tabindex="2" class="form-control" required value="<%= hospital.getAdminName() %>">
                                    <p class="help-block">Username can contain any letters or numbers, without spaces</p>
                                </div>
                            </div>
                            <div class="control-group">
                                <!-- E-mail -->
                                <label class="control-label" for="email">Hospital Admin Email</label>
                                <div class="controls">
                                    <input type="text" id="emailHospital" name="emailH" placeholder="" tabindex="2" 
                                           class="form-control" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" 
                                           value="<%=hospital.getEmail() %>">
                                    <input type="hidden" id="tableHospital" value="hospital">
                                    <button id="ckmailHospital">Check</button> <p id="checkshowHospital" class="help-block"></p>
                                </div>
                            </div>

                            <div class="control-group">
                                <!-- Password-->
                                <label class="control-label" for="password">Password</label>
                                <div class="controls">
                                    <input type="text" disable value="<%= hospital.getPassword()%>">
                                    <input type="password" id="passwordHospital"
                                           name="passwordH" placeholder="" tabindex="2" class="form-control"
                                           pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}">
                                    <p class="help-block">Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters</p>
                                </div>
                            </div>

                            <div class="control-group">
                                <!-- Password -->
                                <label class="control-label"  for="password_confirm">Password (Confirm)</label>
                                <div class="controls">
                                    <input type="password" id="passwordConfir"
                                           name="passwordConfirmH" placeholder="" tabindex="2" class="form-control"
                                           >
                                    <p class="help-block">Please confirm password</p>
                                </div>
                            </div>
                                     <div class="control-group">
                                <!-- Password -->
                                <label class="control-label" >Status</label>
                                <div class="controls">
                                    <input type="text" value="<%= hospital.getStatus() %>"
                                           name="status" placeholder="" tabindex="2" class="form-control"
                                           >
                                    <p class="help-block">Please confirm password</p>
                                </div>
                            </div>

                            <div class="control-group">
                                <!-- Button -->
                                <div class="controls">
                                    <input type="submit" class="btn btn-success" name='action' value='Update Hospital Admin'>
                                    <input type="hidden" name="id" value="<%= hospital.getId() %>">
                                </div>
                            </div>
                        </fieldset>
                    </form>
                  <script type="text/javascript" src="../vendor/bootstrap.js"></script>
            <script type="text/javascript" src="../1.js"></script>
            <script src="../vendor/jquery-3.3.1.min.js" type="text/javascript"></script>
        </div>
    </body>
</html>
