<%@ include file="header.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>View Books</title>
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
        }
        a:hover {
            text-decoration: underline;
        }
        .links {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h2>Books List</h2>
    <table>
        <tr>
            <th>Book ID</th>
            <th>Name</th>
            <th>Author</th>
            <th>Category</th>
            <th>Copies</th>
        </tr>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("org.postgresql.Driver");
                conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/librarydb", "postgres", "Charchit@6639");
            
                stmt = conn.createStatement();
                String sql = "SELECT * FROM BOOKS";
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    int bookId = rs.getInt("BOOK_ID");
                    String name = rs.getString("NAME");
                    String author = rs.getString("AUTHOR");
                    String category = rs.getString("CATEGORY");
                    int copies = rs.getInt("COPIES");
        %>
        <tr>
            <td><%= bookId %></td>
            <td><%= name %></td>
            <td><%= author %></td>
            <td><%= category %></td>
            <td><%= copies %></td>
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
    <div class="links">
        <a href="addBook.jsp">Add Book</a> | <a href="removeBook.jsp">Remove Book</a>
    </div>
</body>
</html>
