class CardsController < ApplicationController
    
    before_filter :authenticate

    def create

        recipient = User.find_by_id(params[:card][:recipient_id].to_i)
        greeting = params[:card][:greeting]
        image_file_name = params[:card][:image_file_name]
        @card = current_user.sent_cards.build(:greeting => greeting, :recipient => recipient, :image_file_name => image_file_name)

        if @card.save
            signers = params[:card][:signers].split(",").map { |s| s.strip } if params[:card][:signers] != nil
            if signers != nil
                signers.each do |s|
                    if (u = User.find_by_email(s)) != nil
                        @card.signers << u
                    end
                end
            end

            if @card.save
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

    def show_all_cards
        @image_files = Dir.glob("app/assets/images/card_images/*").map { |image_file| image_file.gsub(/app\/assets\/images\//, "")}
    end

end
