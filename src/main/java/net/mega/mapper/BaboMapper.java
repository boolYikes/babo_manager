package net.mega.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import net.mega.entities.Category;
import net.mega.entities.Manager;
import net.mega.entities.Menu;
import net.mega.entities.MenuQuery;
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
	public Menu getOneMenu(@Param("menu_ident")String menu_ident);
	public Options getCorrespOtions(long menu_seq);
	public int delCorrespMenu(MenuQuery menu);
	public int updateMenu(@Param("targetID")long menu_seq, @Param("input")MenuQuery menu);
	public int insertMenu(MenuQuery menu);

}
