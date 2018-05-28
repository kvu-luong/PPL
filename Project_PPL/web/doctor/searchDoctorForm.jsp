<%-- 
    Document   : doctor
    Created on : May 25, 2018, 11:36:44 PM
    Author     : PC
--%>


<%@page import="MODEL.Patient"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MODEL.Doctor"%>
<%@page import="DAO.Connect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Doctor</title>
        <link href="vendor/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="1.css" rel="stylesheet" type="text/css"/>
        <link href="vendor/font-awesome.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <div class="container">
                <div class="row">
                    <div class="table-responsive" id="doctorTable">
                    <%
                        Connect con = new Connect();
                        con.open("ppl", "3306");
                        ArrayList<Doctor> doc = con.searchDoctor((String) request.getAttribute("searchDoctor"));
                        if (doc.size() != 0) {%> 
                    <table class="table table-hover" border="1">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Gender</th>
                                <th>Degree</th>
                                <th>Insurance</th>
                                <th>Spec</th>
                                <th>Office Hours</th>
                                <th>Language</th>
                            </tr>
                        </thead>
                        <tbody id="myTable">
                            <%for (int i = 0; i < doc.size(); i++) {%>
                            <tr>
                                <td><%=i + 1%></td>
                                <td><%= doc.get(i).getFirstName()%></td>
                                <td><%= doc.get(i).getLastName()%></td>
                                <td><%= doc.get(i).getGender()%></td>
                                <td><%= doc.get(i).getDegree()%></td>
                                <td><%= doc.get(i).getInsurance()%></td>
                                <td><%= doc.get(i).getSpec()%></td>
                                <td><%= doc.get(i).getOfficeHours()%></td>
                                <td><%= doc.get(i).getLanguage()%></td>
                            </tr>
                            <% }%>


                        </tbody>
                    </table>  
                    <%}
                        con.close();%>
                </div>
                <div class="col-md-12 text-center">
                    <ul class="pagination pagination-lg pager" id="myPager"></ul>
                </div>
            </div>
            <div class="row">
                <%  if (session.getAttribute("patient") != null) {%>
                <a href="./searchDoctorFormAdv.jsp">Search Doctor Advance</a>
                <% }%>

            </div>
        </div>
        <script type="text/javascript" src="vendor/bootstrap.js"></script>
        <script type="text/javascript" src="1.js"></script>
        <script src="vendor/jquery-3.3.1.min.js" type="text/javascript"></script>
        <div id="adjustFooter">
            <jsp:include page="registerAsPatientForm.jsp"></jsp:include>
            <jsp:include page="registerAsHospitalForm.jsp"></jsp:include>
            <jsp:include page="registerAsDoctorForm.jsp"></jsp:include>
            <jsp:include page="loginAsPatientForm.jsp"></jsp:include>
            <jsp:include page="loginAsDoctorForm.jsp"></jsp:include>
            <jsp:include page="loginAsHospitalForm.jsp"></jsp:include>
            <jsp:include page="footer.jsp"></jsp:include>
        </div>

    </body>
</html>
