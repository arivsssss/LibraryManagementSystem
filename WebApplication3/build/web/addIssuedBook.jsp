<%@ include file="header.jsp" %> 
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Issue a Book</title>
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
        input[type="text"],
        input[type="date"] {
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
    <h2>Issue a Book</h2>
    <form method="post" action="addIssuedBook.jsp">
        <label for="bookId">Book ID:</label>
        <input type="text" id="bookId" name="bookId" required>

        <label for="staffId">Staff ID:</label>
        <input type="text" id="staffId" name="staffId" required>

        <label for="issueDate">Issue Date:</label>
        <input type="date" id="issueDate" name="issueDate" required>

        <label for="returnDate">Return Date:</label>
        <input type="date" id="returnDate" name="returnDate">

        <input type="submit" value="Issue Book">
    </form>

    <%
    if (request.getParameter("bookId") != null && request.getParameter("staffId") != null) {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int staffId = Integer.parseInt(request.getParameter("staffId"));
        String issueDateStr = request.getParameter("issueDate");
        String returnDateStr = request.getParameter("returnDate");

        Connection conn = null;
        PreparedStatement pstmt = null;
        PreparedStatement updateStmt = null;
        ResultSet rs = null;

        try {
            // Parse the string to java.sql.Date
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            java.sql.Date issueDate = new java.sql.Date(dateFormat.parse(issueDateStr).getTime());
            java.sql.Date returnDate = null;

            if (returnDateStr != null && !returnDateStr.isEmpty()) {
                returnDate = new java.sql.Date(dateFormat.parse(returnDateStr).getTime());
            }

            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/librarydb", "postgres", "Charchit@6639");

            // Check if the book has available copies
            String checkAvailabilitySql = "SELECT copies FROM books WHERE book_id = ?";
            pstmt = conn.prepareStatement(checkAvailabilitySql);
            pstmt.setInt(1, bookId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                int availableCopies = rs.getInt("copies");

                if (availableCopies > 0) {
                    // Proceed with the transaction
                    String insertSql = "INSERT INTO issued_books (book_id, staff_id, issue_date, return_date) VALUES (?, ?, ?, ?)";
                    pstmt = conn.prepareStatement(insertSql);
                    pstmt.setInt(1, bookId);
                    pstmt.setInt(2, staffId);
                    pstmt.setDate(3, issueDate);

                    if (returnDate != null) {
                        pstmt.setDate(4, returnDate);
                    } else {
                        pstmt.setNull(4, java.sql.Types.DATE);
                    }

                    pstmt.executeUpdate();

                    // Deduct one copy from the books table
                    String updateBookSql = "UPDATE books SET copies = copies - 1 WHERE book_id = ?";
                    updateStmt = conn.prepareStatement(updateBookSql);
                    updateStmt.setInt(1, bookId);
                    updateStmt.executeUpdate();

                    out.println("<div class='message'>Book issued successfully. 1 copy deducted from stock.</div>");
                } else {
                    out.println("<div class='error'>No available copies of this book.</div>");
                }
            } else {
                out.println("<div class='error'>Book not found.</div>");
            }
        } catch (SQLException e) {
            out.println("<div class='error'>SQL Exception: " + e.getMessage() + "</div>");
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            out.println("<div class='error'>JDBC Driver not found: " + e.getMessage() + "</div>");
            e.printStackTrace();
        } catch (Exception e) {
            out.println("<div class='error'>Exception: " + e.getMessage() + "</div>");
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (updateStmt != null) updateStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    %>
</body>
</html>
