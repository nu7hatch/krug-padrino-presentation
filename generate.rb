#!/usr/bin/env ruby

require "rubygems"
require "liquid"
require "bluecloth"
require "albino"

class HighlightBlock < Liquid::Block
  include Liquid::StandardFilters
  SYNTAX = /(\w+)\s*?/
  
  def initialize(tag_name, markup, tokens)
    super
    if markup =~ SYNTAX
      @lang = $1
    else
      raise SyntaxError.new("Syntax Error in 'highlight' - Valid syntax: highlight <lang>")
    end
  end

  def render(context)
    render_pygments(context, super.to_s)
  end
  
  def render_pygments(context, code)
    return "\n" + Albino.new(code, @lang).to_s + "\n"
  end
end

Liquid::Template.register_tag('highlight', HighlightBlock)

ROOT     = File.dirname(__FILE__)
@@layout = File.open(File.join(ROOT, 'layout.html')).read
@@slides = []

Dir[File.join(ROOT, "slides/*.md")].sort.each_with_index do |fname, i|
  @@slides << "<hr id='slide-#{i}' />" unless i == 0
  @@slides << BlueCloth.new(Liquid::Template.parse(File.open(fname).read).render).to_html
end

puts @@layout.gsub("{{ content }}", @@slides.join)
