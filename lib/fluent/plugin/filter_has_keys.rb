# -*- coding: utf-8 -*-
module Fluent
  class HasKeysFilter < Filter
    Fluent::Plugin.register_filter('has_keys', self)

    config_param :keys, :string, :default => nil

    def configure(conf)
      super
      @essential_keys = @keys ? @keys.split(",").map(&:strip) : nil
    end

    def start
      super
    end

    def shutdown
      super
    end

    def filter_stream(tag, es)
      new_es = MultiEventStream.new
      es.each do |time, record|
        if @essential_keys.nil? or @essential_keys.all? {|k| record.has_key?(k) }
            new_es.add(time, record)
        end
      end
      return new_es
    end
  end if defined?(Filter)
end
