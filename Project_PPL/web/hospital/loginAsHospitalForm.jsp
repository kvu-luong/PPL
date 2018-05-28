<%-- 
    Document   : loginAsHospitalForm
    Created on : May 26, 2018, 12:11:49 AM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login As Hospital Form</title>
    </head>
    <body>
        <div class="modal fade" id="logHospital">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Login</h4>
                </div>
                <div class="modal-body">
                    <form id="login-form" action="./UserServlet" method="get" role="form" style="display: block;">
                        <div class="form-group">
                            <input type="text" name="email"  tabindex="1" class="form-control" placeholder="Your Email" value="">
                        </div>
                        <div class="form-group">
                            <input type="password" name="password"  tabindex="2" class="form-control" placeholder="Password">
                        </div>
                        <div class="form-group text-center">
                            <input type="checkbox" tabindex="3" class="" name="remember" id="rememberHospital">
                            <label for="remember"> Remember Me</label>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-6 col-sm-offset-3">
                                    <input type="submit" name="action" tabindex="4" class="form-control btn btn-success" value="LogIn as Hospital">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="text-center">
                                        <a href="./changePassHospital.jsp" tabindex="5" class="forgot-password">Forgot Password?</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- End Modal login -->
    </body>
</html>
