namespace :myrailsapp do
  desc "Purge stale urls from shortened_urls table"
  task pure_urls: :environment do
    puts "Purging old urls..."
    ShortenedUrl.purge
  end
end
