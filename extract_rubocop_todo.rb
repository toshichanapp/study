require 'yaml'

def load_file
  yaml_file = File.read(".rubocop_todo.yml")
  YAML.load(yaml_file)
end

def best_n_cop(n = 100)
  load_file.to_h do |key, value|
    [ key, value["Exclude"]&.count.to_i ]
  end.select do |_, v|
    v >= n
  end.sort_by do |_, v|
    -v
  end.to_h
end

def appearances_files_n_times(n = 15)
  load_file.values.map do |hash|
    hash["Exclude"]
  end.flatten.group_by(&:itself).map do |k, v|
    [k, v.size]
  end.select do |_, v|
    v >= n
  end.sort_by do |_, v|
    -v
  end.to_h
end

p appearances_files_n_times
