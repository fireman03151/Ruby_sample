module Docs
  class Mdn < UrlScraper
    self.abstract = true
    self.type = 'mdn'

    params[:raw] = 1
    params[:macros] = 1

    html_filters.push 'mdn/clean_html'
    text_filters.insert_before 'attribution', 'mdn/contribute_link'

    options[:rate_limit] = 200
    options[:trailing_slash] = false

    options[:skip_link] = ->(link) {
      link['title'].try(:include?, 'not yet been written'.freeze) && !link['href'].try(:include?, 'transform-function'.freeze)
    }

    options[:attribution] = <<-HTML
      &copy; 2005&ndash;2021 MDN contributors.<br>
      Licensed under the Creative Commons Attribution-ShareAlike License v2.5 or later.
    HTML

    def get_latest_version(opts)
      get_latest_github_commit_date('mdn', 'content', opts)
    end

    private

    def process_response?(response)
      response.effective_url.host = 'developer.mozilla.org' if response.effective_url.host == 'wiki.developer.mozilla.org'
      super && response.effective_url.query == 'raw=1&macros=1'
    end
  end
end
