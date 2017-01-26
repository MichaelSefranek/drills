require 'csv'
require 'pry'



## cleans a string from money, decimal point
def scrub(str)
    scrubstr = str.delete("$").delete(",").delete("\n")
    return(scrubstr)
end


## spent takes an Category name (a string) and returns amount of total outflow in that Categoryr
def spent(str)  ## str is our category e.g. "Allowance"

 	num1 = 0

	CSV.foreach("accounts.csv", {headers: true, return_headers: false}) do |row|
		##expense = row[4].delete("\n")
		if row[3] == str
			num1 += row[4].gsub(/[$]/, '').to_f
		end  ##stackoverflow takes dollar sign substitutes with nothing
	end

	return(num1)

end



def perCatSpend(str1, str2)  ## Finds Sum of Out Flow for Each Catagories for Each Account, accounting for refund

	num1 = 0

	CSV.foreach("accounts.csv", {headers: true, return_headers: false}) do |row|
		
		if row[3].delete("\n") == str1 && row[0].delete("\n") == str2
			num1 += row["Outflow"].gsub(/[$]/, '').to_f
			num1 -= row["Inflow"].gsub(/[$]/, '').to_f
		end  
	end

 	
	return(num1)

end

#Allowance("Groceries", "Sonia")





def allowance(account_name)  ## Used to Find Allowance. Sums InFlow for Each Account

	allowance_total = 0

	CSV.foreach("accounts.csv", {headers: true, return_headers: false}) do |row|
		
		if row[3].delete("\n") == "Allowance" && row[0].delete("\n") == account_name
			allowance_total += row["Inflow"].gsub(/[^\d\.]/, '').to_f
		end  
	end

 	#print(num1)
	return(allowance_total)

end


def eachSpent(account_name)  ## for account_ name gives  total spent in everything BUT "Allowance"

	total_spent = 0
	

	CSV.foreach("accounts.csv", {headers: true, return_headers: false}) do |row|
		
		if row["Account"].delete("\n") == account_name && row["Category"] != "Allowance" 
			total_spent += row["Outflow"].gsub(/[$]/, '').to_f
			total_spent -= row["Inflow"].gsub(/[$]/, '').to_f			
		end  
	
	end
	
	return(total_spent)

end

## WORKS,takes a name, and counts nonzero transactions, and gives the average, and count for that Acct
## Has a bug? Maybe doesn't account for refunds?

def avg(account_name, category) 
	counter = 0
	number_of_accounts = []

	CSV.foreach("accounts.csv", {headers: true, return_headers: false}) do |row|
		
		if row["Account"].delete("\n") == account_name && row["Category"] == category


			number_of_accounts.push(row["Outflow"].gsub(/[$]/, '').to_f)
				
		end  
	
	end

	if number_of_accounts.sum > 0 

	average = (number_of_accounts.sum - refund)  / number_of_accounts.length
    #puts average
    end

	

	return(average)
end

#avg("Sonia", "Rent")



##  Incomplete, is not useful not specific to person
## category is our category e.g. "Allowance"

def spentCategory(category)  

	total = 0

	CSV.foreach("accounts.csv", {headers: true, return_headers: false}) do |row|
		##expense = row[4].delete("\n")
		if row[3] == category
			total += row[4].gsub(/[$]/, '').to_f
		end  ##stackoverflow takes dollar sign substitutes with nothing
	end

	return(total)

end







## takes name of header, finds all unique strings within that header row[num], returns an array of those strings

def uniqueValuesInColumn(header_str)
	valuesArr = []
	CSV.foreach("accounts.csv", {headers: true, return_headers: false}) do |row|
		value = row[header_str].delete("\n")
		valuesArr.push(value)
	end

	return(valuesArr.uniq)
end

 

 ## This gives us all of the categories for each person (not the unique categories)
 

 sArray = []
 pArray = []


CSV.foreach("accounts.csv", {headers: true, return_headers: false}) do |row|
	if row[0].delete("\n") == "Sonia"
		sArray.push(row["Category"].delete("\n"))


	elsif 
		pArray.push(row["Category"].delete("\n"))

	end

end





## WORKS: specific variation of csvUnique : takes an string of an account name (e.g Sonia) and prints name and all its unique accounts
def csvUniqCatForName(strAcct)
    catchArray = []
    CSV.foreach("accounts.csv", {headers: true, return_headers: false}) do |row|
        cleanCategory = scrub(row[3])
        cleanAcct = scrub(row[0])
        if cleanAcct == strAcct
            catchArray.push(cleanCategory)
        end
    end
    uniqCat = catchArray.uniq

    return(uniqCat)
end

csvUniqCatForName("Sonia")

csvUniqCatForName("Priya")



########################################################################
#         BEGINNING OF MAIN CODE FOR FORMATTING TERMINAL               #
########################################################################


uniqueValuesInColumn("Account").each do |name|


   		puts "--------------"
    	puts "#{name}"
    	puts "--------------"

    	puts "Allowance was #{allowance(name)}"
    	puts "#{name} spent #{eachSpent(name).round(2)}"
    	puts "Balance is #{allowance(name).round(2) - eachSpent(name).round(2)}"



		# display all the spend
		csvUniqCatForName(name).each do |cat|
			if cat != "Allowance"
		     puts "Spent -#{perCatSpend(cat, name).round(2)} on #{cat}  with average #{avg(name, cat)}"


		    end
		end

	
end
