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
end
