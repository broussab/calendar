class API::MeetingsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!
  before_action :set_access_control_headers

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Content-Type'
  end

  def preflight
    head 200
  end

  def create
    text = params[:text].strip
    response = if text == "help"
      HelpService.new.response
    elsif text.start_with?"@"
      TodayService.new(params).response
    else
      MeetingService.new(params).response
    end

    if response.good?
      render json: response, status: :ok
    else
      render json: response, status: :unprocessable_entity
    end      
  end
end
