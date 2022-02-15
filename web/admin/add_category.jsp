<%-- 
    Document   : add_category
    Created on : 18 Jul, 2020, 9:04:43 AM
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
        if(request.getParameter("category").trim().length()>0){
            String category=request.getParameter("category");
            int sn=0;
            String code="";
             try {
                    /* TODO output your page here. You may use following sample code. */
                   Class.forName("com.mysql.jdbc.Driver");
                   Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3","root","");
                   Statement st = cn.createStatement();
                   
                   ResultSet rs=st.executeQuery("select MAX(sn) from category");
                   if(rs.next()){
                       sn=rs.getInt(1);
                   }
                           sn=sn+1;
                            LinkedList l = new LinkedList();
                            for(char i='a';i<='z';i++){
                                l.add(""+i);
                            }

                            for(char i='A';i<='Z';i++){
                                l.add(""+i);
                            }
                            for(int i=0;i<=9;i++){
                                l.add(new Integer(i));
                            }

                            Collections.shuffle(l);
                            for(int i=0;i<=6;i++){
                                code=code+l.get(i);
                            }
                            code=code+sn;

                            PreparedStatement ps=cn.prepareStatement("insert into category values(?,?,?,?)");
                            ps.setInt(1,sn);
                            ps.setString(2,code);
                            ps.setString(3,category);
                            ps.setInt(4,0);
                            ps.execute();
                   response.sendRedirect("dashboard.jsp?success=1");
                   cn.close();
             }
             catch(Exception e){
                 out.println(e.getMessage());
             }
        }
        else{
            response.sendRedirect("dashboard.jsp?err=1");
        }
        
    }
    else{
        response.sendRedirect("index.jsp");
    }
 %>