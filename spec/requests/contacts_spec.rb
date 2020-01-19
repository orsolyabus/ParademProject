require "rails_helper"

RSpec.describe "Contacts", type: :request do
  describe "users can create contacts" do
    before do
      @user = FactoryBot.create(:user)
    end
    
    context "when not logged in" do
      it "redirects user to login" do
        current_user = nil
        get new_contact_path
        expect(response).to redirect_to(new_sessions_path)
      end
    end
    
  end
  
  it "can only be seen or modified by the owner" do
    user1 = FactoryBot.create(:user, name: "user1", email: "user1@email.com")
    contact = FactoryBot.create(:contact, user_id: user1.id)

    user2 = FactoryBot.create(:user, name: "user2", email: "user2@email.com", password: "password")
    post sessions_path :params => { email: user2.email, password: user2.password }
    
    get contact_path contact
    expect(response).to have_http_status(401)
  end
  
end
