<%-- 
    Document   : index
    Created on : 2020/5/12, 上午 08:34:24
    Author     : summer
--%>

<%@page contentType="text/html" pageEncoding="Big5"%>
<%@page import="com.jdbc.*"%>
<%@page import="java.sql.*"%>
<%
MyConnection mcn=new MyConnection();
Connection conn=mcn.getConnection();
Statement stmt=conn.createStatement();
ResultSet rs=stmt.executeQuery("select * from marketresearchreport");
while(rs.next()){
    System.out.println(rs.getString("showmemo"));
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=Big5">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!我打中文</h1>
    </body>
</html>
