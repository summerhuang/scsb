
<%@ page import="java.sql.*" %>
<%//@ page import="com.vd.*" %>
<%@ page import="com.jdbc.*" %>
<%@ page contentType="text/html;charset=Big5" %>
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
}*/

    MyConnection mcn = new MyConnection();
    Connection conn = mcn.getConnection();
    Statement stmt=conn.createStatement();
    ResultSet rs=null;
    if(request.getParameter("action")!=null){
        if(request.getParameter("action").equalsIgnoreCase("delete")){
            stmt.executeUpdate("delete from marketresearchreport where indexno='"+request.getParameter("indexno")+"'");
        }
    }
%>
<html>
    <head>
        <title>���g��</title>
        <meta http-equiv="Content-Type" content="text/html; charset=big5">
        <link rel="stylesheet" href="../Css/Global.css" type="text/css">
    </head>
    <script language="JavaScript">
        <!--
        function CalcResult()
        {
            return true;
        }
        function CheckField() {
            flag = true

            if (document.all.FILE1.value == "") {
                alert('�|������ɮסI');
                flag = false;
            }
            if (document.all.showmemo.value == "") {
                alert('�п�J�ɮ׻����I');
                flag = false;
            }
            return flag;
        }
        function UPLOADFILE() {
            if (CheckField()) {
                document.FormAdd.action = "./UploadMC.jsp";
                document.FormAdd.encoding = "multipart/form-data";
                document.FormAdd.submit();
            }
        }

        //-->
    </script>

    <body bgcolor="#FFFFFF" text="#000000">
        <form name="FormAdd" method="post" action=""   onsubmit="return CalcResult();">
            <p>&gt;&gt; ���g���W�Ǥ���<br>

                <span class="defaultfont"><br>
                    �Ъ`�N�W���ɮפ��i�������ɦW�A�Y�������ɦW�Х���令�^���ɦW�A�W��
                    <table width="550" border="0" cellspacing="1" cellpadding="2" bgcolor="#336600">
                        <tr valign="middle" bgcolor="#FFFFFF">
                            <td id="upid1" colspan="3">�ɮ׻����G
                                <input type="text" name="showmemo" style="width:350" value="">
                            </td>
                        </tr>
                        <tr valign="middle" bgcolor="#FFFFFF">
                            <td id="upid1" colspan="3">�W���ɮסG
                                <input type="file" name="FILE1" style="width:350" value="">
                            </td>
                        </tr>

                        <tr bgcolor="#FFFFFF">
                            <td colspan="3" align="center"><input type="button" name="SubmitSave" value="�W�� & �s��" class="defaultfont" onclick="UPLOADFILE();"></td>
                        </tr>

                    </table>
        </form>
        <p class="defaultfont">&nbsp;</p>
        <p class="defaultfont"><br>
        <table width="550" border="1" cellspacing="1" cellpadding="2">
            <tr  bgcolor="#FFFFFF">
                <td>����</td><td>�ɮ׻���</td><td>�ɮצW��</td><td>�W�Ǯɶ�</td><td></td>
            </tr>
            <%
                int mid=1;
                rs=stmt.executeQuery("select indexno,showmemo,pdfname,to_char(createtime,'YYYY/MM/DD HH24:MI:SS') as createtime"
                        + " from marketresearchreport  order by createtime desc");
                while(rs.next()){
            %>
            <tr>
                <td><%=mid%></td><td><%=rs.getString("showmemo")%></td><td><%=rs.getString("pdfname")%></td>
                <td><%=rs.getString("createtime")%></td><td><a href="./MarketComment_File.jsp?action=delete&indexno=<%=rs.getString("indexno")%>">�R��</a></td>
            </tr>
            <%
               mid++; }
            %>
        </table>
    </p>
</body>
</html>