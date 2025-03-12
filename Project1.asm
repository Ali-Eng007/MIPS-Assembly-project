# Project 1
# Ali Al-Saed  --  1210198
# Moaid Karakra -- 1211441




.data

fileName:   .asciiz "C:/medical_tests.txt"  # Name of the file
buffer:     .space 1024                   
line:       .space 256   # Assuming max line length is 255 characters
newline:    .asciiz "\n"
end_message: .asciiz "\nProgram Ended"  
idBuffer:   .space 8 
nameBuffer:   .space 4  
numF:   .space 10 
fractionf: .space 10        
intMessage: .asciiz "\nEnter the patiant ID:"    
add_intMessage: .asciiz "\nEnter the new patiant test ID :"
add_nameMessage: .asciiz "\nEnter the new patiant test name :"
add_dateMessage: .asciiz "\nEnter the new patiant test date (yyyy-mm) :"
add_resultMessage: .asciiz "\nEnter the new patiant test result:"
ID:       .space 8
Name:       .space 4
Date:       .space 8 
Result:       .space 6 
testData: .space 50
collon: .space 2            
comma: .space 2
minDateYear: .space 5
maxDateYear: .space 5
minDateMonth: .space 3
maxDateMonth: .space 3
minYear_Message: .asciiz "\nEnter the min patiant test year (yyyy) :"
maxYear_Message: .asciiz "\nEnter the max patiant test year (yyyy) :"
minMonth_Message: .asciiz "\nEnter the min patiant test month (xx) :"
maxMonth_Message: .asciiz "\nEnter the max patiant test month (xx) :"
Year:.space 5
Month:.space 3
choose: .asciiz "\nEnter your choise:"
Add: .asciiz "\n1-)Add a new medical test"
Search_A:.asciiz "\n2-)Retrieve all patient tests"
Search_B:.asciiz "\n3-)Retrieve all up normal patient tests"
Search_C:.asciiz "\n4-)Retrieve all patient tests in a given specific period"
Search_D:.asciiz "\n5-)Retrieve all unnormal patient tests"
Average:.asciiz "\n6-)Average test value"
Update:.asciiz "\n7-)Update an existing test result"
Delete:.asciiz "\n8-)Delete a test"
Exit:.asciiz "\n9-)Exit"
Menu:.asciiz "\n____________________________Menu__________________________________"
File_Write:.asciiz "\nData stored in file"
Test:.asciiz "\nTest"
Nodata:.asciiz "\n Search Falied (NON MATCHED ID OR NO MATCHED RESULTS !)"
mnue_Tryagain:.asciiz "\n Unvalid option try again !"
average:    .asciiz "\nHere are the average values for the available medical tests:"
HgpM:       .asciiz "\nHgb: "
LDLM:       .asciiz "\nLDL: "
BGTM:       .asciiz "\nBGT: "
SBPM:       .asciiz "\nSBP: "
DBPM:       .asciiz "\nDBP: "
fp1: .float 10
fp2: .float 100
fp3: .float 1000
zero: .float 0
HgpCounter: .space 4
LDLCounter: .space 4     
BGTCounter: .space 4      
SBPCounter: .space 4
DBPCounter: .space 4
HgbN:       .asciiz "Hgb"
LDLN:       .asciiz "LDL"
BGTN:       .asciiz "BGT"
SBPN:       .asciiz "SBP"
DBPN:       .asciiz "DBP"
Invalid_ID: .asciiz "\n\nInvalid user ID value, try again.\n"
Invalid_name: .asciiz "\n\nInvalid test name value, try again.\n"
Invalid_date: .asciiz "\n\nInvalid test date value, try again.\n"
Invalid_Result: .asciiz "\n\nInvalid test Result value, try again.\n"
dateBuffer:   .space 8  


.text

fileNotOpened :

jal readFile

        li $v0, 4   
        la $a0, buffer
        syscall


main:
l.s $f10, zero
l.s $f14, zero
l.s $f18, zero
l.s $f22, zero
l.s $f26, zero


