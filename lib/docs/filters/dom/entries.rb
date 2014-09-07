module Docs
  class Dom
    class EntriesFilter < Docs::EntriesFilter
      TYPE_BY_SPEC = {
        'Battery Status'      => 'Battery Status',
        'Canvas '             => 'Canvas',
        'CSS Object Model'    => 'CSS',
        'Device Orientation'  => 'Device Orientation',
        'Encoding'            => 'Encoding',
        'File API'            => 'File',
        'Geolocation'         => 'Geolocation',
        'Media Capture'       => 'Media',
        'Media Source'        => 'Media',
        'MediaStream'         => 'MediaRecorder',
        'Navigation Timing'   => 'Navigation Timing',
        'Network Information' => 'Network Information',
        'Web Audio'           => 'Web Audio',
        'Web Workers'         => 'Web Workers',
        'WebRTC'              => 'WebRTC' }

      TYPE_BY_NAME_STARTS_WITH = {
        'Audio'               => 'Audio',
        'Canvas'              => 'Canvas',
        'ChildNode'           => 'Node',
        'Console'             => 'Console',
        'CSS'                 => 'CSS',
        'document'            => 'Document',
        'DocumentFragment'    => 'DocumentFragment',
        'DOM'                 => 'DOM',
        'element'             => 'Element',
        'event'               => 'Event',
        'Event'               => 'Event',
        'File'                => 'File',
        'GlobalEventHandlers' => 'GlobalEventHandlers',
        'history'             => 'History',
        'IDB'                 => 'IndexedDB',
        'IndexedDB'           => 'IndexedDB',
        'Location'            => 'Location',
        'navigator'           => 'Navigator',
        'Node'                => 'Node',
        'Notification'        => 'Notification',
        'ParentNode'          => 'Node',
        'Range'               => 'Range',
        'RTC'                 => 'WebRTC',
        'Selection'           => 'Selection',
        'StyleSheet'          => 'CSS',
        'SVG'                 => 'SVG',
        'Touch'               => 'Touch',
        'TreeWalker'          => 'TreeWalker',
        'Uint'                => 'Typed Arrays',
        'URL'                 => 'URL',
        'window'              => 'window',
        'XMLHttpRequest'      => 'XMLHTTPRequest' }

      TYPE_BY_NAME_INCLUDES = {
        'WebGL'  => 'Canvas',
        'Worker' => 'Web Workers' }

      TYPE_BY_NAME_MATCHES = {
        /HTML\w*Element/ => 'Elements' }

      TYPE_BY_HAS_LINK_TO = {
        'DeviceOrientation specification' => 'Device Orientation',
        'File System API'                 => 'File',
        'Typed Array'                     => 'Typed Arrays',
        'WebSocket'                       => 'Web Sockets',
        'Web Audio API'                   => 'Web Audio',
        'XMLHTTPRequest'                  => 'XMLHTTPRequest' }

      def get_name
        name = super
        name.sub! 'Input.', 'HTMLInputElement.'
        name.sub! 'window.navigator', 'navigator'
        # Comment.Comment => Comment.constructor
        name.sub! %r{\A(\w+)\.\1\z}, '\1.constructor' unless name == 'window.window'
        name
      end

      def get_type
        TYPE_BY_NAME_STARTS_WITH.each_pair do |key, value|
          return value if name.start_with?(key)
        end

        TYPE_BY_NAME_INCLUDES.each_pair do |key, value|
          return value if name.include?(key)
        end

        TYPE_BY_NAME_MATCHES.each_pair do |key, value|
          return value if name =~ key
        end

        if spec = css('.standard-table').last
          spec = spec.content
          TYPE_BY_SPEC.each_pair do |key, value|
            return value if spec.include?(key)
          end
        end

        links_text = css('a').map(&:content).join
        TYPE_BY_HAS_LINK_TO.each_pair do |key, value|
          return value if links_text.include?(key)
        end

        if name.include? 'Event'
          'Events'
        else
          'Miscellaneous'
        end
      end

      def include_default_entry?
        (node = doc.at_css '.overheadIndicator').nil? ||
        type == 'Console' ||
        (node.content.exclude?('not on a standards track') && node.content.exclude?('removed from the Web'))
      end
    end
  end
end
