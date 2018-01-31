#include <adminmenu>
#include <morecolors>
#include <sourcemod>
#include <tf2_stocks>
#include <updater>
#undef REQUIRE_PLUGIN
#define VERSION "1.1.2"
#define UPDATE_URL "https://raw.githubusercontent.com/jpenton/OpenDoors/master/update.txt"

new initial;

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
	HookEvent("teamplay_game_over", OnGameEnd);
	HookEvent("tf_game_over", OnGameEnd);
	HookEvent("player_spawn", playerSpawn);
	HookEvent("player_team", playerTeam);
	RegServerCmd("mp_tournament_restart", onTournamentRestart);
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

public OnMapStart()
{
	CreateTimer(30.0, mapStart);
}

public Action:mapStart(Handle:timer)
{
	initial = 0;
	unlockMap();
}

public Action:playerSpawn(Handle:event, String:name[], bool:dontBroadcast)
{
	if (initial == 0)
	{
		CreateTimer(1.0, delayUnlock);
	}
}

public Action:delayUnlock(Handle:timer)
{
	unlockMap();
	initial = 1;
}

public Action:OnGameEnd(Handle:event, String:name[], bool:dontBroadcast)
{
	unlockMap();
}

public Action:onTournamentRestart(args)
{
	unlockMap();
}

public Action:playerTeam(Handle:event, String:name[], bool:dontBroadcast)
{
	if (GetTeamClientCount(2) == 0 && GetTeamClientCount(3) == 0)
	{
		initial = 0;
	}
}

public unlockMap()
{
	decl String:map[32];
	GetCurrentMap(map, sizeof(map));
	if (StrEqual(map, "cp_steel"))
	{
		cp_steel();
	}
	if (StrEqual(map, "pl_badwater") || StrEqual(map, "pl_badwater_pro_v9") || StrEqual(map, "pl_badwater_pro_v11"))
	{
		pl_badwater();
	}
	if (StrEqual(map, "pl_millstone_ugc_7"))
	{
		pl_millstone();
	}
	if (StrEqual(map, "pl_swiftwater_ugc") || StrEqual(map, "pl_swiftwater_final1"))
	{
		pl_swiftwater_ugc();
	}
	if (StrEqual(map, "pl_upward"))
	{
		pl_upward();
	}
}

public cp_steel()
{
	new ent = -1;
	decl String:name[32];
	while ((ent = FindEntityByClassname(ent, "func_door")) != -1)
	{
		GetEntPropString(ent, Prop_Data, "m_iName", name, sizeof(name));
		if (StrEqual(name, "point_a_brushdoor") || StrEqual(name, "point_a_door1") || StrEqual(name, "point_a_door2") || StrEqual(name, "point_a_door3") || StrEqual(name, "point_a_door4") || StrEqual(name, "point_b_door_left") || StrEqual(name, "point_b_door_right") || StrEqual(name, "point_d_door") || StrEqual(name, "red_spawn_door_right"))
		{
			AcceptEntityInput(ent, "Open");
		}
		if (StrEqual(name, "point_b_bridge"))
		{
			AcceptEntityInput(ent, "Close");
		}
	}
	while ((ent = FindEntityByClassname(ent, "func_brush")) != -1)
	{
		GetEntPropString(ent, Prop_Data, "m_iName", name, sizeof(name));
		if (StrEqual(name, "red_spawn1_doorbrush_a") || StrEqual(name, "red_spawn1_doorbrush_b"))
		{
			AcceptEntityInput(ent, "Kill");
		}
	}
}

public pl_badwater()
{
  new ent = -1;
  decl String:name[32];
  while ((ent = FindEntityByClassname(ent, "func_door")) != -1)
  {
    GetEntPropString(ent, Prop_Data, "m_iName", name, sizeof(name));
    if (StrEqual(name, "cap1_gate_1_door") || StrEqual(name, "cap1_gate_2_door") || StrEqual(name, "cap1_gate_3_door") || StrEqual(name, "cap1_gate_4_door") || StrEqual(name, "cap1_gate_5_door") || StrEqual(name, "cap1_gate_6_door") || StrEqual(name, "cap1_gate_7_door") || StrEqual(name, "cap1_gate_8_door") || StrEqual(name, "cap1_gate_9_door") || StrEqual(name, "cap1_gate_10_door") || StrEqual(name, "cap1_gate_11_door") || StrEqual(name, "cap1_gate_12_door") || StrEqual(name, "cap2_gate_1_door") || StrEqual(name, "cap2_gate_2_door") || StrEqual(name, "cap2_gate_3_door") || StrEqual(name, "cap2_gate_4_door") || StrEqual(name, "cap2_gate_5_door") || StrEqual(name, "cap2_gate_6_door") || StrEqual(name, "cap2_sign2_door") || StrEqual(name, "cap3_gate_1_door") || StrEqual(name, "cap3_gate_2_door") || StrEqual(name, "cap3_gate_3_door") || StrEqual(name, "cap3_gate_4_door") || StrEqual(name, "door1_door") || StrEqual(name, "door2_door") || StrEqual(name, "window_block_door1") || StrEqual(name, "window_block_door2") || StrEqual(name, "window_block_door3"))
    {
      AcceptEntityInput(ent, "Kill");
    }
  }
}

