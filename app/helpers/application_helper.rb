module ApplicationHelper
    def title
        base_title = "Social Greeting"
        if @title.nil?
            base_title
        else
            "#{base_title} | #{@title}"
        end
    end

    def logo
        image_tag("logo.png", :alt => "Social Greeting", :class => "round")
    end
end
