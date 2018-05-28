/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.Connect;
import static DAO.Connect.database;
import static DAO.Connect.port;
import MODEL.Mail;
import MODEL.Patient;
import RSA.MD5;
import java.io.IOException;
import java.io.PrintWriter;
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
public class PatientServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();//print on browser
        HttpSession session = request.getSession();
        Connect con = new Connect();
        con.open(database, port);

        String action = request.getParameter("action");
        if(action.equals("Update Patient")){
              String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String gender = request.getParameter("gender");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String address = request.getParameter("address");
            String language = request.getParameter("language");
            int id = Integer.parseInt(request.getParameter("id"));
            int status = Integer.parseInt(request.getParameter("status"));
            String page = request.getParameter("page");//help to return page patient or all patient when update database;
            
            boolean check = con.updatePatient(id, firstName, lastName, gender, email, password, address, language,status);
            if(check){
                if(page.equals("patient")){
                    response.sendRedirect("./patient/patient.jsp");
                }else{
                    response.sendRedirect("./patient/allPatient.jsp");
                }
            }else{
                out.println("Error when update patient!");
            }
        }else if(action.equals("Add Patient")){
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
        }else if(action.equals("Remove")){
             int id = Integer.parseInt(request.getParameter("id"));
            Boolean check = con.removePeople("patient", id);
            if(check){
                response.sendRedirect("./patient/allPatient.jsp");
            }else{
                out.println("error when remove patient");
            }  
        }
        con.close();
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
