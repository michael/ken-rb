module Ken
  class Collection < Array
    # add a linebreak after each entry
    def to_s
      self.inject("") { |m,i| "#{m}#{i.to_s}\n"}
    end
  end
end