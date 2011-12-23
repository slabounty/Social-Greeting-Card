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
        @users = User.paginate(:page => params[:page])
    end

    def show
        @user = User.find(params[:id])
        @title = "#{@user.first_name} #{@user.last_name}"
        @sent_cards = @user.sent_cards.paginate(:page => params[:page])
        @received_cards = @user.received_cards.paginate(:page => params[:page])
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

    private

    def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
        redirect_to(root_path) unless current_user.admin?
    end
end
