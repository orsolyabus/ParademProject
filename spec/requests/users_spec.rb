require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "user can create new account" do
    it "reders the form to create a new user" do
      get new_user_path
      expect(response).to render_template(:new)
    end

    context "with valid inputs" do
      it "creates a User and redirects to the User's page" do
        post users_path :user => FactoryBot.attributes_for(:user)
        expect(response).to redirect_to(assigns(:user))
        expect(assigns(:user)).to be_persisted
        follow_redirect!

        expect(response).to render_template(:show)
        expect(response.body).to include("User was successfully created.")
      end
    end

    context "no valid input" do
      it "renders new user form with error message" do
        post users_path :user => { name: nil, email: nil, passwprd: nil }
        expect(response).to render_template(:new)
        expect(response.body).to include("user can not be saved")
      end
    end
  end

  describe "exsisting user" do
    before do
      @user = FactoryBot.create(:user)
    end

    it "renders user page" do
      get user_path @user
      expect(response).to render_template(:show)
      expect(assigns(:user)).to eq @user
    end

    describe "user can edit their account" do
      it "renders user edit page" do
        get edit_user_path @user
        expect(response).to render_template(:edit)
        expect(assigns(:user)).to eq @user
      end

      context "with valid inputs" do
        it "updates a User and redirects to the User's page" do
          put user_path @user, :user => FactoryBot.attributes_for(:user, name: "new name")
          expect(response).to redirect_to(assigns(:user))
          follow_redirect!

          expect(response).to render_template(:show)
          expect(response.body).to include("User was successfully updated.")
          expect(response.body).to include("new name")
        end
      end

      context "no valid input" do
        it "renders edit user form with error message" do
          put user_path @user, :user => FactoryBot.attributes_for(:user, name: nil, email: "invalid")
          expect(response).to render_template(:edit)
          expect(response.body).to include("user can not be saved")
        end
      end
    end

    describe "user can delete their account" do
      it "deletes user and redirects to new user page" do
        delete user_path @user
        expect(response).to redirect_to(:new_user)
        follow_redirect!
        expect(response.body).to include("User was successfully deleted")

        get user_path @user
        expect(response).to have_http_status(404)
      end
    end
  end
end
