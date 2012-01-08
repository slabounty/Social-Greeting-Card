class AdminController < ApplicationController

    # Need a before_filter here.
    before_filter :admin_authenticate

    def index
    end

    def upload
    end

    def tag
        @templates = Template.find(:all)
    end

    def tag_a_card
        @template = Template.find(params[:template_id])
    end

    def tag_card_from_image
        template = Template.find(params[:template_id])
        params[:tags].split(/[ ]*,[ ]*/).delete_if { |t| t.empty? }.each do |tag|
            t = Tag.find_or_create_by_tag(tag)
            template.tags <<  t if template.tag_ids.include?(t.id) == false
        end
        redirect_to admin_path
    end
end
