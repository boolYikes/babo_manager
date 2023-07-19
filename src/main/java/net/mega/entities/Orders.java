package net.mega.entities;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Orders {

	private long od_seq;
	private int menu_cnt;
	private String menu_name;
	private int menu_price;
	private char od_size;
	private String od_ice;
	private String od_shot;
	private String od_cup;
	private int order_seq;
}
