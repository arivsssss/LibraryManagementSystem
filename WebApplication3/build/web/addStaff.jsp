<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Admin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #FFD500;
            margin: 0;
            padding: 20px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        form {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
        }
        input[type="number"], 
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #333;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }
        input[type="submit"]:hover {
            background-color: #555;
        }
        .message {
            text-align: center;
            color: green;
            margin-top: 20px;
        }
        .error {
            text-align: center;
            color: red;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h2>Add Admin</h2>
    <form method="post" action="addStaff.jsp">
        <label for="adminId">Admin ID:</label>
        <input type="number" id="adminId" name="adminId" required>

        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>

        <input type="submit" value="Add Admin">
    </form>

    <%
    if (request.getParameter("adminId") != null) {
        try {
            // Parse adminId as an integer
            int adminId = Integer.parseInt(request.getParameter("adminId"));
            String name = request.getParameter("name");
            String password = request.getParameter("password");

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("org.postgresql.Driver");
                conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/librarydb", "postgres", "Charchit@6639");

                String sql = "INSERT INTO ADMIN (id, name, password) VALUES (?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, adminId);  // Set the adminId as integer
                pstmt.setString(2, name);
                pstmt.setString(3, password);

                pstmt.executeUpdate();
                out.println("<div class='message'>Admin added successfully.</div>");
            } catch (SQLException e) {
                out.println("<div class='error'>SQL Exception: " + e.getMessage() + "</div>");
            } catch (ClassNotFoundException e) {
                out.println("<div class='error'>JDBC Driver not found: " + e.getMessage() + "</div>");
            } finally {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        } catch (NumberFormatException e) {
            out.println("<div class='error'>Invalid Admin ID format. Please enter a valid number.</div>");
        }
    }
    %>
</body>
</html>
