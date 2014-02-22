# -*- encoding : utf-8 -*-

class GameDownloader
  def execute
    doc = download

    results = parse(doc)

    save_results(results)
  end

  def download
    require 'capybara/rails'

    session = Capybara::Session.new(:webkit)
    session.visit('http://www.easports.com/fifa/football-club/profile/history/PC/lmagus')
    content = session.html

    content.force_encoding('iso-8859-1').encode('utf-8')

    Nokogiri::HTML(content, nil, 'utf-8')
  end

  def parse(doc)
    matches = doc.search('div[@class="row-fluid  visible"]').reverse

    all_matches = []

    matches.each do |match|
      score = match.at('div[@class="clearfix"]').next.next
      info = match.at('ul[@class^="match-info"]').search('li')

      attrs = {}

      attrs['match_type'] = match.at('div[@class="clearfix"]').text.strip.split(':').first
      num = match.at('div[@class="clearfix"]').text.strip.split(':').last.split('ago').first.strip.to_i
      word = match.at('div[@class="clearfix"]').text.strip.split(':').last.split('ago').first.strip
      
      attrs['rival_name'] = score.search('*[@class="ng-binding"]')[3].text
      attrs['my_team'] = score.at('*[@class="match-crest align-left"]').at('img')['src']
      attrs['rival_team'] = score.at('*[@class="match-crest align-right"]').at('img')['src']
      attrs['my_score'] = score.search('*[@class="ng-binding"]')[0].text
      attrs['rival_score'] = score.search('*[@class="ng-binding"]')[2].text

      info.each do |i|
        mine = "my_#{i.search('div[@class="text-center"]')[1].text}".downcase.gsub(' ', '_')
        rival = "rival_#{i.search('div[@class="text-center"]')[1].text}".downcase.gsub(' ', '_')
        attrs[mine] = i.search('div[@class="text-center"]')[0].text
        attrs[rival] = i.search('div[@class="text-center"]')[2].text
      end

      attrs['digest'] = Digest::MD5.hexdigest(attrs.to_s)

      attrs['date'] = Time.now - num.minute if word.match /minute/
      attrs['date'] = Time.now - num.hour if word.match /hour/
      attrs['date'] = Time.now - num.day if word.match /day/
      attrs['date'] = Time.now - num.week if word.match /week/
      attrs['date'] = Time.now - num.month if word.match /month/
      attrs['date'] = attrs['date'].to_date

      all_matches << attrs
    end

    all_matches
  end

  def save_results(results)
    results.each do |res|
      Match.where(digest: res['digest']).first_or_create(res)
    end
  end
end