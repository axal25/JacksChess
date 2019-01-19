pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is

   E072 : Short_Integer; pragma Import (Ada, E072, "system__os_lib_E");
   E013 : Short_Integer; pragma Import (Ada, E013, "system__soft_links_E");
   E025 : Short_Integer; pragma Import (Ada, E025, "system__exception_table_E");
   E068 : Short_Integer; pragma Import (Ada, E068, "ada__io_exceptions_E");
   E052 : Short_Integer; pragma Import (Ada, E052, "ada__strings_E");
   E040 : Short_Integer; pragma Import (Ada, E040, "ada__containers_E");
   E027 : Short_Integer; pragma Import (Ada, E027, "system__exceptions_E");
   E078 : Short_Integer; pragma Import (Ada, E078, "interfaces__c_E");
   E054 : Short_Integer; pragma Import (Ada, E054, "ada__strings__maps_E");
   E058 : Short_Integer; pragma Import (Ada, E058, "ada__strings__maps__constants_E");
   E021 : Short_Integer; pragma Import (Ada, E021, "system__soft_links__initialize_E");
   E080 : Short_Integer; pragma Import (Ada, E080, "system__object_reader_E");
   E047 : Short_Integer; pragma Import (Ada, E047, "system__dwarf_lines_E");
   E039 : Short_Integer; pragma Import (Ada, E039, "system__traceback__symbolic_E");
   E460 : Short_Integer; pragma Import (Ada, E460, "ada__numerics_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "ada__tags_E");
   E105 : Short_Integer; pragma Import (Ada, E105, "ada__streams_E");
   E127 : Short_Integer; pragma Import (Ada, E127, "interfaces__c__strings_E");
   E113 : Short_Integer; pragma Import (Ada, E113, "system__file_control_block_E");
   E112 : Short_Integer; pragma Import (Ada, E112, "system__finalization_root_E");
   E110 : Short_Integer; pragma Import (Ada, E110, "ada__finalization_E");
   E109 : Short_Integer; pragma Import (Ada, E109, "system__file_io_E");
   E133 : Short_Integer; pragma Import (Ada, E133, "system__storage_pools_E");
   E129 : Short_Integer; pragma Import (Ada, E129, "system__finalization_masters_E");
   E139 : Short_Integer; pragma Import (Ada, E139, "system__storage_pools__subpools_E");
   E500 : Short_Integer; pragma Import (Ada, E500, "ada__strings__unbounded_E");
   E413 : Short_Integer; pragma Import (Ada, E413, "system__task_info_E");
   E346 : Short_Integer; pragma Import (Ada, E346, "ada__calendar_E");
   E353 : Short_Integer; pragma Import (Ada, E353, "ada__calendar__delays_E");
   E489 : Short_Integer; pragma Import (Ada, E489, "ada__calendar__time_zones_E");
   E447 : Short_Integer; pragma Import (Ada, E447, "ada__real_time_E");
   E103 : Short_Integer; pragma Import (Ada, E103, "ada__text_io_E");
   E484 : Short_Integer; pragma Import (Ada, E484, "gnat__calendar_E");
   E498 : Short_Integer; pragma Import (Ada, E498, "gnat__calendar__time_io_E");
   E361 : Short_Integer; pragma Import (Ada, E361, "system__assertions_E");
   E135 : Short_Integer; pragma Import (Ada, E135, "system__pool_global_E");
   E524 : Short_Integer; pragma Import (Ada, E524, "system__random_seed_E");
   E427 : Short_Integer; pragma Import (Ada, E427, "system__tasking__initialization_E");
   E435 : Short_Integer; pragma Import (Ada, E435, "system__tasking__protected_objects_E");
   E437 : Short_Integer; pragma Import (Ada, E437, "system__tasking__protected_objects__entries_E");
   E441 : Short_Integer; pragma Import (Ada, E441, "system__tasking__queuing_E");
   E445 : Short_Integer; pragma Import (Ada, E445, "system__tasking__stages_E");
   E122 : Short_Integer; pragma Import (Ada, E122, "glib_E");
   E125 : Short_Integer; pragma Import (Ada, E125, "gtkada__types_E");
   E209 : Short_Integer; pragma Import (Ada, E209, "gdk__frame_timings_E");
   E161 : Short_Integer; pragma Import (Ada, E161, "glib__glist_E");
   E191 : Short_Integer; pragma Import (Ada, E191, "gdk__visual_E");
   E163 : Short_Integer; pragma Import (Ada, E163, "glib__gslist_E");
   E155 : Short_Integer; pragma Import (Ada, E155, "gtkada__c_E");
   E145 : Short_Integer; pragma Import (Ada, E145, "glib__object_E");
   E159 : Short_Integer; pragma Import (Ada, E159, "glib__values_E");
   E157 : Short_Integer; pragma Import (Ada, E157, "glib__types_E");
   E147 : Short_Integer; pragma Import (Ada, E147, "glib__type_conversion_hooks_E");
   E149 : Short_Integer; pragma Import (Ada, E149, "gtkada__bindings_E");
   E169 : Short_Integer; pragma Import (Ada, E169, "cairo_E");
   E474 : Short_Integer; pragma Import (Ada, E474, "cairo__image_surface_E");
   E171 : Short_Integer; pragma Import (Ada, E171, "cairo__region_E");
   E476 : Short_Integer; pragma Import (Ada, E476, "cairo__surface_E");
   E178 : Short_Integer; pragma Import (Ada, E178, "gdk__rectangle_E");
   E176 : Short_Integer; pragma Import (Ada, E176, "glib__generic_properties_E");
   E201 : Short_Integer; pragma Import (Ada, E201, "gdk__color_E");
   E181 : Short_Integer; pragma Import (Ada, E181, "gdk__rgba_E");
   E174 : Short_Integer; pragma Import (Ada, E174, "gdk__event_E");
   E312 : Short_Integer; pragma Import (Ada, E312, "glib__key_file_E");
   E193 : Short_Integer; pragma Import (Ada, E193, "glib__properties_E");
   E274 : Short_Integer; pragma Import (Ada, E274, "glib__string_E");
   E272 : Short_Integer; pragma Import (Ada, E272, "glib__variant_E");
   E270 : Short_Integer; pragma Import (Ada, E270, "glib__g_icon_E");
   E334 : Short_Integer; pragma Import (Ada, E334, "gtk__actionable_E");
   E217 : Short_Integer; pragma Import (Ada, E217, "gtk__builder_E");
   E254 : Short_Integer; pragma Import (Ada, E254, "gtk__buildable_E");
   E286 : Short_Integer; pragma Import (Ada, E286, "gtk__cell_area_context_E");
   E302 : Short_Integer; pragma Import (Ada, E302, "gtk__css_section_E");
   E195 : Short_Integer; pragma Import (Ada, E195, "gtk__enums_E");
   E260 : Short_Integer; pragma Import (Ada, E260, "gtk__orientable_E");
   E314 : Short_Integer; pragma Import (Ada, E314, "gtk__paper_size_E");
   E310 : Short_Integer; pragma Import (Ada, E310, "gtk__page_setup_E");
   E322 : Short_Integer; pragma Import (Ada, E322, "gtk__print_settings_E");
   E225 : Short_Integer; pragma Import (Ada, E225, "gtk__target_entry_E");
   E223 : Short_Integer; pragma Import (Ada, E223, "gtk__target_list_E");
   E230 : Short_Integer; pragma Import (Ada, E230, "pango__enums_E");
   E248 : Short_Integer; pragma Import (Ada, E248, "pango__attributes_E");
   E234 : Short_Integer; pragma Import (Ada, E234, "pango__font_metrics_E");
   E236 : Short_Integer; pragma Import (Ada, E236, "pango__language_E");
   E232 : Short_Integer; pragma Import (Ada, E232, "pango__font_E");
   E328 : Short_Integer; pragma Import (Ada, E328, "gtk__text_attributes_E");
   E330 : Short_Integer; pragma Import (Ada, E330, "gtk__text_tag_E");
   E240 : Short_Integer; pragma Import (Ada, E240, "pango__font_face_E");
   E238 : Short_Integer; pragma Import (Ada, E238, "pango__font_family_E");
   E242 : Short_Integer; pragma Import (Ada, E242, "pango__fontset_E");
   E244 : Short_Integer; pragma Import (Ada, E244, "pango__matrix_E");
   E228 : Short_Integer; pragma Import (Ada, E228, "pango__context_E");
   E318 : Short_Integer; pragma Import (Ada, E318, "pango__font_map_E");
   E250 : Short_Integer; pragma Import (Ada, E250, "pango__tabs_E");
   E246 : Short_Integer; pragma Import (Ada, E246, "pango__layout_E");
   E316 : Short_Integer; pragma Import (Ada, E316, "gtk__print_context_E");
   E189 : Short_Integer; pragma Import (Ada, E189, "gdk__display_E");
   E320 : Short_Integer; pragma Import (Ada, E320, "gtk__print_operation_preview_E");
   E292 : Short_Integer; pragma Import (Ada, E292, "gtk__tree_model_E");
   E280 : Short_Integer; pragma Import (Ada, E280, "gtk__entry_buffer_E");
   E278 : Short_Integer; pragma Import (Ada, E278, "gtk__editable_E");
   E276 : Short_Integer; pragma Import (Ada, E276, "gtk__cell_editable_E");
   E258 : Short_Integer; pragma Import (Ada, E258, "gtk__adjustment_E");
   E221 : Short_Integer; pragma Import (Ada, E221, "gtk__style_E");
   E215 : Short_Integer; pragma Import (Ada, E215, "gtk__accel_group_E");
   E207 : Short_Integer; pragma Import (Ada, E207, "gdk__frame_clock_E");
   E211 : Short_Integer; pragma Import (Ada, E211, "gdk__pixbuf_E");
   E298 : Short_Integer; pragma Import (Ada, E298, "gtk__icon_source_E");
   E187 : Short_Integer; pragma Import (Ada, E187, "gdk__screen_E");
   E326 : Short_Integer; pragma Import (Ada, E326, "gtk__text_iter_E");
   E219 : Short_Integer; pragma Import (Ada, E219, "gtk__selection_data_E");
   E203 : Short_Integer; pragma Import (Ada, E203, "gdk__device_E");
   E205 : Short_Integer; pragma Import (Ada, E205, "gdk__drag_contexts_E");
   E199 : Short_Integer; pragma Import (Ada, E199, "gtk__widget_E");
   E304 : Short_Integer; pragma Import (Ada, E304, "gtk__misc_E");
   E197 : Short_Integer; pragma Import (Ada, E197, "gtk__style_provider_E");
   E185 : Short_Integer; pragma Import (Ada, E185, "gtk__settings_E");
   E264 : Short_Integer; pragma Import (Ada, E264, "gdk__window_E");
   E300 : Short_Integer; pragma Import (Ada, E300, "gtk__style_context_E");
   E296 : Short_Integer; pragma Import (Ada, E296, "gtk__icon_set_E");
   E294 : Short_Integer; pragma Import (Ada, E294, "gtk__image_E");
   E290 : Short_Integer; pragma Import (Ada, E290, "gtk__cell_renderer_E");
   E256 : Short_Integer; pragma Import (Ada, E256, "gtk__container_E");
   E266 : Short_Integer; pragma Import (Ada, E266, "gtk__bin_E");
   E252 : Short_Integer; pragma Import (Ada, E252, "gtk__box_E");
   E324 : Short_Integer; pragma Import (Ada, E324, "gtk__status_bar_E");
   E306 : Short_Integer; pragma Import (Ada, E306, "gtk__notebook_E");
   E288 : Short_Integer; pragma Import (Ada, E288, "gtk__cell_layout_E");
   E284 : Short_Integer; pragma Import (Ada, E284, "gtk__cell_area_E");
   E282 : Short_Integer; pragma Import (Ada, E282, "gtk__entry_completion_E");
   E262 : Short_Integer; pragma Import (Ada, E262, "gtk__window_E");
   E183 : Short_Integer; pragma Import (Ada, E183, "gtk__dialog_E");
   E308 : Short_Integer; pragma Import (Ada, E308, "gtk__print_operation_E");
   E268 : Short_Integer; pragma Import (Ada, E268, "gtk__gentry_E");
   E167 : Short_Integer; pragma Import (Ada, E167, "gtk__arguments_E");
   E478 : Short_Integer; pragma Import (Ada, E478, "gdk__cairo_E");
   E371 : Short_Integer; pragma Import (Ada, E371, "glib__menu_model_E");
   E332 : Short_Integer; pragma Import (Ada, E332, "gtk__action_E");
   E336 : Short_Integer; pragma Import (Ada, E336, "gtk__activatable_E");
   E355 : Short_Integer; pragma Import (Ada, E355, "gtk__alignment_E");
   E165 : Short_Integer; pragma Import (Ada, E165, "gtk__button_E");
   E119 : Short_Integer; pragma Import (Ada, E119, "button_clicked_E");
   E528 : Short_Integer; pragma Import (Ada, E528, "gtk__button_box_E");
   E480 : Short_Integer; pragma Import (Ada, E480, "gtk__drawing_area_E");
   E357 : Short_Integer; pragma Import (Ada, E357, "gtk__frame_E");
   E526 : Short_Integer; pragma Import (Ada, E526, "gtk__hbutton_box_E");
   E340 : Short_Integer; pragma Import (Ada, E340, "gtk__main_E");
   E338 : Short_Integer; pragma Import (Ada, E338, "exit_main_E");
   E117 : Short_Integer; pragma Import (Ada, E117, "buttondemo_E");
   E363 : Short_Integer; pragma Import (Ada, E363, "gtk__marshallers_E");
   E373 : Short_Integer; pragma Import (Ada, E373, "gtk__menu_item_E");
   E375 : Short_Integer; pragma Import (Ada, E375, "gtk__menu_shell_E");
   E369 : Short_Integer; pragma Import (Ada, E369, "gtk__menu_E");
   E367 : Short_Integer; pragma Import (Ada, E367, "gtk__label_E");
   E530 : Short_Integer; pragma Import (Ada, E530, "gtk__message_dialog_E");
   E377 : Short_Integer; pragma Import (Ada, E377, "gtk__table_E");
   E365 : Short_Integer; pragma Import (Ada, E365, "gtk__tree_view_column_E");
   E344 : Short_Integer; pragma Import (Ada, E344, "firstapplication_E");
   E449 : Short_Integer; pragma Import (Ada, E449, "gtkadatest1_E");
   E451 : Short_Integer; pragma Import (Ada, E451, "gtkadatest2_E");
   E472 : Short_Integer; pragma Import (Ada, E472, "gtkadatest_animation_cairo_canvas_E");
   E459 : Short_Integer; pragma Import (Ada, E459, "gtkadatest_animation_E");
   E482 : Short_Integer; pragma Import (Ada, E482, "gtkadatest_clock_E");
   E457 : Short_Integer; pragma Import (Ada, E457, "main_windows_E");
   E455 : Short_Integer; pragma Import (Ada, E455, "gtkadatutorials_E");
   E453 : Short_Integer; pragma Import (Ada, E453, "gtkadatest_adacore_E");
   E532 : Short_Integer; pragma Import (Ada, E532, "p_cell_E");
   E518 : Short_Integer; pragma Import (Ada, E518, "p_main_window_E");
   E514 : Short_Integer; pragma Import (Ada, E514, "minesweeper_E");
   E342 : Short_Integer; pragma Import (Ada, E342, "windowdemo_E");
   E115 : Short_Integer; pragma Import (Ada, E115, "anothertutorial_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E518 := E518 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "p_main_window__finalize_spec");
      begin
         F1;
      end;
      E532 := E532 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "p_cell__finalize_spec");
      begin
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "main_windows__finalize_body");
      begin
         E457 := E457 - 1;
         F3;
      end;
      declare
         procedure F4;
         pragma Import (Ada, F4, "main_windows__finalize_spec");
      begin
         F4;
      end;
      declare
         procedure F5;
         pragma Import (Ada, F5, "gtkadatest_clock__finalize_body");
      begin
         E482 := E482 - 1;
         F5;
      end;
      declare
         procedure F6;
         pragma Import (Ada, F6, "gtkadatest_animation__finalize_body");
      begin
         E459 := E459 - 1;
         F6;
      end;
      declare
         procedure F7;
         pragma Import (Ada, F7, "gtkadatest_animation_cairo_canvas__finalize_body");
      begin
         E472 := E472 - 1;
         F7;
      end;
      declare
         procedure F8;
         pragma Import (Ada, F8, "gtkadatest_animation_cairo_canvas__finalize_spec");
      begin
         F8;
      end;
      declare
         procedure F9;
         pragma Import (Ada, F9, "gtkadatest2__finalize_body");
      begin
         E451 := E451 - 1;
         F9;
      end;
      declare
         procedure F10;
         pragma Import (Ada, F10, "gtkadatest1__finalize_body");
      begin
         E449 := E449 - 1;
         F10;
      end;
      declare
         procedure F11;
         pragma Import (Ada, F11, "firstapplication__finalize_body");
      begin
         E344 := E344 - 1;
         F11;
      end;
      declare
         procedure F12;
         pragma Import (Ada, F12, "firstapplication__finalize_spec");
      begin
         F12;
      end;
      E365 := E365 - 1;
      declare
         procedure F13;
         pragma Import (Ada, F13, "gtk__tree_view_column__finalize_spec");
      begin
         F13;
      end;
      E377 := E377 - 1;
      declare
         procedure F14;
         pragma Import (Ada, F14, "gtk__table__finalize_spec");
      begin
         F14;
      end;
      E530 := E530 - 1;
      declare
         procedure F15;
         pragma Import (Ada, F15, "gtk__message_dialog__finalize_spec");
      begin
         F15;
      end;
      E367 := E367 - 1;
      declare
         procedure F16;
         pragma Import (Ada, F16, "gtk__label__finalize_spec");
      begin
         F16;
      end;
      E369 := E369 - 1;
      declare
         procedure F17;
         pragma Import (Ada, F17, "gtk__menu__finalize_spec");
      begin
         F17;
      end;
      E375 := E375 - 1;
      declare
         procedure F18;
         pragma Import (Ada, F18, "gtk__menu_shell__finalize_spec");
      begin
         F18;
      end;
      E373 := E373 - 1;
      declare
         procedure F19;
         pragma Import (Ada, F19, "gtk__menu_item__finalize_spec");
      begin
         F19;
      end;
      E526 := E526 - 1;
      declare
         procedure F20;
         pragma Import (Ada, F20, "gtk__hbutton_box__finalize_spec");
      begin
         F20;
      end;
      E357 := E357 - 1;
      declare
         procedure F21;
         pragma Import (Ada, F21, "gtk__frame__finalize_spec");
      begin
         F21;
      end;
      E480 := E480 - 1;
      declare
         procedure F22;
         pragma Import (Ada, F22, "gtk__drawing_area__finalize_spec");
      begin
         F22;
      end;
      E528 := E528 - 1;
      declare
         procedure F23;
         pragma Import (Ada, F23, "gtk__button_box__finalize_spec");
      begin
         F23;
      end;
      E165 := E165 - 1;
      declare
         procedure F24;
         pragma Import (Ada, F24, "gtk__button__finalize_spec");
      begin
         F24;
      end;
      E355 := E355 - 1;
      declare
         procedure F25;
         pragma Import (Ada, F25, "gtk__alignment__finalize_spec");
      begin
         F25;
      end;
      E332 := E332 - 1;
      declare
         procedure F26;
         pragma Import (Ada, F26, "gtk__action__finalize_spec");
      begin
         F26;
      end;
      E371 := E371 - 1;
      declare
         procedure F27;
         pragma Import (Ada, F27, "glib__menu_model__finalize_spec");
      begin
         F27;
      end;
      E189 := E189 - 1;
      E207 := E207 - 1;
      E215 := E215 - 1;
      E199 := E199 - 1;
      E221 := E221 - 1;
      E256 := E256 - 1;
      E258 := E258 - 1;
      E183 := E183 - 1;
      E262 := E262 - 1;
      E280 := E280 - 1;
      E290 := E290 - 1;
      E282 := E282 - 1;
      E284 := E284 - 1;
      E292 := E292 - 1;
      E268 := E268 - 1;
      E300 := E300 - 1;
      E306 := E306 - 1;
      E308 := E308 - 1;
      E324 := E324 - 1;
      declare
         procedure F28;
         pragma Import (Ada, F28, "gtk__gentry__finalize_spec");
      begin
         F28;
      end;
      declare
         procedure F29;
         pragma Import (Ada, F29, "gtk__print_operation__finalize_spec");
      begin
         F29;
      end;
      declare
         procedure F30;
         pragma Import (Ada, F30, "gtk__dialog__finalize_spec");
      begin
         F30;
      end;
      declare
         procedure F31;
         pragma Import (Ada, F31, "gtk__window__finalize_spec");
      begin
         F31;
      end;
      declare
         procedure F32;
         pragma Import (Ada, F32, "gtk__entry_completion__finalize_spec");
      begin
         F32;
      end;
      declare
         procedure F33;
         pragma Import (Ada, F33, "gtk__cell_area__finalize_spec");
      begin
         F33;
      end;
      declare
         procedure F34;
         pragma Import (Ada, F34, "gtk__notebook__finalize_spec");
      begin
         F34;
      end;
      declare
         procedure F35;
         pragma Import (Ada, F35, "gtk__status_bar__finalize_spec");
      begin
         F35;
      end;
      E252 := E252 - 1;
      declare
         procedure F36;
         pragma Import (Ada, F36, "gtk__box__finalize_spec");
      begin
         F36;
      end;
      E266 := E266 - 1;
      declare
         procedure F37;
         pragma Import (Ada, F37, "gtk__bin__finalize_spec");
      begin
         F37;
      end;
      declare
         procedure F38;
         pragma Import (Ada, F38, "gtk__container__finalize_spec");
      begin
         F38;
      end;
      declare
         procedure F39;
         pragma Import (Ada, F39, "gtk__cell_renderer__finalize_spec");
      begin
         F39;
      end;
      E294 := E294 - 1;
      declare
         procedure F40;
         pragma Import (Ada, F40, "gtk__image__finalize_spec");
      begin
         F40;
      end;
      E296 := E296 - 1;
      declare
         procedure F41;
         pragma Import (Ada, F41, "gtk__icon_set__finalize_spec");
      begin
         F41;
      end;
      declare
         procedure F42;
         pragma Import (Ada, F42, "gtk__style_context__finalize_spec");
      begin
         F42;
      end;
      E185 := E185 - 1;
      declare
         procedure F43;
         pragma Import (Ada, F43, "gtk__settings__finalize_spec");
      begin
         F43;
      end;
      E304 := E304 - 1;
      declare
         procedure F44;
         pragma Import (Ada, F44, "gtk__misc__finalize_spec");
      begin
         F44;
      end;
      declare
         procedure F45;
         pragma Import (Ada, F45, "gtk__widget__finalize_spec");
      begin
         F45;
      end;
      E203 := E203 - 1;
      E205 := E205 - 1;
      declare
         procedure F46;
         pragma Import (Ada, F46, "gdk__drag_contexts__finalize_spec");
      begin
         F46;
      end;
      declare
         procedure F47;
         pragma Import (Ada, F47, "gdk__device__finalize_spec");
      begin
         F47;
      end;
      E219 := E219 - 1;
      declare
         procedure F48;
         pragma Import (Ada, F48, "gtk__selection_data__finalize_spec");
      begin
         F48;
      end;
      E187 := E187 - 1;
      declare
         procedure F49;
         pragma Import (Ada, F49, "gdk__screen__finalize_spec");
      begin
         F49;
      end;
      E211 := E211 - 1;
      E298 := E298 - 1;
      declare
         procedure F50;
         pragma Import (Ada, F50, "gtk__icon_source__finalize_spec");
      begin
         F50;
      end;
      declare
         procedure F51;
         pragma Import (Ada, F51, "gdk__pixbuf__finalize_spec");
      begin
         F51;
      end;
      declare
         procedure F52;
         pragma Import (Ada, F52, "gdk__frame_clock__finalize_spec");
      begin
         F52;
      end;
      declare
         procedure F53;
         pragma Import (Ada, F53, "gtk__accel_group__finalize_spec");
      begin
         F53;
      end;
      declare
         procedure F54;
         pragma Import (Ada, F54, "gtk__style__finalize_spec");
      begin
         F54;
      end;
      declare
         procedure F55;
         pragma Import (Ada, F55, "gtk__adjustment__finalize_spec");
      begin
         F55;
      end;
      declare
         procedure F56;
         pragma Import (Ada, F56, "gtk__entry_buffer__finalize_spec");
      begin
         F56;
      end;
      declare
         procedure F57;
         pragma Import (Ada, F57, "gtk__tree_model__finalize_spec");
      begin
         F57;
      end;
      declare
         procedure F58;
         pragma Import (Ada, F58, "gdk__display__finalize_spec");
      begin
         F58;
      end;
      E316 := E316 - 1;
      declare
         procedure F59;
         pragma Import (Ada, F59, "gtk__print_context__finalize_spec");
      begin
         F59;
      end;
      E246 := E246 - 1;
      declare
         procedure F60;
         pragma Import (Ada, F60, "pango__layout__finalize_spec");
      begin
         F60;
      end;
      E250 := E250 - 1;
      declare
         procedure F61;
         pragma Import (Ada, F61, "pango__tabs__finalize_spec");
      begin
         F61;
      end;
      E318 := E318 - 1;
      declare
         procedure F62;
         pragma Import (Ada, F62, "pango__font_map__finalize_spec");
      begin
         F62;
      end;
      E228 := E228 - 1;
      declare
         procedure F63;
         pragma Import (Ada, F63, "pango__context__finalize_spec");
      begin
         F63;
      end;
      E242 := E242 - 1;
      declare
         procedure F64;
         pragma Import (Ada, F64, "pango__fontset__finalize_spec");
      begin
         F64;
      end;
      E238 := E238 - 1;
      declare
         procedure F65;
         pragma Import (Ada, F65, "pango__font_family__finalize_spec");
      begin
         F65;
      end;
      E240 := E240 - 1;
      declare
         procedure F66;
         pragma Import (Ada, F66, "pango__font_face__finalize_spec");
      begin
         F66;
      end;
      E330 := E330 - 1;
      declare
         procedure F67;
         pragma Import (Ada, F67, "gtk__text_tag__finalize_spec");
      begin
         F67;
      end;
      E232 := E232 - 1;
      declare
         procedure F68;
         pragma Import (Ada, F68, "pango__font__finalize_spec");
      begin
         F68;
      end;
      E236 := E236 - 1;
      declare
         procedure F69;
         pragma Import (Ada, F69, "pango__language__finalize_spec");
      begin
         F69;
      end;
      E234 := E234 - 1;
      declare
         procedure F70;
         pragma Import (Ada, F70, "pango__font_metrics__finalize_spec");
      begin
         F70;
      end;
      E248 := E248 - 1;
      declare
         procedure F71;
         pragma Import (Ada, F71, "pango__attributes__finalize_spec");
      begin
         F71;
      end;
      E223 := E223 - 1;
      declare
         procedure F72;
         pragma Import (Ada, F72, "gtk__target_list__finalize_spec");
      begin
         F72;
      end;
      E322 := E322 - 1;
      declare
         procedure F73;
         pragma Import (Ada, F73, "gtk__print_settings__finalize_spec");
      begin
         F73;
      end;
      E310 := E310 - 1;
      declare
         procedure F74;
         pragma Import (Ada, F74, "gtk__page_setup__finalize_spec");
      begin
         F74;
      end;
      E314 := E314 - 1;
      declare
         procedure F75;
         pragma Import (Ada, F75, "gtk__paper_size__finalize_spec");
      begin
         F75;
      end;
      E302 := E302 - 1;
      declare
         procedure F76;
         pragma Import (Ada, F76, "gtk__css_section__finalize_spec");
      begin
         F76;
      end;
      E286 := E286 - 1;
      declare
         procedure F77;
         pragma Import (Ada, F77, "gtk__cell_area_context__finalize_spec");
      begin
         F77;
      end;
      E217 := E217 - 1;
      declare
         procedure F78;
         pragma Import (Ada, F78, "gtk__builder__finalize_spec");
      begin
         F78;
      end;
      E272 := E272 - 1;
      declare
         procedure F79;
         pragma Import (Ada, F79, "glib__variant__finalize_spec");
      begin
         F79;
      end;
      E145 := E145 - 1;
      declare
         procedure F80;
         pragma Import (Ada, F80, "glib__object__finalize_spec");
      begin
         F80;
      end;
      E209 := E209 - 1;
      declare
         procedure F81;
         pragma Import (Ada, F81, "gdk__frame_timings__finalize_spec");
      begin
         F81;
      end;
      E122 := E122 - 1;
      declare
         procedure F82;
         pragma Import (Ada, F82, "glib__finalize_spec");
      begin
         F82;
      end;
      E437 := E437 - 1;
      declare
         procedure F83;
         pragma Import (Ada, F83, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F83;
      end;
      E135 := E135 - 1;
      declare
         procedure F84;
         pragma Import (Ada, F84, "system__pool_global__finalize_spec");
      begin
         F84;
      end;
      E103 := E103 - 1;
      declare
         procedure F85;
         pragma Import (Ada, F85, "ada__text_io__finalize_spec");
      begin
         F85;
      end;
      E500 := E500 - 1;
      declare
         procedure F86;
         pragma Import (Ada, F86, "ada__strings__unbounded__finalize_spec");
      begin
         F86;
      end;
      E139 := E139 - 1;
      declare
         procedure F87;
         pragma Import (Ada, F87, "system__storage_pools__subpools__finalize_spec");
      begin
         F87;
      end;
      E129 := E129 - 1;
      declare
         procedure F88;
         pragma Import (Ada, F88, "system__finalization_masters__finalize_spec");
      begin
         F88;
      end;
      declare
         procedure F89;
         pragma Import (Ada, F89, "system__file_io__finalize_body");
      begin
         E109 := E109 - 1;
         F89;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      System.Restrictions.Run_Time_Restrictions :=
        (Set =>
          (False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, True, False, 
           False, False, False, False, False, True, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False),
         Value => (0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (False, False, False, False, True, True, True, False, 
           True, False, False, True, True, True, True, False, 
           False, False, True, False, True, True, False, True, 
           True, False, True, True, True, True, False, True, 
           False, False, False, True, False, False, True, False, 
           True, False, False, True, False, True, False, True, 
           False, False, False, True, False, False, False, False, 
           False, True, False, True, False, True, True, True, 
           False, False, True, False, True, True, True, False, 
           True, True, False, True, True, True, True, False, 
           False, True, False, False, False, False, False, True, 
           True, False, False, False),
         Count => (0, 0, 0, 0, 0, 2, 4, 0, 0, 0),
         Unknown => (False, False, False, False, False, False, True, False, False, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E025 := E025 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E068 := E068 + 1;
      Ada.Strings'Elab_Spec;
      E052 := E052 + 1;
      Ada.Containers'Elab_Spec;
      E040 := E040 + 1;
      System.Exceptions'Elab_Spec;
      E027 := E027 + 1;
      Interfaces.C'Elab_Spec;
      System.Os_Lib'Elab_Body;
      E072 := E072 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E058 := E058 + 1;
      System.Soft_Links.Initialize'Elab_Body;
      E021 := E021 + 1;
      E013 := E013 + 1;
      System.Object_Reader'Elab_Spec;
      System.Dwarf_Lines'Elab_Spec;
      E047 := E047 + 1;
      E078 := E078 + 1;
      E054 := E054 + 1;
      System.Traceback.Symbolic'Elab_Body;
      E039 := E039 + 1;
      E080 := E080 + 1;
      Ada.Numerics'Elab_Spec;
      E460 := E460 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E006 := E006 + 1;
      Ada.Streams'Elab_Spec;
      E105 := E105 + 1;
      Interfaces.C.Strings'Elab_Spec;
      E127 := E127 + 1;
      System.File_Control_Block'Elab_Spec;
      E113 := E113 + 1;
      System.Finalization_Root'Elab_Spec;
      E112 := E112 + 1;
      Ada.Finalization'Elab_Spec;
      E110 := E110 + 1;
      System.File_Io'Elab_Body;
      E109 := E109 + 1;
      System.Storage_Pools'Elab_Spec;
      E133 := E133 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E129 := E129 + 1;
      System.Storage_Pools.Subpools'Elab_Spec;
      E139 := E139 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E500 := E500 + 1;
      System.Task_Info'Elab_Spec;
      E413 := E413 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E346 := E346 + 1;
      Ada.Calendar.Delays'Elab_Body;
      E353 := E353 + 1;
      Ada.Calendar.Time_Zones'Elab_Spec;
      E489 := E489 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E447 := E447 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E103 := E103 + 1;
      Gnat.Calendar'Elab_Spec;
      E484 := E484 + 1;
      Gnat.Calendar.Time_Io'Elab_Spec;
      E498 := E498 + 1;
      System.Assertions'Elab_Spec;
      E361 := E361 + 1;
      System.Pool_Global'Elab_Spec;
      E135 := E135 + 1;
      System.Random_Seed'Elab_Body;
      E524 := E524 + 1;
      System.Tasking.Initialization'Elab_Body;
      E427 := E427 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E435 := E435 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E437 := E437 + 1;
      System.Tasking.Queuing'Elab_Body;
      E441 := E441 + 1;
      System.Tasking.Stages'Elab_Body;
      E445 := E445 + 1;
      Glib'Elab_Spec;
      Gtkada.Types'Elab_Spec;
      E122 := E122 + 1;
      E125 := E125 + 1;
      Gdk.Frame_Timings'Elab_Spec;
      Gdk.Frame_Timings'Elab_Body;
      E209 := E209 + 1;
      E161 := E161 + 1;
      Gdk.Visual'Elab_Body;
      E191 := E191 + 1;
      E163 := E163 + 1;
      E155 := E155 + 1;
      Glib.Object'Elab_Spec;
      Glib.Values'Elab_Body;
      E159 := E159 + 1;
      E147 := E147 + 1;
      E157 := E157 + 1;
      E149 := E149 + 1;
      Glib.Object'Elab_Body;
      E145 := E145 + 1;
      E169 := E169 + 1;
      E474 := E474 + 1;
      E171 := E171 + 1;
      E476 := E476 + 1;
      E178 := E178 + 1;
      Glib.Generic_Properties'Elab_Spec;
      Glib.Generic_Properties'Elab_Body;
      E176 := E176 + 1;
      Gdk.Color'Elab_Spec;
      E201 := E201 + 1;
      E181 := E181 + 1;
      E174 := E174 + 1;
      E312 := E312 + 1;
      E193 := E193 + 1;
      E274 := E274 + 1;
      Glib.Variant'Elab_Spec;
      Glib.Variant'Elab_Body;
      E272 := E272 + 1;
      E270 := E270 + 1;
      Gtk.Actionable'Elab_Spec;
      E334 := E334 + 1;
      Gtk.Builder'Elab_Spec;
      Gtk.Builder'Elab_Body;
      E217 := E217 + 1;
      E254 := E254 + 1;
      Gtk.Cell_Area_Context'Elab_Spec;
      Gtk.Cell_Area_Context'Elab_Body;
      E286 := E286 + 1;
      Gtk.Css_Section'Elab_Spec;
      Gtk.Css_Section'Elab_Body;
      E302 := E302 + 1;
      E195 := E195 + 1;
      Gtk.Orientable'Elab_Spec;
      E260 := E260 + 1;
      Gtk.Paper_Size'Elab_Spec;
      Gtk.Paper_Size'Elab_Body;
      E314 := E314 + 1;
      Gtk.Page_Setup'Elab_Spec;
      Gtk.Page_Setup'Elab_Body;
      E310 := E310 + 1;
      Gtk.Print_Settings'Elab_Spec;
      Gtk.Print_Settings'Elab_Body;
      E322 := E322 + 1;
      E225 := E225 + 1;
      Gtk.Target_List'Elab_Spec;
      Gtk.Target_List'Elab_Body;
      E223 := E223 + 1;
      E230 := E230 + 1;
      Pango.Attributes'Elab_Spec;
      Pango.Attributes'Elab_Body;
      E248 := E248 + 1;
      Pango.Font_Metrics'Elab_Spec;
      Pango.Font_Metrics'Elab_Body;
      E234 := E234 + 1;
      Pango.Language'Elab_Spec;
      Pango.Language'Elab_Body;
      E236 := E236 + 1;
      Pango.Font'Elab_Spec;
      Pango.Font'Elab_Body;
      E232 := E232 + 1;
      E328 := E328 + 1;
      Gtk.Text_Tag'Elab_Spec;
      Gtk.Text_Tag'Elab_Body;
      E330 := E330 + 1;
      Pango.Font_Face'Elab_Spec;
      Pango.Font_Face'Elab_Body;
      E240 := E240 + 1;
      Pango.Font_Family'Elab_Spec;
      Pango.Font_Family'Elab_Body;
      E238 := E238 + 1;
      Pango.Fontset'Elab_Spec;
      Pango.Fontset'Elab_Body;
      E242 := E242 + 1;
      E244 := E244 + 1;
      Pango.Context'Elab_Spec;
      Pango.Context'Elab_Body;
      E228 := E228 + 1;
      Pango.Font_Map'Elab_Spec;
      Pango.Font_Map'Elab_Body;
      E318 := E318 + 1;
      Pango.Tabs'Elab_Spec;
      Pango.Tabs'Elab_Body;
      E250 := E250 + 1;
      Pango.Layout'Elab_Spec;
      Pango.Layout'Elab_Body;
      E246 := E246 + 1;
      Gtk.Print_Context'Elab_Spec;
      Gtk.Print_Context'Elab_Body;
      E316 := E316 + 1;
      Gdk.Display'Elab_Spec;
      Gtk.Tree_Model'Elab_Spec;
      Gtk.Entry_Buffer'Elab_Spec;
      Gtk.Cell_Editable'Elab_Spec;
      Gtk.Adjustment'Elab_Spec;
      Gtk.Style'Elab_Spec;
      Gtk.Accel_Group'Elab_Spec;
      Gdk.Frame_Clock'Elab_Spec;
      Gdk.Pixbuf'Elab_Spec;
      Gtk.Icon_Source'Elab_Spec;
      Gtk.Icon_Source'Elab_Body;
      E298 := E298 + 1;
      E211 := E211 + 1;
      Gdk.Screen'Elab_Spec;
      Gdk.Screen'Elab_Body;
      E187 := E187 + 1;
      E326 := E326 + 1;
      Gtk.Selection_Data'Elab_Spec;
      Gtk.Selection_Data'Elab_Body;
      E219 := E219 + 1;
      Gdk.Device'Elab_Spec;
      Gdk.Drag_Contexts'Elab_Spec;
      Gdk.Drag_Contexts'Elab_Body;
      E205 := E205 + 1;
      Gdk.Device'Elab_Body;
      E203 := E203 + 1;
      Gtk.Widget'Elab_Spec;
      Gtk.Misc'Elab_Spec;
      Gtk.Misc'Elab_Body;
      E304 := E304 + 1;
      E197 := E197 + 1;
      Gtk.Settings'Elab_Spec;
      Gtk.Settings'Elab_Body;
      E185 := E185 + 1;
      Gdk.Window'Elab_Spec;
      E264 := E264 + 1;
      Gtk.Style_Context'Elab_Spec;
      Gtk.Icon_Set'Elab_Spec;
      Gtk.Icon_Set'Elab_Body;
      E296 := E296 + 1;
      Gtk.Image'Elab_Spec;
      Gtk.Image'Elab_Body;
      E294 := E294 + 1;
      Gtk.Cell_Renderer'Elab_Spec;
      Gtk.Container'Elab_Spec;
      Gtk.Bin'Elab_Spec;
      Gtk.Bin'Elab_Body;
      E266 := E266 + 1;
      Gtk.Box'Elab_Spec;
      Gtk.Box'Elab_Body;
      E252 := E252 + 1;
      Gtk.Status_Bar'Elab_Spec;
      Gtk.Notebook'Elab_Spec;
      E288 := E288 + 1;
      Gtk.Cell_Area'Elab_Spec;
      Gtk.Entry_Completion'Elab_Spec;
      Gtk.Window'Elab_Spec;
      Gtk.Dialog'Elab_Spec;
      Gtk.Print_Operation'Elab_Spec;
      Gtk.Gentry'Elab_Spec;
      Gtk.Status_Bar'Elab_Body;
      E324 := E324 + 1;
      E320 := E320 + 1;
      Gtk.Print_Operation'Elab_Body;
      E308 := E308 + 1;
      Gtk.Notebook'Elab_Body;
      E306 := E306 + 1;
      Gtk.Style_Context'Elab_Body;
      E300 := E300 + 1;
      Gtk.Gentry'Elab_Body;
      E268 := E268 + 1;
      Gtk.Tree_Model'Elab_Body;
      E292 := E292 + 1;
      Gtk.Cell_Area'Elab_Body;
      E284 := E284 + 1;
      Gtk.Entry_Completion'Elab_Body;
      E282 := E282 + 1;
      Gtk.Cell_Renderer'Elab_Body;
      E290 := E290 + 1;
      Gtk.Entry_Buffer'Elab_Body;
      E280 := E280 + 1;
      E278 := E278 + 1;
      E276 := E276 + 1;
      Gtk.Window'Elab_Body;
      E262 := E262 + 1;
      Gtk.Dialog'Elab_Body;
      E183 := E183 + 1;
      Gtk.Adjustment'Elab_Body;
      E258 := E258 + 1;
      Gtk.Container'Elab_Body;
      E256 := E256 + 1;
      Gtk.Style'Elab_Body;
      E221 := E221 + 1;
      Gtk.Widget'Elab_Body;
      E199 := E199 + 1;
      Gtk.Accel_Group'Elab_Body;
      E215 := E215 + 1;
      Gdk.Frame_Clock'Elab_Body;
      E207 := E207 + 1;
      Gdk.Display'Elab_Body;
      E189 := E189 + 1;
      E167 := E167 + 1;
      E478 := E478 + 1;
      Glib.Menu_Model'Elab_Spec;
      Glib.Menu_Model'Elab_Body;
      E371 := E371 + 1;
      Gtk.Action'Elab_Spec;
      Gtk.Action'Elab_Body;
      E332 := E332 + 1;
      Gtk.Activatable'Elab_Spec;
      E336 := E336 + 1;
      Gtk.Alignment'Elab_Spec;
      Gtk.Alignment'Elab_Body;
      E355 := E355 + 1;
      Gtk.Button'Elab_Spec;
      Gtk.Button'Elab_Body;
      E165 := E165 + 1;
      E119 := E119 + 1;
      Gtk.Button_Box'Elab_Spec;
      Gtk.Button_Box'Elab_Body;
      E528 := E528 + 1;
      Gtk.Drawing_Area'Elab_Spec;
      Gtk.Drawing_Area'Elab_Body;
      E480 := E480 + 1;
      Gtk.Frame'Elab_Spec;
      Gtk.Frame'Elab_Body;
      E357 := E357 + 1;
      Gtk.Hbutton_Box'Elab_Spec;
      Gtk.Hbutton_Box'Elab_Body;
      E526 := E526 + 1;
      E340 := E340 + 1;
      E338 := E338 + 1;
      E117 := E117 + 1;
      E363 := E363 + 1;
      Gtk.Menu_Item'Elab_Spec;
      Gtk.Menu_Item'Elab_Body;
      E373 := E373 + 1;
      Gtk.Menu_Shell'Elab_Spec;
      Gtk.Menu_Shell'Elab_Body;
      E375 := E375 + 1;
      Gtk.Menu'Elab_Spec;
      Gtk.Menu'Elab_Body;
      E369 := E369 + 1;
      Gtk.Label'Elab_Spec;
      Gtk.Label'Elab_Body;
      E367 := E367 + 1;
      Gtk.Message_Dialog'Elab_Spec;
      Gtk.Message_Dialog'Elab_Body;
      E530 := E530 + 1;
      Gtk.Table'Elab_Spec;
      Gtk.Table'Elab_Body;
      E377 := E377 + 1;
      Gtk.Tree_View_Column'Elab_Spec;
      Gtk.Tree_View_Column'Elab_Body;
      E365 := E365 + 1;
      Firstapplication'Elab_Spec;
      Firstapplication'Elab_Body;
      E344 := E344 + 1;
      Gtkadatest1'Elab_Spec;
      Gtkadatest1'Elab_Body;
      E449 := E449 + 1;
      Gtkadatest2'Elab_Body;
      E451 := E451 + 1;
      Gtkadatest_Animation_Cairo_Canvas'Elab_Spec;
      Gtkadatest_Animation_Cairo_Canvas'Elab_Body;
      E472 := E472 + 1;
      Gtkadatest_Animation'Elab_Body;
      E459 := E459 + 1;
      Gtkadatest_Clock'Elab_Body;
      E482 := E482 + 1;
      Main_Windows'Elab_Spec;
      Main_Windows'Elab_Body;
      E457 := E457 + 1;
      E455 := E455 + 1;
      E453 := E453 + 1;
      P_Cell'Elab_Spec;
      P_Cell'Elab_Body;
      E532 := E532 + 1;
      P_Main_Window'Elab_Spec;
      P_Main_Window'Elab_Body;
      E518 := E518 + 1;
      E514 := E514 + 1;
      E342 := E342 + 1;
      E115 := E115 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   C:\Users\JackEel\Documents\PWiR\AdaWorkspace\JackSChess\obj\button_clicked.o
   --   C:\Users\JackEel\Documents\PWiR\AdaWorkspace\JackSChess\obj\exit_main.o
   --   C:\Users\JackEel\Documents\PWiR\AdaWorkspace\JackSChess\obj\buttondemo.o
   --   C:\Users\JackEel\Documents\PWiR\AdaWorkspace\JackSChess\obj\firstapplication.o
   --   C:\Users\JackEel\Documents\PWiR\AdaWorkspace\JackSChess\obj\gtkadatest1.o
   --   C:\Users\JackEel\Documents\PWiR\AdaWorkspace\JackSChess\obj\gtkadatest2.o
   --   C:\Users\JackEel\Documents\PWiR\AdaWorkspace\JackSChess\obj\gtkadatest_animation_cairo_canvas.o
   --   C:\Users\JackEel\Documents\PWiR\AdaWorkspace\JackSChess\obj\gtkadatest_animation.o
   --   C:\Users\JackEel\Documents\PWiR\AdaWorkspace\JackSChess\obj\gtkadatest_clock.o
   --   C:\Users\JackEel\Documents\PWiR\AdaWorkspace\JackSChess\obj\main_windows.o
   --   C:\Users\JackEel\Documents\PWiR\AdaWorkspace\JackSChess\obj\gtkadatutorials.o
   --   C:\Users\JackEel\Documents\PWiR\AdaWorkspace\JackSChess\obj\gtkadatest_adacore.o
   --   C:\Users\JackEel\Documents\PWiR\AdaWorkspace\JackSChess\obj\p_cell.o
   --   C:\Users\JackEel\Documents\PWiR\AdaWorkspace\JackSChess\obj\p_main_window.o
   --   C:\Users\JackEel\Documents\PWiR\AdaWorkspace\JackSChess\obj\minesweeper.o
   --   C:\Users\JackEel\Documents\PWiR\AdaWorkspace\JackSChess\obj\windowdemo.o
   --   C:\Users\JackEel\Documents\PWiR\AdaWorkspace\JackSChess\obj\anothertutorial.o
   --   C:\Users\JackEel\Documents\PWiR\AdaWorkspace\JackSChess\obj\main.o
   --   -LC:\Users\JackEel\Documents\PWiR\AdaWorkspace\JackSChess\obj\
   --   -LC:\Users\JackEel\Documents\PWiR\AdaWorkspace\JackSChess\obj\
   --   -LC:\GtkAda\lib\gtkada\gtkada.static\gtkada\
   --   -LC:/gnat/2018/lib/gcc/x86_64-pc-mingw32/7.3.1/adalib/
   --   -static
   --   -shared-libgcc
   --   -shared-libgcc
   --   -lgthread-2.0
   --   -shared-libgcc
   --   -lgnarl
   --   -lgnat
   --   -Xlinker
   --   --stack=0x200000,0x1000
   --   -mthreads
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;
