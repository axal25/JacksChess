package ModelLayer is

   type FigureType is ( Pawn, Knight, Bishop, Rook, Queen, King );
   type Color is (White, Black);
   type AxisY is new Integer range 1..8;
   type AxisX is ( A, B, C, D, E, F, G, H );
   type Position( Y : AxisY; X : AxisX ) is record
      aYPosition : AxisY := Y;
      aXPosition : AxisX := X;
   end record;
   type Figure is record
      aType : FigureType := Pawn;
      aColor : Color := White;
      aPosition : Position( 5, D );
   end record;
   
   type AccessFigure is access Figure;
   type Square is record
      aColor : Color := White;
      isTaken : Boolean := False;
      aAccessFigure : AccessFigure := null;
   end record;
   
   type TableOfFigures is array (natural range<>, natural range<>) of AccessFigure;
   type DynamicTableOfFigures is access all TableOfFigures;
   type Grid is array (AxisY range 1..8, AxisX range A..H) of Square;
   type ChessBoard is record 
      aGrid : Grid;
      aliveFigures : DynamicTableOfFigures := new TableOfFigures(1..16, 1..2);
   end record;
   
   procedure Main;
   
   function AxisX_to_Integer( aX : AxisX ) return Integer;
   function Integer_to_AxisX( aRowNo : Integer ) return AxisX;

end ModelLayer;
