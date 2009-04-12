module Ken
  module Util
    # magic hash conversion
    def convert_hash(source)
      source.inject({}) do |result, item|
        if result[item["link"]]
          result[item["link"]] << { "id" => item["id"], "name" => item["name"], "value" => item["value"] }
        else
          result[item["link"]] = []
          result[item["link"]] << { "id" => item["id"], "name" => item["name"], "value" => item["value"] }
        end
        result
      end
    end
    module_function :convert_hash
  end
end

class Object
  # nice for debugging
  # usage: print_call_stack(:method_name, 2, 10)
  def print_call_stack(from = 2, to = nil, html = false)
    (from..(to ? to : caller.length)).each do |idx| 
      p "[#{idx}]: #{caller[idx]}#{html ? '<br />' : ''}"
    end
  end
end