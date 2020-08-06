class OrganizationsController < ApplicationController
  # {"name"=>"Sygitech", "shared"=>true, "note"=>"sygitech note", "active"=>true, "domain_assignment"=>false, "domain"=>"sygitech.com", "id"=>"c-2"}
  def index
    @response = RestClient::Request.execute(
      method: :get,
      url: base_url+"/organizations",
      payload: params.as_json,
      headers: {
        'Content-Type' => "application/x-www-form-urlencoded",
        "Authorization" => session[:token],
      },
      timeout: 240
    )
    @response = JSON.parse(@response)
  end

  def new
    @response = RestClient::Request.execute(
      method: :get,
      url: base_url+"/organizations/fetch_timezones",
      payload: params.as_json,
      headers: {
        'Content-Type' => "application/x-www-form-urlencoded",
        "Authorization" => session[:token],
      },
      timeout: 240
    )
    @response = JSON.parse(@response)
    # binding.pry
  end

  def create
    @response = RestClient::Request.execute(
      method: :post,
      url: base_url+"/organizations",
      payload: params.as_json,
      headers: {
        'Content-Type' => "application/x-www-form-urlencoded",
        "Authorization" => session[:token],
      },
      timeout: 240
    )
    @response = JSON.parse(@response)
    render json: @response
  end

end
