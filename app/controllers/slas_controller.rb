class SlasController < ApplicationController
  # {"name"=>"sla2", "first_response_time"=>"120", "update_time"=>"240", "solution_time"=>"240", "condition"=>{"article.type_id"=>{"operator"=>"is", "value"=>"1"}}, "calendar_id"=>"3", "id"=>"c-2"}

  def index
  end

  def new
    @response = RestClient::Request.execute(
      method: :get,
      url: base_url+"/slas/fetch_datas",
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
      url: base_url+"/slas",
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
