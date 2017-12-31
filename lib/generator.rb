class Generator
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = twitter_config[:consumer_key]
      config.consumer_secret     = twitter_config[:consumer_secret]
      config.access_token        = twitter_config[:access_token]
      config.access_token_secret = twitter_config[:access_token_secret]
    end
  end

  def post
    text = Word.random_text
    photo = random_photo
    text += ' ' + photo.instagram_link if photo.instagram_code
    send_tweet(text, photo.image.file_object)
  end

  def send_tweet(text, image)
    @client.update_with_media(text, image)
  end

  private

  def twitter_config
    Rails.application.secrets.twitter
  end

  def random_photo
    photo = Photo.active.unused.sample
    photo.use!
    photo
  end
end
