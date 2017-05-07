module Docs
  class Yarn < UrlScraper
    self.type = 'yarn'
    self.release = '0.23.4'
    self.base_url = 'https://yarnpkg.com/en/docs/'
    self.links = {
      home: 'https://yarnpkg.com/',
      code: 'https://github.com/yarnpkg/yarn'
    }

    html_filters.push 'yarn/entries', 'yarn/clean_html', 'title'

    options[:root_title] = 'Yarn'
    options[:trailing_slash] = false

    options[:skip] = %w(nightly)
    options[:skip_patterns] = [/\Aorg\//]

    options[:attribution] = <<-HTML
      &copy; 2016&ndash;2017 Yarn Contributors<br>
      Licensed under the BSD License.
    HTML
  end
end