public pl_millstone()
{
  new ent = -1;
  decl String:name[32];
  while ((ent = FindEntityByClassname(ent, "func_door")) != -1)
  {
    GetEntPropString(ent, Prop_Data, "m_iName", name, sizeof(name));
    if (StrEqual(name, "cc_door") || StrEqual(name, "e_doorway") || StrEqual(name, "portti_sidec_oikea") || StrEqual(name, "portti_sidec_vasen") || StrEqual(name, "portti_2_oikea") || StrEqual(name, "portti_2_vasen") || StrEqual(name, "portti_3_oikea") || StrEqual(name, "portti_3_vasen") || StrEqual(name, "red_blockdoor") || StrEqual(name, "red_doorblock"))
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
		if (StrEqual(name, "cp_3_destroy_door") || StrEqual(name, "shortcut_stage_3_brush_1") || StrEqual(name, "shortcut_stage_3_brush_2") || StrEqual(name, "shortcut_stage_3_brush_3") || StrEqual(name, "shortcut_stage_3_brush_4") || StrEqual(name, "shortcut_stage_3_brush_5") || StrEqual(name, "shortcut_stage_3_brush_6") || StrEqual(name, "stage_2_dynamic_door_1") || StrEqual(name, "stage_2_shortcut_door") || StrEqual(name, "stage_4_door_entry"))
		{
			AcceptEntityInput(ent, "Kill");
		}
	}
	while ((ent = FindEntityByClassname(ent, "func_door")) != -1)
	{
		GetEntPropString(ent, Prop_Data, "m_iName", name, sizeof(name));
		if (StrEqual(name, "blue_spawn_2_door_1a") || StrEqual(name, "blue_spawn_2_door_1b") || StrEqual(name, "blue_spawn_2_door_2a") || StrEqual(name, "blue_spawn_2_door_2b") || StrEqual(name, "blue_spawn_2_door_3a") || StrEqual(name, "blue_spawn_2_door_3b") || StrEqual(name, "blue_spawn_2_door_4a") || StrEqual(name, "blue_spawn_2_door_4b") || StrEqual(name, "red_spawn_door_exit_1_down") || StrEqual(name, "red_spawn_door_exit_2_down") || StrEqual(name, "red_spawn_door_exit_3_down") || StrEqual(name, "red_spawn_door_exit_4_down") || StrEqual(name, "red_spawn_door_exit_5_down") || StrEqual(name, "shortcut_door_stage_2_left") || StrEqual(name, "shortcut_door_stage_2_right") || StrEqual(name, "shortcut_door_stage_3_right") || StrEqual(name, "shortcut_door_stage_3_left") || StrEqual(name, "stage_1_2_oneway_door") || StrEqual(name, "stage3_shortcut_door_1a") || StrEqual(name, "stage3_shortcut_door_1b"))
		{
			AcceptEntityInput(ent, "Open");
		}
		if (StrEqual(name, "shortcut_door_stage_4_up") || StrEqual(name, "stage_1_2_oneway_door_left") || StrEqual(name, "stage_1_2_oneway_door_right") || StrEqual(name, "stage_5_shortcut_door_1a") || StrEqual(name, "stage_5_shortcut_door_1b"))
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
		GetEntPropString(ent, Prop_Data, "m_iName", name, sizeof(name));
		if (StrEqual(name, "brush_mid_exitC1_block") || StrEqual(name, "brush_mid_exitC2_block") || StrEqual(name, "door_red_exitC3") || StrEqual(name, "door_red_exitC4"))
		{
			AcceptEntityInput(ent, "Kill");
		}
	}
}
