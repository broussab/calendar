class TodayService
  def initialize(params)
    @params = params
  end

  def response
    slackhandle = @params[:text].strip[1..-1]

    title = nil
    color = 'danger'
    text = "I'm sorry. That user does not exist in the Out of Office Calendar database."

    if user = User.where(:slackhandle => slackhandle).first
      title = user.full_name
      if user.meetings.for_calendar(DateTime.now.beginning_of_day, DateTime.now.end_of_day).empty?
        color = 'good'
        text = 'Is In the Office Today!'
      else
        color = 'danger'
        text = 'Is Scheduled to be Out of the Office Today.'
      end
    end

    { "attachments": [ {
          "color":  color,
          "title":  title,
          "title_link": "https://cryptic-woodland-68868.herokuapp.com/",
          "text": text,
          "image_url": "http://my-website.com/path/to/image.jpg",
          "thumb_url": "http://example.com/path/to/thumb.png",
          "footer": "Slack API",
          "footer_icon": "https://platform.slack-edge.com/img/default_application_icon.png"
        }
      ]
    }
  end
end
