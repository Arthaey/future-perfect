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

  describe "GET #goals" do
    it "returns http success" do
      get :goals
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #pomodoros" do
    it "returns http success" do
      get :pomodoros
      expect(response).to have_http_status(:success)
    end
  end


end
