<%-- 
    Document   : upload_song
    Created on : 27 Jul, 2020, 11:00:58 AM
    Author     : dprisky
--%>



<%@page contentType="text/html" import="java.io.*" pageEncoding="UTF-8"%>

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
         if(request.getParameter("album")==null || request.getParameter("ccode")==null || request.getParameter("id")==null ){
             
             response.sendRedirect("album.jsp");
         }
         else{
             String ccode=request.getParameter("ccode");
             String album_code=request.getParameter("album");
              int sn=Integer.parseInt(request.getParameter("id"));
             
             String contentType = request.getContentType();

String imageSave=null;
byte dataBytes[]=null;
String saveFile=null;
if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0))
{
DataInputStream in = new DataInputStream(request.getInputStream());
int formDataLength = request.getContentLength();
dataBytes = new byte[formDataLength];
int byteRead = 0;
int totalBytesRead = 0;
while (totalBytesRead < formDataLength)
{
byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
totalBytesRead += byteRead;
}
String code=sn+"";
/*String code="";
try{
    ....
    ...
    ....
ResultSet rs=st.executeQuery("select code from table_name where email='"+email+"'");
if(rs.next()){
    code=rs.getString(1);
}

} 
catch(Exception er){
    
}*/
String file = new String(dataBytes);
/*saveFile = file.substring(file.indexOf("filename=\"") + 10);
saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));*/
 saveFile = code+".mp3";
// out.print(dataBytes);
int lastIndex = contentType.lastIndexOf("=");
String boundary = contentType.substring(lastIndex + 1, contentType.length());
// out.println(boundary);
int pos;
pos = file.indexOf("filename=\"");
pos = file.indexOf("\n", pos) + 1;
pos = file.indexOf("\n", pos) + 1;
pos = file.indexOf("\n", pos) + 1;
int boundaryLocation = file.indexOf(boundary, pos) - 4;
int startPos = ((file.substring(0, pos)).getBytes()).length;
int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
try
{
FileOutputStream fileOut = new FileOutputStream(request.getRealPath("/")+"/song/"+album_code+"/"+saveFile);

// fileOut.write(dataBytes);
fileOut.write(dataBytes, startPos, (endPos - startPos));
fileOut.flush();
fileOut.close();

response.sendRedirect("song.jsp?album="+album_code+"&ccode="+ccode);
}catch (Exception e)
{

imageSave="Failure";
}
}


             
             
         }
    }
    else{
         response.sendRedirect("index.jsp");
    }
 %>
    