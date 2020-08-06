class TicketsController < ApplicationController
  require 'open-uri'

  def index
    @options = ["hi","hello"]
    @tickets = []
    if !params[:parameter]
      params[:parameter] = "none"
    end
    @response = RestClient::Request.execute(
      method: :get,
      url: base_url+"/tickets",
      payload: params.as_json,
      headers: {
        'Content-Type' => "application/x-www-form-urlencoded",
        "Authorization" => session[:token],
      },
      timeout: 240
    )
    @response = JSON.parse(@response)
    # binding.pry
    @about = @response["about"]
    @response.delete("about")
    if params[:filter] && (params[:filter] == "true")
      # render :layout => false
      render :partial => 'partials/tickets_index'
    end
  end

  def get_options
    url = "/tickets/get_options"
    if params[:parameter] == "customer"
      url = "/users"
    elsif params[:parameter] == "organization"
      url = "/organizations"
    elsif params[:parameter] == "type"
      url = "/ticket_types"
    elsif params[:parameter] == "priority"
      url = "/ticket_priority"
    elsif params[:parameter] == "none"
      render json: []
    end
    @response = RestClient::Request.execute(
      method: :get,
      url: base_url+url,
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

  def show
    @response = RestClient::Request.execute(
      method: :get,
      url: base_url+"/tickets/#{params[:id]}",
      payload: params.as_json,
      headers: {
        'Content-Type' => "application/x-www-form-urlencoded",
        "Authorization" => session[:token],
      },
      timeout: 240
    )

    @response = JSON.parse(@response)
    @users = @response["users"]
    @replies = {}
    @attached_files = {}
    @response["attachments"].each_pair{ |article,attachment|
      @attached_files[article] = []
      attachment.each { |attach|
      if attach["preferences"]["Content-Type"]
        ticket_id = @response["ticket"]["id"].to_s
        article_id = article
        attach["url"] = base_url+"/ticket_attachment/"+ticket_id+"/"+article_id+"/"+attach["id"].to_s+"?disposition=attachment"
        @attached_files[article_id].push(attach)
      end
    }
    # binding.pry
  }
  end

  # def download
  #   @response = RestClient::Request.execute(
  #     method: :get,
  #     url: base_url+"/ticket_attachment/30/39/43?disposition=attachment",
  #     payload: params.as_json,
  #     headers: {
  #       'Content-Type' => "application/x-www-form-urlencoded",
  #       "Authorization" => session[:token],
  #     },
  #     timeout: 240
  #   )
  #
  #   open('test2.png', 'wb') do |file|
  #     file << @response
  #   end
  #   redirect_to tickets_path
  #   # binding.pry
  #
  # end

  def send_reply
    request = RestClient::Request.new(
      :method => :post,
      :url => base_url+"/tickets/send_reply",
      :payload => {
        :multipart => true,
        :ticket_id => params["ticket_id"],
        :to => params["to"],
        :cc => params["cc"],
        :body => params["email_body"],
        :file => params["attachments"]
        })

        response = request.execute
        # binding.pry
        @response = JSON.parse(response)
        # render json: @response
      end


    end
