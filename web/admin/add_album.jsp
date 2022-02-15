<%-- 
    Document   : add_album
    Created on : 18 Jul, 2020, 8:57:01 PM
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
        if(request.getParameter("album").trim().length()>0 && request.getParameter("desc").trim().length()>0 && request.getParameter("ccode").trim().length()>0){
            String album=request.getParameter("album");
            String desc=request.getParameter("desc");
            String ccode=request.getParameter("ccode");
            int sn=0;
            String code="";
             try {
                    /* TODO output your page here. You may use following sample code. */
                   Class.forName("com.mysql.jdbc.Driver");
                   Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3","root","");
                   Statement st = cn.createStatement();
                   
                   ResultSet rs=st.executeQuery("select MAX(sn) from album");
                   if(rs.next()){
                       sn=rs.getInt(1);
                   }
                   sn++;
                   
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
                   
                   PreparedStatement ps=cn.prepareStatement("insert into album values(?,?,?,?,?,?)");
                   ps.setInt(1,sn);
                   ps.setString(2,code);
                   ps.setString(3,album);
                   ps.setString(4,desc);
                   ps.setString(5,ccode);
                   ps.setInt(6,0);
                   
                   ps.execute();
                   
                   response.sendRedirect("album_img.jsp?album="+code+"&ccode="+ccode+"");
                   
                   
                   
                   
                   
                   cn.close();
             }
             catch(Exception e){
                 out.println(e.getMessage());
             }
        }
        else{
            response.sendRedirect("album.jsp?err=1");
        }
        
    }
    else{
        response.sendRedirect("index.jsp");
    }
 %>