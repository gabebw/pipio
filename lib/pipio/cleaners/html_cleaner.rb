module Pipio
  module Cleaners
    class HtmlCleaner
      # Returns a cleaned string.
      # Removes the following tags from _text_:
      # * html
      # * body
      # * font
      # * a with no innertext, e.g. <a href="blah"></a>
      # And removes the following style declarations:
      # * color: #000000 (just turns text black)
      # * font-family
      # * font-size
      # * background
      # * em (really it's changed to <span style="font-style: italic;">)
      # Since each <span> has only one style declaration, spans with these
      # declarations are removed (but the text inside them is preserved).
      def self.clean(text)
        # Sometimes this is in there. I don't know why.
        text.gsub!(%r{&lt;/FONT HSPACE='\d'>}, '')
        # We can remove <font> safely since Pidgin and Adium both show bold
        # using <span style="font-weight: bold;"> except Pidgin uses single
        # quotes while Adium uses double quotes.
        text.gsub!(/<\/?(?:html|body|font)(?: .+?)?>/, '') # very important!

        text.tr!("\r", '')
        # Remove empty lines
        text.gsub!("\n\n", "\n")

        # Remove newlines that end the file, since they screw up the
        # newline -> <br/> conversion
        text.gsub!(/\n\Z/, '')

        # Replace newlines with "<br/>" unless they end a chat line.
        # This must go after we remove <font> tags.
        text.gsub!(/\n(?!#{HtmlLogParser::TIMESTAMP_REGEX})/, '<br/>')

        # These empty links are sometimes appended to every line in a chat,
        # for some weird reason. Remove them.
        text.gsub!(%r{<a href=['"].+?['"]>\s*?</a>}, '')

        # Replace single quotes inside tags with double quotes so we can
        # easily change single quotes to entities.
        # For spans, removes a space after the final declaration if it exists.
        text.gsub!(/<span style='([^']+?;) ?'>/, '<span style="\1">')
        text.gsub!(/([a-z]+=)'(.+?)'/, '\1"\2"')
        text.gsub!("'", '&apos;')

        # This actually does match stuff, but doesn't group it correctly. :(
        # text.gsub!(%r{<span style="((?:.+?;)+)">(.*?)</span>}) do |s|
        text.gsub!(%r{<span style="(.+?)">(.*?)</span>}) do |s|
          # Remove empty spans.
          next if $2 == ''

          # style = style declaration
          # innertext = text inside <span>
          style, innertext = $1, $2

          styleparts = style.split(/; ?/)
          styleparts.map! do |p|
            if p[0,5] == 'color'
              if p.include?('color: #000000')
                next
              elsif p =~ /(color: #[0-9a-fA-F]{6})(>.*)?/
                # Regarding the bit with the ">", sometimes this happens:
                # <span style="color: #000000>today;">today was busy</span>
                # Then p = "color: #000000>today"
                # Or it can end in ">;", with no text before the semicolon.
                # So keep the color but remove the ">" and anything following it.
                next($1)
              end
            else
              # don't remove font-weight
              case p
              when /^font-family/ then next
              when /^font-size/ then next
              when /^background/ then next
              end
            end
          end.compact!
          unless styleparts.empty?
            style = styleparts.join('; ')
            innertext = "<span style=\"#{style};\">#{innertext}</span>"
          end
          innertext
        end
        # Pidgin uses <em>, Adium uses <span>
        if text.gsub!('<em>', '<span style="font-style: italic;">')
          text.gsub!('</em>', '</span>')
        end
        text
      end
    end
  end
end
