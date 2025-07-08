<%-- 
    Document   : search_bar
    Created on : Oct 24, 2024, 5:08:06 PM
    Author     : BALWANT
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%
    if (request.getParameter("text").trim().length() > 0 && request.getParameter("text") != null) {
        String text = request.getParameter("text").trim();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3", "root", "");
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery("select * from songs where sname LIKE '%" + text + "%'");
%>
<div class="row">
    <div class="col-lg-6 d1">
        <div class="row">
            <div class="col-lg-12 ht"><h2>Songs</h2></div>
            <%
                int c1 = 0;
                while (rs.next()) {
                    c1++;
            %>
            <div class="col-lg-12 mt-1 card song song-card" rel="<%=rs.getInt(1)%>" name="../album/<%=rs.getString(5)%>/<%=rs.getString(1)%>.mp3" img="../album/<%=rs.getString(5)%>/<%=rs.getString(5)%>.jpg" sname="<%=rs.getString(2)%>">
                <div class="row">
                    <div class="col-lg-2 my-2 col-md-2 col-sm-2 col-2">
                        <img src="../album/<%=rs.getString(5)%>/<%=rs.getString(5)%>.jpg" style="width:100px;height:100px;">
                    </div>
                    <div class="col-lg-9 my-2 col-md-9 col-sm-9 col-9" style="margin-left:20px;">
                        <b style="font-size:20px;font-weight:400;" class="title"><%=rs.getString(2)%></b><br>
                    </div>
                </div>
            </div>
            <%
                }
                if (c1 == 0) {
            %>
            <div class="col-lg-12 text-center my-5">
                <h2 class="text-dark font-weight-bold mb-3">No Songs Found</h2>
                <p class="text-muted">Sorry, we couldn’t find anything matching your search.<br>Try different keywords.</p>
            </div>

            <%
                }
            %>

        </div>
    </div>
    <div class="col-lg-6 d2 ">
        <div class="row">
            <div class="col-lg-12 ht"><h2>Artists</h2></div>
            <%
                PreparedStatement p = cn.prepareStatement("select * from artist where artist LIKE ?");
                p.setString(1, "%" + text + "%");
                ResultSet r = p.executeQuery();
                int c2 = 0;
                while (r.next()) {
                    c2++;
            %>
            <div class="col-lg-2 my-2 col-md-2 col-sm-2 col-2">
                <a href="view_artist.jsp?code=<%=r.getString(2)%>"><img src="../artist/<%=r.getString(2)%>/<%=r.getString(2)%>.jpg" class="rounded-circle" style="width:100px;height: 100px;"></a>
            </div>
            <div class="col-lg-9 my-2 col-md-9 col-sm-9 col-9" style="margin-left:20px;">
                <a href="view_artist.jsp?code=<%=r.getString(2)%>"><b style="font-size:25px;font-weight:400;padding:25px;" class="title"><%=r.getString(3)%></b></a><br>
            </div>
            <%
                }
                if (c2 == 0) {
            %>
            <div class="col-lg-12 text-center my-5">
                <h2 class="text-dark font-weight-bold mb-3">No Artist Found</h2>
                <p class="text-muted">Sorry, we couldn’t find anything matching your search.<br>Try different keywords.</p>
            </div>

            <%
                }
            %>
        </div>
    </div>
    <div class="col-lg-12 mt-4">
        <div class="row">
            <div class="col-lg-12 ht"><h1>Albums</h1></div>
            <%                     PreparedStatement p0 = cn.prepareStatement("select * from album where album LIKE ?");
                p0.setString(1, "%" + text + "%");
                ResultSet r0 = p0.executeQuery();
                int c3 = 0;
                while (r0.next()) {
                    c3++;
            %>
            <div class="col-lg-2 col-md-3 col-sm-4 col-6 mt-2">
                <div>
                    <div class="img-wrapper" border="1">
                        <a href="view_album.jsp?code=<%=r0.getString(2)%>&Album=<%=r0.getString(3)%>"><img src="../album/<%=r0.getString(2)%>/<%=r0.getString(2)%>.jpg" alt="img" class="img-fluid  inner-img"></a>
                    </div>
                    <div>
                        <a href="view_album.jsp?code=<%=r0.getString(2)%>&Album=<%=r0.getString(3)%>"><h6 style="text-align:center" class="txt clamp"><%=r0.getString(3)%></h6></a>
                    </div>
                </div>
            </div>
            <%
                }
                if (c1 == 0) {
            %>
            <div class="col-lg-12 text-center my-5">
                <h2 class="text-dark font-weight-bold mb-3">No Albums Found</h2>
                <p class="text-muted">Sorry, we couldn’t find anything matching your search.<br>Try different keywords.</p>
            </div>

            <%
                }
            %>
        </div>
    </div>


</div>


<%
        } catch (Exception e) {
            out.print(e.getMessage());
        }
    }
%>
