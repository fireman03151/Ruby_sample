require 'yajl/json_gem'

module Docs
  class Manifest
    FILENAME = 'docs.json'

    def initialize(store, docs)
      @store = store
      @docs = docs
    end

    def store
      @store.write FILENAME, to_json
    end

    def as_json
      @docs.each_with_object [] do |doc, result|
        next unless @store.exist?(doc.meta_path)
        result << JSON.parse(@store.read(doc.meta_path))
      end
    end

    def to_json
      JSON.generate(as_json)
    end
  end
end
