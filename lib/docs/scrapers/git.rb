module Docs
  class Git < UrlScraper
    self.type = 'git'
    self.version = '1.9.0'
    self.base_url = 'http://git-scm.com/docs'
    self.initial_paths = %w(/git.html)

    html_filters.push 'git/clean_html', 'git/entries'

    options[:container] = ->(filter) { filter.root_page? ? '#main' : '.man-page' }
    options[:follow_links] = ->(filter) { filter.root_page? }
    options[:only_patterns] = [/\A\/git\-/]

    options[:attribution] = <<-HTML
      &copy; 2005&ndash;2014 Linus Torvalds and others<br>
      Licensed under the GNU General Public License version 2.
    HTML
  end
end
