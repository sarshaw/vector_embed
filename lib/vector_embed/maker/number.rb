require 'vector_embed/maker'

class VectorEmbed
  class Maker
    class Number < Maker
      class << self
        def want?(v, parent)
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
          if num.nonzero?
            '%.16g' % num
          end
        end
      end

      def value(v)
        case v
        when Numeric, JUST_A_NUMBER
          Number.numify v
        when NilClass, NULL, SLASH_N
          nil
        else
          raise ArgumentError, "Can't embed #{v.inspect} in number feature #{k.inspect}"
        end
      end
    end
  end
end
