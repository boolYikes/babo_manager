package net.mega.mapper;

import java.util.ArrayList;

import net.mega.entities.Category;
import net.mega.entities.Manager;
import net.mega.entities.Menu;
import net.mega.entities.Options;

public interface BaboMapper {
	// methods
	public Manager getManager(Manager info);
	public ArrayList<Menu> getMenus();
	public ArrayList<Category> getCategories();
	public ArrayList<Options> getOptions();
}
