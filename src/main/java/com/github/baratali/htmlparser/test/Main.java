package com.github.baratali.htmlparser.test;

import org.antlr.v4.runtime.misc.TestRig;

public class Main {

	private static String resourcesDirectory = System.getProperty("user.dir")
			+ "/src/test/resources/com/github/baratali/htmlparser/";

	public static void main(String args[]) throws Exception {
		runTestRigGui("InputTestHtmlParser.html");
	}

	public static void runTestRigGui(String fileName) throws Exception {
		TestRig.main(new String[] { "com.github.baratali.htmlparser.HTML",
				"start", "-tokens", "-gui", resourcesDirectory + fileName });
	}
}
