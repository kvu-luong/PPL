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
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author PC
 */
public class MailServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
           response.setContentType("text/html;charset=UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();//print on browser
        Connect con = new Connect();
        con.open(database, port);

        String action = request.getParameter("action");
        if(action.equals("Send")){
            String userName = request.getParameter("UserName");
            String email = request.getParameter("Email");
            String comments = request.getParameter("Comments");
            
            boolean checkSendMail = Mail.sendMail(email,"Request for Help","We have already received your request, We will reply soon!");
            if(checkSendMail){
                con.saveContactComment(userName, email, comments);
               
                 request.setAttribute("SendMail","ok");
                 response.sendRedirect("index_1.jsp");
            }else{
                 
                request.setAttribute("SendMail","no");
                request.getRequestDispatcher("index_1.jsp").forward(request, response);
            }
        }
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
