module ApplicationHelper
    def title
        base_title = "Greeting Social"
        if @title.nil?
            base_title
        else
            "#{base_title} | #{@title}"
        end
    end

    def logo
        image_tag("logo.png", :alt => "Greeting Social", :class => "round")
    end

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
