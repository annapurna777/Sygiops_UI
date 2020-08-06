class GroupsController < ApplicationController

#930-46965104374260]  INFO -- :   Parameters: {"name"=>"user2", "assignment_timeout"=>4, "follow_up_possible"=>"new_ticket", "follow_up_assignment"=>"true", "email_address_id"=>"", "signature_id"=>"", "note"=>"wgdgwfda", "active"=>true, "id"=>"c-4"}

def new
  @response = RestClient::Request.execute(
    method: :get,
    url: base_url+"/groups/fetch_datas",
    payload: params.as_json,
    headers: {
      'Content-Type' => "application/x-www-form-urlencoded",
      "Authorization" => session[:token],
    },
    timeout: 240
  )
  @response = JSON.parse(@response)
end

def index
  @response = RestClient::Request.execute(
    method: :get,
    url: base_url+"/groups",
    payload: params.as_json,
    headers: {
      'Content-Type' => "application/x-www-form-urlencoded",
      "Authorization" => session[:token],
    },
    timeout: 240
  )
  @response = JSON.parse(@response)
end

def create
    @response = RestClient::Request.execute(
      method: :post,
      url: base_url+"/groups",
      payload: params.as_json,
      headers: {
        'Content-Type' => "application/x-www-form-urlencoded",
        "Authorization" => session[:token],
      },
      timeout: 240
    )
    @response = JSON.parse(@response)
end

def update
  @response = RestClient::Request.execute(
    method: :patch,
    url: base_url+"/groups/"+params[:id],
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