menu_loop:
      
      #inisiate flags
        li $s0,0
        li $s7,0
        
         #take value for menue 
         li $v0, 4   
        la $a0, Menu
        syscall
        
        
        li $v0, 4   
        la $a0, Add
        syscall
        
         li $v0, 4   
        la $a0, Search_A
        syscall
        
         li $v0, 4   
        la $a0, Search_B
        syscall
        
         li $v0, 4   
        la $a0, Search_C
        syscall
        
         li $v0, 4   
        la $a0, Search_D
        syscall
        
         li $v0, 4   
        la $a0, Average
        syscall
        
         li $v0, 4   
        la $a0, Update
        syscall
        
         li $v0, 4   
        la $a0, Delete
        syscall
       
         li $v0, 4   
        la $a0, Exit
        syscall
        
        
        li $v0, 4   
        la $a0, choose
        syscall
        
        li $v0, 5 # Read integer
	syscall # $v0 = value read
	move $t4,$v0
	
	beq $t4,1,case1
	beq $t4,2,case2
	beq $t4,3,case2
	beq $t4,4,case4
	beq $t4,5,case5
	beq $t4,6,case5
	beq $t4,7,case2
	beq $t4,8,case2
        beq $t4,9,end_program
        
        li $v0, 4   
        la $a0, mnue_Tryagain
        syscall
        
        b menu_loop
            


case1:
   # taking input from user to add as a new test
   
   ## ID from user and append with :
      	 li $v0, 4   
   	 la $a0, add_intMessage
   	 syscall
   	 
   	 la $a0, ID # $a0 = address of str
         li $a1, 8 # $a1 = max string length
         li $v0, 8 # read string
         syscall
         
         jal checkID
         
         la $a0, ID
         la $a1, testData
    	 addi $a1, $a1, 0
         jal append_string
        
        
         la $a0, collon
         li $s4,':'
         sb $s4, ($a0)

   	 la $a1, testData
  	 addi $a1, $a1, 7  
  	 jal append_string
  	  
  	
    
      ## name from user and append with ,
         li $v0, 4   
   	 la $a0, add_nameMessage
   	 syscall
   	 
   	 la $a0, Name # $a0 = address of str
         li $a1, 4 # $a1 = max string length
         li $v0, 8 # read string
         syscall
         
        la $s7, back
        j checkTestName
back:
         
         
         la $a0, Name
        la $a1, testData
    	addi $a1, $a1, 8
        jal append_string
        
         
         
         la $a0, comma
         li $s4,','
         sb $s4, ($a0)
   	 la $a1, testData
  	 addi $a1, $a1, 11  
  	 jal append_string
      
      
  	  
  	 
     ## date from user and append with ,
      
  	   
  	 li $v0, 4   
   	 la $a0, add_dateMessage
   	 syscall
   	 
   	 la $a0, Date # $a0 = address of str
         li $a1, 8 # $a1 = max string length
         li $v0, 8 # read string
         syscall
         
          j checkTestDate
          back1:
         
         la $a0, Date
         la $a1, testData
    	 addi $a1, $a1, 12
         jal append_string
         
         
         
         la $a0, comma
         li $s4,','
         sb $s4, ($a0)
   	 la $a1, testData
  	 addi $a1, $a1, 19 
  	 jal append_string
  	 
  	 
        ## result from user and append with 
          li $v0, 4   
   	 la $a0, add_resultMessage
   	 syscall
   	 
   	 la $a0, Result # $a0 = address of str
         li $a1, 6 # $a1 = max string length
         li $v0, 8 # read string
         syscall
         
           j checkTestResult
 back2:
         
         la $a0, Result
        la $a1, testData
    	addi $a1, $a1, 20
        jal append_string
        
        addi $a1, $a1, 25
        sb $zero, ($a1)
       
       # calculate addres of free space in buffer
        jal buffer_size
        
        la $a1,buffer
        add $a1,$a1,$t6 #offset 
        
        la $a0, testData     # Load the address of testData into $a0
        jal append_string   # Append testData to the end of the buffer
        
        ##add new line for buufer 
        jal buffer_size
        la $a1,buffer
	add $a1,$a1,$t6
	la $a0, newline     # Load the address of testData into $a0
	jal append_string   # Append testData to the end of the buffer
        

        
        # Test addtion
         li $v0, 4   
   	 la $a0, newline
   	 syscall
    
   	 li $v0, 4   
   	 la $a0, buffer
   	 syscall
   	 
   	 	 
   	 j menu_loop 

                          




checkID:
    li $t0, 7           # Maximum length of the ID
    li $t1, 0           # Counter for non-digit characters, initialize to 0
    
checkNumericDigits:
    lb $t2, 0($a0)      # Load byte from the ID string
    beq $t2, $zero, endCheckID  # If end of string is reached, go to endCheckID
    blt $t2, 48, notNumericID  # If character is less than '0', not numeric
    bgt $t2, 57, notNumericID  # If character is greater than '9', not numeric
    addi $a0, $a0, 1    # Move to the next character
    addi $t1, $t1, 1    # Increment counter for numeric characters
    j checkNumericDigits  # Repeat loop

endCheckID:
    bne $t1, $t0, invalidID  # If number of digits is not 7, ID is invalid  
    jr $ra

