module Docs
  class Openjdk
    class CleanUrlsFilter < Filter
      def call
        # Interlink between versions
        css('a[href^="http://localhost/"]').each do |node|
          path = URI(node['href']).path[1..-1]

          # The following code ignores most options that InternalUrlsFilter accepts,
          # only the currently used options are considered here.
          self.class.parent.versions.each do |v|
            if v.options[:only_patterns].any? { |pattern| path.match? pattern } &&
               v.options[:skip_patterns].none? { |pattern| path.match? pattern }
              node['href'] = "/#{v.slug}/#{path}"
              break
            end
          end
        end

        doc
      end
    end
  end
end
