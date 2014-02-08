module Docs
  class Coffeescript
    class EntriesFilter < Docs::EntriesFilter
      ENTRIES = [
        ['coffee command',              'usage',                    'Miscellaneous'],
        ['Literate mode',               'literate',                 'Miscellaneous'],
        ['Functions',                   'literals',                 'Language'],
        ['->',                          'literals',                 'Statements'],
        ['Objects and arrays',          'objects_and_arrays',       'Language'],
        ['Lexical scoping',             'lexical-scope',            'Language'],
        ['if...then...else',            'conditionals',             'Statements'],
        ['unless',                      'conditionals',             'Statements'],
        ['... splats',                  'splats',                   'Language'],
        ['for...in',                    'loops',                    'Statements'],
        ['for...in...by',               'loops',                    'Statements'],
        ['for...in...when',             'loops',                    'Statements'],
        ['for...of',                    'loops',                    'Statements'],
        ['while',                       'loops',                    'Statements'],
        ['until',                       'loops',                    'Statements'],
        ['loop',                        'loops',                    'Statements'],
        ['do',                          'loops',                    'Statements'],
        ['Array slicing and splicing',  'slices',                   'Language'],
        ['Ranges',                      'slices',                   'Language'],
        ['Expressions',                 'expressions',              'Language'],
        ['?',                           'the-existential-operator', 'Operators'],
        ['?=',                          'the-existential-operator', 'Operators'],
        ['?.',                          'the-existential-operator', 'Operators'],
        ['class',                       'classes',                  'Statements'],
        ['extends',                     'classes',                  'Operators'],
        ['super',                       'classes',                  'Statements'],
        ['::',                          'classes',                  'Operators'],
        ['Destructuring assignment',    'destructuring',            'Language'],
        ['=>',                          'fat-arrow',                'Statements'],
        ['Embedded JavaScript',         'embedded',                 'Language'],
        ['switch...when...else',        'switch',                   'Statements'],
        ['try...catch...finally',       'try',                      'Statements'],
        ['Chained comparisons',         'comparisons',              'Language'],
        ['#{} interpolation',           'strings',                  'Language'],
        ['Block strings',               'strings',                  'Language'],
        ['"""',                         'strings',                  'Language'],
        ['Block comments',              'strings',                  'Language'],
        ['###',                         'strings',                  'Language'],
        ['Block regexes',               'regexes',                  'Language'],
        ['cake command',                'cake',                     'Miscellaneous'],
        ['Cakefile',                    'cake',                     'Miscellaneous'],
        ['Source maps',                 'source-maps',              'Miscellaneous']
      ]

      def additional_entries
        entries = ENTRIES.dup

        # Operators
        css('.definitions td:first-child > code').each do |node|
          node.content.split(', ').each do |name|
            next if %w(true false yes no on off this).include?(name)
            name.sub! %r{\Aa (.+) b\z}, '\1'
            id = name_to_id(name)
            node['id'] = id
            entries << [name, id, 'Operators']
          end
        end

        entries
      end

      def name_to_id(name)
        case name
          when '**' then 'pow'
          when '//' then 'floor'
          when '%%' then 'mod'
          else name.parameterize
        end
      end
    end
  end
end
