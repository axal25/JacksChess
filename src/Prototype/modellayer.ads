package ModelLayer is

   type FigureType is ( Pawn, Knight, Bishop, Rook, Queen, King );
   type Color is (White, Black);
   type AxisY is new Integer range 1..8;
   type AxisX is ( A, B, C, D, E, F, G, H );
   type Position is record
      aYPosition : AxisY := 5;
      aXPosition : AxisX := D;
   end record;
   type Figure is record
      aType : FigureType := Pawn;
      aColor : Color := White;
      aPosition : Position;
   end record;
   
   type AccessFigure is access all Figure;
   type Square is record
      aColor : Color := White;
      isTaken : Boolean := False;
      isActivated : Boolean := False;
      isPossibleMove : Boolean := False;
      aAccessFigure : AccessFigure := null;
   end record;
   
   type TableOfFigures is array (natural range<>, natural range<>) of Figure;
   type DynamicTableOfFigures is access all TableOfFigures;
   type IntegerArrayOf2 is array ( 1..2 ) of Integer;
   type AliveFigures is record
      aDynamicTable : DynamicTableOfFigures;
      First : IntegerArrayOf2 := (0,0);
      Last : IntegerArrayOf2 := (0,0);
   end record;
   type Grid is array (AxisY range 1..8, AxisX range A..H) of Square;
   
   type ChessBoard is record 
      aGrid : Grid;
      aAliveFigures : AliveFigures;
   end record;
   
   function Main return ChessBoard;
   function Init_AliveFigures( aAliveFigures : in out AliveFigures ) return AliveFigures;
   function Init_Grid( aGrid : in out Grid; aAliveFigures : AliveFigures ) return Grid;
   function Init_Structure_AliveFigures( First1 : Integer; Last1 : Integer; 
                                         First2 : Integer; Last2 : Integer ) 
                                        return AliveFigures;
   
   function AxisX_to_Integer( aX : AxisX ) return Integer;
   function Integer_to_AxisX( aRowNo : Integer ) return AxisX;
   
   function isWhite( aColor : Color ) return Boolean;
   function isBlack( aColor : Color ) return Boolean;
   
   procedure MoveFigure(  aFigure : in out Figure; 
                          aFromSquare : in out Square; 
                          aToSquare : in out Square );

end ModelLayer;
