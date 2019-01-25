with VisualLayer;
with ModelLayer;
with Gtk.Widget;
with Gtk.Handlers;
with GameTurn;

package ControllerLayer is
   type NaturalAndZero is new Integer range 0..Integer'Last;
   type TableOfPositions is array (NaturalAndZero range <>) of ModelLayer.Position;
   type DynamicTableOfPositions is access all TableOfPositions;
   type PossibleMoves is record
      aDynamicTable : DynamicTableOfPositions := null;
      First : NaturalAndZero := 0;
      Last : NaturalAndZero := 0;
   end record;
   function newPossibleMoves( outterPossibleMoves : in out PossibleMoves; newSize : in NaturalAndZero ) return PossibleMoves;
   function appendPossibleMoves( outterPossibleMoves : in out PossibleMoves; newPosition : in ModelLayer.Position ) return PossibleMoves;
   function appendPossibleMoves( outterPossibleMoves : in out PossibleMoves;
                                 aY : ModelLayer.AxisY; ax : ModelLayer.AxisX )
                                return PossibleMoves;
   function removePossibleMoves( outterPossibleMoves : in out PossibleMoves; aPosition : in ModelLayer.Position ) return PossibleMoves;
   function isPossibleMovesEmpty( outterPossibleMoves : in out PossibleMoves ) return Boolean;
   function PossibleMovesToString( outterPossibleMoves : in out PossibleMoves ) return String;

   procedure ShowPossibleMoves;
   procedure ShowPossibleMove( aPosition : in out ModelLayer.Position );

   procedure HidePossibleMoves;
   procedure HidePossibleMove( aPosition : in out ModelLayer.Position );

   procedure SetDeactive_aActivatedPosition;
   procedure SetActive_aActivatedPosition( aPosition : in ModelLayer.Position );

   procedure Main;
   procedure SetPossibleToActivate;
   procedure DeSetPossibleToActivate;
   procedure ComputerDeactivateOnEmptyPossibleMoves;
   function End_Turn( aTurn : in out GameTurn.Turn ) return GameTurn.Turn;
   function Is_End_of_the_Game( aTurn : GameTurn.Turn ) return Boolean;
   procedure End_of_the_Game( aTurn : in GameTurn.Turn );

   package UserCallback_Position is new Gtk.Handlers.User_Callback( Gtk.Widget.Gtk_Widget_Record, ModelLayer.Position );
   procedure Activate_Button( aPosition : in ModelLayer.Position );
   procedure Activate_Button_Call( Object : access Gtk.Widget.Gtk_Widget_Record'Class; aPosition : in ModelLayer.Position );

   procedure Deactivate_Button;
   procedure Deactivate_Button_Call( Object : access Gtk.Widget.Gtk_Widget_Record'Class; aPosition : in ModelLayer.Position );

   procedure Move_Figure_Call( Object : access Gtk.Widget.Gtk_Widget_Record'Class; aToPosition : in ModelLayer.Position );
   procedure Move_Figure( aToPosition : in ModelLayer.Position );
   function MoveFigureAndFreeInModel( aFromPosition : in ModelLayer.Position; aToPosition : in ModelLayer.Position; aAllData : in out VisualLayer.AllData ) return VisualLayer.AllData;
   procedure ChangeFigureSPostion( oldPosition : ModelLayer.Position; newPosition : ModelLayer.Position );

   procedure FindPossibleMoves( aPosition : in ModelLayer.Position );
   function FindMoves (tmp_AllData : in  VisualLayer.AllData; aPosition : in ModelLayer.Position; aColor :in  ModelLayer.Color) return PossibleMoves;
   function FindPossibleMovesPawn( tmp_AllData : in  VisualLayer.AllData; aPosition : in ModelLayer.Position; inPossibleMoves : in out PossibleMoves ) return PossibleMoves;
   function PawnAttackMoves( tmp_row : in ModelLayer.AxisY; col : in ModelLayer.AxisX ; aColor : in ModelLayer.Color; tmp_AllData : in  VisualLayer.AllData; inPossibleMoves : in out PossibleMoves ) return PossibleMoves;
   function FindPossibleMovesKnight( tmp_AllData : in  VisualLayer.AllData; aPosition : in ModelLayer.Position; inPossibleMoves : in out PossibleMoves ) return PossibleMoves;
   function FindPossibleMovesBishop( tmp_AllData : in  VisualLayer.AllData; aPosition : in ModelLayer.Position; inPossibleMoves : in out PossibleMoves ) return PossibleMoves;
   function FindPossibleMovesRook( tmp_AllData : in  VisualLayer.AllData; aPosition : in ModelLayer.Position; inPossibleMoves : in out PossibleMoves ) return PossibleMoves;
   function FindPossibleMovesKing( tmp_AllData : in  VisualLayer.AllData; aPosition : in ModelLayer.Position; inPossibleMoves : in out PossibleMoves ) return PossibleMoves;
   function kingDangerSquares (tmp_AllData : in  VisualLayer.AllData; aColor :in  ModelLayer.Color) return PossibleMoves;
   function isKingInDanger(tmp_AllData : in  VisualLayer.AllData; aColor :in  ModelLayer.Color; kingPosition : in out ModelLayer.Position) return Boolean;
   function FindPossibleMovesInLine ( tmp_AllData : in  VisualLayer.AllData; inPossibleMoves : in out PossibleMoves; tmp_row : in out ModelLayer.AxisY; tmp_col : in out ModelLayer.AxisX; aColor : in out ModelLayer.Color ) return Boolean;
   function isEnemyOrEmpty( tmp_AllData : in  VisualLayer.AllData; row : in out ModelLayer.AxisY; col : in out ModelLayer.AxisX; aColor : in out ModelLayer.Color ) return Boolean;
   function concatenatePossibleMoves( outterPossibleMoves1 : in PossibleMoves;
                                      outterPossibleMoves2 : in PossibleMoves  )
                                  return PossibleMoves;

   procedure DestroyObject_And_MainQuit( Object: access Gtk.Widget.Gtk_Widget_Record'Class );

   procedure Setup_Task_GameTurn;

end ControllerLayer;
