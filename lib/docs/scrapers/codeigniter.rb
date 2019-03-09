module Docs
  class Codeigniter < UrlScraper
    self.name = 'CodeIgniter'
    self.type = 'sphinx'
    self.base_url = 'https://www.codeigniter.com/user_guide/'
    self.root_path = 'index.html'
    self.links = {
      home: 'https://codeigniter.com/',
      code: 'https://github.com/bcit-ci/CodeIgniter'
    }

    html_filters.push 'codeigniter/entries', 'sphinx/clean_html'

    options[:container] = '.document'

    options[:skip] = %w(
      license.html
      changelog.html
      DCO.html
      general/welcome.html
      general/requirements.html
      general/credits.html
      libraries/index.html
      helpers/index.html
    )

    options[:skip_patterns] = [
      /\Acontributing/,
      /\Adocumentation/,
      /\Ainstallation\/upgrade/
    ]

    options[:attribution] = <<-HTML
      &copy; 2014&ndash;2018 British Columbia Institute of Technology<br>
      Licensed under the MIT License.
    HTML

    version '3' do
      self.release = '3.1.8'
    end

    def get_latest_version(options, &block)
      fetch_doc('https://codeigniter.com/user_guide/changelog.html', options) do |doc|
        header = doc.at_css('#change-log h2')
        block.call header.content.scan(/([0-9.]+)/)[0][0]
      end
    end
  end
end
