module Docs
  class Codeceptjs < UrlScraper
    self.name = 'CodeceptJS'
    self.type = 'codeceptjs'
    self.root_path = 'index.html'
    self.release = '1.1.1'
    self.base_url = 'http://codecept.io/'
    self.links = {
      home: 'http://codecept.io/',
      code: 'https://github.com/codeception/codeceptjs'
    }

    html_filters.push 'codeceptjs/clean_html', 'codeceptjs/entries', 'title'

    options[:root_title] = 'CodeceptJS'
    options[:title] = false
    options[:skip_links] = ->(filter) { !filter.root_page? }
    options[:skip_patterns] = [/changelog/, /quickstart\z/]

    options[:attribution] = <<-HTML
      &copy; 2015 DavertMik &lt;davert@codegyre.com&gt; (http://codegyre.com)<br>
      Licensed under the MIT License.
    HTML
  end
end
