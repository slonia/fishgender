namespace :dump do
  desc "Dumps db and photos to archive"
  task create: :environment do
    date = Date.today.to_s
    path = relative_path('dumps', date)
    Dir.mkdir(path) unless File.exists?(path)
    `tar -zcvf #{path}/photos.tar.gz #{photos_path}`
    if Rails.env.development?
      db_path = relative_path("db", "development.sqlite3")
      `cp #{db_path} #{path}`
    else
    end
  end

  desc "Drops db and creaes it from archive"
  task :restore, [:path] => :environment do |_t, args|
    dump_path = args[:path] || latest_dump
    FileUtils.remove_dir(photos_path) if File.exists?(photos_path)
    `tar -xf #{dump_path}/photos.tar.gz -C ./`
    if Rails.env.development?
      db_path = FileUtils.rm(relative_path("db", "development.sqlite3"))
      `cp #{dump_path}/development.sqlite3 #{db_path}`
    else
    end
  end

  def photos_path
    'public/uploads/photo'
  end

  def relative_path(*path)
    Rails.root.join(*path).to_s
  end

  def latest_dump
    Dir[Rails.root.join("dumps", "*")].sort.last
  end
end
