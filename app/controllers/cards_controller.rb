class CardsController < ApplicationController
    
    before_filter :authenticate, :except => [:show_all_cards]

    def create
        recipient = User.find_by_id(params[:card][:recipient_id].to_i)
        greeting = params[:card][:greeting]
        template = Template.find(params[:card][:template_id])
        signers = params[:card][:signers].split(",").map { |s| s.strip } if params[:card][:signers] != nil

        create_card_from_recipient_greeting_template_signers(recipient, greeting, template, signers)
    end

    def show_all_cards
        @templates = Template.find(:all)
    end

    def create_a_card
        @template = Template.find(params[:template_id])
    end

    def create_from_image
        recipient = User.find_by_email(params[:recipient_email])
        greeting = params[:greeting]
        signers = params[:signers_email].split(",").map { |s| s.strip } if params[:signers_email] != nil
        template = Template.find_by_id(params[:template_id].to_i)

        create_card_from_recipient_greeting_template_signers(recipient, greeting, template, signers)
    end

    def show_single_card
        @card = Card.find(params[:card])
    end

    private

    def create_card_from_recipient_greeting_template_signers(recipient, greeting, template, signers)
        card = current_user.sent_cards.build(:greeting => greeting, :recipient => recipient, :template => template)

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
