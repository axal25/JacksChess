package body P_Cell is


   procedure Initialize (Cell: in out T_Cell_Record) is
   begin
      Gtk_New(Cell.Alignment,0.5,0.5,1.0,1.0);
      Gtk_New(Cell.Button);
      Cell.Alignment.Add(Cell.Button);
      --Gtk_New(Cell.Image); --initialize a null image
      --Cell.Button.Set_Image(Gtk_Image_New);
   end Initialize;

   procedure Init_Cell(Cell: in out T_Cell) is
   begin
      Cell := new T_Cell_Record;
   end;

   procedure Finalize (Cell: in out T_Cell_Record) is
   begin
      null;
   end;

   procedure Dig(Cell : in out T_Cell_Record) is
   begin
      if Cell.State = normal then
         Cell.State := Digged;
         Cell.Button.Set_Relief(Relief_None);
         Cell.Button.Set_Sensitive(false);
         if Cell.Mined then
            Cell.Button.Set_Image(
               Gtk_Image_New_From_File("share/icons/mine-rouge.png"));
         else
            case Cell.Nb_Foreign_Mine is
               when 0 => Cell.Button.Set_Label("");
               when 1 => Cell.Button.Set_Label("1");
               when 2 => Cell.Button.Set_Label("2");
               when 3 => Cell.Button.Set_Label("3");
               when 4 => Cell.Button.Set_Label("4");
               when 5 => Cell.Button.Set_Label("5");
               when 6 => Cell.Button.Set_Label("6");
               when 7 => Cell.Button.Set_Label("7");
               when 8 => Cell.Button.Set_Label("8");
               when others => null;
            end case;
         end if;
      end if;
   end Dig;

   procedure Loose_Reveal(Cell : in out T_Cell_Record) is
   begin
      Cell.Button.Set_Sensitive(false);
      case Cell.State is
         when Normal =>
            if Cell.Mined then
               Cell.Button.Set_Relief(Relief_None);
               Cell.Button.Set_Image(
                  Gtk_Image_New_From_File("share/icons/mine-noire.png"));
            end if;
         when Flagged =>
            if not Cell.Mined then
               Put_line("Misplaced Flag");
            end if;
         when others =>
            null;
      end case;
   end Loose_Reveal;

   procedure Win_Reveal(Cell : in out T_Cell_Record) is
   begin
      Cell.Button.Set_Sensitive(false);
      case Cell.State is
         when Normal =>
            if Cell.Mined then
               Cell.Button.Set_Image(
                  Gtk_Image_New_From_File("share/icons/drapeau-bleu.png"));
            end if;
         when others =>
            null;
      end case;
   end Win_Reveal;

   procedure Flag(Cell: in out T_Cell_Record) is
   begin
      if Cell.State = Normal then
         Cell.State := Flagged;
         Cell.Button.Set_Image(
            Gtk_Image_New_From_File("share/icons/drapeau-bleu.png"));
      end if;
   end Flag;

   procedure Unflag(Cell: in out T_Cell_Record) is
   begin
      if Cell.State = Flagged then
         Cell.State := Normal;
         Cell.Button.Set_Image( Gtk_Image_New);
      end if;
   end Unflag;


end P_Cell;
