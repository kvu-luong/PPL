/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.Connect;
import static DAO.Connect.database;
import static DAO.Connect.port;
import MODEL.Hospital;
import MODEL.Mail;
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
public class HospitalServlet extends HttpServlet {

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
        if(action.equals("Update Hospital")){
            String name = request.getParameter("nameH");
            String address = request.getParameter("addressH");
            String website = request.getParameter("websiteH");
            String adminName = request.getParameter("adminNameH");
            String email = request.getParameter("emailH");
            String password = request.getParameter("passwordH");
            int id = Integer.parseInt(request.getParameter("id"));
            
            boolean check = con.updateHospitalById(id, name, address, website,email, adminName, password);
            if(check){
                response.sendRedirect("./hospital/hospital.jsp");
            }else{
                out.println("error when update hospital");
            }
        }else if(action.equals("Update Hospital Admin")){
            System.out.println("inSide update hospital admin");
            String name = request.getParameter("nameH");
            String address = request.getParameter("addressH");
            String website = request.getParameter("websiteH");
            String adminName = request.getParameter("adminNameH");
            String email = request.getParameter("emailH");
            String password = request.getParameter("passwordH");
            int id = Integer.parseInt(request.getParameter("id"));
            int status = Integer.parseInt(request.getParameter("status"));
            System.out.println(status +"--in update hospital ");
            boolean check = con.updateHospitalAdminById(id, name, address, website, email, adminName, password, status);
            if(check){
                response.sendRedirect("./hospital/viewAllHospitalAdmin.jsp");
            }else{
                out.println("error when update hospital as admin");
            }
        }else if(action.equals("Remove")){
            int id = Integer.parseInt(request.getParameter("id"));
            boolean check = con.removePeople("hospital", id);
            if(check){
                response.sendRedirect("./hospital/viewAllHospitalAdmin.jsp");
            }else{
                out.println("Error when remove hospital as Admin");
            } 
        }else if(action.equals("Add Hospital Admin")){
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
                    String subject = "Add new Hospital";
                    String message = "\n"
                            + " Thanks for use our services!\n"
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
