<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Remove Staff</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        h2 {
            color: #333;
            text-align: center;
        }
        form {
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            margin: auto;
        }
        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }
        input[type="text"], input[type="submit"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            background-color: #d9534f;
            color: white;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #c9302c;
        }
        .message {
            text-align: center;
            margin-top: 20px;
            color: #d9534f;
        }
    </style>
</head>
<body>
    <h2>Remove Admin</h2>
    <form method="post" action="removeStaff.jsp">
        <label for="adminId">Admin ID:</label>
        <input type="text" id="adminId" name="adminId" required placeholder="Enter Admin ID">
        <input type="submit" value="Remove Admin">
    </form>

    <%
    if (request.getParameter("adminId") != null) {
        int adminId = Integer.parseInt(request.getParameter("adminId"));

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/librarydb", "postgres", "Charchit@6639");

            String sql = "DELETE FROM ADMIN WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, adminId);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                out.println("<div class='message'>Admin removed successfully.</div>");
            } else {
                out.println("<div class='message'>No admin found with the given ID.</div>");
            }
        } catch (SQLException e) {
            out.println("<div class='message'>SQL Exception: " + e.getMessage() + "</div>");
        } catch (ClassNotFoundException e) {
            out.println("<div class='message'>Class Not Found Exception: " + e.getMessage() + "</div>");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    %>
</body>
</html>