invalidID:

     li $v0, 4            # Print string syscall code
    la $a0, Invalid_ID   # Load address of Invalid_ID string
    syscall              # Print Invalid_ID message
    j menu_loop

notNumericID:
    li $v0, 4            # Print string syscall code
    la $a0, Invalid_ID   # Load address of Invalid_ID string
    syscall              # Print Invalid_ID message
    j menu_loop
    
    

checkTestName:

    # Compare the test name with each valid test name
    # If it matches any, jump to stringsEqual
    la $a1, HgbN          # Load the address of the first valid test name
    jal stringEqual      # Compare the test name with Hgb
    bne $v0, 0, checkSecondTestName  # If not equal, check the next valid test name

    # If the test name matches Hgb, it's valid
    j stringsEqual

checkSecondTestName:
    la $a1, LDLN          # Load the address of the second valid test name
    jal stringEqual      # Compare the test name with LDL
    bne $v0, 0, checkThirdTestName  # If not equal, check the next valid test name

    # If the test name matches LDL, it's valid
    j stringsEqual

checkThirdTestName:
    la $a1, BGTN          # Load the address of the third valid test name
    jal stringEqual      # Compare the test name with BGT
    bne $v0, 0, checkFourthTestName  # If not equal, check the next valid test name

    # If the test name matches BGT, it's valid
    j stringsEqual

checkFourthTestName:
    la $a1, SBPN          # Load the address of the fourth valid test name
    jal stringEqual      # Compare the test name with SBP
    bne $v0, 0, checkFifthTestName  # If not equal, check the next valid test name

    # If the test name matches SBP, it's valid
    j stringsEqual

checkFifthTestName:
    la $a1, DBPN          # Load the address of the fifth valid test name
    jal stringEqual      # Compare the test name with DBP
    bne $v0, 0, notValidTestName  # If not equal, it's not a valid test name

    # If the test name matches DBP, it's valid
    j stringsEqual

stringsEqual:
    j back               # Return to the calling code

notValidTestName:
    li $v0, 4            # Print string syscall code
    la $a0, Invalid_name # Load address of Invalid_name string
    syscall              # Print Invalid_name message
    j menu_loop          # Return to the menu loop

stringEqual:
    move $t0, $a0        # Copy the address of the first string to $t0
    move $t1, $a1        # Copy the address of the second string to $t1

compareLoop:
    lb $t2, ($t0)        # Load byte from the first string
    lb $t3, ($t1)        # Load byte from the second string
    beq $t2, $t3, checkEnd  # If characters are equal, continue checking
    j endNotEqual        # If characters are not equal, strings are not equal

checkEnd:
    beq $t2, $zero, stringsEqual  # If end of string is reached, strings are equal
    addi $t0, $t0, 1     # Move to the next character in the first string
    addi $t1, $t1, 1     # Move to the next character in the second string
    j compareLoop        # Repeat loop

endNotEqual:
la $a0, Name
jr $ra




checkTestDate:

     la $t5,Date
     addi $t5, $t5, 4
     lb $t6, ($t5)
     bne $t6, '-', invalidDate
     la $t5,Date
     subi $t5, $t5, 1
     la $t6,Year
     la $t2,Month     
     
     
     jal startExtract_Year
       
    
       la $a0, Year
       jal str2int
       # int id 
       move $s5,$a0 
       
       la $a0, Month
       jal str2int
       # int id 
       move $s6,$a0
       
       
    # Check year range (1800 - 2024)
    li $t0, 1800        # Minimum year
    li $t1, 2024        # Maximum year
    blt $s5, $t0, invalidDate  # If year is less than 1800, date is invalid
    bgt $s5, $t1, invalidDate  # If year is greater than 2024, date is invalid

    # Check month range (1 - 12)
    li $t2, 1           # Minimum month
    li $t3, 12          # Maximum month
    blt $s6, $t2, invalidDate  # If month is less than 1, date is invalid
    bgt $s6, $t3, invalidDate  # If month is greater than 12, date is invalid

    # Date is valid
    j back1

invalidDate:
    li $v0, 4            # Print string syscall code
    la $a0, Invalid_date # Load address of Invalid_date string
    syscall              # Print Invalid_name message
    j menu_loop          # Return to the menu loop

       
       
       
checkTestResult:
     
checkTestnumericResult:
    lb $t2, 0($a0)      # Load byte from the Result string
    beq $t2, $zero, endCheckResult  # If end of string is reached, go to endCheckResult
    beq $t2, '.', con
    blt $t2, 48, notNumericResult  # If character is less than '0', not numeric
    bgt $t2, 57, notNumericResult  # If character is greater than '9', not numeric
    con:
    addi $a0, $a0, 1    # Move to the next character
    j checkTestnumericResult  # Repeat loop

