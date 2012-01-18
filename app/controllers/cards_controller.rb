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
        # Create a "fake" user that's inactive if there's no user with that
        # email address.
        recipient = User.find_or_create_by_email(params[:recipient_email],
            { :password => 'password',
            :password_confirmation => 'password',
            :first_name => 'First',
            :last_name => 'Last',
            :active => false})

        greeting = params[:greeting]
        signers = params[:signers_email].split(",").map { |s| s.strip } if params[:signers_email] != nil
        template = Template.find_by_id(params[:template_id].to_i)

        create_card_from_recipient_greeting_template_signers(recipient, greeting, template, signers)
    end

    def show_single_card
        @card = Card.find(params[:card])
        render :not_your_card if (@card.recipient != current_user) && (@card.sender != current_user) &&
            !@card.signers.include?(current_user)
    end

    def show_card_from_email
        puts "show_card_from_email: h = #{params[:h]}"
        @card = Card.find_by_hash_value(params[:h])
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

    def create_card_from_recipient_greeting_template_signers(recipient, greeting, template, signers)

        card = current_user.sent_cards.build(:greeting => greeting, :recipient => recipient, :template => template)

        # Add a hash to the card for sending to a user. This should probably
        # use a SHA256 type hash, but that causes some issues with (at least)
        # sqlite3 converting it to a blob in the database (64 characters).
        # This should be OK for small applications.
        card.hash_value = "#{Time.now}/#{card.id}".hash

        if card.save
            if signers != nil
                signers.each do |s|
                    if (u = User.find_by_email(s)) != nil
                        card.signers << u
                    end
                end
            end

            if card.save
                email(recipient.email, "You've got a Card!", 
                      "Congratulations! You've got a card waiting at Greeting Social " << 
                      " from #{current_user.first_name} #{current_user.last_name}\n" <<
                      "It can be viewed at\n" <<
                      "#{url_for(:only_path => false).gsub(action_name, "")}show_card_from_email?h=#{card.hash_value}\n"
                     )
                card.signers.each do |u|
                    email(recipient.email, "You've got a card to sign!", 
                        "Congratulations! You've got a card waiting to sign at Greeting Social" <<
                        " from #{current_user.first_name} #{current_user.last_name} " << 
                        " to #{recipient.first_name} #{recipient.last_name}")
                end


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
