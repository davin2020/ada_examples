with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; -- to create variable length strings
with Ada.Numerics.Discrete_Random;

procedure Rock is
   use Ada.Strings.Unbounded;
   User_Choice : Integer := 0;
   --  Winner : Unbounded_String;
   Winner : String (1 .. 8);
   ROCK     : constant Integer := 1;
   PAPER    : constant Integer := 2;
   SCISSORS : constant Integer := 3;

   subtype VariableLengthString is Unbounded_String;
   type array_strings is array (1 .. 3) of VariableLengthString;

   -- IDE doesnt have line/word wrap option but u can add carraige returns manually
   options_array : array_strings :=
     (To_Unbounded_String ("rock"), To_Unbounded_String ("paper"),
      To_Unbounded_String ("scissors"));

   -- setup random num generator
   subtype randRange is Integer range 1 .. 3;
   package Rand_Int is new Ada.Numerics.Discrete_Random (randRange);
   use Rand_Int;
   gen             : Generator;
   Computer_Choice : randRange;

begin
   -- Next - add a loop to keep playing, or 0 to quit loop - eg best of 3,
   -- or keep score across multiple rounds and then determine the winner
   Until_Loop :
   loop
      Put_Line ("Enter a number - 1 for Rock, 2 for Paper, 3 for Scissors, or 0 to exit");

      -- read str input and convert to int
      User_Choice := Integer'Value (Get_Line);
      exit Until_Loop when User_Choice = 0;

      --print the to_string version of the users requested index of the options_array
      Put_Line ("You chose: " & To_String(options_array(User_Choice)));
      --  Put_Line (To_String (options_array(User_Choice)));

      --randomly choose an option for the computer user, then dispaly its number and value from the array
      Reset (gen);
      Computer_Choice := Random (gen);
      Put_Line ("The computer used random number gen to choose: " & To_String(options_array (Computer_Choice)));
      --  Put_Line (randRange'Image (Computer_Choice)); -- converts an int to string for printing
      --  Put_Line (To_String (options_array (Computer_Choice)));

      --  2paper beats 1rock , 1rock beats 3scissors, 3sciossrs beats 2paper. - RPS
      --  if user=2 and computer=1 OR user=1 and computer=3 or user=3 and computer=2 - then user wins

      if (User_Choice = PAPER and Computer_Choice = ROCK) or
        (User_Choice = ROCK and Computer_Choice = SCISSORS) or
        (User_Choice = SCISSORS and Computer_Choice = PAPER)
      then
         Winner := "User    ";
      elsif (User_Choice = ROCK and Computer_Choice = ROCK) or
        (User_Choice = PAPER and Computer_Choice = PAPER) or
        (User_Choice = SCISSORS and Computer_Choice = SCISSORS)
      then
         Winner := "Tie!    ";
      else
         Winner := "Computer";
      end if;

      Put_Line ("The winner is: " & Winner);
      Put_Line ("");

   end loop Until_Loop;
   Put_Line ("Thanks for Playing, Bye! ");

end Rock;
