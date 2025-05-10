<%-- 
    Document   : upload_song
    Created on : Oct 4, 2024, 4:07:31 PM
    Author     : BALWANT
--%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import="java.io.*" %>
<%
    Cookie c[]=request.getCookies();
    String email="";
    if(c==null){
        response.sendRedirect("index.jsp");
    }
    else{
        for(int i=0; i<c.length; i++){
            if(c[i].getName().equals("user")){
                email=c[i].getValue();
            }
        }
            
    if(email!=null && session.getAttribute(email)!=null){
    
    if(request.getParameter("code")!=null && request.getParameter("code").trim().length()>5){
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
         String code=request.getParameter("code").trim();
         String sn=request.getParameter("sn").trim();
        //String code="ytjiuf56_1";
        String file = new String(dataBytes);
        /*saveFile = file.substring(file.indexOf("filename=\"") + 10);
        saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
        saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));*/
         saveFile = sn+".mp3";
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
        FileOutputStream fileOut = new FileOutputStream(request.getRealPath("/")+"/album/"+code+"/"+saveFile);
        


        // fileOut.write(dataBytes);
        fileOut.write(dataBytes, startPos, (endPos - startPos));
        fileOut.flush();
        fileOut.close();
            response.sendRedirect("song.jsp?success=1&id="+code);
        }catch (Exception e)
        {

            response.sendRedirect("song.jsp?song_err=1 & id="+code);
        }
        }
    }
    else{
        response.sendRedirect("song.jsp");
    }
    }
    else{
        response.sendRedirect("index.jsp?no_cookie=1");
    }
        }        
%>



