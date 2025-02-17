# Online Library Management System

## 📌 Project Overview

The **Online Library Management System** is a Java-based web application designed to efficiently manage library operations, including book inventory, staff administration, and transaction tracking. The system is built using **JDBC** for database connectivity and integrates with **PostgreSQL** for secure data handling.

## 🚀 Features

### 🔹 Book Management

- Add, update, remove, and display book information.
- Maintain a catalog of books in the library.

### 🔹 Staff Management

- Add, update, remove, and display staff records.
- Enhance administrative control over library operations.

### 🔹 Book Issuing & Returns

- Maintain records of issued books along with issue and return dates.
- Prevent issuing if no copies are available.

### 🔹 Authentication System

- User login functionality to ensure secure access to the system.

### 🔹 Database Integration

- Uses **PostgreSQL** with **JDBC** for secure and efficient CRUD operations.

## 🛠️ Tools & Technologies Used

- **IDE:** Apache NetBeans 18
- **Language:** Java (JDK 22)
- **Database:** PostgreSQL
- **Database Connector:** PostgreSQL JDBC Driver 42.2.19
- **Database Management Tool:** pgAdmin 4

## 📂 Project Structure

```
OnlineLibraryManagementSystem/
│── src/main/java/      # Java Source Code
│── web/                # Web Pages (JSP, HTML, CSS)
│── WEB-INF/            # Configuration Files
│── db/                 # Database SQL Scripts
│── README.md           # Project Documentation
│── LICENSE             # License Information
```

## 📜 Installation & Setup

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/arivsssss/OnlineLibraryManagementSystem.git
cd OnlineLibraryManagementSystem
```

### 2️⃣ Setup the Database

- Install **PostgreSQL** and **pgAdmin 4**.
- Create a database named `librarydb`.
- Import the SQL schema provided in `db/librarydb.sql`.

### 3️⃣ Configure Database Connection

- Update `JDBC` connection settings in Java files.

```java
Connection conn = DriverManager.getConnection(
    "jdbc:postgresql://localhost:5432/librarydb",
    "postgres", "your_password"
);
```

### 4️⃣ Run the Application

- Open the project in **Apache NetBeans 18**.
- Start the application server (Tomcat/GlassFish).
- Access the system via `http://localhost:8080/OnlineLibraryManagementSystem/`.

## 🌐 Key Pages

| Page                  | Description                                  |
| --------------------- | -------------------------------------------- |
| `login.jsp`           | User login page for secure access.           |
| `index.html`          | Homepage with navigation to system features. |
| `viewBooks.jsp`       | Displays available books in the library.     |
| `addBook.jsp`         | Add new books to the database.               |
| `removeBook.jsp`      | Remove books from the database.              |
| `viewStaff.jsp`       | List of administrative staff members.        |
| `addStaff.jsp`        | Add new staff members.                       |
| `removeStaff.jsp`     | Remove staff members.                        |
| `viewIssuedBooks.jsp` | Display issued books and their return dates. |
| `addIssuedBook.jsp`   | Issue a new book to a user.                  |

## 🏆 Contribution

We welcome contributions! Feel free to fork this repository and submit pull requests.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📧 Contact

**Author:** R. Arivanandam\
**GitHub:** [@arivsssss](https://github.com/arivsssss)


