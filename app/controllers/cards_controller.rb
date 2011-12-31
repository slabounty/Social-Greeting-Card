class CardsController < ApplicationController
    
    before_filter :authenticate, :except => [:show_all_cards]

    def create

        recipient = User.find_by_id(params[:card][:recipient_id].to_i)
        greeting = params[:card][:greeting]
        image_file_name = params[:card][:image_file_name]
        signers = params[:card][:signers].split(",").map { |s| s.strip } if params[:card][:signers] != nil

        create_card_from_recipient_greeting_image_signers(recipient, greeting, image_file_name, signers)

    end

    def show_all_cards
        @image_files = Dir.glob("app/assets/images/card_images/*").map { |image_file| image_file.gsub(/app\/assets\/images\//, "")}
    end

    def create_a_card
        puts "image file passed = #{params}"
        @image_file_name = params[:image_file_name]
        # <%=link_to (image_tag image_file_name, :size => "200x200"), '/cards/create_a_card', :image_file => image_file_name %>
    end

    def create_from_image
        recipient = User.find_by_email(params[:recipient_email])
        greeting = params[:greeting]
        signers = params[:signers_email].split(",").map { |s| s.strip } if params[:signers_email] != nil
        image_file_name = params[:image_file_name]

        create_card_from_recipient_greeting_image_signers(recipient, greeting, image_file_name, signers)
    end

    private

    def create_card_from_recipient_greeting_image_signers(recipient, greeting, image_file_name, signers)
        card = current_user.sent_cards.build(:greeting => greeting, :recipient => recipient, :image_file_name => image_file_name)

        if card.save
            if signers != nil
                signers.each do |s|
                    if (u = User.find_by_email(s)) != nil
                        card.signers << u
                    end
                end
            end

            if card.save
                flash[:success] = "Card created and signers added (if there were any)!"
                redirect_to current_user
            else
                flash.now[:error] = "Card not created!"
                render 'pages/home'
            end

        else
            flash.now[:error] = "Card not created!"
            render 'pages/home'
        end
    end

end
