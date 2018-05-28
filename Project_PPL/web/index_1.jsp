<%@page import="MODEL.Patient"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html lang="en"><head>
        <title> Hospital View _ PPL_Project </title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1">  
<!--        <link href="vendor/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="1.css" rel="stylesheet" type="text/css"/>
        <link href="vendor/font-awesome.css" rel="stylesheet" type="text/css"/>-->

    </head>
    <body >
        <jsp:include page="header.jsp" ></jsp:include>
            <!-- Welcome Slide -->
            <div class="welcome_slide wow fadeInUp">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-6 ">
                            <div class="welcome_contain">
                                <div class="line wow fadeInLeft"  data-wow-delay="1s">
                                    IT'S AMAZING SERVICES!
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
                <div class="container">
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
        <jsp:include page="footer.jsp" ></jsp:include>
        <jsp:include page="./patient/registerAsPatientForm.jsp"></jsp:include>
        <jsp:include page="./hospital/registerAsHospitalForm.jsp"></jsp:include>
        <jsp:include page="./doctor/registerAsDoctorForm.jsp"></jsp:include>
        <jsp:include page="./patient/loginAsPatientForm.jsp"></jsp:include>
        <jsp:include page="./doctor/loginAsDoctorForm.jsp"></jsp:include>
        <jsp:include page="./hospital/loginAsHospitalForm.jsp"></jsp:include>

            <!--        check validate form-->
<!--            <script type="text/javascript" src="vendor/bootstrap.js"></script>
            <script type="text/javascript" src="1.js"></script>
            <script src="vendor/jquery-3.3.1.min.js" type="text/javascript"></script>-->

            <script>
                $(document).ready(function () {

                    function anounce() {
            <%
                if (request.getAttribute("sendMail") != null) {
            %>
                        alert("<%= request.getAttribute("sendMail")%>");
            <% }
                if (request.getAttribute("active") != null) {
            %>
                        alert("<%= request.getAttribute("active")%>");

            <% }
                if (request.getAttribute("login") != null) {%>
                        alert("<%= request.getAttribute("login")%>");
            <%}  
                if (request.getAttribute("contact") != null) {
            %>
                        alert("<%= request.getAttribute("sendMail")%>");
            <% }%>
                    }
                    anounce();

                });
        </script>



    </body>
</html>