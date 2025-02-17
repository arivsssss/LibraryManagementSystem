import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;


public class AdminServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/library";
    private static final String USER = "root"; // change as per your configuration
    private static final String PASS = "root"; // change as per your configuration

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            addAdmin(request);
        } else if ("delete".equals(action)) {
            deleteAdmin(request);
        }
        response.sendRedirect("admin.jsp"); // Redirect to admin page
    }

    private void addAdmin(HttpServletRequest request) {
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {
            String sql = "INSERT INTO ADMIN (NAME, PASSWORD, CONTACT) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, request.getParameter("name"));
            stmt.setString(2, request.getParameter("password"));
            stmt.setString(3, request.getParameter("contact"));
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void deleteAdmin(HttpServletRequest request) {
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {
            String sql = "DELETE FROM ADMIN WHERE USER_ID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(request.getParameter("userId")));
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
