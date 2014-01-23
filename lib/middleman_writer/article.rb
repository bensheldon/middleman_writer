require 'yaml'
require 'pathname'

module MiddlemanWriter
  class Article
    attr_accessor :content, :frontmatter

    YAML_ERRORS = [ StandardError ]

    def initialize(content="", frontmatter={})
      @content = content
      @frontmatter = frontmatter
    end

    def deserialize(string)
      yaml_regex = /\A(---\s*\n.*?\n?)^(---\s*$\n?)/m
      if string =~ yaml_regex
        self.content = string.sub(yaml_regex, '')

        begin
          self.frontmatter = (YAML.load($1) || {})
        rescue *YAML_ERRORS => e
          raise "YAML Exception parsing #{$1}: #{e.message}"
        end
      else
        self.content = string
      end

      self
    end

    def serialize
      <<-EOS.gsub(/^ {8}/, '').gsub(/\n\z/, '')
        #{frontmatter.to_yaml.strip}
        ---

        #{content}
      EOS
    end

    def self.from_string(string)
      new.deserialize(string)
    end

  end
end
