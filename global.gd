extends Node


var current_scene = "main_camp_outside"
var transition_scene = false
var transit_to_dining = false
var transit_to_vertical_path = false
var transit_to_tent_path = false
var transit_to_vertical_2 = false
var transit_to_tent_ext = false
var transit_to_tent_path_2 = false
var transit_to_tent = false
var transit_to_tent_ext_2 = false
var transit_to_four_way = false
var transit_to_four_way_2 = false
var transit_to_four_way_3 = false
var transit_to_four_way_4 = false
var transit_to_main_camp_2 = false
var first_time_out_tent = false
var first_time_in_dining = true
var got_map = false
var annoying_ester = 0

var player_cabin_f_start_positionx = 1051
var player_cabin_f_start_positiony = 652

var player_cabin_f_exit_positionx = 1016
var player_cabin_f_exit_positiony = 570

var player_camp_out_positionx = 1338
var player_camp_out_positiony = 489

var player_dining_start_positionx = 1047
var player_dining_start_positiony = 685

var player_dining_exit_positionx = 1241
var player_dining_exit_positiony = 570

var player_vertical_start_positionx = 921
var player_vertical_start_positiony = 808

var player_vertical_exit_positionx = 921
var player_vertical_exit_positiony = 656

var player_tent_path_start_positionx = 730
var player_tent_path_start_positiony = 458

var player_tent_path_exit_positionx = 1020
var player_tent_path_exit_positiony = 845

var player_tent_ext_start_positionx = 1017
var player_tent_ext_start_positiony = 669

var player_tent_ext_exit_positionx = 1014
var player_tent_ext_exit_positiony = 813

var player_main_camp_exit_positionx = 801
var player_main_camp_exit_positiony = 628

var player_four_way_east_positionx = 1201
var player_four_way_east_positiony = 629

var player_first_tent_positionx = 970
var player_first_tent_positiony = 597

var player_tent_positionx = 953
var player_tent_positiony = 621

var game_first_loadin = true
var loadin_world2 = false
var loadin_dining = false
var loadin_vertical_path = false
var loadin_tent_path = false
var loadin_vertical_2 = false
var loadin_tent_ext = false
var loadin_tent_path_2 = false
var loadin_tent = false
var loadin_tent_ext_2 = false
var loadin_four_way = false
var loadin_four_way_2 = false
var loadin_four_way_3 = false
var loadin_four_way_4 = false
var loadin_main_camp_2 = false
var loadin_main_camp = false
var loadin_lake_1 = false
var loadin_lake_2 = false
var loadin_path_to_barley = false
var loadin_path_to_barley_2 = false
var loadin_path_to_barley_3 = false
var loadin_barley_office_ext = false
var loadin_barley_office_ext_2 = false
var loadin_stage = false
var loadout_dining = false
var loadin_barley_office = false
var first_time_in_office = false
var loadin_horizontal_clancy = false
var loadin_horizontal_clancy_2 = false
var loadin_clancy_ext = false

var input_blocked = false
var sprint_blocked = false
var eavesdrop_yes = false
var eavesdrop_day0_finished = false

var sunset = false
