package DAO;

import MODEL.User;
import RSA.AsymmetricCryptography;
import com.mysql.jdbc.PreparedStatement;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.NoSuchPaddingException;

/**
 *
 * @author PC
 */
public class Connect {

    private Connection con;
    public static final String database = "ppl";
    public static final String port = "3306";

    public static void main(String[] args) throws NoSuchAlgorithmException, NoSuchPaddingException, Exception {
        Scanner input = new Scanner(System.in);
        Connect con = new Connect();

        con.open(database, port);
       
      
        boolean check = con.checkUserName("luongkhanhvu1392@gmail.com");
        if (check) {
            System.out.println("ok");
        } else {
            System.out.println("no");
        }

        con.close();
    }

    public Connection getConnection(String dataName, String port) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:" + port + "/" + dataName + "?useUnicode=true&characterEncoding=UTF-8";
            con = (Connection) DriverManager.getConnection(url, "root", "");
            con.setAutoCommit(false);//dùng cho update và insert hoặc delete
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        }
        return con;
    }

    public void open(String dataName, String port) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:" + port + "/" + dataName + "?useUnicode=true&characterEncoding=UTF-8";
            con = (Connection) DriverManager.getConnection(url, "root", "");
            con.setAutoCommit(false);//dùng cho update và insert hoặc delete
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void close() {
        try {
            con.close();
        } catch (SQLException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //so sánh xem user đã tồn tại trong data chưa cho chức năng login
    public boolean checkUserName(String email) {
        ArrayList list = new ArrayList();
        try {
            String query = "Select u.Email From user u where u.Email = '" + email + "'";
            PreparedStatement pr = (PreparedStatement) con.prepareStatement(query);
            System.out.println(query);
            ResultSet rs = pr.executeQuery();
            //check username exist or not
            while (rs.next()) {
                String name = rs.getString(1);
                list.add(name);
            }
            if (list.size() > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
//Checking when user login
    public boolean checkAccount(String Email, String password) {
        ArrayList list = new ArrayList();
        try {
            //encrypt passwork for checking
            AsymmetricCryptography ac = new AsymmetricCryptography();
            PrivateKey privateKey = ac.getPrivate("D:\\HockiIINam4\\PPL\\project_PPL\\PPL\\Project_PPL\\src\\java\\KeyPair/privateKey");
            String passwordEncypt = ac.encryptText(password, privateKey);
            
            String query = "select u.Email from user u where u.Email = '" + Email + "' and u.Password='" + passwordEncypt + "'";
            PreparedStatement pr = (PreparedStatement) con.prepareStatement(query);
            System.out.println(query);
            ResultSet rs = pr.executeQuery();

            while (rs.next()) {
                String name = rs.getString(1);
                list.add(name);
            }
            if (list.size() > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchPaddingException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean createAccount(String firstName, String lastName, String gender,
            String email, String password, String phone, String address,
            String language, String avatar, String dateOfBirth, String role, int status) {
        //Set current time
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        String registerDay = dateFormat.format(cal.getTime());
        try {
            //encrypt password
            AsymmetricCryptography ac = new AsymmetricCryptography();
            PrivateKey privateKey = ac.getPrivate("D:\\HockiIINam4\\PPL\\project_PPL\\PPL\\Project_PPL\\src\\java\\KeyPair/privateKey");
            String passwordEncypt = ac.encryptText(password, privateKey);
            
            String query = "insert into user(FirstName,LastName,Gender,Email,Password,Phone,Address,Language,Avatar,DateOfBirth,RegisterDay,Role,Status)"
                    + " values('" + firstName + "','" + lastName + "','" + gender + "','" + email + "','" + passwordEncypt + "','" + phone + "','" + address + "'"
                    + ",'" + language + "','" + avatar + "','" + dateOfBirth + "'"
                    + ",'" + registerDay + "','" + role + "','" + status + "')";
            PreparedStatement pr = (PreparedStatement) con.prepareStatement(query);
            System.out.println(query);
            int create = pr.executeUpdate();
            if (create > 0) {
                con.commit();
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchPaddingException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //get user information
    public User getInforUser(String email) {
        String query = "select * from user u where u.Username='" + email+ "'";
        User user = new User();
        try {
            PreparedStatement pr = (PreparedStatement) con.prepareStatement(query);
            ResultSet rs = pr.executeQuery();
            while (rs.next()) {

                user.setPhone(rs.getString("Phone"));
                user.setId(rs.getInt("ID"));

            }
        } catch (SQLException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

//update password sau khi remind
    public boolean updatePasswordWithUserName(String password, String username) {

        try {
            String query = "update userinfo c set c.Password = '" + password + "' where c.Username = '" + username + "'";
            PreparedStatement pr = (PreparedStatement) con.prepareStatement(query);
            System.out.println(query);
            int rs = pr.executeUpdate();
            if (rs > 0) {
                con.commit();
                return true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    //xử lý chuổi color trong bảng design
    public static String[] xuLyChuoibySplit(String chuoi) {
        String[] c = chuoi.split(",");
        return c;
    }

    public int countProduct() {
        String query = "select p.IdChild from product_info p";
        int i = 0;
        try {
            PreparedStatement pr = (PreparedStatement) con.prepareStatement(query);
            ResultSet rs = pr.executeQuery();
            while (rs.next()) {
                i++;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        }
        return i;
    }

    //check authority
    public boolean checkAuthority(String userName) {
        String query = "select u.level from userinfo u where u.Username = '" + userName + "'";
        try {
            PreparedStatement pr = (PreparedStatement) con.prepareStatement(query);
            ResultSet rs = pr.executeQuery();
            int level = 1;
            while (rs.next()) {
                level = rs.getInt("level");
            }
            if (level != 1) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean checkApprove(String username) {
        String status = "";
        try {
            String query = "select u.Status from userinfo u where u.Username ='" + username + "'";

            PreparedStatement pr = (PreparedStatement) con.prepareStatement(query);
            ResultSet rs = pr.executeQuery();

            while (rs.next()) {
                status = rs.getString("Status");
            }
            if (status.equals("Yes")) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;

    }
    
    //Contact funtions
    public boolean saveContactComment(String userName, String email, String comments){
        try{
            
            String query = "insert into contact(UserName,Email,Comments)"
                    + " values('" + userName + "','" + email + "','" + comments + "')";
            PreparedStatement pr = (PreparedStatement) con.prepareStatement(query);
            System.out.println(query);
            int create = pr.executeUpdate();
            if (create > 0) {
                con.commit();
                return true;
            } 
        }catch(Exception ex){
            ex.printStackTrace();
        }
        return false;
    }
}
