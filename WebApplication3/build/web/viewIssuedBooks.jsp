<%@ include file="header.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>View Issued Books</title>
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
            margin: 10px;
            display: block;
            text-align: center;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h2>Issued Books List</h2>
    <table>
        <tr>
            <th>Issue ID</th>
            <th>Book ID</th>
            <th>Staff ID</th>
            <th>Issue Date</th>
            <th>Return Date</th>
        </tr>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("org.postgresql.Driver");
                conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/librarydb", "postgres", "Charchit@6639");

                stmt = conn.createStatement();
                String sql = "SELECT * FROM issued_books";
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    int issueId = rs.getInt("issue_id");
                    int bookId = rs.getInt("book_id");
                    int staffId = rs.getInt("staff_id");
                    Date issueDate = rs.getDate("issue_date");
                    Date returnDate = rs.getDate("return_date");
        %>
        <tr>
            <td><%= issueId %></td>
            <td><%= bookId %></td>
            <td><%= staffId %></td>
            <td><%= issueDate %></td>
            <td><%= returnDate != null ? returnDate : "Not returned yet" %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
    </table>
    <a href="addIssuedBook.jsp">Add Issued Book</a>
</body>
</html>
