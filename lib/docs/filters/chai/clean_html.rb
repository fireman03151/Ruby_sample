module Docs
  class Chai
    class CleanHtmlFilter < Filter
      def call
        @doc = at_css('.documentation .rendered')

        if root_page?
          at_css('h1').content = 'Chai Assertion Library'
        end

        css('> article', '.header').each do |node|
          node.before(node.children).remove
        end

        # Remove code highlighting
        css('pre').each do |node|
          node.content = node.content
        end

        doc
      end
    end
  end
end
