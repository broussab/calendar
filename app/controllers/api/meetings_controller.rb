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
    if params[:text].strip == "help"
      render json: {
        "attachments": [
          {
          "color":  "#70468C",
          "title":  "Out of Office Calendar Help",
          "title_link": "https://cryptic-woodland-68868.herokuapp.com/instructions",
          "text": "Just enter /ooo [reason, start time, end time] and your event will automatically be added to the Out of Office Calendar! Make sure the parameters are separated by commas and the times are in the format: MM-DD-YYYY HH:MM am/pm. For example: /ooo WFH, 03-27-2017 8:00 am, 03-27-2017 5:00 pm "
        }
      ]
    }
  else
    params_array = params[:text].split(',')

    if params_array.length != 3
      messages("failure")
    else
      @reason = params_array[0]
      start_time_arr = params_array[1].scan(/\d+|\w+/)
      if start_time_arr.length != 6
        messages("failure")
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
      messages("failure")
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
          messages("success")
        else
          messages("failure")
        end
    end
  end
end

  def preflight
    head 200
  end

  def messages(status)
    if status == "success"
      render json: {
        "attachments": [
            {
                "color": "#36a64f",
                "pretext": "Your new Out of Office Event has been created successfully!",
                "title": "#{@meeting.name}  -  #{@meeting.reason}",
                "title_link": "https://cryptic-woodland-68868.herokuapp.com",
                "text": "#{@meeting.start_time.strftime '%B %d, %Y at %I:%M %P'} - #{@meeting.end_time.strftime '%B %d, %Y at %I:%M %P'}",
                "image_url": "http://my-website.com/path/to/image.jpg",
                "thumb_url": "http://example.com/path/to/thumb.png",
                "footer": "Slack API",
                "footer_icon": "https://platform.slack-edge.com/img/default_application_icon.png"
            }
        ]
      }, status: :created
    else
      render json: {
        "attachments":  [
          {
              "color": "danger",
              "pretext": "There was an error creating your Out of Office event. Check to see if your parameters are correct.",
              "title": "Out of Office Calendar",
              "title_link": "https://cryptic-woodland-68868.herokuapp.com",
              "image_url": "http://my-website.com/path/to/image.jpg",
              "thumb_url": "http://example.com/path/to/thumb.png",
              "footer": "Slack API",
              "footer_icon": "https://platform.slack-edge.com/img/default_application_icon.png"
          }
      ]
      }, status: :unprocessable_entity
    end
  end
end
