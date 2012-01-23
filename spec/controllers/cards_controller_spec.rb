require 'spec_helper'

describe CardsController do
    render_views

    describe "access control" do

        it "should deny access to 'create'" do
            post :create
            response.should redirect_to(signin_path)
        end

    end

    describe "POST 'create'" do
        before(:each) do
            @sender = test_sign_in(Factory(:sender))
            @recipient = Factory(:recipient)
            @signer = Factory(:signer)
            @template = Factory(:template)
        end

        describe "failure" do
            before(:each) do
                @attr = { :greeting => "", :template_id => @template.id }
            end

            it "should not create a card" do
                lambda do
                    post :create, :card => @attr
                end.should_not change(Card, :count)
            end

            it "should render the home page" do
                post :create, :card => @attr
                response.should render_template('pages/home')
            end
        end

        describe "success" do
            before(:each) do
                @attr = {   :greeting => "Lorem ipsum", 
                            :template_id => @template.id,
                            :recipient_id => @recipient.id, 
                            :signers => "#{@signer.email}" }
            end

            it "should create a card" do
                lambda do
                    post :create, :card => @attr
                end.should change(Card, :count).by(1)
            end

            it "should redirect to the user page" do
                post :create, :card => @attr
                response.should redirect_to(@sender )
            end

            it "should have a flash message" do
                post :create, :card => @attr
                flash[:success].should =~ /card created/i
            end

            it "should add a sent card to the sender" do
                pre_count = @sender.sent_cards.size
                post :create, :card => @attr
                @sender.sent_cards.length.should == pre_count+1
            end

            it "should send an email to the recipient" do
                post :create, :card => @attr
                Pony.should_receive(:mail) do |params|
                    params[:to].should == @recipient.email
                    params[:body].should include("Congratulations")
                end
            end
        end
    end

    describe "POST 'create_from_image'" do
        before(:each) do
            @sender = test_sign_in(Factory(:sender))
            @recipient = Factory(:recipient)
            @signer = Factory(:signer)
            @template = Factory(:template)
        end

        describe "failure" do
            before(:each) do
                @attr = { :greeting => "" }
            end

            it "should not create a card" do
                lambda do
                    post :create_from_image, :card => @attr
                end.should_not change(Card, :count)
            end

            it "should render the home page" do
                post :create_from_image, :card => @attr
                response.should render_template('pages/home')
            end
        end

        describe "success" do
            before(:each) do
                @attr = {   :greeting => "Lorem ipsum", 
                            :template_id => @template.id,
                            :recipient_email => "#{@recipient.email}", 
                            :signers => "#{@signer.email}" }
            end

            it "should create a card" do
                lambda do
                    post :create_from_image, @attr
                end.should change(Card, :count).by(1)
            end

            it "should redirect to the user page" do
                post :create_from_image, @attr
                response.should redirect_to(@sender )
            end

            it "should have a flash message" do
                post :create_from_image, @attr
                flash[:success].should =~ /card created/i
            end

            it "should add a sent card to the sender" do
                pre_count = @sender.sent_cards.size
                post :create_from_image, :card => @attr
                @sender.sent_cards.length.should == pre_count+1
            end

            it "should send an email to the recipient" do
                post :create, :card => @attr
                Pony.should_receive(:mail) do |params|
                    params[:to].should == @recipient.email
                    params[:body].should include("Congratulations")
                end
            end
        end
    end

    describe "show_single_card" do
        before do
            @sender = Factory(:sender)
            @recipient = Factory(:recipient)
            @template = Factory(:template)
            @card = Factory(:card, :sender => @sender, :recipient => @recipient, :greeting => "Greeting 1", :template => @template)
        end

        describe "failure" do
            before(:each) do
                @attr = { :card => @card.id }
                @user = Factory(:user)
            end

            it "should display a not your card" do
                test_sign_in(@user)
                get 'show_single_card', :card => @card.id
                response.should have_selector('h1', :content => "Sorry")
            end

        end

        describe "success" do
            before(:each) do
                @attr = { :card => @card.id }
            end

            it "should display the card for the recipient" do
                test_sign_in(@recipient)
                get 'show_single_card', :card => @card.id
                response.should have_selector('title', :content => "Single Card")
            end

            it "should display the card for the sender" do
                test_sign_in(@sender)
                get 'show_single_card', :card => @card.id
                response.should have_selector('title', :content => "Single Card")
            end
        end
    
    end

    describe "show_card_from_email" do
        before do
            @sender = Factory(:sender)
            @recipient = Factory(:recipient)
            @template = Factory(:template)
            @card = Factory(:card, :sender => @sender, :recipient => @recipient, :greeting => "Greeting 1", :template => @template)
        end

        it "should display the card" do
            get 'show_card_from_email', :h => @card.hash_value
            response.should have_selector('title', :content => "Single Card from Email")
        end
    
    end

end