notNumericResult:
    li $v0, 4            # Print string syscall code
    la $a0, Invalid_Result   # Load address of Invalid_Result string
    syscall              # Print Invalid_Result message
    j menu_loop
    
endCheckResult:    
     la $t5, Result
     subi $t5, $t5, 1
     la $t6,numF
     la $t2,fractionf

     jal  start_extract_result_num
     
    
       la $a0, numF
       jal str2int
       # result int 
       move $s5,$a0 

       
     # Check if the result is less than 0
    blt $s5, 0, notNumericResult
    # Check if the result is greater than 600
    bgt $s5, 450, notNumericResult   
j back2
                     















case2:

    la $a0,add_intMessage
    li $v0, 4		
    syscall
    
    li $v0, 5 # Read integer
    syscall 
    move $t7,$v0
    
    j case5
    
case4:  
    la $a0,add_intMessage
    li $v0, 4		
    syscall
    
    li $v0, 5 # Read integer
    syscall 
    move $t7,$v0
    
        la $a0,minYear_Message
    li $v0, 4		
    syscall
    
    li $v0, 5 # Read integer
    syscall 
    move $s1,$v0
    
    
    la $a0,minMonth_Message 
    li $v0, 4		
    syscall
    
    li $v0, 5 # Read integer
    syscall 
    move $s2,$v0
    
    la $a0,maxYear_Message
    li $v0, 4		
    syscall
    
    li $v0, 5 # Read integer
    syscall 
    move $s3,$v0 
    
    la $a0,maxMonth_Message 
    li $v0, 4		
    syscall
    
    li $v0, 5 # Read integer
    syscall 
    move $s4,$v0
    
   
    
    
case5:
 # Initialize registers for buffer and line
    la $t0, buffer      # $t0 points to the start of the buffer2
        move $s0, $t0
    
          
    # Loop to process each line in the buffer
read_loop:
    # Initialize registers for the line buffer
    la $t1, line        # $t1 points to the start of the line
    
    
    # Load a character from the buffer
load_char:
    lb $t2, ($t0)
    
    # Check if we've reached the end of the buffer
    beq $t2, $zero, cheak_patinat
    
    # Check if we've reached the end of the line
    beq $t2, '\n', process_line
    
    
        beq $t2, ' ', next_char
    
    # Copy the character to the line buffer
    sb $t2, ($t1)
    
    # Move to the next character in both buffers
    addi $t0, $t0, 1
    addi $t1, $t1, 1
    
    # Repeat loading characters from the buffer
    j load_char
    
     next_char:
    # Move to the next character in both buffers
    addi $t0, $t0, 1
   j load_char
    

process_line:
    # Null-terminate the line string
   sb $zero, ($t1)
   
   beq $t4,5,case3_1 
  
    la $t5, line
   la $t6, idBuffer
    
      beq $t4,6,cond6
    
   jal  extract_id
    
     
   
     #int to str id 
       la $a0, idBuffer
       jal str2int
       # int id 
       move $t6,$a0
    
      
      beq $t4,2,cond2_2  
      beq $t4,3,cond2_3 
      beq $t4,4,cond2_4 
      beq $t4,7,cond7  
      beq $t4,8,cond8  
      j next
cond2_2: beq $t6,$t7,case2_2
cond2_3: beq $t6,$t7,case3_1 
cond2_4: beq $t6,$t7,case4_1
cond7: beq $t6,$t7,case7
cond8: beq $t6,$t7,case8
       j next

cond6: b case6     

 next:   
    # Move to the next line in the buffer
    addi $t0, $t0, 1
     move $s0, $t0

    
    # Repeat the loop to process the next line
    j read_loop

end_program:

     jal writeFile
    # Print program ending message
    li $v0, 4           
    la $a0, end_message
    syscall
    
    # Exit the program
    li $v0, 10          # syscall code for exit
    syscall
     
    
extract_id:    
    lb $t3, ($t5)       
    beq $t3, ':', end_extractID
    sb $t3, ($t6)      
    addi $t5, $t5, 1    
    addi $t6, $t6, 1    
    j extract_id  

end_extractID:
    # Null-terminate the line string
    li $t3, 0           
    sb $t3, ($t6) 
    jr $ra 
    
    
extract_name:
   lb $t3,($t5)
   beq $t3,':',start_extractName
   addi $t5,$t5,1
   j extract_name

start_extractName:
     addi $t5,$t5,1
     lb $t3,($t5)
     beq $t3,',',end_extractName
     sb $t3, ($t6) 
     addi $t6, $t6, 1   
     j start_extractName  

end_extractName: 
    li $t3, 0           
    sb $t3, ($t6) 
    jr $ra
    
    
    
    
 extract_result:
    li $a3, 0    # Initialize comma counter

    # Loop to scan characters in line
