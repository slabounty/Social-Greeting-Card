class UsersController < ApplicationController
    before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
    before_filter :correct_user, :only => [:edit, :update]
    before_filter :admin_user, :only => [:destroy]

    def new
        @title = "Sign up"
        @user = User.new
    end

    def show
        @user = User.find(params[:id])
        @title = "#{@user.first_name} #{@user.last_name}"
    end

    def create
        @user = User.new(params[:user])
        if @user.save
            sign_in @user
            flash[:success] = "Welcome to Greeting Social!"
            redirect_to @user
        else
            @title = "Sign up"
            render 'new'
        end
    end

    def edit
        @title = "Edit user"
    end

    def update
        if @user.update_attributes(params[:user])
            flash[:success] = "Profile updated"
            redirect_to @user
        else
            @title = "Edit user"
            render 'edit'
        end
    end

    def index
        @title = "All users"
        @suggestion = "Pick someone and send them a card!"
        @users = User.paginate(:page => params[:page])
    end

    def show
        @user = User.find(params[:id])
        @title = "#{@user.first_name} #{@user.last_name}"
        @sent_cards = @user.sent_cards.paginate(:page => params[:page])
        @received_cards = @user.received_cards.paginate(:page => params[:page])
        @signed_cards = @user.signed_cards.paginate(:page => params[:page])
        @need_to_sign_cards = @user.signatures.find_all { |s| s.signed == false }.map { |s| s.card } # .paginate(:page => params[:page])
        @already_signed_cards = @user.signatures.find_all { |s| s.signed == true }.map { |s| s.card } # .paginate(:page => params[:page])
    end

    def destroy
        User.find(params[:id]).destroy
        flash[:success] = "User destroyed"
        redirect_to users_path
    end

    def send_card
        @recipient = User.find(params[:recipient])
        @card = Card.new(:recipient => @recipient)
        @image_files = Dir.glob("app/assets/images/card_images/*").map { |image_file| image_file.gsub(/app\/assets\/images\//, "")}
    end

    def sign_card
        puts "Calling Sign the Card!!"
        @card = Card.find(params[:card])
    end

    def do_sign
        card = Card.find(params[:card])
        signature = Signature.where(:card_id => card, :signer_id => current_user).limit(1)[0]
        signature.signed = true
        signature.message = params[:message]
        signature.save

        flash[:success] = "Card Signed!!"
        redirect_to current_user
    end

    def sign
    end

    def see_received
        @user = User.find(params[:id])
        @received_cards = @user.received_cards.paginate(:page => params[:page])
    end

    def see_sent
        @user = User.find(params[:id])
        @sent_cards = @user.sent_cards.paginate(:page => params[:page])
    end

    def see_need_to_sign
        @user = User.find(params[:id])
        @need_to_sign_cards = @user.signatures.find_all { |s| s.signed == false }.map { |s| s.card } # .paginate(:page => params[:page])
    end

    def see_signed 
        @user = User.find(params[:id])
        @already_signed_cards = @user.signatures.find_all { |s| s.signed == true }.map { |s| s.card } # .paginate(:page => params[:page])
    end

    private

    def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
        redirect_to(root_path) unless current_user.admin?
    end
end
