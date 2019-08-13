module Docs
  class Enzyme < UrlScraper
    self.type = 'simple'
    self.release = '3.10.0'
    self.base_url = 'https://airbnb.io/enzyme/'
    self.root_path = 'index.html'
    self.links = {
      code: 'https://github.com/airbnb/enzyme'
    }

    html_filters.push 'enzyme/entries', 'enzyme/clean_html'

    options[:skip] = %w(CHANGELOG.html docs/future.html CONTRIBUTING.html)

    options[:attribution] = <<-HTML
      &copy; 2015 Airbnb, Inc.<br>
      Licensed under the MIT License.
    HTML

    def get_latest_version(opts)
      get_npm_version('enzyme', opts)
    end
  end
end
