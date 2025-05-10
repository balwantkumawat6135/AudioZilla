<%-- 
    Document   : upload_song
    Created on : Apr 18, 2025, 8:35:50 AM
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
    String code = null;
    if(request.getParameter("sn") != null && request.getParameter("sn").trim().length() > 0
       && request.getParameter("code") != null && request.getParameter("code").trim().length() > 5) {
        
        code = request.getParameter("code");
        String sn = request.getParameter("sn");
        
        // Configure upload settings for MP3
        String UPLOAD_DIRECTORY = "/album/"+code;  // Changed to mp3s directory
        int MAX_FILE_SIZE = 20 * 1024 * 1024;    // Increased to 20MB for MP3 files
        int MAX_MEM_SIZE = 4 * 1024;             // 4KB buffer

        // Get absolute path to upload directory
        String uploadPath = application.getRealPath("") + File.separator + UPLOAD_DIRECTORY;

        // Create upload folder if it doesn't exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();  // Changed to mkdirs() to create parent directories if needed
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
            String fileName = "";

            // Process form items
            for (FileItem item : formItems) {
                if (!item.isFormField()) {
                    // Handle file upload
                    String originalName = new File(item.getName()).getName();
                    if (!originalName.isEmpty()) {
                        // Validate file extension
                        String fileExt = originalName.substring(originalName.lastIndexOf(".")).toLowerCase();
                        
                        if (!fileExt.equals(".mp3")) {
                            throw new Exception("Only MP3 files are allowed");
                        }

                        // Generate filename (using ID + .mp3 extension)
                        fileName = sn + ".mp3";

                        // Save file
                        File storeFile = new File(uploadPath + File.separator + fileName);
                        
                        // Delete existing file if it exists
                        if (storeFile.exists()) {
                            storeFile.delete();
                        }
                        
                        item.write(storeFile);
                        
                        // Verify file was actually written
                        if (!storeFile.exists() || storeFile.length() == 0) {
                            throw new Exception("Failed to save MP3 file");
                        }
                    }
                }
            }
            response.sendRedirect("song.jsp?id=" +code + "&success=1");
        } catch (Exception ex) {
            // Log the error to server console
            System.err.println("MP3 Upload Error: " + ex.getMessage());
            ex.printStackTrace();
            
            // Redirect with error message
            response.sendRedirect("album.jsp?id=" +code + "&error=" + 
                java.net.URLEncoder.encode(ex.getMessage(), "UTF-8"));
        }
    } else {
        response.sendRedirect("song.jsp?id="+code+"error=invalid_parameters");
    }
%>