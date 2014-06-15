module Docs
  class Requirejs
    class CleanHtmlFilter < Filter
      def call
        css('.sectionMark', '.hbox > .sect').remove
        css('h1 + .note').remove if root_page?

        css('.section', 'pre > code').each do |node|
          node.before(node.children).remove
        end

        css('h2', 'h3', 'h4').each do |node|
          next unless link = node.at_css('a[name]')
          node['id'] = link['name']
          link.before(link.children).remove
        end

        doc
      end
    end
  end
end
