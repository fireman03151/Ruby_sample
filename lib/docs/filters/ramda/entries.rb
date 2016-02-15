module Docs
  class Ramda
    class EntriesFilter < Docs::EntriesFilter
      def additional_entries
        css('ul.toc li').map do |node|
          ["R.#{node['data-name']}", node['data-name'], node['data-category']]
        end
      end
    end
  end
end
