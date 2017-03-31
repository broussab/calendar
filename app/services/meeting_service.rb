class MeetingService
  def initialize(params)
    @params = params
  end

  def response
    parts = @params[:text].strip.split(',').map(&:strip)

    if parts.size != 3
      return failure_message
    else
      reason = parts[0]

      start_time = DateTime.strptime(parts[1], '%m-%d-%Y %H:%M %p').to_s rescue false
      return failure_message unless start_time

      end_time = DateTime.strptime(parts[2], '%m-%d-%Y %H:%M %p').to_s rescue false
      return failure_message unless end_time

      user = User.where({ slackhandle: @params[:user_name] }).first
      if user && meeting = user.meetings.create({ name: user.full_name, reason: reason, start_time: start_time, end_time: end_time })
        success_message(meeting)
      else
        failure_message
      end
    end
  end

  private

  def failure_message
    SlackResponse.new({
      failed: true,
      pretext: "There was an error creating your Out of Office event. Check to see if your parameters are correct.",
      title: "Out of Office Calendar"
    })
  end


  def success_message(meeting)
    SlackResponse.new({
      pretext: "Your new Out of Office Event has been created successfully!",
      title: "#{meeting.name}  -  #{meeting.reason}",
      text: "#{meeting.start_time.strftime '%B %d, %Y at %I:%M %P'} - #{meeting.end_time.strftime '%B %d, %Y at %I:%M %P'}"
    })
  end
end
