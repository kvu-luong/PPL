/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CONTROL;

import DAO.Connect;
import static DAO.Connect.database;
import static DAO.Connect.port;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author PC
 */
public class DoctorServlet extends HttpServlet {

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
        if(action.equals("Add Doctor")){
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String gender = request.getParameter("gender");
            String degree = request.getParameter("degree");
            String insurance = request.getParameter("insurance");
            String specific = request.getParameter("specific");
            String day = request.getParameter("day");
            String ses = request.getParameter("session");
            String officeHourse = day+"--"+ses;
            String language = request.getParameter("language");
            Boolean check = con.addDoctor(firstName, lastName, gender, degree, insurance, specific, officeHourse, language);
            if(check){
                response.sendRedirect("./doctor/doctor.jsp");
            }else{
                out.println("Error when add doctor");
            }
        }else if(action.equals("Remove")){
            int id = Integer.parseInt(request.getParameter("id"));
            Boolean check = con.removePeople("doctor", id);
            if(check){
                response.sendRedirect("./doctor/doctor.jsp");
            }else{
                out.println("error when remove doctor");
            }  
        }else if(action.equals("Update Doctor")){
             String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String gender = request.getParameter("gender");
            String degree = request.getParameter("degree");
            String insurance = request.getParameter("insurance");
            String specific = request.getParameter("specific");
            String day = request.getParameter("day");
            String ses = request.getParameter("session");
            String officeHourse = day+"--"+ses;
            String language = request.getParameter("language");
            int id = Integer.parseInt(request.getParameter("id"));
            
            Boolean check = con.updateDoctor(id, firstName, lastName, gender, degree, insurance, specific, officeHourse, language);
            if(check){
                response.sendRedirect("./doctor/doctor.jsp");
            }else{
                out.println("Error when update doctor");
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
