<%@page contentType="text/html" pageEncoding="Big5"%>
<%@ page import="java.io.*,java.net.*"%>
<%
String path = "/Users/summer/eclipse-workspace/"; //�ɮץD�n��m�ؿ�
String filename = "abc.pdf"; //�ɮצW��
File file = new File(path+filename);
if(file.exists()){//�����ɮ׬O�_�s�b
try{
response.setHeader("Content-Disposition","attachment; filename=\"" + new String(filename.getBytes(), "ISO_8859_1") + "\"");
OutputStream output = response.getOutputStream();
InputStream in = new FileInputStream(file);
byte[] b = new byte[2048];
int len;

while((len = in.read(b))>0){
output.write(b,0,len);
}
in.close();
output.flush();
output.close(); //������y
out.clear();
out = pageContext.pushBody();
}catch(Exception ex){
out.println("Exception : "+ex.toString());
out.println("<br/>");
}
}else{
out.println(filename+" : ���ɮפ��s�b");
out.println("<br/>");
}
%>