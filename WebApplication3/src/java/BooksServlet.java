import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

public class BooksServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/test_bigdata";
    private static final String USER = "root";
    private static final String PASS = "root";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            addBook(request);
        } else if ("delete".equals(action)) {
            deleteBook(request);
        }
        response.sendRedirect("books.jsp"); // Redirect to books page
    }

    private void addBook(HttpServletRequest request) {
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {
            String sql = "INSERT INTO BOOKS (CATEGORY, NAME, AUTHOR, COPIES) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, request.getParameter("category"));
            stmt.setString(2, request.getParameter("name"));
            stmt.setString(3, request.getParameter("author"));
            stmt.setInt(4, Integer.parseInt(request.getParameter("copies")));
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void deleteBook(HttpServletRequest request) {
        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {
            String sql = "DELETE FROM BOOKS WHERE BOOK_ID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(request.getParameter("bookId")));
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
