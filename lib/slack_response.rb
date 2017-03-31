class SlackResponse
  attr_reader :title, :text, :title_link, :image_url, :thumb_url, :footer, :footer_icon, :color

  def initialize(params = {})
    @title_link  = 'https://cryptic-woodland-68868.herokuapp.com/instructions'
    @image_url   = 'http://my-website.com/path/to/image.jpg'
    @thumb_url   = 'http://example.com/path/to/thumb.png'
    @footer      = 'Slack API'
    @footer_icon = 'https://platform.slack-edge.com/img/default_application_icon.png'
    @title       = 'OOO Bot'
    @text        = 'This is a post'
    @pretext     = 'OOO Bot'

    if params[:failed]
      @color = 'danger'
    else
      @color = 'good'
    end

    params.each do |key, value|
      self.instance_variable_set(:"@#{key}", value)
    end
  end

  def good?
    !@failed
  end
end
