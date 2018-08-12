namespace :importer do
  desc "Imports words from file into db"
  task :words, [:path, :kind] => :environment do |_t, args|
    File.readlines(args[:path]).each do |word|
      Word.create_normalized(word, args[:kind])
    end
  end

  desc "Import photos from folder"
  task :photos, [:path] => :environment do |_t, args|
    Dir[File.join(args[:path], '*.jpg')].each do |image|
      Photo.create(image: File.open(image, 'rb'))
    end
  end

  desc "Update tags on photos"
  task tags: :environment do
    Photo.where("tags = ?", [].to_yaml).map(&:save)
  end

  desc "From instagram"
  task instagram: :environment do
    InstagramDownloader.new.run
  end
end



ua = "Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:16.0.1) Gecko/20121011 Firefox/16.0.1"
response = http.request(Net::HTTP::Get.new(uri.request_uri))
url = "https://www.instagram.com"
uri = URI.parse(url)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
resp, data = http.get("/", {"User-Agent" => ua})
cookie = resp.response['set-cookie'].split("; ")[0]
shared_data = get_shared_data(resp.body)
headers = {
  'X-CSRFToken' => shared_data['config']['csrf_token'],
  'User-Agent' => ua,
  'Cookie' => cookie
}
rhx = shared_data['rhx_gis']
def get_shared_data(str)
  match = str.match(/window\._sharedData = (\{[^\n]*\});/)
  matches = match.to_a
  if matches.size > 1
    JSON.load(matches[1])
  else
    {}
  end
end
