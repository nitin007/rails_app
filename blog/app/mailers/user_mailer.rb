class UserMailer < ActionMailer::Base
  default from: "nitin.gupta@vinsol.com"
  
   def welcome_email(user)
    @user = user
    @url  = "http://localhost:3000/signup"
    mail(:to => "nitinmangala@in.com", :subject => "Welcome to My Awesome Site")
  end
end
