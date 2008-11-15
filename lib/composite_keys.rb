require 'cgi'

module ActiveScaffold
  module CompositeKeys
    def stringify_id(id)
      return nil if id.nil?

      if id.is_a?(Array)
        return nil unless id.detect { |item| !item.nil? }
        id.map { |item| item.to_s }.join(',')
      else
        id.to_s
      end
    end

    def escape_id(id)
      return nil if id.nil?
      return id if id.is_a?(Integer)

      if id.is_a?(Array)
        return nil unless id.detect { |item| !item.nil? }
        id.map { |item| CGI.escape(item.to_s) }.join(',')
      else
        CGI.escape(id.to_s)
      end
    end

    def unescape_id(id)
      return nil if id.nil?

      parts = id.split(',')
      if parts.length == 1
        return CGI.unescape(parts[0])
      else
        parts.map { |part| CGI.unescape(part) }
      end
    end
  end
end
