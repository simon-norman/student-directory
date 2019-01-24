
require 'csv'

@students = [] # an empty array accessible to all methods

def interactive_menu
  loop do
    print_menu
    
    process(STDIN.gets.chomp)
  end
end

def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list"
    puts "4. Load the list"
    puts "9. Exit" # 9 because we'll be adding more items
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students(get_filename)
    when "4"
      load_students(get_filename)
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
        new_student[field] = get_input_student(field)
      end
        
      add_student(new_student)
      print_student_count
    end
  end
end

def get_input_student(field)
  print_input_request(field) 
      
  while true do
    input = STDIN.gets.chomp
    
    if input == ""
      puts "This is an invalid response, please try again."
    elsif input == "exit"
      throw :finish
    else
      return input
    end
  end
end

def print_input_request(field) 
  puts "Please enter the #{field} of the student"
  puts "To return to main menu, enter 'exit'"
end

def add_student(student)
  @students << student
end

def print_student_count
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

def get_filename
  puts "Please specify the filename"
  STDIN.gets.chomp
end

def save_students(filename)
  CSV.open(filename, "w") do |csv|
    csv = students_to(csv)
  end
end

def students_to(csv)
  @students.each do |student|
    csv << student.values
  end
  
  return csv
end

def load_students(filename = "students.csv")
  CSV.foreach(filename, "r") do |student|
    name, cohort = student[0], student[1]
    add_student({:name => name, :cohort => cohort})
  end
  
  puts "Loaded #{@students.count} from #{filename}"
end

def load_students_cmd_args
  filename = ARGV.first
  
  if filename.nil? 
    load_students
  else
    try_load_students(filename)
  end
end

def try_load_students(filename)
  if File.exists?(filename)
    load_students(filename)
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

load_students_cmd_args

interactive_menu