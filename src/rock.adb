-- Game Rules - paper beats rock, rock beats scissors, scissors beats paper.
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; -- to create variable length strings
with Ada.Numerics.Discrete_Random;

-- FYI Parameters in Ada subprogram declarations are separated with semicolons,
-- because commas are reserved for listing multiple parameters of the same type.

procedure Rock is
   use Ada.Strings.Unbounded;

   User_Choice : Integer := 0;
   -- whats syntax to limit this to be Integer range 1..3 without making more errors ? eg
   subtype xyz is Integer range 1..3;
   type abc is new Integer range 1..3;
   --  type custom is new Integer range 0..wanted;
   --  subtype User_Choice is  Integer range 1..3;
   --  User_Choice : Integer is range 1..3 := 0;

   Winner, WinnerResult : Unbounded_String;

   ROCK     : constant Integer := 1;
   PAPER    : constant Integer := 2;
   SCISSORS : constant Integer := 3;

   -- this makew a new type such that u cant accidentally assign the wrong type to the variable without the compiler noticing
   --  subtype VariableLengthString is Unbounded_String;
   --  type array_strings is array (1 .. 3) of VariableLengthString;
   type array_strings is array (1 .. 3) of Unbounded_String;

   -- IDE doesnt have line/word wrap option but u can add carraige returns manually
   options_array : array_strings :=
     (To_Unbounded_String ("rock"), To_Unbounded_String ("paper"),
      To_Unbounded_String ("scissors"));

   -- try enum instead for options - but how to pick a random number from this?
   type Game_Options is (Rock_Img, Paper_Img, Scissors_Img);

   -- setup random number generator
   subtype randRange is Integer range 1 .. 3;
   package Rand_Int is new Ada.Numerics.Discrete_Random (randRange);
   use Rand_Int;
   gen             : Generator;
   Computer_Choice : randRange;

   -- FunctioNs Need to return a value while ProceduREs REturn nothing
   -- do i need to add OUT params, if so how?
   function Determine_Winner (User_Input : in Integer; Computer_Input : in Integer) return Unbounded_String is
   begin
      if (User_Input = PAPER and Computer_Input = ROCK) or
        (User_Input = ROCK and Computer_Input = SCISSORS) or
        (User_Input = SCISSORS and Computer_Input = PAPER) then
         -- syntax to assing an unbounded string when your value IS a string ie no implicit casting/type juggling happens
         Winner := To_Unbounded_String ("User");
      elsif (User_Input = ROCK and Computer_Input = ROCK) or
        (User_Input = PAPER and Computer_Input = PAPER) or
        (User_Input = SCISSORS and Computer_Input = SCISSORS) then
         Winner      := To_Unbounded_String ("Tie");
      else
         Winner      := To_Unbounded_String ("Computer");
      end if;
      return Winner;
   end Determine_Winner;



begin
   -- Next - keep score eg  best of 3 across multiple rounds and then determine the winner
   Until_Loop :
   loop
      Put_Line ("Enter a number - 1 for Rock, 2 for Paper, 3 for Scissors - or 0 to exit");

      -- read string of user input and convert to int
      User_Choice := Integer'Value (Get_Line);
      exit Until_Loop when User_Choice = 0;

      --print the to_string version of the users requested index of the options_array
      Put_Line ("You chose: " & To_String (options_array (User_Choice)));

      --randomly choose an option for the computer user, then dispaly its value from the array
      Reset (gen);
      Computer_Choice := Random (gen);
      Put_Line ("The computer used random number generator to choose: " & To_String (options_array (Computer_Choice)));
      --  Put_Line (randRange'Image (Computer_Choice)); -- converts an int to string for printing


      WinnerResult := Determine_Winner (User_Choice, Computer_Choice);
      Put_Line ("...and the winner is: " & To_String (WinnerResult));
      Put_Line ("");

   end loop Until_Loop;
   Put_Line ("Thanks for Playing, Bye! ");

end Rock;
