module Source
  class AdapterBase

    def convert(items, conversions)
      items.map do |item|
        conversions.reduce({}) do |memo, c|
          value = item[c[:selector]] || c[:default]
          if c[:transform]
            value = c[:transform].call value
          end
          memo[c[:property]] = value
          memo
        end
      end
    end

  end
end
