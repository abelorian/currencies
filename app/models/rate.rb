class Rate < ApplicationRecord

  require 'open-uri'

  EACH_HOURS = 12

  API_KEY = ENV['API_KEY']

  def self.set_key_value key, value
    data = Rate.where(key: key)
    if data.exists?
      data = data.last
      data.value = value
      data.updated_at = Time.now
    else
      data = Rate.new(key: key, value: value)
    end
    data.save!
  end

  def self.get_value(key)
    where(key: key).last.try(:value)
  end

  def self.update_value key
    response = URI.open("https://openexchangerates.org/api/latest.json?app_id=#{API_KEY}").read
    timestamp = JSON.parse(response)["timestamp"] if response.present? && response.include?("timestamp")
    if timestamp.present?
      Rate.set_key_value(key, response)
    end
    response
  end

  def self.get_rates
    old_data = Rate.where(key: "rates")

    if old_data.exists?
      old_data = old_data.last
      if old_data.updated_at < EACH_HOURS.hours.ago
        Rate.update_value("rates")
      else
        get_value("rates")
      end
    else
      Rate.update_value("rates")
    end
  end

end
