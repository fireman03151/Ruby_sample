module Docs
  class Node < UrlScraper
    self.name = 'Node.js'
    self.slug = 'node'
    self.type = 'node'
    self.links = {
      home: 'https://nodejs.org/',
      code: 'https://github.com/nodejs/node'
    }

    html_filters.push 'node/clean_html', 'node/entries', 'title'

    options[:title] = false
    options[:root_title] = 'Node.js'
    options[:container] = '#apicontent'
    options[:skip] = %w(index.html all.html documentation.html synopsis.html)

    options[:attribution] = <<-HTML
      &copy; Joyent, Inc. and other Node contributors<br>
      Licensed under the MIT License.<br>
      Node.js is a trademark of Joyent, Inc. and is used with its permission.<br>
      We are not endorsed by or affiliated with Joyent.
    HTML

    version do
      self.release = '7.10.0'
      self.base_url = 'https://nodejs.org/dist/latest-v7.x/docs/api/'
    end

    version '6 LTS' do
      self.release = '6.10.3'
      self.base_url = 'https://nodejs.org/dist/latest-v6.x/docs/api/'
    end

    version '4 LTS' do
      self.release = '4.8.3'
      self.base_url = 'https://nodejs.org/dist/latest-v4.x/docs/api/'
    end
  end
end
