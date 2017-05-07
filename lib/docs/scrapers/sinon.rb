module Docs
  class Sinon < UrlScraper
    self.name = 'Sinon.JS'
    self.slug = 'sinon'
    self.type = 'sinon'
    self.links = {
      home: 'http://sinonjs.org/',
      code: 'https://github.com/sinonjs/sinon'
    }

    html_filters.push 'sinon/clean_html', 'sinon/entries'

    options[:title] = 'Sinon.JS'
    options[:container] = '.content .container'

    options[:attribution] = <<-HTML
      &copy; 2010&ndash;2017 Christian Johansen<br>
      Licensed under the BSD License.
    HTML

    version '2' do
      self.release = '2.2.0'
      self.base_url = "http://sinonjs.org/releases/v#{release}/"
    end

    version '1' do
      self.release = '1.17.7'
      self.base_url = "http://sinonjs.org/releases/v#{release}/"
    end
  end
end
