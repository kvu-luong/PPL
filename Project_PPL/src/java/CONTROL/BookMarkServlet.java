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
public class BookMarkServlet extends HttpServlet {

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
        if (action.equals("HospitalLike")) {
            int hospitalId = Integer.parseInt(request.getParameter("hospitalId"));
            int patientId = Integer.parseInt(request.getParameter("patientId"));
            boolean checkExit = con.isPeopleExitInBookmark(hospitalId, patientId, "HospitalID");
            if (!checkExit) {
                boolean check = con.LikePeopleAndToBookMark(hospitalId, patientId, "HospitalID");
                if (check) {
                    response.sendRedirect("./hospital/viewAllHospitalForBookMark.jsp");
                } else {
                    out.println("error when add hospital to bookmark");
                }
            } else {
                response.sendRedirect("./hospital/viewAllHospitalForBookMark.jsp");
                System.out.println("Target has been exited");
            }
        } else if (action.equals("DoctorLike")) {
            int doctorId = Integer.parseInt(request.getParameter("doctorId"));
            int patientId = Integer.parseInt(request.getParameter("patientId"));
            boolean checkExit = con.isPeopleExitInBookmark(doctorId, patientId, "DoctorID");
            if (!checkExit) {
                boolean check = con.LikePeopleAndToBookMark(doctorId, patientId, "DoctorID");
                if (check) {
                    response.sendRedirect("./doctor/viewAllDoctorForBookMark.jsp");
                } else {
                    out.println("error when update doctor to bookmark");
                }
            } else {
                response.sendRedirect("./doctor/viewAllDoctorForBookMark.jsp");
                System.out.println("Target has been exited");
            }
        } else if (action.equals("DoctorDisLike")) {
            int doctorId = Integer.parseInt(request.getParameter("doctorId"));
            int patientId = Integer.parseInt(request.getParameter("patientId"));
            boolean check = con.removePeopleBookMark(doctorId, "DoctorID", patientId);
            if (check) {
                response.sendRedirect("./patient/myDoctorBookMark.jsp");
            } else {
                out.println("Error when dislike doctor in bookmark");
            }
        } else if (action.equals("HospitalDisLike")) {
            int hospitalId = Integer.parseInt(request.getParameter("hospitalId"));
            int patientId = Integer.parseInt(request.getParameter("patientId"));
            boolean check = con.removePeopleBookMark(hospitalId, "HospitalID", patientId);
            if (check) {
                response.sendRedirect("./patient/myHospitalBookMark.jsp");
            } else {
                out.println("Error when dislike doctor in bookmark");
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
