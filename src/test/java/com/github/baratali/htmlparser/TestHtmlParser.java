package com.github.baratali.htmlparser;

import java.io.InputStream;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.junit.Test;

public class TestHtmlParser {

	@Test
	public void test() throws Exception {
		InputStream in = getInputStream("InputTestHtmlParser.html");
		// create a CharStream that reads from standard input
		ANTLRInputStream input = new ANTLRInputStream(in);
		// create a lexer that feeds off of input CharStream
		HTMLLexer lexer = new HTMLLexer(input);
		// create a buffer of tokens pulled from the lexer
		CommonTokenStream tokens = new CommonTokenStream(lexer);
		// create a parser that feeds off the tokens buffer
		HTMLParser parser = new HTMLParser(tokens);
		ParseTree tree = parser.htmlDocument(); // begin parsing at init rule
		System.out.println(tree.toStringTree(parser)); // print LISP-style tree

	}

	public InputStream getInputStream(String fileName) {
		return this.getClass().getResourceAsStream(fileName);
	}

}
