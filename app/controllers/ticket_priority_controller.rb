class TicketPriorityController < ApplicationController
  def new

  end

  def create
    @response = RestClient::Request.execute(
      method: :post,
      url: base_url+"/ticket_priority",
      payload: params.as_json,
      headers: {
        'Content-Type' => "application/x-www-form-urlencoded",
        "Authorization" => session[:token],
      },
      timeout: 240
    )
    render json: @response
  end

  def index
    @response = RestClient::Request.execute(
      method: :get,
      url: base_url+"/ticket_priority",
      payload: params.as_json,
      headers: {
        'Content-Type' => "application/x-www-form-urlencoded",
        "Authorization" => session[:token],
      },
      timeout: 240
    )
    @response = JSON.parse(@response)
  end

  def edit
    @name = params[:name]
    @note = params[:note]
    @id = params[:id]
    render 'new'
  end

  def update
    @id = params[:id]
    @response = RestClient::Request.execute(
      method: :patch,
      url: base_url+"/ticket_priority/"+@id,
      payload: params.as_json,
      headers: {
        'Content-Type'  => "application/x-www-form-urlencoded",
        "Authorization" => session[:token],
      },
      timeout: 240
    )
    @response = JSON.parse(@response)
    render json: @response
  end

  def destroy
    @id = params[:id]
    @response = RestClient::Request.execute(
      method: :delete,
      url: base_url+"/ticket_priority/"+@id,
      payload: params.as_json,
      headers: {
        'Content-Type' => "application/x-www-form-urlencoded",
        "Authorization" => session[:token],
      },
      timeout: 240
    )
    render json: @response

  end
end
