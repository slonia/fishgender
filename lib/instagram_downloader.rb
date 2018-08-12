class InstagramDownloader
  USER = 'ververa'
  UA = "Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:16.0.1) Gecko/20121011 Firefox/16.0.1"
  URL = "https://www.instagram.com"

  def run
    uri = URI.parse(URL)
    http = Net::HTTP.new(uri.host, uri.port)
    headers = {"User-Agent" => UA}
    http.use_ssl = true
    resp, data = http.get("/", headers)
    shared_data = get_shared_data(resp.body)
    cookie = resp.response['set-cookie'].split("; ")[0]
    headers = {
      'X-CSRFToken' => shared_data['config']['csrf_token'],
      'User-Agent' => UA,
      'Cookie' => cookie
    }
    rhx = shared_data['rhx_gis']
    resp, data = http.get("/#{USER}", headers)
    # binding.pry
  end

  private

  def process_image(image)
    Photo.create(
      image: open(image['display_src']),
      source: :instagram,
      instagram_id: image['id'],
      instagram_code: image['code']
    )
  end

  def get_shared_data(str)
    match = str.match(/window\._sharedData = (\{[^\n]*\});/)
    matches = match.to_a
    if matches.size > 1
      JSON.load(matches[1])
    else
      {}
    end
  end
end
