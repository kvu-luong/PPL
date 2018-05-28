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
        <title>Update Patient As Admin </title>
    </head>
    <body>
        <div class="container doctorProfile">
            <% Connect con = new Connect();
                con.open("ppl", "3306");
                int id = Integer.parseInt(request.getParameter("id"));
                System.out.println("ID of patient "+id);
                Patient patient = con.getPatientById(id);
                con.close(); 
            System.out.println(patient.getFirstName()+" firstname of patient"); %>
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
                          
                        </div>
                    </div>

                    <div class="control-group">
                        <!-- Password-->
                        <label class="control-label" for="password">Password</label>
                        <div class="controls">
                            <input type="text" name="oldpass" value="<%=patient.getPassword()%>" disabled><br>
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
                        <label class="control-label">Status</label>
                        <div class="controls">
                            <input type="text"  name="status" placeholder="" tabindex="2" 
                                   class="form-control" required value="<%= patient.getStatus() %>">
                        </div>
                    </div>
                    <div class="control-group">
                        <!-- Button -->
                        <div class="controls">
                            <input type="submit" class="btn btn-success" name='action' value='Update Patient'>
                            <input type="hidden" name ="id"  value="<%= patient.getId()%>">
                                   <input type="hidden" name="page" value="allPatient">

                        </div>
                    </div>
                </fieldset>
            </form>
        </div>
    
    </body>
</html>
