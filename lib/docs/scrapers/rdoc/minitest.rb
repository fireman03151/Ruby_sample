module Docs
  class Minitest < Rdoc
    self.name = 'Ruby / Minitest'
    self.slug = 'minitest'
    self.version = '5.6.0'
    self.dir = '/Users/Thibaut/DevDocs/Docs/RDoc/Minitest' # rake docs

    html_filters.replace 'rdoc/entries', 'minitest/entries'

    options[:root_title] = 'Minitest'
    options[:only_patterns] = [/\AMinitest/]

    options[:attribution] = <<-HTML
      &copy; Ryan Davis, seattle.rb<br>
      Licensed under the MIT License.
    HTML
  end
end
