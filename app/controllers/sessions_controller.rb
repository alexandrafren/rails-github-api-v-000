class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    client_id = ENV[GITHUB_CLIENT_ID]
    client_secret = '2bd22e593a540174830fa6899ddc7aae445b9882'
    response = Faraday.post "https://github.com/login/oauth/access_token" do |r|
      r.body = { 'client_id': client_id, 'client_secret': client_secret, 'code': params[:code] }
      r.headers['Accept'] = 'application/json'
    end
    body = JSON.parse(response.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
