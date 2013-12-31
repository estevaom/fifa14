# -*- encoding : utf-8 -*-

namespace :db do

  desc "Updates matches database"
  task :populate do

    require File.expand_path("config/environment")
    puts "Running matches update..."
    GameDownloader.new.execute
    puts "Finished.\n\n"

    puts Match.report

  end

end
