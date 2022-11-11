# frozen_string_literal: true

class WidgetToDisable
  def initialize
    @liste = []
  end

  def append(widget_id)
    @liste.append(widget_id)
  end

  def call
    puts "WidgetToDisable #call"
    @liste.each do |widget_id|
      widget = Widget.find(widget_id)
      puts widget.inspect
      widget.disactivate
      puts Widget.find(widget_id).inspect
    end

    @liste.clear
  end
end
