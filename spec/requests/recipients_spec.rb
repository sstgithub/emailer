require 'rails_helper'

RSpec.describe "Recipients", type: :request do
  describe "GET /recipients" do
    it "works! (now write some real specs)" do
      get recipients_path
      expect(response).to have_http_status(200)
    end
  end
end
