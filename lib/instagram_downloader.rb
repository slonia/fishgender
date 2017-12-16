class InstagramDownloader
  USER = 'ververa'

  def new
    # @last_id = Photo.unscoped.where.not(instagram_id: nil).order(:created_at).last.instagram_id
  end

  def run
    images = RubyInstagramScraper.get_user_media_nodes(USER)
    images.each do |image|
      process_image(image)
      puts 'done'
    end
  end

  private

  def process_image(image)
    Photo.create(
      image: open(image['display_src']),
      source: :instagram,
      instagram_id: image['id']
    )
  end
end
