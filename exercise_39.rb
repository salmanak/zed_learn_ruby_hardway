#Create a mapping of state to abbreviation
states = {
  'Oregon' => 'OR',
  'Florida' => 'FL',
  'California' => 'CA',
  'New York' => 'NY',
  'Michigan' => 'MI'
}

cities = {
  'CA' => 'San Francisco',
  'MI' => 'Detroit',
  'FL' => 'Jacksonville'
}

#add more cities
cities['NY'] = 'New York'
cities['OR'] = 'Portland'

#now do both at the same time
states.each do |state, abbrev|
  city = cities[abbrev]
  puts "#{state} is abbreviated #{abbrev} and has city #{city}"
end

#Making your own Hash Module
def Dict.hash_keys(aDict, key)
  #Given a key, this will create a numer and then convert it to
  #an index for the aDict's buckets.
  return key.hash % aDict.length
  # key.hash returns a number, by getting the remainder of modulus
  # aDict.length, we ensure it fits into our buckets
end

def Dict.get_bucket(aDict, key)
  #Given a key, find the bucket where it would go
  bucket_id = Dict.hash_keys(aDict, key)
  #bucket_id is a number, indicating the bucket in aDict
  #return the bucket
  return aDict[bucket_id]
end

def Dict.get_slot(aDict, key, default=nil)
  #Returns the index, key, and value of a slot found in a bucket.

  #get the bucket (remember the bucket is an array of key-value pairs)
  bucket = Dict.get_bucket(aDict, key)

  #go through each key-value in the bucket
  bucket.each_with_index do |kv, i|
    k, v = kv
    # if the key in the key-value pair matches the argument key,
    # return the index, key, and value
    if key == k
      return i, k, v
    end
  end

  #if none of the keys in the bucket match,
  #return -1 for index, key, and nil for value
  return -1, key, default
end


#Create a dump function that is like list but which dumps the full contents of every bucket so you can debug it.
def Dict.dump(aDict)
  aDict.each do |bucket|
    puts bucket
  end
end
