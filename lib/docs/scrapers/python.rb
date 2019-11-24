module Docs
  class Python < FileScraper
    self.type = 'python'
    self.root_path = 'library/index.html'
    self.links = {
      home: 'https://www.python.org/',
      code: 'https://github.com/python/cpython'
    }

    options[:only_patterns] = [/\Alibrary\//]

    options[:skip] = %w(
      library/2to3.html
      library/formatter.html
      library/index.html
      library/intro.html
      library/undoc.html
      library/unittest.mock-examples.html
      library/sunau.html)

    options[:attribution] = <<-HTML
      &copy; 2001&ndash;2019 Python Software Foundation<br>
      Licensed under the PSF License.
    HTML

    # In order to download the documentation, run:
    # $ mkdir -p docs/python~3.8 && \
    #   cd docs/python~3.8 && \
    #   curl -L https://docs.python.org/3.8/archives/python-3.8.0-docs-html.tar.bz2 | \
    #   tar xj --strip-components=1

    version '3.8' do # docs.python.org/3.8/download.html
      self.release = '3.8.0'
      self.base_url = 'https://docs.python.org/3.8/'

      html_filters.push 'python/entries_v3', 'sphinx/clean_html', 'python/clean_html'
    end

    version '3.7' do # docs.python.org/3.7/download.html
      self.release = '3.7.5'
      self.base_url = 'https://docs.python.org/3.7/'

      html_filters.push 'python/entries_v3', 'sphinx/clean_html', 'python/clean_html'
    end

    version '3.6' do # docs.python.org/3.6/download.html
      self.release = '3.6.9'
      self.base_url = 'https://docs.python.org/3.6/'

      html_filters.push 'python/entries_v3', 'sphinx/clean_html', 'python/clean_html'
    end

    version '3.5' do # docs.python.org/3.5/download.html
      self.release = '3.5.9'
      self.base_url = 'https://docs.python.org/3.5/'

      html_filters.push 'python/entries_v3', 'sphinx/clean_html', 'python/clean_html'
    end

    version '2.7' do # docs.python.org/2.7/download.html
      self.release = '2.7.16'
      self.base_url = 'https://docs.python.org/2.7/'

      html_filters.push 'python/entries_v2', 'sphinx/clean_html', 'python/clean_html'
    end

    def get_latest_version(opts)
      doc = fetch_doc('https://docs.python.org/', opts)
      doc.at_css('.version_switcher_placeholder').content
    end
  end
end
