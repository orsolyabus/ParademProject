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
end