loop_extract:
    lb $t3, ($t5)
    beq $t3, ',', flag_comma
    addi $t5, $t5, 1
    j loop_extract

flag_comma:
    addi $a3, $a3, 1     # Increment comma counter
    beq $a3, 2, start_extract_result_num
    addi $t5, $t5, 1     # Move to next character
    j loop_extract

start_extract_result_num:
    addi $t5, $t5, 1     # Move to next character after comma
    li $a3, 0            # Reset comma counter

    # Loop to extract integer part
extract_integer:
    lb $t3, ($t5)  
    beq $t3, '.', end_extract_result_num
    beq $t3, $zero, end_extract_result_noF
    sb $t3, ($t6) 
     
    addi $t6, $t6, 1
    addi $t5, $t5, 1
    j extract_integer

end_extract_result_num:
    # Null-terminate integer part
    li $t3, 0           
    sb $t3, 0($t6) 

    # Move to next character after dot
    addi $t5, $t5, 1

    # Loop to extract fractional part
extract_fraction:
    lb $t3, ($t5)
    beq $t3, $zero, end_extract_result
    sb $t3, ($t2) 
    addi $t2, $t2, 1
    addi $t5, $t5, 1
    j extract_fraction

end_extract_result:
    # Null-terminate fractional part
    li $t3, 0           
    sb $t3, ($t2) 

    jr $ra

end_extract_result_noF:
     li $t3, 0           
    sb $t3, 0($t6) 
    jr $ra
 
 
 
extract_date:
    # Loop to scan characters in line
loop_comma:
    lb $t3, ($t5)
    beq $t3, ',', startExtract_Year
    addi $t5, $t5, 1
    j loop_comma

startExtract_Year:
    addi $t5, $t5, 1    
    lb $t3, ($t5)  
    beq $t3, '-', end_extract_Year
    sb $t3,($t6) 
    addi $t6, $t6, 1
    j startExtract_Year

end_extract_Year:
    # Null-terminate integer part
    li $t3, 0           
    sb $t3, 0($t6) 

    # Move to next character after dot
    addi $t5, $t5, 1

    # Loop to extract fractional part
extract_Month:
    lb $t3, ($t5)
    beq $t3,',', end_extract_Month
    sb $t3, ($t2) 
    addi $t2, $t2, 1
    addi $t5, $t5, 1
    j extract_Month

end_extract_Month:
    # Null-terminate fractional part
    li $t3, 0           
    sb $t3, ($t2) 
    jr $ra


str2int:
li $v0, 0 # Initialize: $v0 = sum = 0
li $t5, 10 # Initialize: $t0 = 10
L1:
 lb $t6, ($a0) # load $t1 = str[i]
blt $t6, '0', done # exit loop if ($t1 < '0')
bgt $t6, '9', done # exit loop if ($t1 > '9')
addiu $t6, $t6, -48 # Convert character to digit
mul $v0, $v0, $t5 # $v0 = sum * 10
addu $v0, $v0, $t6 # $v0 = sum * 10 + digit
addiu $a0, $a0, 1 # $a0 = address of next char
j L1 # loop back
done: 
move $a0,$v0
jr $ra # return to caller

     
case2_2:   

     addi $s0,$s0,1  #flag   
    # Print the line
    li $v0, 4           # Print string syscall code
    la $a0, line        # Load address of the line
    syscall
    
    # Print a newline
    li $v0, 4           # Print string syscall code
    la $a0, newline     # Load address of the newline character
    syscall
    j next
    
case3_1: 
 
   la $t5, line
   la $t6, nameBuffer
    
   jal  extract_name
     

   
     la $t5,line
     la $t6,numF
     la $t2,fractionf
     
       jal extract_result
 
       la $a0, numF
       jal str2int
       # result int 
       move $s5,$a0 
       
      

         
       la $a0, fractionf
       jal str2int
       # result fraction
       move $s6,$a0
       

      
      #kind of test 
       la $s2,nameBuffer
       
       

       lb $t3,0($s2)
      
       beq $t3,'H',Hgp
       beq $t3, 'L',LDL     
       beq $t3,'B',BGT      
       beq $t3, 'S',SBP
       beq $t3, 'D',DBP
       
       
Hgp:

  blt $s5,13,case2_2  
  beq $s5,13,C2T1
  
  j C3T1 #bigger check max 
             
C2T1: 

   blt $s6,8,case2_2  
   j C3T1    

C3T1:
   bgt $s5,17,case2_2
   beq $s5,17,C4T1
   
    
    j next #NORMAL
    
