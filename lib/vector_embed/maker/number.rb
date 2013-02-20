require 'vector_embed/maker'

class VectorEmbed
  class Maker
    class Number < Maker
      class << self
        def want?(k, v, parent)
          v.is_a?(::Numeric) or v =~ JUST_A_NUMBER
        end

        def numify(v)
          num = if v.is_a?(String)
            if v.include?('.') or v.include?('e')
              v.to_f
            else
              v.to_i
            end
          else
            v
          end
          num > 1e10 ? ('%.10e' % num) : num
        end
      end

      def value(v)
        case v
        when Numeric, JUST_A_NUMBER
          Number.numify v
        when NilClass
          0
        else
          raise ArgumentError, "Can't embed #{v.inspect} in number mode."
        end
      end
    end
  end
end
