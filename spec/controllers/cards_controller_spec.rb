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
        end

        describe "failure" do
            before(:each) do
                @attr = { :greeting => "" }
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
                @attr = { :greeting => "Lorem ipsum", :recipient_id => @recipient.id }
            end

            it "should create a card" do
                lambda do
                    post :create, :card => @attr
                end.should change(Card, :count).by(1)
            end

            it "should redirect to the home page" do
                post :create, :card => @attr
                response.should redirect_to(root_path)
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
        end
    end

end
