class CardsController < ApplicationController
    
    before_filter :authenticate, :except => [:show_all_cards, :search, :show_card_from_email]

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

        if params[:commit] =~ /Preview/
            puts "Previewing!!"

            @sender = current_user
            @recipient_email = params[:recipient_email]
            @greeting = params[:greeting]
            @template = Template.find_by_id(params[:template_id].to_i)
            @signers = params[:signers_email]

            render 'preview'

        else # params[:commit] =~ /Send/
            send_card(params[:recipient_email], params[:greeting], params[:signers_email], params[:template_id].to_i)
        end
    end

    def from_preview

        # :sender_id
        # :recipient_email
        # :greeting
        # :template_id
        # :signers

        if params[:commit] =~ /Edit/
            # Re-edit
            @template = Template.find_by_id(params[:template_id].to_i)
            @greeting = params[:greeting]
            @recipient_email = params[:recipient_email]
            @signers = params[:signers]
            render 'create_a_card'
        else
            send_card(params[:recipient_email], params[:greeting], params[:signers], params[:template_id].to_i)
        end
    end

    def show_single_card
        @title = "Single Card"
        @card = Card.find(params[:card])
        render :not_your_card if @card.recipient != current_user && @card.sender != current_user && !@card.signers.include?(current_user)
    end

    def show_card_from_email
        @title = "Single Card from Email"
        @card = Card.find_by_hash_value(params[:h])
        render :show_single_card
    end

    def search
        @search_string = params[:search]
        # @templates = tags.templates if tags = Tag.find_by_tag(@search_string)

        tag = Tag.find(:first, :conditions => ["lower(tag) = ?", @search_string.downcase])
        if tag != nil && tag != []
            @templates = tag.templates
        end
        if @templates
            flash.now[:success] = "Showing cards with #{@search_string}:"
        else
            flash.now[:error] = "Sorry, no cards with #{@search_string}:"
        end
        render 'cards/show_all_cards'
    end

    private

    def send_card(recipient_email, greeting, signers_emails, template_id)

        recipient = User.find_or_create_inactive_by_email(recipient_email)
        signers = signers_emails.split(",").map { |s| s.strip } if signers_emails != nil
        template = Template.find_by_id(template_id)

        create_card_from_recipient_greeting_template_signers(recipient, greeting, template, signers)
    end

    def create_card_from_recipient_greeting_template_signers(recipient, greeting, template, signers)

        card = current_user.sent_cards.build(:greeting => greeting, :recipient => recipient, :template => template)

        if card.save
            add_signers_to_card(card, signers) if signers != nil

            if card.save
                email_recipient(card)
                email_signers(card) if signers != nil

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

    def add_signers_to_card(card, signers)
        signers.each do |s|
            if (u = User.find_or_create_inactive_by_email(s)) != nil
                card.signers << u
            end
        end
    end

    def email_recipient(card)
        email(card.recipient.email, "You've got a Card!", 
              "Congratulations! You've got a card waiting at Greeting Social " << 
        " from #{card.sender.first_name} #{card.sender.last_name}\n" <<
        "It can be viewed at\n" <<
        "#{url_for(:only_path => false).gsub(action_name, "")}show_card_from_email?h=#{card.hash_value}\n")
    end

    def email_signers(card)
        card.signers.each do |signer|
            email(signer.email, "You've got a card to sign!", 
                  "Congratulations! You've got a card waiting to sign at Greeting Social\n" <<
            " from #{card.sender.first_name} #{card.sender.last_name} " << 
            " to #{card.recipient.first_name} #{card.recipient.last_name}\n" <<
            "It can be signed at\n" <<
            "#{url_for(:only_path => false).gsub(controller_name, "").gsub(action_name, "").gsub(/\/+$/, "/")}" <<
            "users/sign_card_from_email?h=#{card.hash_value}&s=#{signer.hash_value}\n")
        end
    end

end
