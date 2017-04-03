class SlackResponse
  attr_reader :title, :text, :title_link, :image_url, :thumb_url, :footer, :footer_icon, :color

  def initialize(params = {})
    @failed = params[:failed] || false
    @title_link  = params[:title_link] || 'https://cryptic-woodland-68868.herokuapp.com/instructions'
    @image_url   = params[:image_url] || 'http://my-website.com/path/to/image.jpg'
    @thumb_url   = params[:thumb_url] || 'http://example.com/path/to/thumb.png'
    @footer      = params[:footer] || 'Slack API'
    @footer_icon = params[:footer_icon] || 'https://platform.slack-edge.com/img/default_application_icon.png'
    @title       = params[:title] || 'OOO Bot'
    @text        = params[:text] || 'This is a post'
    @pretext     = params[:pretext] || 'OOO Bot'
    @color = params[:failed] ? 'danger' : 'good'
  end

  def good?
    !@failed
  end
end
