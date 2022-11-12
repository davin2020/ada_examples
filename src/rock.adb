with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; -- to create variable length strings
with ada.numerics.discrete_random;

procedure Rock is
   use Ada.Strings.Unbounded;
   User_Choice: Integer := 0 ;

   subtype VariableLengthString is Unbounded_String;
   type array_strings is array (1 .. 3) of VariableLengthString;
   -- IDE doesnt have line/word wrap option but u can add carraige returns manually
   options_array : array_strings := (To_Unbounded_String("rock"),
                              To_Unbounded_String("paper"),
                              To_Unbounded_String("scissors"));

   -- setup random num generator
   subtype randRange is Integer range 1..3;
   package Rand_Int is new ada.numerics.discrete_random (randRange);
   use Rand_Int;
   gen : Generator;
   num: randRange;


begin
   -- Next - add a loop to keep playing eg best of 3, or determine the winner

   --  Insert code here.
   Put_Line("Enter a number 1 for Rock, 2 for Paper, 3 for Scissors");

   -- read stuff - causing errors, need to convert string to int
   User_Choice := Integer'Value(Get_Line);

   --print the to_string version of the users requested index of the options_array
   Put_Line("You chose: ");
   Put_Line(To_String(options_array(User_Choice)));

   --randomly choose an option for the computer user, then dispaly its number and value from the array
   reset(gen);
   num := random(gen);
   Put_Line ("The computer used random number gen to choose: ");
   put_line(randRange'Image(num));
   Put_Line(To_String(options_array(num)));

end Rock;
