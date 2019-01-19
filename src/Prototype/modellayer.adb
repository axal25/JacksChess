package body ModelLayer is

   procedure Main is 
   begin
      null;
   end Main;
   
   -- type AxisX is ( A, B, C, D, E, F, G, H );
   function AxisX_to_Integer( aX : AxisX ) return Integer is
   begin
      case aX is
         when A => return 1;
         when B  => return 2;
         when C => return 3;
         when D => return 4;
         when E => return 5;
         when F => return 6;
         when G => return 7;
         when others => return 8;
      end case;
   end AxisX_to_Integer;

end ModelLayer;
