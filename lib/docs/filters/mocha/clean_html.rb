module Docs
  class Mocha
    class CleanHtmlFilter < Filter
      def call
        doc.child.remove until doc.child['id'] == 'installation'

        css('pre').each do |node|
          node.content = node.content
        end

        doc
      end
    end
  end
end
