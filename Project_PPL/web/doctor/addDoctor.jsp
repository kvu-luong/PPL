<%-- 
    Document   : addDoctor
    Created on : May 27, 2018, 4:04:01 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Doctor</title>
                 <link href="../vendor/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../1.css" rel="stylesheet" type="text/css"/>
        <link href="../vendor/font-awesome.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
    
        <div class="container ">
            <form class="form-horizontal" action='../DoctorServlet' method="POST">
                <fieldset>
                    <div class="control-group">
                        <!-- Username -->
                        <label class="control-label"  for="username">First Name</label>
                        <div class="controls">
                            <input type="text" name="firstName" placeholder="" tabindex="2" class="form-control">
                            <p class="help-block">Username can contain any letters or numbers, without spaces</p>
                        </div>
                    </div>
                    <div class="control-group">
                        <!-- Username -->
                        <label class="control-label"  for="username">Last Name</label>
                        <div class="controls">
                            <input type="text" name="lastName" placeholder="" tabindex="2" class="form-control">
                            <p class="help-block">Username can contain any letters or numbers, without spaces</p>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label"  for="Gender" style="padding-right:20px">Gender</label><br>
                        <input class="radio-inline" type="radio" name="gender" value="Male" >Male
                        <input class="radio-inline" type="radio" name="gender" value="Female" style="margin-left:20px">Female
                    </div>
                    <div class="control-group">
                        <!-- Password -->
                        <label class="control-label"  for="degree">Degree</label>
                        <select class="form-control" name="degree">
                            <option>bachelor</option>
                            <option>master</option>
                        </select>
                    </div>
                    <div class="control-group">
                        <label class="control-label"  for="Accepted Insurance" style="padding-right:20px">Accepted Insurance</label><br>
                        <input class="radio-inline" type="radio" name="insurance" value="yes" >Yes
                        <input class="radio-inline" type="radio" name="insurance" value="no" style="margin-left:20px">No
                    </div>
                    <div class="control-group">
                        <!-- Username -->
                        <label class="control-label" >Specific Specialty</label>
                        <div class="controls">
                            <input type="text"  name="specific" placeholder="" tabindex="2" class="form-control">
                            <p class="help-block">e.g. Accident surgery, anatomy, etc...</p>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label"  for="Accepted Insurance" style="padding-right:20px">Office Hours</label><br>
                        <input class="radio-inline" type="radio" name="day" value="mon" >Mon
                        <input class="radio-inline" type="radio" name="day" value="tue" style="margin-left:20px">Tue
                        <input class="radio-inline" type="radio" name="day" value="web" style="margin-left:20px">Wed
                        <input class="radio-inline" type="radio" name="day" value="thur" style="margin-left:20px">Thur
                        <input class="radio-inline" type="radio" name="day" value="fri" style="margin-left:20px">Fri<br>
                        <input class="radio-inline" type="radio" name="session" value="morning" >Morning
                        <input class="radio-inline" type="radio" name="session" value="afternoon" style="margin-left:20px">Afternoon
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
                        <!-- Button -->
                        <div class="controls">
                            <input type="submit" class="btn btn-success" name='action' value='Add Doctor'>
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>
    </body>
</html>
