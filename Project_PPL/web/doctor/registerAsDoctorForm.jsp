<%-- 
    Document   : registerAsDoctorForm
    Created on : May 26, 2018, 12:07:55 AM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register As Doctor Form</title>
    </head>
    <body>
       <!--        Register as Doctor-->
    <div class="modal fade" id="asDoctor">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Register as Doctor</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" action='' method="POST">
                        <fieldset>
                            <div class="control-group">
                                <!-- Username -->
                                <label class="control-label"  for="username">First Name</label>
                                <div class="controls">
                                    <input type="text" id="firstName" name="firstName" placeholder="" tabindex="2" class="form-control">
                                    <p class="help-block">Username can contain any letters or numbers, without spaces</p>
                                </div>
                            </div>
                            <div class="control-group">
                                <!-- Username -->
                                <label class="control-label"  for="username">Last Name</label>
                                <div class="controls">
                                    <input type="text" id="lastName" name="lastName" placeholder="" tabindex="2" class="form-control">
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
                                <label class="control-label"  for="username">Specific Specialty</label>
                                <div class="controls">
                                    <input type="text" id="specific" name="specific" placeholder="" tabindex="2" class="form-control">
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
                                <!-- E-mail -->
                                <label class="control-label" for="email">E-mail</label>
                                <div class="controls">
                                    <input type="text" id="emailRegister" name="email" placeholder="" tabindex="2" class="form-control">
                                    <p class="help-block">Please provide your E-mail</p>
                                </div>
                            </div>

                            <div class="control-group">
                                <!-- Password-->
                                <label class="control-label" for="password">Password</label>
                                <div class="controls">
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
                                    <input type="password" id="passwordConfirm" name="passwordConfirm" placeholder="" tabindex="2" class="form-control">
                                    <p class="help-block">Please confirm password</p>
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
                                <!-- Button -->
                                <div class="controls">
                                    <input type="submit" class="btn btn-success" name='action' value='RegisterAsDoctor'>
                                    <button class="btn btn-danger" data-dismiss="modal">Cancel</button>
                                </div>
                            </div>
                        </fieldset>
                    </form>
                </div>

            </div>
        </div>
    </div>
    <!--        End register as Doctor-->
    </body>
</html>
