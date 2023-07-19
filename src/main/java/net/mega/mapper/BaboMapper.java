package net.mega.mapper;

import java.util.ArrayList;

import net.mega.entities.Category;
import net.mega.entities.Manager;
import net.mega.entities.Menu;
import net.mega.entities.Options;
import net.mega.entities.Orders;
import net.mega.entities.OrdersBoard;

public interface BaboMapper {
	// methods
	public Manager getManager(Manager info);
	
	public ArrayList<Menu> getMenus();
	public ArrayList<Category> getCategories();
	public ArrayList<Options> getOptions();
	public ArrayList<OrdersBoard> getOrders();
	
	public ArrayList<Orders> getCorrespOrders(int order_seq);
	public ArrayList<Menu> getCorrespMenus(Category cat);
	public Category getOneCategory(String category_name);
	public Menu getOneMenu(String menu_seq);
	public Options getCorrespOtions(String menu_seq);

}