C4T1:
    bgt $s6,2,case2_2  
    j next       
    

    
BGT:   
   


  blt $s5,70,case2_2  
  beq $s5,70,C2T2
  
  j C3T2 #bigger check max 
             
C2T2: 

   blt $s6,0,case2_2  
   j C3T2    

C3T2:
   bgt $s5,99,case2_2
   beq $s5,99,C4T2
   
    
    j next #NORMAL
    
C4T2:
    bgt $s6,0,case2_2  
    j next  



LDL:


  blt $s5,0,case2_2  
  beq $s5,0,C2T3
  
  j C3T3 #bigger check max 
             
C2T3: 

   blt $s6,0,case2_2  
   j C3T3    

C3T3:
   bgt $s5,100,case2_2
   beq $s5,100,C4T3
   
    
    j next #NORMAL
    
C4T3:
    bgt $s6,0,case2_2  
    j next  

 
   
SBP:
  
    blt $s5,0,case2_2  
  beq $s5,0,C2T4
  
  j C3T4 #bigger check max 
             
C2T4: 

   blt $s6,0,case2_2  
   j C3T4    

C3T4:
   bgt $s5,120,case2_2
   beq $s5,120,C4T4
   
    
    j next #NORMAL
    
C4T4:
    bgt $s6,0,case2_2  
    j next  


DBP:
   
     blt $s5,0,case2_2  
  beq $s5,0,C2T5
  
  j C3T5 #bigger check max 
             
C2T5: 

   blt $s6,0,case2_2  
   j C3T5    

C3T5:
   bgt $s5,80,case2_2
   beq $s5,80,C4T5
   
    
    j next #NORMAL
    
C4T5:
    bgt $s6,0,case2_2  
    j next  

   
case4_1:
     
###################

    
     la $t5,line   
     la $t6,Year
     la $t2,Month     
     jal extract_date
        
      
       la $a0, Year
       jal str2int
       # int id 
       move $s5,$a0 
       
    

       
       la $a0, Month
       jal str2int
       # int id 
       move $s6,$a0
       
      
  
  #compare starts
  bgt $s5,$s1,C3P 
  beq $s5,$s1,C2P
  
  j next #bigger check max 
             
C2P: 

   blt $s6,$s2,next 
   j C3P    

C3P:
   blt $s5,$s3,case2_2
   beq $s5,$s3,C4P
   
    
    j next #NORMAL
    
C4P:
    bgt $s6,$s4,next 
    j case2_2       
    

 
   
    
append_string:
    loop_append:
        lb $t0, 0($a0)  
        beq $t0, $zero, end_append  
        sb $t0, 0($a1)  
        addi $a0, $a0, 1  
        addi $a1, $a1, 1  
        j loop_append  
    end_append:
        sb $zero, ($a1)
        jr $ra  


buffer_size:

    la $t5, buffer
    li $t6, 0
    

find_end:
    lb $t3, ($t5)
    beq $t3, $zero, found_end
    addi $t5, $t5, 1
    addi $t6, $t6, 1
    j find_end
    
found_end:

   
    # move $a2, $t6
    jr $ra



readFile:
  # Open the file
    li $v0, 13              
    la $a0, fileName       
    li $a1, 0 
    li $a3, 0              
    syscall
    move $s0, $v0   
    
           
   bltz $s1, fileNotOpened  # If $s1 is negative, file open failed            
                                
loop_file:
    # Read from file
    li $v0, 14              
    move $a0, $s0           
    la $a1, buffer 
    add $a1,$a1,$a3         
    li $a2, 1         
    syscall
   
     beq $v0,0,end_fileloop
     addi $a3,$a3,1
j loop_file

end_fileloop:

     li $t0, 0            
    sb $t0, ($a1)
    # Close the file
    li $v0, 16              
    move $a0, $s0           
    syscall
    jr $ra
    
 writeFile:
 #open file 
    	li $v0,13           	# open_file syscall code = 13
    	la $a0,fileName     	# get the file name
    	li $a1,1           	# file flag = write (1)
    	syscall
    	move $s1,$v0        	# save the file descriptor. $s0 = file
    	

        bltz $s1, fileNotOpened  # If $s1 is negative, file open failed
    	
    	#Write the file
    	li $v0,15		# write_file syscall code = 15
    	move $a0,$s1		# file descriptor
    	la $a1,buffer		# the string that will be written
    	la $a2,1024		# length of the buffer string
    	syscall
    	
	#MUST CLOSE FILE IN ORDER TO UPDATE THE FILE
    	li $v0,16         		# close_file syscall code
    	move $a0,$s1      		# file descriptor to close
    	syscall
    	
    	jr $ra



