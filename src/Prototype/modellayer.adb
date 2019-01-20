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
   
   function Integer_to_AxisX( aRowNo : Integer ) return AxisX is
   begin
      case aRowNo is
         when 1 => return A;
         when 2 => return B;
         when 3 => return C;
         when 4 => return D;
         when 5 => return E;
         when 6 => return F;
         when 7 => return G;
         when others => return H;
      end case;
   end Integer_to_AxisX;

end ModelLayer;
