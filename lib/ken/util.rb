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

