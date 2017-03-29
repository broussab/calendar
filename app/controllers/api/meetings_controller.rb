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
    params_array = params[:text].split(',')

    if params_array.length != 3
      render json: { error: "You have not entered the parameters correctly. Please try again."}, status: :unprocessable_entity
    else
      @reason = params_array[0]
      start_time_arr = params_array[1].scan(/\d+|\w+/)
      if start_time_arr.length != 6
        render json: { error: "You have not entered the start time parameter correctly. Please try again."}, status: :unprocessable_entity
      else
        if start_time_arr[5].start_with?('p', 'P')
          start_time_hour = start_time_arr[3].to_i + 12
        else
          start_time_hour = start_time_arr[3]
        end
        @start_time = DateTime.new(start_time_arr[2].to_i, start_time_arr[0].to_i, start_time_arr[1].to_i, start_time_hour.to_i, start_time_arr[4].to_i)
      end
      end_time_arr = params_array[2].scan(/\d+|\w+/)
      if start_time_arr.length != 6
        render json: { error: "You have not entered the end time parameter correctly. Please try again."}, status: :unprocessable_entity
      else
        if end_time_arr[5].start_with?('p', 'P')
          end_time_hour = end_time_arr[3].to_i + 12
        else
          end_time_hour = end_time_arr[3]
        end
        @end_time = DateTime.new(end_time_arr[2].to_i, end_time_arr[0].to_i, end_time_arr[1].to_i, end_time_hour.to_i, end_time_arr[4].to_i)
      end
      @user = User.where("slackhandle = ?", params[:user_name].to_s).take!
      @meeting = @user.meetings.build(name: @user.full_name, reason: @reason, start_time: @start_time, end_time: @end_time)

        if @meeting.save
          # render json: @meeting, status: :created
          render json: {
            "attachments": [
                {
                    "fallback": "Required plain-text summary of the attachment.",
                    "color": "#36a64f",
                    "pretext": "Optional text that appears above the attachment block",
                    "author_name": "Bobby Tables",
                    "author_link": "http://flickr.com/bobby/",
                    "author_icon": "http://flickr.com/icons/bobby.jpg",
                    "title": "Slack API Documentation",
                    "title_link": "https://api.slack.com/",
                    "text": "Optional text that appears within the attachment",
                    "fields": [
                        {
                            "title": "Priority",
                            "value": "High",
                            "short": false
                        }
                    ],
                    "image_url": "http://my-website.com/path/to/image.jpg",
                    "thumb_url": "http://example.com/path/to/thumb.png",
                    "footer": "Slack API",
                    "footer_icon": "https://platform.slack-edge.com/img/default_application_icon.png",
                    "ts": 123456789
                }
            ]
          }
        else
          render json: { errors: @meeting.errors }, status: :unprocessable_entity
        end
    end
  end


  def preflight
    head 200
  end
end
