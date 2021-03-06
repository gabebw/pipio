# pipio [![Build Status][travis-image]][travis-link] [![Code Climate][cc-image]][cc-link]

[travis-image]: https://travis-ci.org/gabebw/pipio.svg?branch=master
[travis-link]: https://travis-ci.org/gabebw/pipio
[cc-image]: https://codeclimate.com/github/gabebw/pipio.svg
[cc-link]: https://codeclimate.com/github/gabebw/pipio

Pipio parses [Pidgin](http://pidgin.im/) (formerly gaim) logs. It can output
them in Adium format by calling `to_s` on a `Pipio::Chat` object or any of the
message objects in `Pipio::Chat#messages`.

## For the impatient

To deal with meta-information about the chat itself:

    path_to_chat_log = File.expand_path('~/path/to/chat_log.html') # or .txt
    chat = Pipio.parse(path_to_chat_log, ["Gabe B-W", "Gabe", "Other Alias"])
    if chat
      puts "Screen name of the person you chatted with: #{chat.their_screen_name}"
      puts "Chat contents, in adium format:"
      puts chat.to_s
    else
      puts "Oh no! Could not parse! Please open an issue."
      puts path_to_chat_log
      exit 1
    end

Or, to deal with individual messages in a chat:

    chat = Pipio.parse("/path/to/log/file.html", ["gabe", "gbw", "gabeb-w"])
    chat.each do |message|
      puts "Screen name of person who sent this message: #{message.sender_screen_name}"
      puts "Alias of person who sent this message: #{message.sender_alias}"
      puts "Time message was sent: #{message.time}"

      if message.respond_to?(:body)
        puts "Message body: #{message.body}"
        if message.respond_to?(:event)
          puts "Event type: #{message.event_type}"
        end
      elsif message.respond_to?(:status)
        puts "Status: #{message.status}"
      end

      puts "Message in Adium format: #{message}"
    end

## The fine print

This library needs access to aliases to work correctly, which may require a bit
of explanation. Adium and Pidgin allow you to set aliases for buddies as well as
for yourself, so that you show up in chats as (for example) `Me` instead of as
`best_screen_name_ever_018845`.

However, Pidgin then uses aliases in the log file instead of the actual screen
name, which complicates things. To parse properly, this gem needs to know which
aliases belong to you so it can map them to the correct screen name. If it
encounters an alias that you did not list,  it assumes that it belongs to the
person to whom you are chatting. Note that aliases are lower-cased and space is
removed, so providing `Gabe B-W, GBW` is the same as providing `gabeb-w,gbw`.

You do not need to provide your screenname in the alias list.

## INSTALL

    gem install pipio

## Testing

To get a coverage report, run `rake` with the `COVERAGE` environment variable
set:

    COVERAGE=1 rake

## THANKS

With thanks to Li Ma, whose [blog post](http://li-ma.blogspot.com/2008/10/pidgin-log-file-to-adium-log-converter.html)
helped tremendously.

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2009-2014 Gabe Berke-Williams. See LICENSE for details.
