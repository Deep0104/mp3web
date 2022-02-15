<%-- 
    Document   : check
    Created on : 14 Jul, 2020, 8:58:38 PM
    Author     : dprisky
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%  
            Cookie c[]=request.getCookies();
                String email=null;
                for(int i=0;i<c.length;i++){
                    if(c[i].getName().equals("admin")){
                        email=c[i].getValue();
                        break;
                    }
                }
                if(email!=null && session.getAttribute(email)!=null){
                    response.sendRedirect("dashboard.jsp");
                }
                else{
                    if(email==null){
                        if(request.getParameter("email").length()==0){
                            response.sendRedirect("index.jsp?err=1");
                        }
                        else{
                            email=request.getParameter("email");

                        }
                    }
                    if(request.getParameter("pass").length()==0){
                        response.sendRedirect("index.jsp?err=1");
                    }
                    else{
                        String pass=request.getParameter("pass");
                        try{
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3","root","");
                            Statement st=cn.createStatement();
                            ResultSet rs=st.executeQuery("select * from admin where email='"+email+"'");
                            if(rs.next()){
                                    if(rs.getString(3).equals(pass)){
                                        Cookie ct =new Cookie("admin",email);
                                        ct.setMaxAge(3600);
                                        response.addCookie(ct);

                                        session.setAttribute(email,pass);
                                        session.setMaxInactiveInterval(60);
                                        response.sendRedirect("dashboard.jsp");

                                    }
                                    else{
                                        response.sendRedirect("index.jsp?invalid_pass=1");
                                    }
                            }

                                cn.close();

                }
                    catch(ClassNotFoundException e){
                            out.println(e.getMessage());
                        }
                    catch(SQLException e){
                        out.println(e.getMessage());
                    }
                }
            }
                %>
    </body>
</html>
