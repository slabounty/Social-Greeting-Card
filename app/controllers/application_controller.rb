class ApplicationController < ActionController::Base

    protect_from_forgery

    include SessionsHelper

    def email(to, subject, body)
        Pony.mail(:to => to, :via => :smtp, :via_options => 
                  {
                      :address => 'smtp.gmail.com',
                      :port => '587',
                      :enable_starttls_auto => true,
                      :user_name => 'greetingsocial',
                      :password => 's0cI41greeting',
                      :authentication => :plain,
                      :domain => "HELO",
                  },
                  :subject => subject,
                  :body => body)
    end
end
