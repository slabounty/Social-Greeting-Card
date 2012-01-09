class AdminController < ApplicationController

    # Need a before_filter here.
    before_filter :admin_authenticate

    def index
    end

    def upload
    end

    def upload_template
        uploaded_io = params[:template_file_name]
        if %w[.jpg .jpeg .png].include? File.extname(uploaded_io.original_filename).downcase
            File.open(Rails.root.join('app', 'assets', 'images', 'card_images', uploaded_io.original_filename), 'wb') do |file|
                file.write(uploaded_io.read)
            end
            template = Template.create(:image_name => uploaded_io.original_filename)
            if template
                flash[:success] = "Template created!"
            else
                flash[:error] = "Template not created!"
            end
        else
            flash[:error] = "File: \"#{uploaded_io.original_filename}\" is wrong type. Must be an image (jpg, jpeg, png)!"
        end
        redirect_to admin_path
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
