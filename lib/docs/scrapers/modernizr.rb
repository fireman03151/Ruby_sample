module Docs
  class Modernizr < UrlScraper
    self.name = 'Modernizr'
    self.type = 'modernizr'
    self.release = '3.3.1'
    self.base_url = 'https://modernizr.com/docs/'

    html_filters.push 'modernizr/entries', 'modernizr/clean_html', 'title'

    options[:title] = 'Modernizr'
    options[:container] = '#main'
    options[:skip_links] = true

    options[:attribution] = <<-HTML
      &copy; 2009&ndash;2016 The Modernizr team<br>
      Licensed under the MIT License.
    HTML
  end
end
