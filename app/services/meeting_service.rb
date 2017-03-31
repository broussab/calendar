class MeetingService
  def initialize(params)
    @params = params
  end

  def response
    parts = @params[:text].strip.split(',')

    if parts.size != 3
      return failure_message
    else
      reason     = parts.shift
      start_time = DateTime.parse(parts.shift) rescue nil
      return failure_message unless start_time

      end_time = DateTime.parse(parts.shift) rescue nil
      return failure_message unless end_time


      user = User.where({ slackhandle: @params[:user_name] }).first
      if meeting = user.meetings.create({ name: user.full_name, reason: reason, start_time: start_time, end_time: end_time })
        success_message(meeting)
      else
        failure_message
      end
    end
  end

  private

  def failure_message
    { "attachments":  [
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
    ] }
  end


  def success_message(meeting)
    { "attachments":  [
      {
        "color": "#36a64f",
        "pretext": "Your new Out of Office Event has been created successfully!",
        "title": "#{meeting.name}  -  #{meeting.reason}",
        "title_link": "https://cryptic-woodland-68868.herokuapp.com",
        "text": "#{meeting.start_time.strftime '%B %d, %Y at %I:%M %P'} - #{meeting.end_time.strftime '%B %d, %Y at %I:%M %P'}",
        "image_url": "http://my-website.com/path/to/image.jpg",
        "thumb_url": "http://example.com/path/to/thumb.png",
        "footer": "Slack API",
        "footer_icon": "https://platform.slack-edge.com/img/default_application_icon.png"
      }
    ] }
  end
end
