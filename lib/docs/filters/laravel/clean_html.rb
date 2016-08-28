module Docs
  class Laravel
    class CleanHtmlFilter < Filter
      def call
        if subpath.start_with?('/api')
          api
        else
          other
        end

        # Remove code highlighting
        css('pre').each do |node|
          node.content = node.content
          node['data-language'] = 'php'
        end

        css('a.__cf_email__').each do |node|
          node.replace(decode_cloudflare_email(node['data-cfemail']))
        end

        doc
      end

      def api
        @doc = doc.at_css('#page-content')

        css('.location').remove

        # Replace .header with <h1>
        css('.page-header > h1').each do |node|
          node.content = 'Laravel' if root_page?
          node.parent.before(node).remove
        end

        css('.container-fluid').each do |node|
          node.name = 'table'
          node.css('.row').each { |n| n.name = 'tr' }
          node.css('div[class^="col"]').each { |n| n.name = 'td' }
        end

        css('> div').each do |node|
          node.before(node.children).remove
        end

        # Remove <abbr>
        css('a > abbr').each do |node|
          node.parent['title'] = node['title']
          node.before(node.children).remove
        end

        # Clean up headings
        css('h1 > a', '.content', 'h3 > code', 'h3 strong', 'abbr').each do |node|
          node.before(node.children).remove
        end

        # Remove empty <td>
        css('td').each do |node|
          node.remove if node.content =~ /\A\s+\z/
        end
      end

      def other
        @doc = at_css('article')

        # Clean up headings
        css('h2 > a').each do |node|
          node.before(node.children).remove
        end

        css('p > a[name]').each do |node|
          node.parent.next_element['id'] = node['name']
        end

        css('blockquote').each do |node|
          node['class'] = 'tip' if node.inner_html.include?('{tip}')
          node.inner_html = node.inner_html.remove(/\{(tip|note)\}\s?/)
        end
      end
    end
  end
end
