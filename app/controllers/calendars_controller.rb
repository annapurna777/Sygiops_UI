class CalendarsController < ApplicationController

  # Parameters: {"name"=>"new calendar", "timezone"=>"Asia/Kolkata", "business_hours"=>{"mon"=>{"active"=>true, "timeframes"=>[["09:00", "17:00"], ["13:00", "17:00"]]}, "tue"=>{"active"=>true, "timeframes"=>[["09:00", "17:00"]]}, "wed"=>{"active"=>true, "timeframes"=>[["09:00", "17:00"]]}, "thu"=>{"active"=>true, "timeframes"=>[["09:00", "17:00"], ["13:00", "17:00"]]}, "fri"=>{"active"=>true, "timeframes"=>[["09:00", "17:00"]]}, "sat"=>{"active"=>false, "timeframes"=>[["10:00", "14:00"]]}, "sun"=>{"active"=>false, "timeframes"=>[["10:00", "14:00"]]}}, "ical_url"=>"", "note"=>"", "id"=>"c-1"}

  # {"name"=>"hdcxJSHx", "timezone"=>"Asia/Kabul", "business_hours"=>{"mon"=>{"active"=>true, "timeframes"=>[["09:00", "17:00"]]}, "tue"=>{"active"=>true, "timeframes"=>[["09:00", "17:00"]]}, "wed"=>{"active"=>true, "timeframes"=>[["09:00", "17:00"]]}, "thu"=>{"active"=>true, "timeframes"=>[["09:00", "17:00"]]}, "fri"=>{"active"=>true, "timeframes"=>[["09:00", "17:00"]]}, "sat"=>{"active"=>false, "timeframes"=>[["10:00", "14:00"]]}, "sun"=>{"active"=>false, "timeframes"=>[["10:00", "14:00"]]}}, "ical_url"=>"", "public_holidays"=>{"2020-09-01"=>{"active"=>true, "summary"=>"vfgg"}}, "note"=>"", "id"=>"c-3"}

  def index
    response = RestClient::Request.execute(
  			method: :get,
  			url: base_url+"/calendars",
  			payload: params.as_json,
  			headers: {
  				'Content-Type' => "application/x-www-form-urlencoded",
  				"Authorization" => session[:token],
        },
        timeout: 240
      )
      @response = JSON.parse(response)
      # binding.pry
  end

  def new
    @days = ["mon","tue","wed","thu","fri","sat","sun"]
  end

  def create
    data = {"name" => params["name"],"business_hours" => {}}
    data["authenticity"] = params["authenticity_token"]
    @days = ["mon","tue","wed","thu","fri","sat","sun"]
    @days.each do |day|
      data["business_hours"][day] = {}
      data["business_hours"][day]["timeframes"] = []
      params[day].each_pair do |key,value|
        if key.match("from_")
          if ((params["#{day}_checkbox"]) && (params["#{day}_checkbox"] == "active"))
            data["business_hours"][day]["active"] = true
          else
            data["business_hours"][day]["active"] = false
          end
          id = key.split("_")[1]
          duration = [params[day][key],params[day]["till_#{id}"]]
          data["business_hours"][day]["timeframes"].push(duration)
        end
      end
    end

    data["public_holidays"] = {}
    params.each_pair do |key,value|
      if ((key.match("public_holiday_")) && (value != ""))
        id = key.split("_")[2]
        data["public_holidays"][value] = {"active" => true}
        data["public_holidays"][value]["summary"] = params["summary_#{id}"]
      end
    end
   puts data
    response = RestClient::Request.execute(
      method: :post,
      url: base_url+"/calendars",
      payload: data.as_json,
      headers: {
        'Content-Type' => "application/json",
        "Authorization" => session[:token],
      },
      timeout: 240
    )
    @response = JSON.parse(response)
    render json: response

  end

end
