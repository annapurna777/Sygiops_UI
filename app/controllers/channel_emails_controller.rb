class ChannelEmailsController < ApplicationController
  def index
    response = RestClient::Request.execute(
  			method: :get,
  			url: base_url+"/channel_emails",
  			payload: params.as_json,
  			headers: {
  				'Content-Type' => "application/x-www-form-urlencoded",
  				"Authorization" => session[:token],
        },
        timeout: 240
      )
      @response = JSON.parse(response)
  end

  def create
    if params["probe_type"] == "inbound"
      url = base_url+"/channel_emails/inbound"
    elsif params["probe_type"] == "outbound"
      url = base_url+"/channel_emails/outbound"
    else
      url = base_url+"/channel_emails/verify"
    end
    response = RestClient::Request.execute(
  			method: :post,
  			url: url,
  			payload: params.as_json,
  			headers: {
  				'Content-Type' => "application/x-www-form-urlencoded",
  				"Authorization" => session[:token],
        },
        timeout: 240
      )
      render json: response
  end

end
