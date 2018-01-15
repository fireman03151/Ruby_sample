module Docs
  class Mdn < UrlScraper
    self.abstract = true
    self.type = 'mdn'

    params[:raw] = 1
    params[:macros] = 1

    html_filters.push 'mdn/clean_html'
    text_filters.insert_before 'attribution', 'mdn/contribute_link'

    options[:rate_limit] = 400
    options[:trailing_slash] = false

    options[:skip_link] = ->(link) {
      link['title'].try(:include?, 'not yet been written'.freeze) && !link['href'].try(:include?, 'transform-function'.freeze)
    }

    options[:attribution] = <<-HTML
      &copy; 2005&ndash;2018 Mozilla Developer Network and individual contributors.<br>
      Licensed under the Creative Commons Attribution-ShareAlike License v2.5 or later.
    HTML

    private

    def process_response?(response)
      super && response.effective_url.query == 'raw=1&macros=1'
    end
  end
end