cheak_patinat:
   beq  $t4,6, checkcasesix
   bne $s0,0,menu_loop
   beq $t4,8,deleteDone

        
        li $v0, 4   
        la $a0, Nodata
        syscall
        
        li $v0, 4   
        la $a0, newline
        syscall
        
        j menu_loop
       
deleteDone:
    la $a0, newline
    li $v0, 4		
    syscall
    
    la $a0, buffer
    li $v0, 4		
    syscall

j menu_loop

   
checkcasesix:
  bne  $t4, 6, menu_loop

   la $s6, HgpCounter
   lw $s7, ($s6)
   mtc1  $s7, $f4
   cvt.s.w  $f4, $f4
   div.s $f10, $f10, $f4
   
   la $s6, LDLCounter
   lw $s7, ($s6)
   mtc1  $s7, $f4
   cvt.s.w  $f4, $f4
   div.s $f14, $f14, $f4
   
   la $s6, BGTCounter
   lw $s7, ($s6)
   mtc1  $s7, $f4
   cvt.s.w  $f4, $f4
   div.s $f18, $f18, $f4
   
   la $s6, SBPCounter
   lw $s7, ($s6)
   mtc1  $s7, $f4
   cvt.s.w  $f4, $f4
   div.s $f22, $f22, $f4
   
    la $s6, DBPCounter
   lw $s7, ($s6)
   mtc1  $s7, $f4
   cvt.s.w  $f4, $f4
   div.s $f26, $f26, $f4
  
   la $a0, average
   li $v0, 4	
   syscall  
   
   la $a0, HgpM
    li $v0, 4	
    syscall 
    
    li $v0, 2
  mov.s $f12, $f10   # Move contents of register $f3 to register $f12
  syscall
  
  
     la $a0, LDLM
    li $v0, 4	
    syscall 
    
    li $v0, 2
  mov.s $f12, $f14   # Move contents of register $f3 to register $f12
  syscall
  
     la $a0, BGTM
    li $v0, 4	
    syscall 
    
    li $v0, 2
  mov.s $f12, $f18   # Move contents of register $f3 to register $f12
  syscall
  
     la $a0, SBPM
    li $v0, 4	
    syscall 
    
    li $v0, 2
  mov.s $f12, $f22   # Move contents of register $f3 to register $f12
  syscall
  
     la $a0, DBPM
    li $v0, 4	
    syscall 
    
    li $v0, 2
  mov.s $f12, $f26   # Move contents of register $f3 to register $f12
  syscall
  
  
   sw  $zero,HgpCounter
      sw  $zero,LDLCounter
         sw  $zero,BGTCounter
            sw  $zero,SBPCounter
               sw  $zero,DBPCounter
    
    
    
   l.s $f10, zero
l.s $f14, zero
l.s $f18, zero
l.s $f22, zero
l.s $f26, zero
   
  
  
  j menu_loop
   
     
case6:
     la $t5,line
     la $t6,numF
     la $t2,fractionf
     la $s5, nameBuffer
     
     jal extract_name1
     jal extract_result
     
     
       la $a0, numF
       jal str2int
       # result int 
       move $s5,$a0 

         
       la $a0, fractionf
       jal str2int
       # result fraction
       move $s6,$a0
     
    la $s0, fractionf
    jal length
    l.s $f2, zero      
    jal int2float
  
   
   lb $s7, nameBuffer
    
   
       beq $s7,'H',Hgp1
       beq $s7, 'L',LDL1    
       beq $s7,'B',BGT1     
       beq $s7, 'S',SBP1
       beq $s7, 'D',DBP1
       
   Hgp1:
   add.s $f10, $f10, $f2                         
   
   la $s6, HgpCounter
   
  
  
   
   lw $s7, ($s6)
   
    move $a0,$s7
    li $v0,1
 
     move $s7,$a0
   
   addi $s7, $s7, 1
   sw $s7, ($s6)
   
    
    
   
   j next
   
   
   LDL1:
   add.s $f14, $f14, $f2


   la $s6, LDLCounter
   lw $s7, ($s6)
   addi $s7, $s7, 1
   sw $s7, ($s6)
   j next 
   
   BGT1:
   add.s $f18, $f18, $f2
   
   
   la $s6, BGTCounter
   lw $s7, ($s6)
   addi $s7, $s7, 1
   sw $s7, ($s6)
   j next   

   SBP1:
   add.s $f22, $f22, $f2
   
   la $s6, SBPCounter
   lw $s7, ($s6)
   addi $s7, $s7, 1
   sw $s7, ($s6)
   j next
   
    DBP1:
   add.s $f26, $f26, $f2
   
   
   la $s6, DBPCounter
   lw $s7, ($s6)
   addi $s7, $s7, 1
   sw $s7, ($s6)
   j next

    
   
