module Docs
  class Yii
    class CleanHtmlFilter < Filter
      def call

        #remove irrelevant content
        css('div').each do |node| 
          if node['class'] == "layout-main-header"
            node.remove
          elsif node['class'] == "layout-main-submenu"
            node.remove
          elsif node['class'] == "layout-main-shortcuts"
            node.remove
          elsif node['class'] == "layout-main-footer"
            node.remove
          elsif node['class'] == "grid_3 alpha"
            node.remove
          elsif node['class'] == "comments"
            node.remove
          elsif node['class'] == "api-suggest clearfix"
            node.remove
          elsif node['id'] == "comments"
            node.remove
          elsif node['id'] == "nav"
            node.remove
          else
            end
          end

        # Put code blocks in <pre> tags
        css('.code').each do |node|
          node.name = 'pre'
        end

        #remove Hide inherited methods / properties and show links
        css('a').each do |node|
          if node['class'] == 'toggle'
            node.remove
          elsif node['class'] == 'show'
            node.remove
          end
        end

        doc
      end
    end
  end
end