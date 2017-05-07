module Docs
  class Typescript < UrlScraper
    self.name = 'TypeScript'
    self.type = 'typescript'
    self.release = '2.3.2'
    self.base_url = 'https://www.typescriptlang.org/docs/'
    self.root_path = 'tutorial.html'
    self.links = {
      home: 'https://www.typescriptlang.org',
      code: 'https://github.com/Microsoft/TypeScript'
    }

    html_filters.push 'typescript/entries', 'typescript/clean_html'

    options[:container] = '#content'
    options[:skip_link] = ->(node) { node.parent.parent['class'] == 'dropdown-menu' }
    options[:fix_urls] = ->(url) {
      url.sub!(/(\w+)\.md/) { "#{$1.downcase}.html" }
      url
    }

    options[:attribution] = <<-HTML
      &copy; Microsoft and other contributors<br>
      Licensed under the Apache License, Version 2.0.
    HTML
  end
end


