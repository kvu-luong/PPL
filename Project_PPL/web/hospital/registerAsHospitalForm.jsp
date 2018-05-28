<%-- 
    Document   : registerAsHospitalForm
    Created on : May 26, 2018, 12:06:15 AM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register As Hospital Form</title>
    </head>
    <body>
         <!--        Register as Hospital-->
    <div class="modal fade" id="asHospital">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Register as Hospital</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" action='./UserServlet' method="POST" name="hospital" onsubmit="return validateFormHospital();">
                        <fieldset>
                            <div class="control-group">
                                <!-- Username -->
                                <label class="control-label"  for="username">Name</label>
                                <div class="controls">
                                    <input type="text" id="name" name="nameH" placeholder="" tabindex="2" class="form-control">
                                    <p class="help-block">Username can contain any letters or numbers, without spaces</p>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"  for="Address">Address</label>
                                <div class="controls">
                                    <input type="text"  name="addressH" placeholder="" tabindex="2" class="form-control" required>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"  for="Website">Website</label>
                                <div class="controls">
                                    <input type="text"  name="websiteH" placeholder="" tabindex="2" class="form-control" required>
                                </div>
                            </div>
                            <div class="control-group">
                                <!-- Username -->
                                <label class="control-label"  for="Admin Name">Hospital Admin Name</label>
                                <div class="controls">
                                    <input type="text" id="adminName" name="adminNameH" placeholder="" tabindex="2" class="form-control" required>
                                    <p class="help-block">Username can contain any letters or numbers, without spaces</p>
                                </div>
                            </div>
                            <div class="control-group">
                                <!-- E-mail -->
                                <label class="control-label" for="email">Hospital Admin Email</label>
                                <div class="controls">
                                    <input type="text" id="emailHospital" name="emailH" placeholder="" tabindex="2" 
                                           class="form-control" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" >
                                    <input type="hidden" id="tableHospital" value="hospital">
                                    <button id="ckmailHospital">Check</button> <p id="checkshowHospital" class="help-block"></p>
                                </div>
                            </div>

                            <div class="control-group">
                                <!-- Password-->
                                <label class="control-label" for="password">Password</label>
                                <div class="controls">
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
                                <!-- Button -->
                                <div class="controls">
                                    <input type="submit" class="btn btn-success" name='action' value='RegisterAsHospital'>
                                    <button class="btn btn-danger" data-dismiss="modal">Cancel</button>
                                </div>
                            </div>
                        </fieldset>
                    </form>
                </div>

            </div>
        </div>
    </div>
    <!--        End register as Hospital-->
    </body>
</html>
