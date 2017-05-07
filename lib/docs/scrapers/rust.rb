module Docs
  class Rust < UrlScraper
    self.type = 'rust'
    self.release = '1.17.0'
    self.base_url = 'https://doc.rust-lang.org/'
    self.root_path = 'book/index.html'
    self.initial_paths = %w(
      reference/introduction.html
      collections/index.html
      std/index.html
      error-index.html)
    self.links = {
      home: 'https://www.rust-lang.org/',
      code: 'https://github.com/rust-lang/rust'
    }

    html_filters.push 'rust/entries', 'rust/clean_html'

    options[:only_patterns] = [
      /\Abook\//,
      /\Areference\//,
      /\Acollections\//,
      /\Astd\// ]

    options[:skip] = %w(book/README.html)
    options[:skip_patterns] = [/(?<!\.html)\z/]

    options[:fix_urls] = ->(url) do
      url.sub! %r{(#{Rust.base_url}.+/)\z}, '\1index.html'
      url.sub! '/unicode/u_str', '/unicode/str/'
      url
    end

    options[:attribution] = <<-HTML
      &copy; 2010 The Rust Project Developers<br>
      Licensed under the Apache License, Version 2.0 or the MIT license, at your option.
    HTML

    private

    REDIRECT_RGX = /http-equiv="refresh"/i
    NOT_FOUND_RGX = /<title>Not Found<\/title>/

    def process_response?(response)
      !(response.body =~ REDIRECT_RGX || response.body =~ NOT_FOUND_RGX || response.body.blank?)
    end
  end
end
