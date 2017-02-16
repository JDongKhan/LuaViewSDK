package com.core.lua.local.utils;


import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

/**
 * @title 获取泛型的类型
 * @author wangjindong
 */
public class TUtil {
	/**
	 * @title 获取clz父类的泛型类
	 * @author wangjindong
	 * @param clz
	 * @return
	 */
	public static  Class<?> getGenricClassType(Class<?> clz){
		return TUtil.getGenricClassType(clz, 0);
	}
	
	/**
	 * @title 获取clz父类的泛型类
	 * @author wangjindong
	 * @param clz
	 * @param position
	 * @return
	 */
	public static  Class<?> getGenricClassType(Class<?> clz,int position){
		Type type=clz.getGenericSuperclass();
		if(type instanceof ParameterizedType){
			ParameterizedType pt=(ParameterizedType) type;
			Type[] types=pt.getActualTypeArguments();
			if(types.length > position && types[position] instanceof Class){
				return (Class<?>)types[position];
			}
		}
		return (Class<?>) Object.class;
	}
	/**
	 * @title 获取clz父类的泛型类
	 * @author wangjindong
	 * @param clz
	 * @return
	 */
	public static  Class<?>[] getGenricClassTypes(Class<?> clz){
		Type type=clz.getGenericSuperclass();
		Class<?>[] clazzs = null;
		if(type instanceof ParameterizedType){
			ParameterizedType pt=(ParameterizedType) type;
			Type[] types=pt.getActualTypeArguments();
			clazzs = new Class<?>[types.length];
			for(int i = 0; i < types.length;i++){
				Type subType = types[i];
				if(subType instanceof Class){
					clazzs[i] = (Class<?>)subType;
				}
			}
		}
		return clazzs;
	}
		
		
	/**
	 * @title 获取clz第一个带泛型的接口的泛型类
	 * @author wangjindong
	 * @param clz
	 * @return
	 */
	public static  Class<?> getGenricInterfaceType(Class<?> clz){
		return TUtil.getGenricInterfaceType(clz, 0);
	}
	
	/**
	 * @title 获取clz第一个带泛型的接口的泛型类
	 * @author wangjindong
	 * @param clz
	 * @param postiton
	 * @return
	 */
	public static  Class<?> getGenricInterfaceType(Class<?> clz,int postiton){
		Type[] interfaceTypes = clz.getGenericInterfaces();
		for(Type type : interfaceTypes){
			if(type instanceof ParameterizedType){
				ParameterizedType pt=(ParameterizedType) type;
				Type[] types=pt.getActualTypeArguments();
				if(types.length > postiton && types[postiton] instanceof Class){
					return (Class<?>)types[postiton];
				}
			}
		}
		return (Class<?>) Object.class;
	}
	
	/**
	 * @title获取clz带泛型的接口的泛型类
	 * @author wangjindong
	 * @param clz
	 * @return
	 */
	public static  Class<?>[] getGenricInterfaceTypes(Class<?> clz){
		Type[] interfaceTypes = clz.getGenericInterfaces();
		Class<?>[] clazzs = null;
		for(Type type : interfaceTypes){
			if(type instanceof ParameterizedType){
				ParameterizedType pt=(ParameterizedType) type;
				Type[] types=pt.getActualTypeArguments();
				clazzs = new Class<?>[types.length];
				for(int i = 0; i < types.length;i++){
					Type subType = types[i];
					if(subType instanceof Class){
						clazzs[i] = (Class<?>)subType;
					}
				}
			}
		}
		return clazzs;
	}
	
}
