module Docs
  class Git < UrlScraper
    self.type = 'git'
    self.release = '2.15.1'
    self.base_url = 'https://git-scm.com/docs'
    self.initial_paths = %w(/git.html)
    self.links = {
      home: 'https://git-scm.com/',
      code: 'https://github.com/git/git'
    }

    html_filters.push 'git/entries', 'git/clean_html'

    options[:container] = '#content'
    options[:only_patterns] = [/\A\/[^\/]+\z/]
    options[:skip] = %w(/howto-index.html)

    options[:attribution] = <<-HTML
      &copy; 2005&ndash;2017 Linus Torvalds and others<br>
      Licensed under the GNU General Public License version 2.
    HTML
  end
end