int2float:      
       
       mtc1  $s6, $f4
       cvt.s.w  $f4, $f4
       mtc1  $s5, $f8
       cvt.s.w $f8, $f8
       
       beq $s2, 1, oneD
       beq $s2, 2, twoD
       bge $s2, 3, threeD
       
       oneD:
        l.s   $f6, fp1
        div.s $f2, $f4, $f6
        add.s $f2, $f2, $f8
        jr $ra  
        twoD:
        l.s   $f6, fp2
        div.s $f2, $f4, $f6
        add.s $f2, $f2, $f8
        jr $ra  
        threeD:
        l.s   $f6, fp3
        div.s $f2, $f4, $f6
        add.s $f2, $f2, $f8
        jr $ra        
   
        

     length:
   li $s2, 0
   addi $s0, $s0, 1
  start4:
   lb $s1, ($s0)
   beq $s1, $zero, end4
   addi $s0, $s0, 1
   addi $s2, $s2, 1
   j start4
   
   end4:
   jr $ra
   



extract_name1:
     lb $t3, ($t5)  
     beq $t3, ':', start
     addi $t5, $t5, 1   
     j extract_name1
    start:
    addi $t5, $t5, 1
    lb $t3, ($t5)
    beq $t3, ',', end_name
    sb $t3, ($s5)
    addi $s5, $s5, 1
    j start
   end_name:
       # Null-terminate the line string
    li $t3, 0           
    sb $t3, ($s5) 
   jr $ra 
   
   
   
   
   
   
   
   
    
        
case7:


   la $t5, line
   la $t6, idBuffer

  jal extract_id
  



     la $a0, newline
    li $v0, 4	
    syscall

   la $t5, line
   la $s5, nameBuffer
   

    
   jal extract_name1
   

   
   la $t5, line
   la $s5, dateBuffer
   
   jal extract_date1
   

         la $a0, idBuffer
         la $a1, testData
    	 addi $a1, $a1, 0
         jal append_string
        

         la $a0, collon
         li $s4,':'
         sb $s4, ($a0)
   	 la $a1, testData
  	 addi $a1, $a1, 7  
  	 jal append_string
  	  
  	
         
         la $a0, nameBuffer
        la $a1, testData
    	addi $a1, $a1, 8
        jal append_string
        
         
         la $a0, comma
         li $s4,','
         sb $s4, ($a0)
   	 la $a1, testData
  	 addi $a1, $a1, 11  
  	 jal append_string
      
         
         la $a0, dateBuffer
         la $a1, testData
    	 addi $a1, $a1, 12
         jal append_string
         
         la $a0, comma
         li $s4,','
         sb $s4, ($a0)
   	 la $a1, testData
  	 addi $a1, $a1, 19 
  	 jal append_string
  	 
  	 
        ## result from user and append with 
          li $v0, 4   
   	 la $a0, add_resultMessage
   	 syscall
   	 
   	 la $a0, Result # $a0 = address of str
         li $a1, 6 # $a1 = max string length
         li $v0, 8 # read string
         syscall
         
         la $a0, Result
        la $a1, testData
    	addi $a1, $a1, 20
        jal append_string
        
        
       
       # calculate addres of free space in buffer
        jal buffer_size
        
        la $a1,buffer
        add $a1,$a1,$t6 #offset 
        
        la $a0, testData     # Load the address of testData into $a0
        jal append_string   # Append testData to the end of the buffer
        
        ##add new line for buufer 
        jal buffer_size
        la $a1,buffer
	add $a1,$a1,$t6
	la $a0, newline     # Load the address of testData into $a0
	jal append_string   # Append testData to the end of the buffer
   
       li $s4, 1
       jal case8
       
    la $a0, newline
    li $v0, 4		
    syscall
    
    la $a0, buffer
    li $v0, 4		
    syscall

       j menu_loop
   
    
case8:
   
    readchar:
      
      lb $s3, ($s0)
      li $s1, ' '
       beq $s3, '\n', done1  
         
         sb $s1,($s0)
         addi $s0, $s0, 1
         j readchar
      done1:
         beq $s4, 1, done2
          j next
      done2:      
      jr $ra
      
        
   
   
extract_date1:
  
    lb $t3, ($t5)  
     beq $t3, ',', start1
     addi $t5, $t5, 1   
     j extract_date1
    start1:
    addi $t5, $t5, 1
    lb $t3, ($t5)
    beq $t3, ',', end_date
    sb $t3, ($s5)
    addi $s5, $s5, 1
    j start1
   end_date:
       # Null-terminate the line string
    li $t3, 0           
    sb $t3, ($s5) 
   jr $ra      