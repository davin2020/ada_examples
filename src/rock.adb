with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded;

procedure Rock is
   use Ada.Strings.Unbounded;
   type Index is range 1 .. 5;


   subtype str_data is String (1 .. 3);
   type str_array is array (1 .. 3) of str_data;

   vals : constant str_array := ("roc", "pap", "sci");

   subtype VString is Unbounded_String;
   type options_array is array (1 .. 3) of VString;
   values : options_array := (To_Unbounded_String("rock"), To_Unbounded_String("paper"), To_Unbounded_String("scissors"));

begin
   --  Insert code here.
   Put_Line("Enter a number 1 Rock, 2 Paper 3 Scissors");
   null;
   -- read stuff

   -- print stuff
   for Item of vals loop
      Put_Line(Item);
   end loop;
end Rock;
