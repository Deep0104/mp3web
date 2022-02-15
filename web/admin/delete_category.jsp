<%-- 
    Document   : delete_category
    Created on : 30 Jul, 2020, 8:11:43 PM
    Author     : dprisky
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*" pageEncoding="UTF-8"%>
<%
    Cookie c[] = request.getCookies();
    String email=null;
    for(int i=0;i<c.length;i++){
       if(c[i].getName().equals("admin")){
           email=c[i].getValue();
           break;
        } 
        
    }
    if(email!=null && session.getAttribute(email)!=null){
       
         if(request.getParameter("id")!=null){
                 int sn=Integer.parseInt(request.getParameter("id").trim());
                 try{
                   Class.forName("com.mysql.jdbc.Driver");
                   Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3","root","");
                   Statement st = cn.createStatement();
                   st.execute("update category set status=1 where sn="+sn+"");
                   cn.close();;
                   
                 }
                 catch(Exception er){
                     out.print(er.getMessage());
                 }
        }
    }else{
        response.sendRedirect("dashboard.jsp");
    }
    
%>