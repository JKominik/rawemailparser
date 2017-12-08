# empty variables I will use through out these blocks of code

array = []
datesent = nil
emailto = nil
emailfrom = nil
emailsubject = nil
starthtmlbodyindex = nil
endhtmlbodyindex = nil
starttextbodyindex = nil
endtextbodyindex = nil

# opens file and iterates through adding every line to an array so I dont have to continously open it
File.open( "YOUR_FILE_HERE.eml" ).each do |line|
	array << line
end

# searches each line after the split on ":" to see if the first includes the relevent fields EXACTLY
array.each do |line|

	eachline = line.split(":", 2)

	if eachline[0].include?("Date") && (eachline[0].split(//).length == 4)
		datesent = eachline[1]
	elsif eachline[0].include?("To") && (eachline[0].split(//).length == 2)
		emailto = eachline[1]
	elsif eachline[0].include?("From") && (eachline[0].split(//).length == 4)
		emailfrom = eachline[1]
	elsif eachline[0].include?("Subject") && (eachline[0].split(//).length == 7)
		emailsubject = eachline[1]
	end
end
# searches each line of the array while counting the number of interations
# when the line includes what I am looking for it sets the loop number to the var(+ or - select numbers for readability)
# for later evaluation
i = 0
array.each do |line|

	eachline = line.split(";", 2)
	
	if eachline.include?("Content-Type: text/plain") && (eachline[0].split(//).length == 24)
		starttextbodyindex = i + 2
	elsif eachline.include?("Content-Type: text/html") && (eachline[0].split(//).length == 23)
		endtextbodyindex = i -1
	end
	i = i+1
end

# searches each line of the array while counting the number of interations
# when the line includes what I am looking for it sets the loop number to the var for later evaluation
i = 0
array.each do |line|
	if line.include?("<html>")
		starthtmlbodyindex = i
	elsif line.include?("</html>")
		endhtmlbodyindex = i
	end
	i = i+1
end

# calling the empty variables from earlier with approprate labels
# HTML is commented out because the plain text it easier to read

puts "--Date Sent:" + datesent 
puts "--To:" + emailto 
puts "--From:" + emailfrom 
puts "--Subject:" + emailsubject 
puts "--TEXT:" + array[starttextbodyindex...endtextbodyindex].join
# puts "--HTML:" + array[starthtmlbodyindex..endhtmlbodyindex].join
