require 'vector_embed/maker/phrase'
require 'vector_embed/maker/ngram'
require 'vector_embed/maker/number'
require 'vector_embed/maker/boolean'

class VectorEmbed
  class Maker
    class << self
      def pick(choices, k, first_v, parent)
        if klass = choices.detect { |klass| klass.want?(first_v, parent) }
          parent.logger.debug { "Interpreting #{k.inspect} as #{klass.name.split('::').last} given first value #{first_v.inspect}" }
          klass.new k, parent
        else
          raise "Can't use #{first_v.class} for #{k.inspect} given #{first_v.inspect} and choices #{choices.inspect}"
        end
      end
    end

    attr_reader :parent
    attr_reader :k

    def initialize(k, parent)
      @k = k
      @parent = parent
    end

    def pairs(v)
      case v
      when Array
        memo = []
        v.each_with_index do |vv, i|
          memo << [ parent.index([k, i]), value(vv) ]
        end
        memo
      else
        [ [ parent.index([k]), value(v) ] ]
      end
    end
  end
end
