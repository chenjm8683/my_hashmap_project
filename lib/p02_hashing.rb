class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_num_str = ""
    self.to_s.each_char do |ch|
      hash_num_str += ch.ord.to_s
    end
    hash_num_str.to_i * hash_num_str.length
  end
end

class String
  def hash
    # split chars in the array and store them in an arr
    string_arr = self.split("")
    # using the hash from array and multiply by a string-obj identifier hash
    string_arr.hash * self.length
  end
end

class Hash
  def hash
    # convert to sorted array of arrays that contain key and value pairs
    hash_arr = []
    self.keys.sort.each do |key|
      hash_arr << [key, self[key]]
    end
    # using the hash from array and multiply by a hash-obj identifier hash
    hash_arr.hash * "hash".ord
  end
end
