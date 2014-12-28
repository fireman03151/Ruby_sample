module Docs
  class Rdoc < FileScraper
    self.abstract = true
    self.type = 'rdoc'
    self.root_path = 'table_of_contents.html'

    html_filters.replace 'container', 'rdoc/container'
    html_filters.push 'title', 'rdoc/entries', 'rdoc/clean_html'

    options[:title] = false
    options[:skip] = %w(index.html)
    options[:skip_patterns] = [
      /changelog/i,
      /readme/i,
      /news/i,
      /license/i]
  end
end
