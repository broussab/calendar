class HelpService
  def response
    SlackResponse.new({
      title: "Out of Office Calendar Help",
      text: "Just enter /ooo [reason, start time, end time] and your event will automatically be added to the Out of Office Calendar! Make sure the parameters are separated by commas and the times are in the format: MM-DD-YYYY HH:MM am/pm. For example: /ooo WFH, 03-27-2017 8:00 am, 03-27-2017 5:00 pm
      You can also see if an employee is in or out of the office today by entering /ooo @slack_name. For example: /ooo @alyssa"
    })
  end
end
