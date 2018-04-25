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
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();//print on browser
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
if(role =="admin"){
    r =1;
}
    
            out.println(firstName + "-" + lastName + "-" + email + "-" + password + "-" + confirmPass + "-" + address + "-"
                    + phone + "-" + gender + "-" + avatar + "-" + dateOfBirth + "-" + language + "-" + role);
            boolean newAccount = con.createAccount(firstName, lastName, gender, email, password, phone, address, language, avatar, dateOfBirth, role, r);
            if(newAccount){
                out.println("ok");
               response.sendRedirect("/Project_PPL/page/admin.jsp");
            }else{
                out.println("Not Yet");
            }

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
