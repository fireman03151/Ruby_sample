module Docs
  class CleanTextFilter < Filter
    EMPTY_NODES_RGX = /<(?!td|th|iframe)(\w+)[^>]*>[[:space:]]*<\/\1>/

    def call
      html.strip!
      while html.remove!(EMPTY_NODES_RGX); end
      html
    end
  end
end
