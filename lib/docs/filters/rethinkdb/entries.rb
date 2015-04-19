module Docs
  class Rethinkdb
    class EntriesFilter < Docs::EntriesFilter
      def get_name
        at_css('.title').content.remove('ReQL command:').split(', ').first
      end

      def get_type
        link = at_css('a[href^="https://github.com/rethinkdb/docs/blob/master/api/javascript/"]')
        dir = link['href'][/javascript\/([^\/]+)/, 1]
        dir.titleize.gsub('Rql', 'ReQL').gsub('And', 'and')
      end

      def additional_entries
        at_css('.title').content.split(', ')[1..-1].map do |name|
          [name]
        end
      end
    end
  end
end
