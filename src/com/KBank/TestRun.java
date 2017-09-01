package com.KBank;

import java.util.Vector;
import java.util.Enumeration;
import java.util.StringTokenizer;

public class TestRun{
   public static void main(String[] args) throws Exception {
			java.sql.Connection con=ConnectionPool.getConnection();
			System.out.println("Connection Object:"+con);
		
	}

}
