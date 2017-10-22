RSpec.describe DashboardController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end


  describe "GET #timeline" do
    it "returns http success" do
      get :timeline
      expect(response).to have_http_status(:success)
    end
  end


  describe "GET #styleguide" do
    it "returns http success" do
      get :styleguide
      expect(response).to have_http_status(:success)
    end
  end

end
