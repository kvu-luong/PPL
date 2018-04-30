<html lang="en"><head>
        <title> Hospital View _ PPL_Project </title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">  
        <script type="text/javascript" src="vendor/bootstrap.js"></script>
        <script type="text/javascript" src="1.js"></script>
        <link href="vendor/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="1.css" rel="stylesheet" type="text/css"/>
        <link href="vendor/font-awesome.css" rel="stylesheet" type="text/css"/>
        <script src="vendor/jquery-3.3.1.min.js" type="text/javascript"></script>

    </head>
    <body >
        <!--Start Header -->
        <nav class="navbar navbar-default  navbar-fixed-top wow fadeInDown" data-wow-duration="2s" role="navigation">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <a class="navbar-brand" href="#"><img class="logo" src="img/logo.png" alt="logo"></a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse navbar-ex1-collapse">
                    <ul class="nav navbar-nav">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Hospital <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                                <li><a href="#">Separated link</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Doctor <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                                <li><a href="#">Separated link</a></li>
                            </ul>
                        </li>
                        <li><a href="#">Patient</a></li>
                        <li><a href="#">Appointment</a></li>


                    </ul>
                    <form class="navbar-form navbar-left" role="search">
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="Search Doctor">
                        </div>
                        <button type="submit" class="btn btn-default"><span class="fa fa-search "></span></button>
                    </form>

                    <ul class="nav navbar-nav navbar-right">
                        <li><a  data-toggle="modal" href='#login-modal'>Login</a></li>
                        <li><a data-toggle="modal" href='#register-modal'>Register</a></li>
                        <li><a href="#">Logout</a></li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div>
        </nav>
        <!--End Header -->
        <!-- Welcome Slide -->
        <div class="welcome_slide wow fadeInUp">
            <div class="container">
                <div class="row">
                    <div class="col-xs-6 ">
                        <div class="welcome_contain">
                            <div class="line wow fadeInLeft"  data-wow-delay="1s">
                                IT'S AN AMAZING SERVICES!
                            </div>
                            <div class="line1 wow fadeInLeft" data-wow-delay="1.5s">
                                Welcome To Medical Services You Can Trust
                            </div>
                            <div class="2button wow fadeInLeft" data-wow-delay="2s">
                                <a href="#" class="btn btn-default nut-contact">READ MORE</a>
                            </div>
                        </div>
                    </div>  
                </div>
            </div>
        </div>
        <!-- End Welcome-slide -->
        <!-- 24/7 Service -->
        <div class="Service wow bounceInUp">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-8 col-sm-push-2 text-center">
                        <h1 class="text">24/7 SERVICES</h1>
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolores quae porro consequatur aliquam, incidunt eius magni provident, doloribus omnis minus ovident, doloribus omnis minus temporibus perferendis nesciunt..</p>
                    </div>
                </div>
                <div class="row text-center">
                    <div class="col-sm-4 wow bounceInUp " data-wow-duration="2s" data-wow-delay="0.5s" >
                        <h2 class="text2">Adults</h2>
                        <div class="content photo1">

                        </div>
                    </div>
                    <div class="col-sm-4 wow bounceInUp " data-wow-duration="2s" data-wow-delay="1.5s" >
                        <h2 class="text2">Childrens</h2>
                        <div class="content  photo2">

                        </div>
                    </div>
                    <div class="col-sm-4 wow bounceInUp " data-wow-duration="2s" data-wow-delay="2s">
                        <h2 class="text2">Specials</h2>
                        <div class="content photo3">

                        </div>
                    </div>
                </div>

            </div>
        </div>

        <!-- End 24/7 Service -->
        <!-- About us -->
        <div class="aboutUs">
            <!-- Container (Contact Section) -->
            <div class="container bg-grey">
                <h2 class="text-center">CONTACT</h2>
                <div class="row content_about_us">
                    <div class="col-sm-5">
                        <p>Contact us and we'll get back to you within 24 hours.</p>
                        <p><span class="glyphicon glyphicon-map-marker"></span> HCM International University</p>
                        <p><span class="glyphicon glyphicon-phone"></span> +00 9999999999</p>
                        <p><span class="glyphicon glyphicon-envelope"></span> myemail@gmail.com</p>
                    </div>
                    <% try {
                            if (request.getAttribute("SendEmail").equals("ok")) {
                    %>
                    <script>
                        alert("We will reply to you soon!");
                    </script>
                    <% } else {
                    %>
                    <script>
                        alert("Please check your email address again!");
                    </script>
                    <%
                            }
                        } catch (Exception ex) {
                            ex.printStackTrace();
                        }
                    %>
                    <div class="col-sm-7">
                        <form action="MailServlet" method="POST">
                            <div class="row">
                                <div class="col-sm-6 form-group">
                                    <input class="form-control" name="UserName" placeholder="Name" type="text" required>
                                </div>
                                <div class="col-sm-6 form-group">
                                    <input class="form-control" name="Email" placeholder="Email" type="email" required>
                                </div>
                            </div>
                            <textarea class="form-control"  name="Comments" placeholder="Comment" rows="5" required></textarea><br>
                            <div class="row">
                                <div class="col-sm-12 form-group">
                                    <input class="btn btn-default pull-right" name="action" value="Send" type="submit">
                                </div>
                            </div>
                        </form> <!-- end form -->
                    </div>
                </div>
            </div>
        </div>
        <!-- End About us -->
        <!-- Start Bottom -->
        <div class="bottom">
            <div class="container">
                <div class="row text-center">
                    Design by AVU DESIGN freelancer. Using Bootstrap - Java - Python.
                </div>
            </div>
        </div>
        <!-- End Bottom -->

        <!-- Modal Register -->
        <div class="modal fade" id="register-modal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Register</h4>
                    </div>
                    <div class="modal-body">
                        <!------ Include the above in your HEAD tag ---------->

                        <form class="form-horizontal" action='' method="POST">
                            <fieldset>
                                <div class="control-group">
                                    <!-- Username -->
                                    <label class="control-label"  for="username">Username</label>
                                    <div class="controls">
                                        <input type="text" id="usernameRegister" name="username" placeholder="" tabindex="2" class="form-control">
                                        <p class="help-block">Username can contain any letters or numbers, without spaces</p>
                                    </div>
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
                                        <input type="password" id="passwordRegister" name="password" placeholder="" tabindex="2" class="form-control">
                                        <p class="help-block">Password should be at least 4 characters</p>
                                    </div>
                                </div>

                                <div class="control-group">
                                    <!-- Password -->
                                    <label class="control-label"  for="password_confirm">Password (Confirm)</label>
                                    <div class="controls">
                                        <input type="password" id="password_confirmRegister" name="password_confirm" placeholder="" tabindex="2" class="form-control">
                                        <p class="help-block">Please confirm password</p>
                                    </div>
                                </div>

                                <div class="control-group">
                                    <!-- Button -->
                                    <div class="controls">
                                        <button class="btn btn-success">Register</button>
                                        <button class="btn btn-danger">Cancel</button>
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- End modal register -->
        <!-- Modal login -->
        <div class="modal fade" id="login-modal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Login</h4>
                    </div>
                    <div class="modal-body">
                        <form id="login-form" action="" method="post" role="form" style="display: block;">
                            <div class="form-group">
                                <input type="text" name="username" id="username" tabindex="1" class="form-control" placeholder="Username" value="">
                            </div>
                            <div class="form-group">
                                <input type="password" name="password" id="password" tabindex="2" class="form-control" placeholder="Password">
                            </div>
                            <div class="form-group text-center">
                                <input type="checkbox" tabindex="3" class="" name="remember" id="remember">
                                <label for="remember"> Remember Me</label>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-sm-6 col-sm-offset-3">
                                        <input type="submit" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-login" value="Log In">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="text-center">
                                            <a href="" tabindex="5" class="forgot-password">Forgot Password?</a>
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