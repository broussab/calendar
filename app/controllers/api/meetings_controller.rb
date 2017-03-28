class API::MeetingsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!
  before_action :set_access_control_headers

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Content-Type'
  end

  def create
    params_array = params[:text].split

    if params_array.length != 5
      render json: { errors: "You have not entered the parameters correctly. Please try again."}, status: :unprocessable_entity
    else
      @reason = params_array[0]
      @start_time =  [params_array[1], params_array[2]].join(' ')
      @end_time = [params_array[3], params_array[4]].join(' ')
      @user = User.where("slackhandle = ?", params[:user_name].to_s).take!
      @meeting = @user.meetings.build(name: @user.full_name, reason: @reason, start_time: @start_time, end_time: @end_time)

        if @meeting.save
          render json: @meeting, status: :created
        else
          render json: { errors: @meeting.errors }, status: :unprocessable_entity
        end
    end
  end


  def preflight
    head 200
  end
end
