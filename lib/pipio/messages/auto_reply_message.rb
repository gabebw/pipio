module Pipio
  class AutoReplyMessage < XMLMessage
    def to_s
      %(<message sender="#{sender_screen_name}" time="#{adium_formatted_time}" auto="true" alias="#{@sender_alias}">#{@styled_body}</message>)
    end
  end
end
