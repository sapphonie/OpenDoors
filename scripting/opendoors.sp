#include <sourcemod>
#include <adminmenu>
#include <tf2_stocks>
#include <updater>
#undef REQUIRE_PLUGIN
#define VERSION "1.0"
#define UPDATE_URL "http://computervps.duckdns.org/OpenDoors/update.txt"

public Plugin:myinfo =
{
	name = "[TF2] Open Doors",
	description = "Opens doors locked to control points.",
	author = "Computer",
	version = VERSION,
	url = "http://steamcommunity.com/id/computer_/"
};

public OnPluginStart()
{
	RegAdminCmd("sm_opendoors", command_opendoors, ADMFLAG_KICK);

	if (LibraryExists("updater"))
    {
        Updater_AddPlugin(UPDATE_URL)
    }
}

public OnLibraryAdded(const String:name[])
{
    if (StrEqual(name, "updater"))
    {
        Updater_AddPlugin(UPDATE_URL)
    }
}

public Action:command_opendoors(client, args)
{
  decl String:map[32];
  GetCurrentMap(map, sizeof(map));
  if (StrEqual(map, "cp_steel"))
  {
		cp_steel();
  }
  if (StrEqual(map, "pl_badwater_pro_v9"))
  {
    pl_badwater_pro_v9();
  }
  if (StrEqual(map, "pl_swiftwater_ugc"))
  {
		pl_swiftwater_ugc();
  }
  if (StrEqual(map, "pl_upward"))
  {
    pl_upward();
  }
  return Plugin_Handled;
}

public cp_steel()
{
	new ent = -1;
	decl String:name[32];
	while ((ent = FindEntityByClassname(ent, "func_door")) != -1)
	{
		GetEntPropString(ent, Prop_Data, "m_iName", name, sizeof(name));
		if (StrEqual(name, "point_a_door1") || StrEqual(name, "point_a_door2") || StrEqual(name, "point_a_door3") || StrEqual(name, "point_a_door4") || StrEqual(name, "point_a_brushdoor") || StrEqual(name, "point_b_door_left") || StrEqual(name, "point_b_door_right"))
		{
			AcceptEntityInput(ent, "Open");
		}
		if (StrEqual(name, "point_b_bridge"))
		{
			AcceptEntityInput(ent, "Close");
		}
	}
}

public pl_badwater_pro_v9()
{
  new ent = -1;
  decl String:name[32];
  while ((ent = FindEntityByClassname(ent, "func_door")) != -1)
  {
    GetEntPropString(ent, Prop_Data, "m_iName", name, sizeof(name));
    if (StrEqual(name, "cap1_gate_1_door") || StrEqual(name, "cap1_gate_2_door") || StrEqual(name, "cap1_gate_9_door") || StrEqual(name, "cap1_gate_10_door") || StrEqual(name, "cap1_gate_11_door") || StrEqual(name, "cap1_gate_12_door") || StrEqual(name, "door1_door") || StrEqual(name, "cap2_gate_1_door") || StrEqual(name, "cap2_gate_2_door") || StrEqual(name, "cap1_gate_7_door") || StrEqual(name, "cap1_gate_8_door") || StrEqual(name, "cap3_gate_1_door") || StrEqual(name, "cap3_gate_2_door") || StrEqual(name, "cap3_gate_3_door") || StrEqual(name, "cap3_gate_4_door") || StrEqual(name, "cap1_gate_5_door") || StrEqual(name, "cap1_gate_6_door") || StrEqual(name, "cap2_gate_5_door") || StrEqual(name, "cap2_gate_6_door") || StrEqual(name, "cap2_sign2_door") || StrEqual(name, "window_block_door1") || StrEqual(name, "window_block_door2") || StrEqual(name, "window_block_door3"))
    {
      AcceptEntityInput(ent, "Kill");
    }
  }
}

public pl_swiftwater_ugc()
{
	new ent = -1;
	decl String:name[32];
	while ((ent = FindEntityByClassname(ent, "func_brush")) != -1)
	{
		GetEntPropString(ent, Prop_Data, "m_iName", name, sizeof(name));
		if (StrEqual(name, "shortcut_stage_3_brush_1") || StrEqual(name, "cp_3_destroy_door") || StrEqual(name, "shortcut_stage_3_brush_6") || StrEqual(name, "shortcut_stage_3_brush_3") || StrEqual(name, "shortcut_stage_3_brush_5") || StrEqual(name, "shortcut_stage_3_brush_4") || StrEqual(name, "stage_2_dynamic_door_1") || StrEqual(name, "stage_2_shortcut_door") || StrEqual(name, "shortcut_stage_3_brush_2"))
		{
			AcceptEntityInput(ent, "Kill");
		}
	}
	while ((ent = FindEntityByClassname(ent, "func_door")) != -1)
	{
		GetEntPropString(ent, Prop_Data, "m_iName", name, sizeof(name));
		if (StrEqual(name, "shortcut_door_stage_4_up") || StrEqual(name, "stage_5_shortcut_door_1b") || StrEqual(name, "stage_5_shortcut_door_1a"))
		{
			AcceptEntityInput(ent, "Kill");
		}
	}
}

public pl_upward()
{
	new ent = -1;
	decl String:name[32];
	while ((ent = FindEntityByClassname(ent, "func_brush")) != -1)
  {
		if (StrEqual(name, "door_red_exitC3") || StrEqual(name, "door_red_exitC4") || StrEqual(name, "brush_mid_exitC1_block") || StrEqual(name, "brush_mid_exitC2_block"))
		{
			AcceptEntityInput(ent, "Kill");
		}
  }
}
