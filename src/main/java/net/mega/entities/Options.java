package net.mega.entities;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Options {
	private long menu_seq;
	private int op_seq;
	private String op_size_s;
	private String op_size_m;
	private String op_size_l;
	private String op_ice;
	private String op_ice_s;
	private String op_ice_l;
	private String op_shot;
	private String op_shot_s;
	private String op_shot_l;
	private String op_cup;
	private String op_cup_t;
}
