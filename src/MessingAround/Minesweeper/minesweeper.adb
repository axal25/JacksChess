with Ada.Command_line; use Ada.Command_Line;
with Ada.Text_IO; use Ada.Text_IO;
with Gtk.Main; use Gtk.Main;

with P_Main_Window; use P_Main_Window;

package body Minesweeper is

   procedure Test_Then_Get( Var : in out Natural;
                            Str : String;
                            Tag : String ) is 
   begin
      --if Str start with Tag, Var get the value after Tag as Natural
      if Str'Length >= Tag'Length
        and then Str (Str'First..Str'First + Tag'Length - 1) = Tag then
         Put_Line(Str & " Start with " & Tag);
         declare
            Val_Str : String := Str(Str'First + Tag'Length..Str'Last);
         begin
            Var := Natural'Value(Val_Str);
         exception
            when CONSTRAINT_ERROR => 
               Put_line("""" & Val_Str & """ in """ & Str &
                          """ is a bad value, ignoring");
         end;
      end if;
   end Test_Then_Get;
   
   procedure Parse(Width, Height, Nb_Mine: in out Natural) is 
   begin
      -- Parse command line
      for Arg in 1..Argument_Count loop
         Test_Then_Get(Width,Argument(Arg),"width=");
         Test_Then_Get(Height,Argument(Arg),"height=");
         Test_Then_Get(Nb_Mine,Argument(Arg),"nb_mine=");
         null;
      end loop;
   end Parse;
   
   procedure Main is
      Width : Natural := 10;
      Height : Natural := 10;
      Nb_Mine : Natural := 10;
      iterator1, iterator2, iterator3 : Integer := 0;
   begin
      Put_Line( "minesweeper - start \/ " ); --
      
      Parse(Width, Height, Nb_Mine);
      
      --Start the Gui things
      Gtk.Main.Init;
      declare
         main_window : T_Main_Window;
      begin
         P_Main_Window.Init_Main_Window( 
                                         Main_Window => main_window,
                                         Height => Height,
                                         Width => Width,
                                         Nb_Mine=> Nb_Mine 
                                        ); 
         
         -- Main; -- Gryzło się nazewnictwo
         Gtk.Main.Main;
         
         free(main_window);
      end;
      Put_Line( "minesweeper - stop /\ " ); --
   end Main;

end Minesweeper;
