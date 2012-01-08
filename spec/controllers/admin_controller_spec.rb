require 'spec_helper'

describe AdminController do
    render_views

    describe "GET 'index'" do
        before(:each) do
            @admin = Factory(:admin)
            test_sign_in(@admin)
        end

        it "should be successful" do
            get 'index'
            response.should be_success
        end
    end

    describe "GET 'upload'" do
        before(:each) do
            @admin = Factory(:admin)
            test_sign_in(@admin)
        end

        it "should be successful" do
            get 'upload'
            response.should be_success
        end
    end

    describe "GET 'tag'" do
        before(:each) do
            @admin = Factory(:admin)
            test_sign_in(@admin)
        end

        it "should be successful" do
            get 'tag'
            response.should be_success
        end
    end

    describe "POST 'tag_card_from_image'" do
        before(:each) do
            @admin = test_sign_in(Factory(:admin))
            @template = Factory(:template)
            @tags = "birthday"
        end

        describe "failure" do
            before(:each) do
                @attr = { :tags => "",
                          :template_id => @template.id }
            end

            it "should not create a tag" do
                lambda do
                    post :tag_card_from_image, @attr
                end.should_not change(Tag, :count)
            end

            it "should render the admin page" do
                post :tag_card_from_image, @attr
                response.should redirect_to(admin_path)
            end
        end

        describe "success" do
            before(:each) do
                @attr = {
                    :template_id => @template.id,
                    :tags => @tags }
            end

            it "should create a tag" do
                lambda do
                    post :tag_card_from_image, @attr
                end.should change(Tag, :count).by(1)
            end

            it "should create multiple tags" do
                lambda do
                    post :tag_card_from_image, @attr.merge(:tags => "birthday, congratulations")
                end.should change(Tag, :count).by(2)
            end

            it "should not a tag more than once to a card" do
                lambda do
                    post :tag_card_from_image, @attr
                    post :tag_card_from_image, @attr
                end.should change(Tag, :count).by(1)
            end


            it "should redirect to the admin page" do
                post :tag_card_from_image, @attr
                response.should redirect_to(admin_path)
            end

#            it "should add a tag to the template" do
#                pre_count = @template.tags.length
#                post :tag_card_from_image, @attr
#                @template.tags.length.should == pre_count+1
#            end
        end
    end

end
