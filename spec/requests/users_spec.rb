require "rails_helper"
# require 'spec_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users/new" do
    it "reders the form to create a new user" do
      get new_user_path
      expect(response).to render_template(:new)
    end
  end

  describe "POST /users/:id" do
    
    context "with valid inputs" do
      it "creates a User and redirects to the User's page" do
        post users_path :user => FactoryBot.attributes_for(:user)
        expect(response).to redirect_to(assigns(:user))
        follow_redirect!

        expect(response).to render_template(:show)
        expect(response.body).to include("User was successfully created.")
      end
    end
    
    context "no valid input" do
      it "renders new user form with error message" do
        post users_path :user => {name: nil, email: nil, passwprd: nil}
        expect(response).to render_template(:new)
        expect(response.body).to include("user can not be saved")
      end
    end
    
  end
  
  describe "GET /users/:id" do
    it "renders user page" do
      user = FactoryBot.create(:user)
      get user_path user
      expect(response).to render_template(:show)
      expect(assigns(:user)).to eq user
    end
  end

  describe "GET /users/:id/edit" do
    it "renders user edit page" do
      user = FactoryBot.create(:user)
      get edit_user_path user
      expect(response).to render_template(:edit)
      expect(assigns(:user)).to eq user
    end
  end
  
  describe "PUT users/:id" do
    context "with valid inputs" do
      it "updates a User and redirects to the User's page" do
        user = FactoryBot.create(:user)
        put user_path user, :user => FactoryBot.attributes_for(:user, name: "new name")
        expect(response).to redirect_to(assigns(:user))
        follow_redirect!

        expect(response).to render_template(:show)
        expect(response.body).to include("User was successfully updated.")
        expect(response.body).to include("new name")
      end
    end
    
    context "no valid input" do
      it "renders edit user form with error message" do
        user = FactoryBot.create(:user)
        put user_path user, :user => FactoryBot.attributes_for(:user, name: nil, email: "invalid")
        expect(response).to render_template(:edit)
        expect(response.body).to include("user can not be saved")
      end
    end
    
  end
  # destroy
  describe "DELETE users/:id" do
    it "deletes user and redirects to new user page" do
      user = FactoryBot.create(:user)
      delete user_path user
      expect(response).to redirect_to(:new_user)
      follow_redirect!
      expect(response.body).to include("User was successfully deleted")
      
      get user_path user
      expect(response).to have_http_status(404)
    end
  end
end
