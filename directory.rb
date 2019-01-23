
@students = [] # an empty array accessible to all methods

def interactive_menu
  loop do
    print_menu
    
    process(gets.chomp)
  end
end

def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list to students.csv"
    puts "4. Load the list from students.csv"
    puts "9. Exit" # 9 because we'll be adding more items
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def input_students
  catch :finish do
    loop do
    
      new_student = { :name => "", :cohort => "" }
      
      new_student.each do |field, value|
        new_student[field] = get_user_input(field)
      end
        
      @students << new_student
      print_count
    end
  end
end

def get_user_input(field)
  puts "Please enter the #{field} of the student"
  puts "To exit, enter 'exit'"
      
  while true do
    input = gets.sub("\n", "")
    
    if input == ""
      puts "This is an invalid response, please try again."
    elsif input == "exit"
      throw :finish
    else
      return input
    end
  end
end

def print_count
  if @students.count == 1
    puts "Now we have #{@students.count} student"
  else
    puts "Now we have #{@students.count} students"
  end
end

def show_students
  print_header
  print_students
  print_footer
end

def print_header
  print_aligned("The students of Villains Academy")
  print_aligned("-------------")
end

def print_aligned(text)
  puts text.center(100)
end

def print_students
  students_by_cohort = group_students_by_cohort
    
  students_by_cohort.each do |cohort, student_names|
    names_as_string = student_names.join(", ")
    print_aligned("#{cohort}: #{names_as_string}")
  end
end

def group_students_by_cohort
  students_by_cohort = Hash.new { |hash, key| hash[key] = [] }
    
  @students.map { |student| 
    students_by_cohort[student[:cohort].to_sym].push(student[:name])
  }
  
  return students_by_cohort
end

def print_footer
   print_aligned("Overall, we have #{@students.count} great students")
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  
  file.close
end

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort}
  end
  file.close
end
	

interactive_menu