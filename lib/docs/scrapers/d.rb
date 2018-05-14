module Docs
  class D < UrlScraper
    include MultipleBaseUrls

    self.release = '2.080.0'
    self.type = 'd'
    self.base_urls = ['https://dlang.org/phobos/', 'https://dlang.org/spec/']
    self.root_path = 'index.html'
    self.links = {
      home: 'https://dlang.org/',
      code: 'https://github.com/dlang/phobos'
    }

    html_filters.push 'd/entries', 'd/clean_html'

    options[:skip] = %w(spec.html)
    options[:container] = '.container'
    options[:root_title] = 'D Programming Language'
    options[:title] = false

    options[:attribution] = <<-HTML
      &copy; 1999&ndash;2018 The D Language Foundation<br>
      Licensed under the Boost License 1.0.
    HTML

    def initial_urls
      %w(https://dlang.org/phobos/index.html https://dlang.org/spec/intro.html)
    end
  end
end
