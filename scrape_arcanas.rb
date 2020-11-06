require 'active_record'
require 'active_support/all'
require 'open-uri'
require 'nokogiri'

Time.zone_default = Time.find_zone! 'Tokyo'
ActiveRecord::Base.default_timezone = :local

ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  host: 'localhost',
  username: 'root',
  password: '',
  database: 'persona5_development',
  encoding: 'utf8mb4',
  charset: 'utf8mb4',
  collation: 'utf8mb4_general_ci'
)

class Persona < ActiveRecord::Base
end

class Arcana < ActiveRecord::Base
end

def scrape_persona
  url = 'https://kamigame.jp/P5R/%E3%83%9A%E3%83%AB%E3%82%BD%E3%83%8A/index.html'
  doc = Nokogiri::HTML.parse(open(url))
  doc.css('table.wt.pct_10_46_auto > tbody > tr').each do |tr|
    persona_initial_level = tr.css('td')[0].text
    persona_name = tr.css('td > a')[0].text.strip
    persona_arcana = tr.css('td > a')[1].text
    begin
      Persona.create(
        name: persona_name,
        arcana_number: Arcana.find_by(name: persona_arcana).number,
        initial_level: persona_initial_level
      )
    rescue
      next
    end
  end
end

def update_collective_guillotine
  collective_guillotine_url = 'https://kamigame.jp/P5R/%E3%83%9A%E3%83%AB%E3%82%BD%E3%83%8A/%E9%9B%86%E5%9B%A3%E3%82%AE%E3%83%AD%E3%83%81%E3%83%B3.html'
  sleep 1
  doc = Nokogiri::HTML.parse(open(collective_guillotine_url))
  doc.css('table.wt.pct_30_30_auto > tbody > tr').each do |tr|
    collective_guillotine_persona_name = tr.css('td')[0].text
    begin
      Persona.find_by(name: collective_guillotine_persona_name)
            .update(category_id: 3)
    rescue => e
      p e.message
      p e.backtrace
    end
  end
end

def update_treasure_devil
  treasure_devil_url = 'https://kamigame.jp/P5R/%E6%94%BB%E7%95%A5%E3%82%AC%E3%82%A4%E3%83%89/%E5%AE%9D%E9%AD%94.html'
  sleep 1
  doc = Nokogiri::HTML.parse(open(treasure_devil_url))
  doc.css('table.wt.pct_33_30 > tbody > tr').each do |tr|
    treasure_devil_name = tr.css('td')[0].text
    begin
      Persona.find_by(name: treasure_devil_name)
            .update(category_id: 2)
    rescue => e
      p e.message
      p e.backtrace
    end
  end
end

scrape_persona
update_collective_guillotine
update_treasure_devil
