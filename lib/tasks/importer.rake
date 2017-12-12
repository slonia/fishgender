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
end
