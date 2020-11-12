require 'active_record'
require 'active_support/all'
require 'open-uri'
require 'nokogiri'

Time.zone_default = Time.find_zone! 'Tokyo'
ActiveRecord::Base.default_timezone = :local
ActiveRecord::Base.logger = Logger.new(STDOUT)

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

class Skill < ActiveRecord::Base
end

class PersonaSkill < ActiveRecord::Base
end

def create_record(ref, persona_name)
  detail_url = "https://kamigame.jp#{ref}"
  sleep 1
  detail_doc = Nokogiri::HTML.parse(open(detail_url))
  skill_table = detail_doc.css('table.description_table')[1]
  skill_table.css('tbody > tr').each do |tr|
    level_text = tr.css('td')[0].text
    level = level_text == '初期' ? 0 : level_text[/\d+/].to_i
    skill = tr.css('td')[1].text
    skill_name = skill[/【(.*)】/, 1]
    skill_description = skill[/】(.*)/, 1]
    unless Skill.find_by(name: skill_name)
      Skill.create(
        name: skill_name,
        description: skill_description
      )
    end
    PersonaSkill.create(
      persona_id: Persona.find_by(name: persona_name).id,
      skill_id: Skill.find_by(name: skill_name).id,
      level: level
    )
  end
end

url = 'https://kamigame.jp/P5R/%E3%83%9A%E3%83%AB%E3%82%BD%E3%83%8A/index.html'
sleep 1
doc = Nokogiri::HTML.parse(open(url))
doc.css('table.wt.pct_10_46_auto > tbody > tr').each do |tr|
  target_element = tr.css('td > a')[0]
  a_href = target_element[:href]
  persona_name =  target_element.text.strip
  create_record(a_href, persona_name)
end
