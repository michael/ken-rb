module Ken
  class Collection < Array
    # def initialize(data = [])
    #   @data = data
    # end
    
    # def method_missing(name, *args, &blk)
    #   @data.send name, *args, &blk
    # end
    
    # add a linebreak after each entry
    def to_s
      self.inject("") { |m,i| "#{m}#{i.to_s}\n"}
    end
  end
end