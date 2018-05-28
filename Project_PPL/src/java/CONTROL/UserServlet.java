package CONTROL;

import DAO.Connect;
import static DAO.Connect.database;
import static DAO.Connect.port;
import MODEL.Admin;
import MODEL.Doctor;
import MODEL.Hospital;
import MODEL.Mail;
import MODEL.Patient;
import RSA.MD5;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author PC
 */
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();//print on browser
        HttpSession session = request.getSession();
        Connect con = new Connect();
        con.open(database, port);

        String action = request.getParameter("action");
        String avatar = null;//sometime p.p don't want to upload image
        if (action.equals("Register")) {
            String firstName = request.getParameter("FirstName");
            String lastName = request.getParameter("LastName");
            String email = request.getParameter("Email");
            String password = request.getParameter("Password");
            String confirmPass = request.getParameter("ConfirmPassword");
            String address = request.getParameter("Address");
            String phone = request.getParameter("Phone");
            String gender = request.getParameter("Gender");
            avatar = request.getParameter("Avatar");
            String dateOfBirth = request.getParameter("DateOfBirth");
            String language = request.getParameter("Language");
            String role = request.getParameter("Role");
            int r = 0;
            if (role == "admin") {
                r = 1;
            }
            boolean newAccount = con.createAccount(firstName, lastName, gender, email, password, phone, address, language, avatar, dateOfBirth, role, r);
            if (newAccount) {
                Admin admin = new Admin(firstName,lastName,gender,email,password,phone,address,language, avatar,dateOfBirth,1);
                out.println("ok");
                session.setAttribute("admin", admin);
                request.getRequestDispatcher("./page/admin.jsp").forward(request, response);
            } else {
                out.println("Not Yet");
            }

        } else if (action.equals("verify")) {
            String email = request.getParameter("email");
            String hash = request.getParameter("hash");
            String table = request.getParameter("table");
            System.out.println(table + " in verify function");
            Boolean check;
            if (table.equals("patient")) {
                System.out.println("equal");
                check = con.verifyPatient(email, hash, table, "Email");
            } else {
                System.out.println(" not equal");
                check = con.verifyPatient(email, hash, table, "AdminEmail");
            }
            out.println("inside verify");
            if (check) {
                String m = "Your account has been activated, you can now login.";
                request.setAttribute("active", m);
                //response.sendRedirect("/Project_PPL/index_1.jsp");
                request.getRequestDispatcher("./index_1.jsp").forward(request, response);
            } else {
                String m = "The url is either invalid or you already have activated your account.";
                request.setAttribute("active", m);
                request.getRequestDispatcher("./index_1.jsp").forward(request, response);
            }
        } else if (action.equals("logout")) {
            session.removeAttribute("patient");
            session.removeAttribute("hospital");
            response.sendRedirect("./index_1.jsp");
        } else if (action.equals("checkmail")) {
            String email = request.getParameter("email_atr");
            String table = request.getParameter("table");
            System.out.println(email);
            Boolean check;
            if (table.equals("patient")) {
                check = con.checkMailExist(email, table, "Email");//true if email exits in our database
            } else {
                check = con.checkMailExist(email, table, "AdminEmail");
            }
            if (check) {
                out.println("no");
            } else {
                out.println("ok");
            }
        } else if (action.equals("SearchDoctor")) {
            request.setAttribute("searchDoctor", request.getParameter("searchDoctor"));
            request.getRequestDispatcher("./doctor/searchDoctorForm.jsp").forward(request, response);
        } else if (action.equals("LogIn as Hospital")) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Hospital hospital = con.getInforHospitalToLogin(email, password);
            if (hospital.getEmail() != null) {
                String m = " login successfully";
                session.setAttribute("hospital", hospital);
                request.setAttribute("login", m);
                request.removeAttribute("sendMail");
                request.removeAttribute("active");
                session.removeAttribute("admin");
                session.removeAttribute("patient");
                response.sendRedirect("./index_1.jsp");
//                out.println("login as hospital succeed");
            } else {
                out.println("error in get hospital infor");
                String m = "Email or Password doesn't exist!";
                request.setAttribute("login", m);
                request.getRequestDispatcher("./index_1.jsp").forward(request, response);
            }
        }else if(action.equals("LogoutAdmin")){
            session.removeAttribute("admin");
            response.sendRedirect("./page/admin.jsp");
        }

        con.close();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();//print on browser
        HttpSession session = request.getSession();
        Connect con = new Connect();
        con.open(database, port);

        String action = request.getParameter("action");
        if (action.equals("RegisterAsPatient")) {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String gender = request.getParameter("gender");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String address = request.getParameter("address");
            String language = request.getParameter("language");

            Patient patient = new Patient();
            patient.setFirstName(firstName);
            patient.setLastName(lastName);
            patient.setGender(gender);
            patient.setEmail(email);
            patient.setAddress(address);
            patient.setPassword(password);
            patient.setLanguage(language);
            //create hash
            Random rd = new Random();
            int r = rd.nextInt(1000);//from 0 to n-1
            String hash = MD5.encryption(r + "");
            Boolean checkMail = con.checkMailExist(email, "patient", "Email");
            if (!checkMail) {
                Boolean check = con.createPatient(firstName, lastName, gender, email, password, address, language, hash);
                if (check) {
                    //send mail
                    String subject = "Signup | Verification";
                    String message = "\n"
                            + " Thanks for signing up!\n"
                            + " Your account has been created, you can login with the following credentials after you have activated your account by pressing the url below.\n\n"
                            + "------------------------\n"
                            + "Username: " + firstName + " " + lastName + "\n"
                            + "Password: " + password + "\n"
                            + "------------------------\n\n"
                            + "Please click this link to activate your account:\n"
                            + "http://localhost:8080/Project_PPL/UserServlet?action=verify&table=patient&email=" + email + "&hash=" + hash + ""; // Our message above including the link
                    Boolean sendMail = Mail.sendMail(email, subject, message);
                    if (sendMail) {
                        String m = "Your account has been made,please verify it by clicking the activation link that has been send to your email.";
                        request.setAttribute("sendMail", m);
                        //response.sendRedirect("/Project_PPL/index_1.jsp");
                        request.getRequestDispatcher("./index_1.jsp").forward(request, response);
                    } else {
                        System.out.println("Send Mail ERROR");
                    }
                } else {
                    out.println("error when we try to insert data");
                }
            } else {
                String m = "Your email address has been exist, Please try with other email address!";
                request.setAttribute("sendMail", m);
                //response.sendRedirect("/Project_PPL/index_1.jsp");
                request.getRequestDispatcher("./index_1.jsp").forward(request, response);
            }
        } else if (action.equals("LogIn as Patient")) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Patient patient = con.getInforPatientToLogin(email, password);
            if (patient.getEmail() != null) {
                String m = " login successfully";
                session.setAttribute("patient", patient);
                session.removeAttribute("hospital");
                request.setAttribute("login", m);
                request.removeAttribute("sendMail");
                request.removeAttribute("active");
                response.sendRedirect("./index_1.jsp");
            } else {
                out.println("error in get patient infor");
                String m = "Email or Password doesn't exist!";
                request.setAttribute("login", m);
                request.getRequestDispatcher("./index_1.jsp").forward(request, response);
            }
        } else if (action.equals("RegisterAsHospital")) {
            String name = request.getParameter("nameH");
            String address = request.getParameter("addressH");
            String website = request.getParameter("websiteH");
            String adminName = request.getParameter("adminNameH");
            String adminEmail = request.getParameter("emailH");
            String password = request.getParameter("passwordH");

            Hospital hospital = new Hospital();
            hospital.setName(name);
            hospital.setAddress(address);
            hospital.setWebsite(website);
            hospital.setAdminName(adminName);
            hospital.setEmail(adminEmail);
            hospital.setPassword(password);
            //create hash
            Random rd = new Random();
            int r = rd.nextInt(1000);//from 0 to n-1
            String hash = MD5.encryption(r + "");
            Boolean checkMail = con.checkMailExist(adminEmail, "hospital", "AdminEmail");
            if (!checkMail) {
                Boolean check = con.createHospital(name, address, website, adminName, adminEmail, password, hash);
                if (check) {
                    //send mail
                    String subject = "Signup | Verification";
                    String message = "\n"
                            + " Thanks for signing up!\n"
                            + " Your account has been created, you can login with the following credentials after you have activated your account by pressing the url below.\n\n"
                            + "------------------------\n"
                            + "Username: " + name + "\n"
                            + "Password: " + password + "\n"
                            + "------------------------\n\n"
                            + "Please click this link to activate your account:\n"
                            + "http://localhost:8080/Project_PPL/UserServlet?action=verify&table=hospital&email=" + adminEmail + "&hash=" + hash + ""; // Our message above including the link
                    Boolean sendMail = Mail.sendMail(adminEmail, subject, message);
                    if (sendMail) {
                        String m = "Your account has been made,please verify it by clicking the activation link that has been send to your email.";
                        request.setAttribute("sendMail", m);
                        //response.sendRedirect("/Project_PPL/index_1.jsp");
                        request.getRequestDispatcher("./index_1.jsp").forward(request, response);
                    } else {
                        System.out.println("Send Mail ERROR");
                    }
                } else {
                    out.println("error when we try to insert data");
                }
            } else {
                String m = "Your email address has been exist, Please try with other email address!";
                request.setAttribute("sendMail", m);
                //response.sendRedirect("/Project_PPL/index_1.jsp");
                request.getRequestDispatcher("./index_1.jsp").forward(request, response);
            }
        } else if (action.equals("Change Password Hospital")) {
            String email = request.getParameter("Email");
            String table = request.getParameter("table");
            Boolean check = con.resetPassword(email, table, "AdminEmail");
            if (check) {

                //send mail
                String subject = "Reset Password";
                String message = "\n"
                        + " Thanks for use our services!\n"
                        + " Your account has been reset, you can login with the following credentials after you have activated your account by pressing the url below.\n\n"
                        + "------------------------\n"
                        + "User Email: " + email + "\n"
                        + "Password: 12345\n"
                        + "------------------------\n\n"
                        + "Please click this link to activate your account:\n"
                        + "http://localhost:8080/Project_PPL/index_1.jsp"; // Our message above including the link
                Boolean sendMail = Mail.sendMail(email, subject, message);
                request.setAttribute("changePass", "Your pass has been changed, Please check mail");
                request.getRequestDispatcher("./hospital/changePassHospital.jsp").forward(request, response);
            } else {
                request.setAttribute("changePass", "Can't reset your password, Please check your email address");
                request.getRequestDispatcher("./hospital/changePassHospital.jsp").forward(request, response);
                out.println("Can't reset your password, Please check your email address");
            }
        }else if(action.equals("Change Password Patient")){
               String email = request.getParameter("Email");
            String table = request.getParameter("table");
            Boolean check = con.resetPassword(email, table, "Email");
            if (check) {

                //send mail
                String subject = "Reset Password";
                String message = "\n"
                        + " Thanks for use our services!\n"
                        + " Your account has been reset, you can login with the following credentials after you have activated your account by pressing the url below.\n\n"
                        + "------------------------\n"
                        + "User Email: " + email + "\n"
                        + "Password: 12345\n"
                        + "------------------------\n\n"
                        + "Please click this link to activate your account:\n"
                        + "http://localhost:8080/Project_PPL/index_1.jsp"; // Our message above including the link
                Boolean sendMail = Mail.sendMail(email, subject, message);
                request.setAttribute("changePass", "Your pass has been changed, Please check mail");
                request.getRequestDispatcher("./patient/changePassPatient.jsp").forward(request, response);
            } else {
                request.setAttribute("changePass", "Can't reset your password, Please check your email address");
                request.getRequestDispatcher("./patient/changePassPatient.jsp").forward(request, response);
                out.println("Can't reset your password, Please check your email address");
            }
        }else if(action.equals("Reset Password As Patient")){
            String oldPass = request.getParameter("oldPasswordReset");
            String newPass = request.getParameter("newPasswordReset");
            String email = request.getParameter("email");
            
            Boolean check = con.changePassword(oldPass, newPass,"patient",email, "Email");
               if (check) {

                //send mail
                String subject = "Change Password";
                String message = "\n"
                        + " Thanks for use our services!\n"
                        + " Your account has been changed, you can login with the following credentials after you have activated your account by pressing the url below.\n\n"
                        + "------------------------\n"
                        + "User Email: " + email + "\n"
                        + "Password: "+newPass+"\n"
                        + "------------------------\n\n"
                        + "Please click this link to activate your account:\n"
                        + "http://localhost:8080/Project_PPL/index_1.jsp"; // Our message above including the link
                Boolean sendMail = Mail.sendMail(email, subject, message);
                request.setAttribute("changePass", "Your pass has been changed, Please check mail");
                request.getRequestDispatcher("./patient/resetPassPatient.jsp").forward(request, response);
            } else {
                request.setAttribute("changePass", "Can't reset your password, Please check your old password");
                request.getRequestDispatcher("./patient/resetPassPatient.jsp").forward(request, response);
                out.println("Can't change your password, Please check your email address");
            }
        }else if(action.equals("Reset Password As Hospital")){
               String oldPass = request.getParameter("oldPasswordReset");
            String newPass = request.getParameter("newPasswordReset");
            String email = request.getParameter("email");
            
            Boolean check = con.changePassword(oldPass, newPass,"hospital",email, "AdminEmail");
               if (check) {

                //send mail
                String subject = "Change Password";
                String message = "\n"
                        + " Thanks for use our services!\n"
                        + " Your account has been changed, you can login with the following credentials after you have activated your account by pressing the url below.\n\n"
                        + "------------------------\n"
                        + "User Email: " + email + "\n"
                        + "Password: "+newPass+"\n"
                        + "------------------------\n\n"
                        + "Please click this link to activate your account:\n"
                        + "http://localhost:8080/Project_PPL/index_1.jsp"; // Our message above including the link
                Boolean sendMail = Mail.sendMail(email, subject, message);
                request.setAttribute("changePass", "Your pass has been changed, Please check mail");
                request.getRequestDispatcher("./hospital/resetPassHospital.jsp").forward(request, response);
            } else {
                request.setAttribute("changePass", "Can't reset your password, Please check your old password");
               // request.getRequestDispatcher("./hospital/resetPassHospital.jsp").forward(request, response);
                out.println("Can't change your password, Please check your email address");
                response.sendRedirect("./hospital/resetPassHospital.jsp");
            }
        }else if(action.equals("LogIn as Admin")){
            String email = request.getParameter("email");
            String pass = request.getParameter("password");
            
            Admin admin = con.getInforAdminToLogin(email, pass);
               if (admin.getEmail() != null) {
                String m = " login successfully";
                session.setAttribute("admin", admin);
                session.removeAttribute("hospital");
                session.removeAttribute("patient");
                request.setAttribute("login", m);
                request.removeAttribute("sendMail");
                request.removeAttribute("active");
                response.sendRedirect("./page/admin.jsp");
            } else {
                out.println("error in get patient infor");
                String m = "Email or Password doesn't exist!";
                request.setAttribute("login", m);
                response.sendRedirect("./page/admin.jsp");
            }
        }
        con.close();
    }
}


