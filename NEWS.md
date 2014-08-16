## HEAD

* Pass around aliases as an array instead of a comma-delimited string.

## 0.0.1

Extract Pidgin2Adium, commit hash 96c443fd244b3d2d57564bf17c68d3ec1bcb48ff, into
this library, Pipio. There are also other commits in this release that are not in
Pidgin2Adium as of that commit:

* Expose `Chat#my_screen_name`
* Rename `Chat#lines` to `Chat#messages`
* Expose `Chat#service`
* Join the lines of `Chat#to_s` with "\n" instead of nothing
