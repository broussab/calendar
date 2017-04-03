class TodayService
  def initialize(params)
    @params = params
  end

  def response
    slackhandle = @params[:text].strip[1..-1]

    if user = User.where(:slackhandle => slackhandle).first
      if user.meetings.for_calendar(DateTime.now.beginning_of_day, DateTime.now.end_of_day).empty?
        SlackResponse.new({
          title:  user.full_name,
          text: 'Is In the Office Today!'
        })
      else
        SlackResponse.new({
          failed: true,
          title:  user.full_name,
          text: 'Is Scheduled to be Out of the Office Today.'
        })
      end
    else
      SlackResponse.new({
        failed: true,
        text: "I'm sorry. That user does not exist in the Out of Office Calendar database."
      })
    end
  end
end
