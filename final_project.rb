#Money Tracker

#for a new person to be created
class User
  attr_accessor :name, :amount
  #user can set a name and the amount of money he/she has
  def initialize(name, amount)
    @name = name
    @amount = amount
  end

  #calculates the amount of money after processing the account- interacts with the object from Account class
  def current_amount(money)
    @amount - money.sum_of_usage + money.sum_of_earning
  end
end

#for a new account to be created
class Account
#stores the amount of money the user spend and earn with name and value
  def initialize
    @spent = {}
    @earned = {}
  end

  def spend(money)
    money.each do |thing, amount|
    #key_value pair are created within @spent hash
      @spent[thing] = amount
    end
    self
  end

  def earn(money)
    #key_value pair are created within @earned hash
    money.each do |thing, amount|
      @earned[thing] = amount
    end
    self
  end

  #makes an array of all the values in the @earned hash 
  def sum_of_earning
    @earned.values.collect do |num_str| 
      num_str.to_i
    #calculates the sum of all the values
    end.inject(0){|num, another_num| num + another_num }
  end

  def sum_of_usage
    @spent.values.collect do |num_str| 
      num_str.to_i
    end.inject(0){|num, another_num| num + another_num }
  end
end

### TEST
# x = 100
# xiu  = User.new("Xiu", x)
# personal = Account.new
# personal.spend("ice cream" => "5")
# personal.earn("gift_card" => "10").earn("work" => "10")
# puts "You started #{x} in your account. 
# After checking your account, you have #{xiu.current_amount(personal)}"

# puts "______"
# business = Account.new
# business.spend("papers" => "5").spend("food" => "5")
# business.earn("job" => "20")
# puts "You started #{x} in your account. 
# After checking your account, you have #{xiu.current_amount(business)}"
# puts "Money spent: #{business.instance_variable_get(:@spent)}"
# puts "Money earned: #{business.instance_variable_get(:@earned)}"

# y = 200
# puts "______"
# ben  = User.new("Ben", y)
# personal = Account.new
# personal.spend("coffee" => "5")
# personal.earn("gift_card" => "20")
# puts "You started #{y} in your account. 
# After checking your account, you have #{ben.current_amount(personal)}"


###Extra CREDIT
def get_info
  puts "what is your name?"
  user_name = "@" + gets.chomp
  puts "How much money do you have"
  amount = gets.chomp.to_i
  # user_name = User.new(user_name, amount)
  # ^does not work for specific user
  user = instance_variable_set user_name, User.new(user_name, amount)
  
  puts "Hi #{user_name}, what would you like to make a account for? 
  Give this account a name(Do not include space)."
  account_name = "@" + gets.chomp
  account = instance_variable_set account_name, Account.new

    loop do 
    puts "What would you like to track on your acount: #{account_name}? 
    money_spent(s) or money_earned(e)?"
    action = gets.chomp
    
    if action == "s".downcase
      loop do
        puts "Enter 'done' when you are done entering all the money you spend, otherwise enter in this format: 
        money_spend_on, amount"
        money_spent = gets.chomp
      
        account.spend("#{money_spent.split(",")[0]}" => "#{money_spent.split(",")[1].to_i}" )

        break if money_spent == "done".downcase
      end
    elsif action == "e".downcase
      loop do
        puts "Enter 'done' when you are done entering all the money you earn, otherwise enter in this format: 
        money_earned_from, amount"
        money_earned = gets.chomp
      
        account.earn("#{money_earned.split(",")[0]}" => "#{money_earned.split(",")[1].to_i}" )

        break if money_earned == "done".downcase
      end
    end

    puts "continue tracking? (enter no to stop, otherwise, it will continue tracking"
    answer = gets.chomp
    break if answer == "no".downcase
  end

  #summary
    puts "You started #{amount} in your account. 
    After checking your account, you have #{user.current_amount(account)}"

    puts "Here are your expenses
    Money spent: #{account.instance_variable_get(:@spent)}
    Money earned: #{account.instance_variable_get(:@earned)}"

end

get_info