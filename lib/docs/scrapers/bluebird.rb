module Docs
  class Bluebird < UrlScraper
    self.type = 'simple'
    self.release = '3.5.1'
    self.base_url = 'http://bluebirdjs.com/docs/'
    self.root_path = 'api-reference.html'
    self.force_gzip = true
    self.links = {
      home: 'http://bluebirdjs.com/',
      code: 'https://github.com/petkaantonov/bluebird/'
    }

    html_filters.push 'bluebird/clean_html', 'bluebird/entries'

    options[:skip] = %w(support.html download-api-reference.html contribute.html)

    options[:attribution] = <<-HTML
      &copy; 2013&ndash;2017 Petka Antonov<br>
      Licensed under the MIT License.
    HTML
  end
end
