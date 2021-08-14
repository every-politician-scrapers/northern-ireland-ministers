#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      Name.new(
        full: noko.css('h4').text.tidy,
        prefixes: %w[Mr Mrs Miss Ms]
      ).short
    end

    def position
      return ministry.sub('Department', 'Minister') if role == 'Minister'

      noko.css('label').text.tidy
    end


    private

    def role
      noko.css('label').text.tidy
    end

    def ministry
      noko.css('p').text.tidy
    end
  end

  class Members
    def member_container
      noko.css('.field-item .field-item')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
