class TinFormat
  Validation = Struct.new(:errors, :type)

  RULES = {
    'au' => {
      au_abn: [/^\d{11}$/, 11],
      au_acn: [/^\d{9}$/, 9],
    },
    'ca' =>{
      ca_gst: [/^\d{9}$/, 9]
    },
    'in' =>{
      in_gst: [/\d{2}[A-Z0-9]{10}\d[A-Z]\d/, 15]
    }
  }

  def self.validate(tin, iso)
    validation = Validation.new([],nil)

    RULES[iso.downcase].each do |rule|
      type, pattern, length = rule[0], rule[1][0], rule[1][1]

      if tin.match?(pattern)
        validation.type = type.to_s
        validation.errors = []
        return validation
      else
        validation.errors << "is too long" if tin.length > length
        validation.errors << "is too short" if tin.length < length
        validation.errors << "is invalid" if !tin.match?(pattern)
      end
    end
    validation
  end
end
