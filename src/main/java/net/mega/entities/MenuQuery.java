package net.mega.entities;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MenuQuery {
	private long menu_seq;
	private String menu_name;
	private int menu_price;
	private String menu_desc;
	private String menu_img;
	private int category_seq;
}
