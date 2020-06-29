<%@ page contentType="text/html;charset=big5" %>
<%@ page language="java"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%//@ page import="com.vd.*" %>
<%@ page import="com.jdbc.*" %>
<%//@ include file ="../Globallib/CharEncode.jsp" %>
<%
/*
if(session.isNew())
{
   return;
}
else
{
   String tf=(String)session.getAttribute("login");
   if(tf == null || !tf.equals("Y"))
     return;
}
     */
%>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />

<HTML>
    <BODY BGCOLOR="white">
        <%
            boolean UploadOk = true;
            /*
                  ServletContext context=config.getServletContext();
                ConnectionPool cp=(ConnectionPool)context.getAttribute("scsbdb");
                StringBall sb=(StringBall)context.getAttribute("sb");
             */
            MyConnection mcn = new MyConnection();
            Connection conn = mcn.getConnection();
            // Initialization
            mySmartUpload.initialize(pageContext);
            mySmartUpload.upload();
            String indexno = UUID.randomUUID().toString().replace("-", "");
            // Upload
            try {
                for (int i = 0; i < mySmartUpload.getFiles().getCount(); i++) {
                    com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(i);
                    if (!myFile.isMissing()) {
                        byte[] binarydata = new byte[myFile.getSize()];
                        for (int j = 0; j < myFile.getSize(); j++) {
                            binarydata[j] = (byte) myFile.getBinaryData(j);
                        }
                        conn.setAutoCommit(false);
                        Statement stmt = conn.createStatement();
                        stmt.executeUpdate("insert into marketresearchreport (indexno,showmemo,pdfname,pdfdata,pdftype,createtime) "
                                + "values('" + indexno + "','"+mySmartUpload.getRequest().getParameter("showmemo")+"','" + myFile.getFileName() + "',empty_blob(),1,sysdate)");
                        ResultSet rs = stmt.executeQuery("select pdfdata from marketresearchreport where indexno='" + indexno + "' for update");
                        if (rs.next()) {
                            oracle.sql.BLOB blob = (oracle.sql.BLOB) rs.getBlob("pdfdata");
                            OutputStream osm=blob.getBinaryOutputStream();
                            osm.write(binarydata, 0, binarydata.length);
                            osm.flush();
                            osm.close();
                        }
                        conn.commit();
                        conn.close();
                    }
                }
                //上傳至遠端主機

                if (UploadOk == true) {
                    out.println("<script>alert('上傳 & 存檔完成！');location.href='./MarketComment_File.jsp'</script>");
                } else {
                    out.println("<script>alert('上傳失敗！請重新操作');</script>");
                }

            } catch (SecurityException e) {
                //out.println(e+"<br>");
                out.println("<script>alert('上傳失敗！請重新操作');</script>");
            }
        %>
    </BODY>
</HTML>
<script>

</script>