package DAO;

import MODEL.Admin;
import MODEL.Doctor;
import MODEL.Hospital;
import MODEL.Patient;
import MODEL.Specialty;
import RSA.AsymmetricCryptography;
import com.mysql.jdbc.PreparedStatement;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
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
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
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
        ArrayList<Doctor> doc = con.searchDoctor("vi");
        System.out.println(doc.size());
        for (Doctor d : doc) {
            System.out.println(d.getFirstName());
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
//for admin

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

    public boolean checkMailExist(String email, String table, String emailCol) {
        Boolean check = false;
        try {
            String query = "select u.Email from " + table + " u where u." + emailCol + " = ? ";

            PreparedStatement pr = (PreparedStatement) con.prepareStatement(query);
            pr.setString(1, email);
            System.out.println(query);
            ResultSet rs = pr.executeQuery();

            while (rs.next()) {
                check = true;
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return check;
    }

    public boolean verifyPatient(String email, String hash, String table, String emailcol) {

        try {
            String query = "update " + table + " set Status =1 where " + emailcol + "=? and hash=?";
            PreparedStatement pr = (PreparedStatement) con.prepareStatement(query);
            pr.setString(1, email);
            pr.setString(2, hash);
            System.out.println(query);
            int create = pr.executeUpdate();
            if (create > 0) {
                con.commit();
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //get user information
    public Patient getInforPatientToLogin(String email, String password) {
        String query = "select * from patient u where u.Email=? and u.Password = ? and u.Status = 1";
        Patient patient = new Patient();
        try {
            PreparedStatement pr = (PreparedStatement) con.prepareStatement(query);
            pr.setString(1, email);
            //encrypt password
            AsymmetricCryptography ac = new AsymmetricCryptography();
            PrivateKey privateKey = ac.getPrivate("D:\\HockiIINam4\\PPL\\project_PPL\\PPL\\Project_PPL\\src\\java\\KeyPair/privateKey");
            String passwordEncypt = ac.encryptText(password, privateKey);
            pr.setString(2, passwordEncypt);
            System.out.println(query);
            //deencrypt password
            AsymmetricCryptography ac2 = new AsymmetricCryptography();
            PublicKey publicKey = ac2.getPublic("D:\\HockiIINam4\\PPL\\project_PPL\\PPL\\Project_PPL\\src\\java\\KeyPair/publicKey");
            //String pass = ac2.decryptText(password, publicKey);
            ResultSet rs = pr.executeQuery();
            while (rs.next()) {
                patient.setId(rs.getInt("Id"));
                patient.setAddress(rs.getString("Address"));
                patient.setEmail(rs.getString("Email"));
                patient.setFirstName(rs.getString("FirstName"));
                patient.setGender(rs.getString("Gender"));
                patient.setLanguage(rs.getString("Language"));
                patient.setLastName(rs.getString("LastName"));
                patient.setPassword(ac2.decryptText(rs.getString("Password"), publicKey));
                patient.setRegisterDay(rs.getDate("RegisterDay").toString());
                patient.setStatus(rs.getInt("Status"));

            }
        } catch (SQLException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchPaddingException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalBlockSizeException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (BadPaddingException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvalidKeyException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        }
        return patient;
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
    public boolean saveContactComment(String userName, String email, String comments) {
        try {
//Set current time
            DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            Calendar cal = Calendar.getInstance();
            String date = dateFormat.format(cal.getTime());
            String query = "insert into contact(UserName,Email,Comments,Dates)"
                    + " values('" + userName + "','" + email + "','" + comments + "','" + date + "')";
            PreparedStatement pr = (PreparedStatement) con.prepareStatement(query);
            System.out.println(query);
            int create = pr.executeUpdate();
            if (create > 0) {
                con.commit();
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // Doctor DAO
    public ArrayList<Doctor> searchDoctor(String doctor) {
        ArrayList<Doctor> arr = new ArrayList<Doctor>();
        String query = "Select * from doctor d where d.FirstName like ? ";
        try {
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            pre.setString(1, "%" + doctor + "%");
            System.out.println(query);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Doctor doc = new Doctor();
                doc.setFirstName(rs.getString("FirstName"));
                doc.setLastName(rs.getString("LastName"));
                doc.setGender(rs.getString("Gender"));
                doc.setDegree(rs.getString("Degree"));
                doc.setInsurance(rs.getString("Insurance"));
                doc.setSpec(rs.getString("Spec"));
                doc.setOfficeHours(rs.getString("OfficeHours"));
                doc.setLanguage(rs.getString("Language"));
                arr.add(doc);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return arr;
    }

    //change password function
    public boolean changePassword(String oldPassword, String newPassword, String table, String email, String emailCol) {
        try {
            AsymmetricCryptography ac = new AsymmetricCryptography();
            PrivateKey privateKey = ac.getPrivate("D:\\HockiIINam4\\PPL\\project_PPL\\PPL\\Project_PPL\\src\\java\\KeyPair/privateKey");
            String passwordEncypt = ac.encryptText(oldPassword, privateKey);
            String newpass = ac.encryptText(newPassword, privateKey);
            String query = "update " + table + " c set c.Password = ? where c.Password =? and c." + emailCol + "=?";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            pre.setString(1, newpass);
            pre.setString(2, passwordEncypt);
            pre.setString(3, email);
            System.out.println(query);
            int check = pre.executeUpdate();
            if (check > 0) {
                con.commit();
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    //reset Password
    public boolean resetPassword(String email, String table, String emailCol) {
        try {
            AsymmetricCryptography ac = new AsymmetricCryptography();
            PrivateKey privateKey = ac.getPrivate("D:\\HockiIINam4\\PPL\\project_PPL\\PPL\\Project_PPL\\src\\java\\KeyPair/privateKey");
            String passwordEncypt = ac.encryptText("12345", privateKey);

            String query = "update " + table + " c set c.Password = ? where c." + emailCol + " =?";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            pre.setString(1, passwordEncypt);
            pre.setString(2, email);
            System.out.println(email);
            System.out.println(query);
            int check = pre.executeUpdate();
            if (check > 0) {
                con.commit();
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    //get All doctor for profile
    public ArrayList<Doctor> getAllDoctor() {
        ArrayList<Doctor> arr = new ArrayList<Doctor>();
        try {
            String query = "Select * from doctor";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            ResultSet rs = pre.executeQuery();
            System.out.println(query);
            while (rs.next()) {
                Doctor doctor = new Doctor();
                doctor.setId(rs.getInt("Id"));
                doctor.setFirstName(rs.getString("FirstName"));
                doctor.setLastName(rs.getString("LastName"));
                doctor.setGender(rs.getString("Gender"));
                doctor.setDegree(rs.getString("Degree"));
                doctor.setInsurance(rs.getString("Insurance"));
                doctor.setSpec(rs.getString("Spec"));
                doctor.setOfficeHours(rs.getString("OfficeHours"));
                doctor.setLanguage(rs.getString("Language"));
                arr.add(doctor);

            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return arr;
    }

    public boolean removePeople(String table, int id) {
        try {
            String query = "delete from " + table + "  where  Id = ? ";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            pre.setInt(1, id);
            System.out.println(query);
            int check = pre.executeUpdate();
            if (check > 0) {
                con.commit();
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public boolean addDoctor(String firstName, String lastName, String gender, String degree,
            String insurance, String spec, String officeHours, String language) {
        try {
            String query = "insert into doctor(FirstName,LastName,Gender,Degree,Insurance"
                    + ",Spec,OfficeHours,Language)"
                    + " values(?,?,?,?,?,?,?,?)";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            pre.setString(1, firstName);
            pre.setString(2, lastName);
            pre.setString(3, gender);
            pre.setString(4, degree);
            pre.setString(5, insurance);
            pre.setString(6, spec);
            pre.setString(7, officeHours);
            pre.setString(8, language);
            int check = pre.executeUpdate();
            if (check > 0) {
                con.commit();
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public boolean updateDoctor(int id, String firstName, String lastName, String gender, String degree,
            String insurance, String spec, String officeHours, String language) {
        try {
            String query = "update  doctor  "
                    + "set FirstName = ? , LastName = ?,  Gender = ? ,"
                    + "Degree = ? , Insurance = ? ,  Spec = ? ,"
                    + "OfficeHours = ? , Language = ? "
                    + "where Id =? ";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            pre.setString(1, firstName);
            pre.setString(2, lastName);
            pre.setString(3, gender);
            pre.setString(4, degree);
            pre.setString(5, insurance);
            pre.setString(6, spec);
            pre.setString(7, officeHours);
            pre.setString(8, language);
            pre.setInt(9, id);
            System.out.println(query);
            int check = pre.executeUpdate();
            if (check > 0) {
                con.commit();
                return true;
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public Doctor getDoctorById(int id) {
        Doctor doctor = new Doctor();
        try {
            String query = "Select * from doctor d where d.Id = ? ";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            pre.setInt(1, id);
            System.out.println(query);

            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                doctor.setId(rs.getInt("Id"));
                doctor.setFirstName(rs.getString("FirstName"));
                doctor.setLastName(rs.getString("LastName"));
                doctor.setGender(rs.getString("Gender"));
                doctor.setDegree(rs.getString("Degree"));
                doctor.setInsurance(rs.getString("Insurance"));
                doctor.setSpec(rs.getString("Spec"));
                doctor.setOfficeHours(rs.getString("OfficeHours"));
                doctor.setLanguage(rs.getString("Language"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return doctor;
    }

    //Patient
    public ArrayList<Patient> getAllPatient() {
        ArrayList<Patient> arr = new ArrayList<Patient>();

        try {
            //decrypt password
            AsymmetricCryptography ac2 = new AsymmetricCryptography();
            PublicKey publicKey = ac2.getPublic("D:\\HockiIINam4\\PPL\\project_PPL\\PPL\\Project_PPL\\src\\java\\KeyPair/publicKey");

            String query = "Select * from patient";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            ResultSet rs = pre.executeQuery();
            System.out.println(query);
            while (rs.next()) {
                Patient patient = new Patient();
                patient.setId(rs.getInt("Id"));
                patient.setFirstName(rs.getString("FirstName"));
                patient.setLastName(rs.getString("LastName"));
                patient.setGender(rs.getString("Gender"));
                patient.setEmail(rs.getString("Email"));

                String pass = ac2.decryptText(rs.getString("Password"), publicKey);
                patient.setPassword(pass);
                patient.setAddress(rs.getString("Address"));
                patient.setLanguage(rs.getString("Language"));
                patient.setRegisterDay(rs.getDate("RegisterDay").toString());
                patient.setStatus(rs.getInt("Status"));
                arr.add(patient);

            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return arr;
    }

    public Patient getPatientById(int id) {
        Patient patient = new Patient();
        try {
            //decrypt password
            AsymmetricCryptography ac2 = new AsymmetricCryptography();
            PublicKey publicKey = ac2.getPublic("D:\\HockiIINam4\\PPL\\project_PPL\\PPL\\Project_PPL\\src\\java\\KeyPair/publicKey");

            String query = "Select * from patient p where p.Id = ? ";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            System.out.println(query);
            while (rs.next()) {
                patient.setId(rs.getInt("Id"));
                patient.setFirstName(rs.getString("FirstName"));
                patient.setLastName(rs.getString("LastName"));
                patient.setGender(rs.getString("Gender"));
                patient.setEmail(rs.getString("Email"));

                String pass = ac2.decryptText(rs.getString("Password"), publicKey);
                patient.setPassword(pass);
                patient.setAddress(rs.getString("Address"));
                patient.setLanguage(rs.getString("Language"));
                patient.setRegisterDay(rs.getDate("RegisterDay").toString());
                patient.setStatus(rs.getInt("Status"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return patient;
    }

    public boolean updatePatient(int id, String firstName, String lastName, String gender,
            String email, String password, String address, String language, int status) {

        try {
            AsymmetricCryptography ac = new AsymmetricCryptography();
            PrivateKey privateKey = ac.getPrivate("D:\\HockiIINam4\\PPL\\project_PPL\\PPL\\Project_PPL\\src\\java\\KeyPair/privateKey");
            String passwordEncypt = ac.encryptText(password, privateKey);

            String query = "update  patient  "
                    + "set FirstName = ? , LastName = ?,  Gender = ? ,"
                    + "Email = ? , Password = ? ,  Address = ? ,"
                    + "Language = ? , Status = ? "
                    + "where Id =? ";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            pre.setString(1, firstName);
            pre.setString(2, lastName);
            pre.setString(3, gender);
            pre.setString(4, email);
            pre.setString(5, passwordEncypt);
            pre.setString(6, address);
            pre.setString(7, language);
            pre.setInt(8, status);
            pre.setInt(9, id);
            System.out.println(query);
            int check = pre.executeUpdate();
            if (check > 0) {
                con.commit();
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;

    }
//removePeople(table, id) to remove patient
// addPatient using create Patient

    public boolean createPatient(String firstName, String lastName, String gender,
            String email, String password, String address,
            String language, String hash) {
        //Set current time
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        String registerDay = dateFormat.format(cal.getTime());
        try {
            //encrypt password
            AsymmetricCryptography ac = new AsymmetricCryptography();
            PrivateKey privateKey = ac.getPrivate("D:\\HockiIINam4\\PPL\\project_PPL\\PPL\\Project_PPL\\src\\java\\KeyPair/privateKey");
            String passwordEncypt = ac.encryptText(password, privateKey);
            String query = "insert into patient(FirstName,LastName,Gender,Email,Password,Address,Language,Hash,RegisterDay)"
                    + " values('" + firstName + "','" + lastName + "','" + gender + "','" + email + "','" + passwordEncypt + "','" + address + "'"
                    + ",'" + language + "','" + hash + "','" + registerDay + "')";
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

    //admin
    public Admin getInforAdminToLogin(String email, String password) {
        String query = "select * from user u where u.Email=? and u.Password = ?";
        Admin admin = new Admin();
        try {
            PreparedStatement pr = (PreparedStatement) con.prepareStatement(query);
            pr.setString(1, email);
            //encrypt password
            AsymmetricCryptography ac = new AsymmetricCryptography();
            PrivateKey privateKey = ac.getPrivate("D:\\HockiIINam4\\PPL\\project_PPL\\PPL\\Project_PPL\\src\\java\\KeyPair/privateKey");
            String passwordEncypt = ac.encryptText(password, privateKey);
            pr.setString(2, passwordEncypt);
            System.out.println(query);
            //deencrypt password
            AsymmetricCryptography ac2 = new AsymmetricCryptography();
            PublicKey publicKey = ac2.getPublic("D:\\HockiIINam4\\PPL\\project_PPL\\PPL\\Project_PPL\\src\\java\\KeyPair/publicKey");
            //String pass = ac2.decryptText(password, publicKey);
            ResultSet rs = pr.executeQuery();
            while (rs.next()) {
                admin.setId(rs.getInt("Id"));
                admin.setAddress(rs.getString("Address"));
                admin.setEmail(rs.getString("Email"));
                admin.setFirstName(rs.getString("FirstName"));
                admin.setGender(rs.getString("Gender"));
                admin.setLanguage(rs.getString("Language"));
                admin.setLastName(rs.getString("LastName"));
                admin.setPassword(ac2.decryptText(rs.getString("Password"), publicKey));
                admin.setRegisterDay(rs.getDate("RegisterDay").toString());
                admin.setStatus(rs.getInt("Status"));
                admin.setDateOfBirth(rs.getDate("DateOfBirth").toString());
                admin.setAvatar(rs.getString("Avatar"));

            }
        } catch (SQLException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchPaddingException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalBlockSizeException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (BadPaddingException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvalidKeyException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        }
        return admin;
    }
    //hospital

    public Hospital getHospitalById(int id) {
        Hospital hospital = new Hospital();
        try {
            AsymmetricCryptography ac2 = new AsymmetricCryptography();
            PublicKey publicKey = ac2.getPublic("D:\\HockiIINam4\\PPL\\project_PPL\\PPL\\Project_PPL\\src\\java\\KeyPair/publicKey");

            String query = "Select * from hospital h where h.Id = ? ";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            System.out.println(query);
            while (rs.next()) {
                hospital.setId(rs.getInt("Id"));
                hospital.setName(rs.getString("Name"));
                hospital.setAddress(rs.getString("Address"));
                hospital.setWebsite(rs.getString("Website"));
                hospital.setAdminName(rs.getString("AdminName"));
                hospital.setEmail(rs.getString("AdminEmail"));
                String pass = ac2.decryptText(rs.getString("Password"), publicKey);
                hospital.setPassword(pass);
                hospital.setStatus(rs.getInt("Status"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return hospital;

    }

    public ArrayList<Hospital> getAllHospital() {
        ArrayList<Hospital> arr = new ArrayList<Hospital>();
        try {
            AsymmetricCryptography ac2 = new AsymmetricCryptography();
            PublicKey publicKey = ac2.getPublic("D:\\HockiIINam4\\PPL\\project_PPL\\PPL\\Project_PPL\\src\\java\\KeyPair/publicKey");

            String query = "Select * from hospital";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            System.out.println(query);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Hospital hospital = new Hospital();
                hospital.setId(rs.getInt("Id"));
                hospital.setName(rs.getString("Name"));
                hospital.setAddress(rs.getString("Address"));
                hospital.setWebsite(rs.getString("Website"));
                hospital.setAdminName(rs.getString("AdminName"));
                hospital.setEmail(rs.getString("AdminEmail"));
                String pass = ac2.decryptText(rs.getString("Password"), publicKey);
                hospital.setPassword(pass);
                hospital.setStatus(rs.getInt("Status"));
                arr.add(hospital);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return arr;
    }
    //for hospital

    public boolean updateHospitalById(int id, String name, String address, String website,
            String adminEmail, String adminName, String password) {
        try {
            AsymmetricCryptography ac = new AsymmetricCryptography();
            PrivateKey privateKey = ac.getPrivate("D:\\HockiIINam4\\PPL\\project_PPL\\PPL\\Project_PPL\\src\\java\\KeyPair/privateKey");
            String passwordEncypt = ac.encryptText(password, privateKey);

            String query = "update hospital "
                    + "set Name = ? , Address = ?,  Website = ? ,"
                    + "AdminEmail = ? , AdminName = ? ,Password = ? "
                    + "where Id =? ";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            pre.setString(1, name);
            pre.setString(2, address);
            pre.setString(3, website);
            pre.setString(4, adminEmail);
            pre.setString(5, adminName);
            pre.setString(6, passwordEncypt);
            pre.setInt(7, id);
            System.out.println(query);
            int check = pre.executeUpdate();
            if (check > 0) {
                con.commit();
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public boolean updateHospitalAdminById(int id, String name, String address, String website,
            String adminEmail, String adminName, String password, int status) {
        try {
            AsymmetricCryptography ac = new AsymmetricCryptography();
            PrivateKey privateKey = ac.getPrivate("D:\\HockiIINam4\\PPL\\project_PPL\\PPL\\Project_PPL\\src\\java\\KeyPair/privateKey");
            String passwordEncypt = ac.encryptText(password, privateKey);

            String query = "update hospital "
                    + "set Name = ? , Address = ?,  Website = ? , "
                    + "AdminEmail = ? , AdminName = ? , Password = ? ,Status = ? "
                    + "where Id =? ";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            pre.setString(1, name);
            pre.setString(2, address);
            pre.setString(3, website);
            pre.setString(4, adminEmail);
            pre.setString(5, adminName);
            pre.setString(6, passwordEncypt);
            pre.setInt(7, status);
            pre.setInt(8, id);
            System.out.println(query);
            int check = pre.executeUpdate();
            if (check > 0) {
                con.commit();
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }
    //Hospital

    public Boolean createHospital(String name, String address, String website,
            String adminName, String email, String password, String hash) {
        String query = "insert into hospital(Name,Address,Website,AdminName, AdminEmail, Password,Hash)"
                + " values(?,?,?,?,?,?,?)";
        //encrypt password
        try {
            AsymmetricCryptography ac = new AsymmetricCryptography();
            PrivateKey privateKey = ac.getPrivate("D:\\HockiIINam4\\PPL\\project_PPL\\PPL\\Project_PPL\\src\\java\\KeyPair/privateKey");
            String passwordEncypt = ac.encryptText(password, privateKey);

            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            pre.setString(1, name);
            pre.setString(2, address);
            pre.setString(3, website);
            pre.setString(4, adminName);
            pre.setString(5, email);
            pre.setString(6, passwordEncypt);
            pre.setString(7, hash);

            System.out.println(query);
            int create = pre.executeUpdate();

            if (create > 0) {
                con.commit();
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return false;
    }
    //get user information

    public Hospital getInforHospitalToLogin(String email, String password) {
        String query = "select * from hospital u where u.AdminEmail=? and u.Password = ? and u.Status = 1";
        Hospital hospital = new Hospital();
        try {
            PreparedStatement pr = (PreparedStatement) con.prepareStatement(query);
            pr.setString(1, email);
            //encrypt password
            AsymmetricCryptography ac = new AsymmetricCryptography();
            PrivateKey privateKey = ac.getPrivate("D:\\HockiIINam4\\PPL\\project_PPL\\PPL\\Project_PPL\\src\\java\\KeyPair/privateKey");
            String passwordEncypt = ac.encryptText(password, privateKey);
            pr.setString(2, passwordEncypt);
            System.out.println(query);
            //deencrypt password
            AsymmetricCryptography ac2 = new AsymmetricCryptography();
            PublicKey publicKey = ac2.getPublic("D:\\HockiIINam4\\PPL\\project_PPL\\PPL\\Project_PPL\\src\\java\\KeyPair/publicKey");
            //String pass = ac2.decryptText(password, publicKey);
            ResultSet rs = pr.executeQuery();
            while (rs.next()) {
                hospital.setId(rs.getInt("Id"));
                hospital.setAddress(rs.getString("Address"));
                hospital.setEmail(rs.getString("AdminEmail"));
                hospital.setPassword(ac2.decryptText(rs.getString("Password"), publicKey));
                hospital.setStatus(rs.getInt("Status"));
                hospital.setName(rs.getString("Name"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchPaddingException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalBlockSizeException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (BadPaddingException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvalidKeyException ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Connect.class.getName()).log(Level.SEVERE, null, ex);
        }
        return hospital;
    }

    //Specialty
    public ArrayList<Specialty> getAllSpecialty() {
        ArrayList<Specialty> arr = new ArrayList<Specialty>();
        try {
            String query = "Select * from specialty";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                Specialty spec = new Specialty();
                spec.setId(rs.getInt("Id"));
                spec.setSpec(rs.getString("Specialty"));
                arr.add(spec);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return arr;
    }

    public Specialty getSpecById(int id) {
        Specialty spec = new Specialty();
        try {
            String query = "Select * from specialty s where s.Id = ? ";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            pre.setInt(1, id);
            System.out.println(query);

            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                spec.setId(rs.getInt("Id"));
                spec.setSpec(rs.getString("Specialty"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return spec;
    }

    public boolean updateSpecById(int id, String spec) {
        try {
            String query = "update specialty set Specialty = ? where id = ? ";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            pre.setString(1, spec);
            pre.setInt(2, id);
            System.out.println(query);
            int check = pre.executeUpdate();
            if (check > 0) {
                con.commit();
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public boolean addSpecialty(String spec) {
        try {
            String query = "insert into specialty(Specialty) values( ? )";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            pre.setString(1, spec);
            System.out.println(query);
            int check = pre.executeUpdate();
            if (check > 0) {
                con.commit();
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    //Bookmark
    public ArrayList<Integer> getPeopleIdbyPatientId(int patientId, String targetID) {
        ArrayList<Integer> arr = new ArrayList<Integer>();
        try {
            String query = "Select b." + targetID + " from bookmark b where b.PatientID = ? ";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            pre.setInt(1, patientId);
            System.out.println(query);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                int i = rs.getInt(targetID);
                arr.add(i);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return arr;

    }

    public Doctor getDoctorBookMark(int doctorId) {
      Doctor doctor = new Doctor();
        try {
            String query = "select * from doctor u where u.Id = ? ";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            pre.setInt(1, doctorId);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
          
                doctor.setId(rs.getInt("Id"));
                doctor.setFirstName(rs.getString("FirstName"));
                doctor.setLastName(rs.getString("LastName"));
                doctor.setGender(rs.getString("Gender"));
                doctor.setDegree(rs.getString("Degree"));
                doctor.setInsurance(rs.getString("Insurance"));
                doctor.setSpec(rs.getString("Spec"));
                doctor.setOfficeHours(rs.getString("OfficeHours"));
                doctor.setLanguage(rs.getString("Language"));
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return doctor;
    }

    public ArrayList<Hospital> getHospitalBookMark(int hospitalId) {
        ArrayList<Hospital> arr = new ArrayList<Hospital>();
        try {
            AsymmetricCryptography ac2 = new AsymmetricCryptography();
            PublicKey publicKey = ac2.getPublic("D:\\HockiIINam4\\PPL\\project_PPL\\PPL\\Project_PPL\\src\\java\\KeyPair/publicKey");

            String query = "Select * from hospital h where h.Id = ? ";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            pre.setInt(1, hospitalId);
            ResultSet rs = pre.executeQuery();
            System.out.println(query);
            while (rs.next()) {
                Hospital hospital = new Hospital();
                hospital.setId(rs.getInt("Id"));
                hospital.setName(rs.getString("Name"));
                hospital.setAddress(rs.getString("Address"));
                hospital.setWebsite(rs.getString("Website"));
                hospital.setAdminName(rs.getString("AdminEmail"));
                String pass = ac2.decryptText(rs.getString("Password"), publicKey);
                hospital.setPassword(pass);
                hospital.setStatus(rs.getInt("Status"));
                arr.add(hospital);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return arr;
    }
    
      public boolean removePeopleBookMark(int targetId, String targetCol,int patientId) {//DoctorID, HospitalID
        try {
            String query = "delete from bookmark  where  "+targetCol+" = ? AND PatientID = ?";
            PreparedStatement pre = (PreparedStatement) con.prepareStatement(query);
            pre.setInt(1, targetId);
            pre.setInt(2, patientId);
            System.out.println(query);
            int check = pre.executeUpdate();
            if (check > 0) {
                con.commit();
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }
      
      public boolean LikePeopleAndToBookMark(int targetID, int patientID, String targetCol){
          try{
              String query = "insert into bookmark ("+targetCol+",PatientID) values ( ?, ?) ";
              PreparedStatement pre = (PreparedStatement)con.prepareStatement(query);
              pre.setInt(1, targetID);
              pre.setInt(2, patientID);
              System.out.println(query);
              int check = pre.executeUpdate();
              if(check > 0){
                  con.commit();
                  return true;
              }
          }catch(Exception ex){
              ex.printStackTrace();
          }
          return false;
      }
     
      public boolean isPeopleExitInBookmark(int targetId, int patientId, String targetCol){
          try{
              String query = "select * from bookmark b where b."+targetCol+" = ? AND b.PatientID = ? ";
              PreparedStatement pre = (PreparedStatement)con.prepareStatement(query);
              pre.setInt(1, targetId);
              pre.setInt(2, patientId);
              ResultSet rs = pre.executeQuery();
              System.out.println(query);
              int id = 0;
              while(rs.next()){
                  id = rs.getInt(targetCol);
              }
              if(id != 0){
                  return true;
              }
          }catch(Exception ex){
              ex.printStackTrace();
          }
          return false;
      }
}
