readme

java version = "21.0.1";
apache tomcat version = "9.0";

tomcat context.xml
  <Resource name="jdbc/basicjsp"
           auth="Container"
           type="javax.sql.DataSource"
           driverClassName="com.mysql.jdbc.Driver" 
           username=""
           password=""
           url="jdbc:mysql://localhost:3306/basicjsp"
           maxWait="5000"       
 	/>

lib = webapp\WEB-INF\lib
