<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html lang="en">
<head>
    <title>Login Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('images/login.jpg'); /* Correct path to the image */
            background-size: cover; /* Cover the entire viewport */
            background-position: center; /* Center the background image */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Full height of the viewport */
        }
        .container {
            text-align: center; /* Center the header text */
        }
        h2 {
            color: white; /* White color for header */
            margin-bottom: 20px;
        }
        form {
            background-color: rgba(255, 255, 255, 0.9); /* White with some transparency */
            border-radius: 10px; /* Rounded corners */
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2); /* Subtle shadow */
            padding: 30px; /* Padding inside the form */
            max-width: 350px; /* Slightly wider form */
            width: 100%; /* Full width */
            box-sizing: border-box; /* Include padding and border in width */
            margin: 0 auto; /* Center form horizontally */
        }
        input[type="text"],
        input[type="password"] {
            width: 100%; /* Full width input */
            padding: 12px; /* Padding for inputs */
            margin: 15px 0; /* Margin for spacing */
            border: 1px solid #ccc; /* Light gray border */
            border-radius: 5px; /* Rounded corners for inputs */
            box-sizing: border-box; /* Include padding and border in total width */
        }
        input[type="submit"] {
            background-color: #28a745; /* Green background for submit button */
            color: white; /* White text for button */
            border: none; /* No border */
            padding: 12px; /* Padding for button */
            cursor: pointer; /* Pointer cursor on hover */
            border-radius: 5px; /* Rounded corners for button */
            width: 100%; /* Full width button */
            font-size: 16px; /* Larger font for submit button */
            transition: background-color 0.3s; /* Smooth transition for background */
        }
        input[type="submit"]:hover {
            background-color: #218838; /* Darker green on hover */
        }
        .error {
            color: red; /* Red color for error messages */
            text-align: center; /* Center the error message */
            margin-top: 10px;
        }
        label {
            font-size: 14px;
            color: #333; /* Dark color for labels */
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>AM LIBRARY LOGIN</h2>
        <form method="post" action="">
            <label for="username">Username:</label>
            <input type="text" name="username" required>

            <label for="password">Password:</label>
            <input type="password" name="password" required>

            <input type="submit" value="Login">
        </form>
    </div>

    <% 
    if(request.getParameter("username") != null && request.getParameter("password") != null) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/librarydb", "postgres", "Charchit@6639");

            String sql = "SELECT * FROM ADMIN WHERE NAME=? AND PASSWORD=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if(rs.next()) {
                response.sendRedirect("index.html");
            } else {
                out.println("<p class='error'>Invalid username or password.</p>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(rs != null) rs.close();
            if(pstmt != null) pstmt.close();
            if(conn != null) conn.close();
        }
    }
    %>
</body>
</html>
