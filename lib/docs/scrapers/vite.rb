module Docs
  class Vite < UrlScraper
    self.name = 'Vite'
    self.slug = 'vite'
    self.type = 'simple'
    self.links = {
      home: 'https://vitejs.dev/',
      code: 'https://github.com/vitejs/vite'
    }

    options[:container] = 'main'
    options[:root_title] = 'Vite'

    options[:attribution] = <<-HTML
      &copy; 2019–present, Yuxi (Evan) You and Vite contributors<br>
      Licensed under the MIT License.
    HTML

    self.release = '2.7.5'
    self.base_url = 'https://vitejs.dev/'
    self.initial_paths = %w(guide/)
    html_filters.push 'vue/entries_v3', 'vue/clean_html'

    def get_latest_version(opts)
      get_npm_version('vite', opts)
    end
  end
end
