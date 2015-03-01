module Docs
  class Marionette < UrlScraper
    self.name = 'Marionette.js'
    self.slug = 'marionette'
    self.type = 'marionette'
    self.version = '2.4.1'
    self.base_url = "http://marionettejs.com/docs/v#{version}/"
    self.root_path = 'index'

    html_filters.push 'marionette/clean_html', 'marionette/entries'

    options[:container] = '.docs__content'

    options[:attribution] = <<-HTML
      &copy; 2015 Muted Solutions, LLC<br>
      Licensed under the MIT License.
    HTML
  end
end
