#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'csv'

uri = URI('https://raw.githubusercontent.com/db1000n-coordinators/LoadTestConfig/main/config.v0.7.json')
response = Net::HTTP.get(uri)
data = JSON.parse(response)

CSV.open('targets.csv', 'w') do |csv|
  data['jobs'].map do |row|
    if row['type'] == 'http'
      csv << [row.dig('args', 'request', 'path')]
    elsif row['type'] == 'tcp'
      csv << ["tcp://#{row.dig('args', 'address')}"]
    end
  end
end

  



