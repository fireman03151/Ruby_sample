module Docs
  class Lodash < UrlScraper
    self.name = 'lodash'
    self.slug = 'lodash'
    self.type = 'lodash'
    self.version = '3.8.0'
    self.base_url = 'https://lodash.com/docs'
    self.links = {
      home: 'https://lodash.com/',
      code: 'https://github.com/lodash/lodash/'
    }

    html_filters.push 'lodash/entries', 'lodash/clean_html', 'title'

    options[:title] = 'lodash'
    options[:skip_links] = true

    options[:attribution] = <<-HTML
      &copy; 2012&ndash;2015 The Dojo Foundation<br>
      Licensed under the MIT License.
    HTML
  end
end
