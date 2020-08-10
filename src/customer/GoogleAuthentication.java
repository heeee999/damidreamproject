package customer;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator{
	PasswordAuthentication passAuth;
	
	public GoogleAuthentication(){
		passAuth = new PasswordAuthentication("japandanmi211", "jspjapan211");
	}
	
	public PasswordAuthentication getPasswordAuthentication(){
		return passAuth;
	}
}
