<%@ include file="header.jsp" %>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Book</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #FFD500; /* Background color */
            margin: 0;
            padding: 20px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        form {
            max-width: 400px; /* Set a maximum width for the form */
            margin: 0 auto; /* Center the form */
            padding: 20px;
            background-color: white; /* White background for form */
            border-radius: 8px; /* Rounded corners */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow */
        }
        input[type="text"],
        input[type="number"] {
            width: 100%; /* Full width for input fields */
            padding: 10px; /* Padding for input fields */
            margin: 10px 0; /* Margin for spacing */
            border: 1px solid #ccc; /* Light border */
            border-radius: 4px; /* Rounded corners */
            box-sizing: border-box; /* Include padding in width */
        }
        input[type="submit"] {
            background-color: #333; /* Button color */
            color: white; /* Button text color */
            border: none; /* Remove border */
            padding: 10px; /* Padding for button */
            border-radius: 4px; /* Rounded corners for button */
            cursor: pointer; /* Pointer cursor */
            font-size: 16px; /* Font size */
            width: 100%; /* Full width */
        }
        input[type="submit"]:hover {
            background-color: #555; /* Darker shade on hover */
        }
        .message {
            text-align: center;
            color: green; /* Success message color */
            margin-top: 20px;
        }
        .error {
            text-align: center;
            color: red; /* Error message color */
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h2>Add a New Book</h2>
    <form method="post" action="addBook.jsp">
        <label for="bookId">Book ID:</label>
        <input type="number" id="bookId" name="bookId" required>

        <label for="bookName">Book Name:</label>
        <input type="text" id="bookName" name="bookName" required>

        <label for="author">Author:</label>
        <input type="text" id="author" name="author" required>

        <label for="category">Category:</label>
        <input type="text" id="category" name="category" required>

        <label for="copies">Copies:</label>
        <input type="number" id="copies" name="copies" required>

        <input type="submit" value="Add Book">
    </form>

    <%
    // Checking if the form has been submitted with all required parameters
    if (request.getParameter("bookId") != null && request.getParameter("bookName") != null) {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        String bookName = request.getParameter("bookName");
        String author = request.getParameter("author");
        String category = request.getParameter("category");
        int copies = Integer.parseInt(request.getParameter("copies"));

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/librarydb", "postgres", "Charchit@6639");

            // SQL query to insert book data
            String sql = "INSERT INTO BOOKS (book_id, name, author, category, copies) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bookId);
            pstmt.setString(2, bookName);
            pstmt.setString(3, author);
            pstmt.setString(4, category);
            pstmt.setInt(5, copies);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                out.println("<div class='message'>Book added successfully.</div>");
            } else {
                out.println("<div class='error'>Failed to add book.</div>");
            }

        } catch (SQLException e) {
            out.println("<div class='error'>SQL Exception: " + e.getMessage() + "</div>");
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            out.println("<div class='error'>Class Not Found Exception: " + e.getMessage() + "</div>");
            e.printStackTrace();
        } finally {
            // Close resources
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
