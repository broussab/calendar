class SlackResponse
  attr_reader :title, :text

  def initialize(title, text)
    @title = title
    @text = text
  end
  def title_link
    "https://cryptic-woodland-68868.herokuapp.com"
  end

  def image_url
    "http://my-website.com/path/to/image.jpg"
  end

  def thumb_url
    "http://example.com/path/to/thumb.png"
  end

  def footer
    "Slack API"
  end

  def footer_icon
    "https://platform.slack-edge.com/img/default_application_icon.png"
  end
end

class DangerResponse < SlackResponse
  def color; 'danger'; end
end

class GoodResponse < SlackResponse
  def color; 'good'; end
end
