puts "Enter your todo"
todo = gets
File.open("todo.txt", "a") {|f| f.write(todo)}
