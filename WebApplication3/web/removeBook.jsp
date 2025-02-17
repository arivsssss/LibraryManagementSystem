<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Remove Book</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        h2 {
            color: #333;
        }
        form {
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            margin: auto;
        }
        input[type="text"], input[type="number"], input[type="submit"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            background-color: #5cb85c;
            color: white;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #4cae4c;
        }
        .message {
            text-align: center;
            margin-top: 20px;
            color: #d9534f; /* red color for error messages */
        }
    </style>
</head>
<body>
    <h2>Remove Book</h2>
    <form method="post" action="removeBook.jsp">
        <label for="bookId">Book ID:</label>
        <input type="text" id="bookId" name="bookId" required placeholder="Enter Book ID">
        
        <label for="copiesToRemove">Number of Copies to Remove:</label>
        <input type="number" id="copiesToRemove" name="copiesToRemove" required min="1" placeholder="Enter number of copies to remove">
        
        <input type="submit" value="Remove Book">
    </form>

    <%
    String bookIdParam = request.getParameter("bookId");
    String copiesToRemoveParam = request.getParameter("copiesToRemove");

    if (bookIdParam != null && copiesToRemoveParam != null) {
        int bookId = Integer.parseInt(bookIdParam);
        int copiesToRemove = Integer.parseInt(copiesToRemoveParam);

        Connection conn = null;
        PreparedStatement pstmtSelect = null;
        PreparedStatement pstmtUpdate = null;
        PreparedStatement pstmtDelete = null;
        ResultSet rs = null;

        try {
            // Load PostgreSQL driver and connect to database
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/librarydb", "postgres", "Charchit@6639");

            // Query to get the current number of copies
            String sqlSelect = "SELECT COPIES FROM BOOKS WHERE BOOK_ID = ?";
            pstmtSelect = conn.prepareStatement(sqlSelect);
            pstmtSelect.setInt(1, bookId);
            rs = pstmtSelect.executeQuery();

            if (rs.next()) {
                int currentCopies = rs.getInt("COPIES");

                if (copiesToRemove <= currentCopies) {
                    if (copiesToRemove < currentCopies) {
                        // Reduce the number of copies by the specified amount
                        String sqlUpdate = "UPDATE BOOKS SET COPIES = COPIES - ? WHERE BOOK_ID = ?";
                        pstmtUpdate = conn.prepareStatement(sqlUpdate);
                        pstmtUpdate.setInt(1, copiesToRemove);
                        pstmtUpdate.setInt(2, bookId);
                        int updatedRows = pstmtUpdate.executeUpdate();

                        if (updatedRows > 0) {
                            out.println("<div class='message'>" + copiesToRemove + " copies of the book were removed successfully. Remaining copies: " + (currentCopies - copiesToRemove) + ".</div>");
                        } else {
                            out.println("<div class='message'>Failed to update book copies.</div>");
                        }
                    } else if (copiesToRemove == currentCopies) {
                        // If the number of copies to remove is equal to the current number, delete the book
                        String sqlDelete = "DELETE FROM BOOKS WHERE BOOK_ID = ?";
                        pstmtDelete = conn.prepareStatement(sqlDelete);
                        pstmtDelete.setInt(1, bookId);
                        int deletedRows = pstmtDelete.executeUpdate();

                        if (deletedRows > 0) {
                            out.println("<div class='message'>Book removed successfully as all copies were removed.</div>");
                        } else {
                            out.println("<div class='message'>Failed to remove the book.</div>");
                        }
                    }
                } else {
                    out.println("<div class='message'>You cannot remove more copies than available. Available copies: " + currentCopies + ".</div>");
                }
            } else {
                out.println("<div class='message'>Book not found with the given ID.</div>");
            }

        } catch (SQLException e) {
            out.println("<div class='message'>SQL Exception: " + e.getMessage() + "</div>");
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            out.println("<div class='message'>Class Not Found Exception: " + e.getMessage() + "</div>");
            e.printStackTrace();
        } finally {
            // Close resources properly
            try {
                if (rs != null) rs.close();
                if (pstmtSelect != null) pstmtSelect.close();
                if (pstmtUpdate != null) pstmtUpdate.close();
                if (pstmtDelete != null) pstmtDelete.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    %>
</body>
</html>
