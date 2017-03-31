class HelpService
  def response
    { attachments: [ {
      color:  "#70468C",
      title:  "Out of Office Calendar Help",
      title_link: "https://cryptic-woodland-68868.herokuapp.com/instructions",
      text: "Just enter /ooo [reason, start time, end time] and your event will automatically be added to the Out of Office Calendar! Make sure the parameters are separated by commas and the times are in the format: MM-DD-YYYY HH:MM am/pm. For example: /ooo WFH, 03-27-2017 8:00 am, 03-27-2017 5:00 pm ",
      image_url: "http://my-website.com/path/to/image.jpg",
      thumb_url: "http://example.com/path/to/thumb.png",
      footer: "Slack API",
      footer_icon: "https://platform.slack-edge.com/img/default_application_icon.png"
    } ] }
  end
end
