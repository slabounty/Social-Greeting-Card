class CardsController < ApplicationController
    
    before_filter :authenticate

    def create

        recipient = User.find_by_id(params[:card][:recipient_id].to_i)
        greeting = params[:card][:greeting]
        @card = current_user.sent_cards.build(:greeting => greeting, :recipient => recipient)

        if @card.save
            flash[:success] = "Card created!"
            redirect_to root_path
        else
            flash.now[:error] = "Card not created!"
            render 'pages/home'
        end
    end

end
