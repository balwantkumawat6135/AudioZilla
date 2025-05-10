<%-- 
    Document   : artist_upload_img
    Created on : Apr 24, 2025, 12:00:30 PM
    Author     : balwant-kumawat
--%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="java.util.UUID"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String ccode=null;
    if(request.getParameter("id")!=null && request.getParameter("id").trim().length()>5){
        String id=request.getParameter("id");
        // Configure upload settings
        String UPLOAD_DIRECTORY = "artist/"+id;
        int MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
        int MAX_MEM_SIZE = 4 * 1024; // 4KB buffer

        // Get absolute path to upload directory
        String uploadPath = application.getRealPath("") + File.separator + UPLOAD_DIRECTORY;

        // Create upload folder if it doesn't exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        try {
            // Check if request contains multipart content
            if (!ServletFileUpload.isMultipartContent(request)) {
                throw new Exception("Form must have enctype=multipart/form-data");
            }

            // Configure factory
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(MAX_MEM_SIZE);
            factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

            // Create upload handler
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setSizeMax(MAX_FILE_SIZE);

            // Parse request
            List<FileItem> formItems = upload.parseRequest(request);
            String description = "";
            String fileName = "";

            // Process form items
            for (FileItem item : formItems) {
                if (item.isFormField()) {
                    // Handle regular form field
                   /* if (item.getFieldName().equals("description")) {
                        description = item.getString();
                    }*/
                } else {
                    // Handle file upload
                    String originalName = new File(item.getName()).getName();
                    if (!originalName.isEmpty()) {
                        // Generate unique filename
                        
                        fileName = id + ".jpg";

                        // Save file
                        File storeFile = new File(uploadPath + File.separator + fileName);
                        item.write(storeFile);
                        
                        

                    }
                }
            }
        } catch (Exception ex) {
            out.println("<p style='color:red'>Error: " + ex.getMessage() + "</p>");
        }
        response.sendRedirect("artist.jsp?success=1");
    }
    else{
        response.sendRedirect("artist.jsp?something_wrong=1");
    }
%>
