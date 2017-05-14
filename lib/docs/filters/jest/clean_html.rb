module Docs
  class Jest
    class CleanHtmlFilter < Filter
      def call
        @doc = at_css('.mainContainer .post')

        at_css('h1').content = 'Jest' if root_page?

        css('.edit-page-link', '.hash-link', 'hr').remove

        css('.postHeader', 'article', 'div:not([class])').each do |node|
          node.before(node.children).remove
        end

        css('.anchor[name]').each do |node|
          node.parent['id'] = node['name']
          node.remove
        end

        css('pre').each do |node|
          node['data-language'] = node['class'][/language-(\w+)/, 1]
          node.content = node.content
        end

        doc
      end
    end
  end
end
