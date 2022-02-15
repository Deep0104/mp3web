<%-- 
    Document   : add_song
    Created on : 27 Jul, 2020, 10:58:53 AM
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
        if(request.getParameter("album")==null || request.getParameter("ccode")==null){
            response.sendRedirect("album.jsp");
           

        }
        else{
           
            String album_code=request.getParameter("album");
            String ccode=request.getParameter("ccode");
             if(request.getParameter("desc").trim().length()>0 && request.getParameter("song").trim().length()>0){                 
               
             
          int sn=0;
            String code="";          
                       String song=request.getParameter("song").trim();
				String desc=request.getParameter("desc").trim();
                        
                   
                try{
                /* TODO output your page here. You may use following sample code. */
                   Class.forName("com.mysql.jdbc.Driver");
                   Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3","root","");
                   Statement st = cn.createStatement();
                   
                   ResultSet rs=st.executeQuery("select MAX(sn) from song where album_code='"+album_code+"' AND category_code='"+ccode+"'");
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
                   PreparedStatement ps=cn.prepareStatement("insert into song values(?,?,?,?,?,?,?)");
                   
                   ps.setInt(1,sn);
                   ps.setString(2,code);
                   ps.setString(3,album_code);
                   
                  
		   ps.setString(4,ccode);
                    ps.setString(5,song);
                    ps.setString(6,desc);
		   ps.setInt(7,0);
                   
                   ps.execute();
                  
                   
                   cn.close();
                   
                   response.sendRedirect("upload_songs.jsp?album="+album_code+"&ccode="+ccode+"&id="+sn);
                }
                catch(Exception er){
                    out.print(er.getMessage());
                }
                                
             }
             else{
                
                 response.sendRedirect("song.jsp?album="+album_code+"&ccode="+ccode+"&field_err=1");
             }
            
        }
        
        
    }
    else{
        
         response.sendRedirect("index.jsp");
    }
   %>