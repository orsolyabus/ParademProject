require "rails_helper"

RSpec.describe "Sessions", type: :request do
  describe "Authentication" do
    before do
      @user = FactoryBot.create(:user, email: "valid@email.com", password: "password")
    end
    
    context "with valid credentials" do
      it "allows users to log in" do
        get new_sessions_path
        expect(response).to render_template :new

        post sessions_path :params => { email: @user.email, password: @user.password }

        expect(response).to redirect_to(user_path(@user))
        follow_redirect!

        expect(response).to render_template("users/show")
        expect(assigns(:user)).to eq @user
      end
    end
    
    context "no valid credentials" do
      it "prevents user from logging in" do
        post sessions_path :params => { email: "@user.email", password: "wrong password" }
        expect(response).to render_template(:new)
        expect(response.body).to include("wrong email or password")
      end
    end
    
  end
end
