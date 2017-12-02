namespace :fishgender do
  desc "Posts to twitter"
  task post: :environment do
    Generator.new.post
  end
end
