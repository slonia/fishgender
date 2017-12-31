namespace :fishgender do
  desc "Posts to twitter"
  task post: :environment do
    Generator.new.post
  end

  desc "New year"
  task new_year: :environment do
    text = "Новогодняя селёдка под шубой"
    photo = Photo.where(used: 1000).last
    Generator.new.send_tweet(text, photo.image.file_object)
  end
end
