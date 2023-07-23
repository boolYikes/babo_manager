package net.mega.entities;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Preference {
	private String menu_name;
	private int order_age;
	private int count;
}
