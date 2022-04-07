vowel = ("a".."z").each.with_index(1).to_h.delete_if { |element| /[aeiouy]/ !~ element }
puts vowel
