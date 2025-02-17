import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;


public class IssuedBooksServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/library";
    private static final String USER = "root";
    private static final String PASS = "root";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("issue".equals(action)) {
            issueBook(request);
        } else if ("return".equals(action)) {
            returnBook(request);
        }
        response.sendRedirect("issued_books.jsp"); // Redirect to issued books page
    }

    private void issueBook(HttpServletRequest request) {
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {
            String sql = "INSERT INTO ISSUED_BOOKS (book_id, staff_id, issue_date, return_date) VALUES (?, ?, NOW(), NULL)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(request.getParameter("bookId")));
            stmt.setInt(2, Integer.parseInt(request.getParameter("staffId")));
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void returnBook(HttpServletRequest request) {
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {
            String sql = "UPDATE ISSUED_BOOKS SET return_date = NOW() WHERE issue_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(request.getParameter("issueId")));
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
