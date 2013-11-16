module Docs
  class Rdoc < FileScraper
    self.abstract = true
    self.type = 'rdoc'
    self.root_path = 'index.html'

    html_filters.replace 'container', 'rdoc/container'
    html_filters.push 'rdoc/entries', 'rdoc/clean_html', 'title'

    options[:title] = false
    options[:skip] = %w(table_of_contents.html)
  end
end
