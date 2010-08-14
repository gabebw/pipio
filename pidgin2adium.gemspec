# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{pidgin2adium}
  s.version = "3.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gabe Berke-Williams"]
  s.date = %q{2010-08-13}
  s.default_executable = %q{pidgin2adium}
  s.description = %q{Pidgin2Adium is a fast, easy way to convert Pidgin (formerly gaim) logs to the Adium format.}
  s.email = %q{gbw@brandeis.edu}
  s.executables = ["pidgin2adium"]
  s.extensions = ["ext/balance_tags_c/extconf.rb"]
  s.extra_rdoc_files = [
    "ChangeLog",
     "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".autotest",
     ".gitignore",
     ".rspec",
     "ChangeLog",
     "Gemfile",
     "LICENSE",
     "Manifest.txt",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/pidgin2adium",
     "config/website.yml",
     "ext/balance_tags_c/balance_tags_c.c",
     "ext/balance_tags_c/extconf.rb",
     "lib/pidgin2adium.rb",
     "lib/pidgin2adium/log_converter.rb",
     "lib/pidgin2adium/log_file.rb",
     "lib/pidgin2adium/log_parser.rb",
     "lib/pidgin2adium/message.rb",
     "lib/pidgin2adium/messages/all.rb",
     "lib/pidgin2adium/messages/auto_reply_message.rb",
     "lib/pidgin2adium/messages/event.rb",
     "lib/pidgin2adium/messages/message.rb",
     "lib/pidgin2adium/messages/status_message.rb",
     "lib/pidgin2adium/messages/xml_message.rb",
     "lib/pidgin2adium/parsers/all.rb",
     "lib/pidgin2adium/parsers/basic_parser.rb",
     "lib/pidgin2adium/parsers/html_log_parser.rb",
     "lib/pidgin2adium/parsers/text_log_parser.rb",
     "pidgin2adium.gemspec",
     "spec/balance_tags_c_extn_spec.rb",
     "spec/basic_parser_spec.rb",
     "spec/html_log_parser_spec.rb",
     "spec/log_converter_spec.rb",
     "spec/log_file_spec.rb",
     "spec/logfiles/2006-12-21.223606.txt",
     "spec/logfiles/2008-01-15.071445-0500PST.htm",
     "spec/logfiles/2008-01-15.071445-0500PST.html",
     "spec/pidgin2adium_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "spec/test-output/README.md",
     "spec/test-output/html_log_output.xml",
     "spec/test-output/text_log_output.xml",
     "spec/text_log_parser_spec.rb",
     "tasks/extconf.rake",
     "tasks/extconf/balance_tags_c.rake"
  ]
  s.homepage = %q{http://github.com/gabebw/pidgin2adium}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Pidgin2Adium is a fast, easy way to convert Pidgin (formerly gaim) logs to the Adium format}
  s.test_files = [
    "spec/balance_tags_c_extn_spec.rb",
     "spec/basic_parser_spec.rb",
     "spec/html_log_parser_spec.rb",
     "spec/log_converter_spec.rb",
     "spec/log_file_spec.rb",
     "spec/pidgin2adium_spec.rb",
     "spec/spec_helper.rb",
     "spec/text_log_parser_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, [">= 0.9.26"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
    else
      s.add_dependency(%q<bundler>, [">= 0.9.26"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
    end
  else
    s.add_dependency(%q<bundler>, [">= 0.9.26"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
  end
end

