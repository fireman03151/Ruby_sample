module Docs
  class Wordpress
    class CleanHtmlFilter < Filter
      def call
        if root_page?
          doc.inner_html = '<h1>WordPress</h1>'
          return doc
        end

        css('hr', '.screen-reader-text', '.table-of-contents',
            '.anchor', '.toc-jump', '.source-code-links', '.user-notes',
            '.show-more', '.hide-more').remove

        br = /<br\s?\/?>/i

        # Add PHP code highlighting
        css('pre').each do |node|
          node['data-language'] = 'php'
        end

        css('.source-code-container').each do |node|
          node.name = 'pre'
          node.inner_html = node.inner_html.gsub(br, "\n")
          node.content = node.content.strip
          node['data-language'] = 'php'
        end

        doc
      end
    end
  end
end