<%@page   import="java.sql.*"  %>
<%@page   import="java.util.*"  %>
<%@page   import="javax.mail.*"  %>
<%@page   import="javax.mail.internet.*" %>
<%@page   import="javax.activation.*"  %>

<html>
<head>
<title>enquiry app</title>
<style> *{font-size:30px;font-family:Simsun;}

                  textarea{resize:none;}
               h1{background-color:black;color:white;width:50%;border-radius:30px;}
             body{background-color:azure;}

</style>

</head>
<body>
<center>

<h1>Enquiry from</h1>
<form>
<input type="text"name="name"placeholder="enter ur name"   />
<br/><br/>
<input type="number"name="phone"placeholder="enter mobile no"   />
<br/><br/>
<textarea name="query"placeholder="enter query"rows=3></textarea>
<br/><br/>
<input type="submit"name="btn"   />
<br/><br/>

</form>
<%
if(request.getParameter("btn")!= null)
      {
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
String query = request.getParameter("query");
String dt = new java.util.Date().toString();
    try
         {
         DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
         String url="jdbc:mysql://localhost:3306/en_6jan23";
         Connection con=DriverManager.getConnection(url,"root","abc456");
         String sql="insert into enquiry values(?,?,?,?)";
         PreparedStatement pst=con.prepareStatement(sql);
         pst.setString(1,name);
         pst.setString(2,phone);
pst.setString(3,query);
pst.setString(4,dt);
pst.executeUpdate();
         out.println("well get back in 2hrs otherwise the course is free");


//mail khase jayega
Properties p = System.getProperties();
p.put("mail.smtp.host","smtp.gmail.com");
p.put("mail.smtp.port",587);
p.put("mail.smtp.auth",true);
p.put("mail.smtp.starttls.enable",true);

Session ms = Session.getInstance(p,new Authenticator(){
public PasswordAuthentication getPasswordAuthentication(){
String un = "tester.parag.6jan23@gmail.com";
String pw = "ikhbbzfqxawiqneg";
return new PasswordAuthentication(un,pw);
}
});



try
{
//mail ko draft krke bhejo
MimeMessage msg=new MimeMessage(ms);
String subject="enquiry from"+name;
msg.setSubject(subject);
String txt="name is "+name+"phone no is"+phone+"query="+query;
msg.setText(txt);
msg.setFrom(new InternetAddress("tester.parag.6jan23@gmail.com"));
msg.addRecipient(Message.RecipientType.TO,new InternetAddress("fardeharshati@gmail.com"));
Transport.send(msg);


} catch(Exception e)
{

out.println("issues "+e);

}
con.close();

}
catch(SQLException se)
{

out.println("issues "+ se);

}







}





%>
</center>
</body>
</html>