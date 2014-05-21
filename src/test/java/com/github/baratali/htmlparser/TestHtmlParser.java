package com.github.baratali.htmlparser;

import java.io.IOException;
import java.io.InputStream;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ErrorNode;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeVisitor;
import org.antlr.v4.runtime.tree.RuleNode;
import org.antlr.v4.runtime.tree.TerminalNode;
import org.junit.Test;

public class TestHtmlParser {

	@Test
	public void test() throws Exception {
		HTMLParser parser = getParser("InputTestHtmlParser.html");
		ParseTree tree = parser.start();
		tree.accept(new ParseTreeVisitor<Void>() {

			@Override
			public Void visit(ParseTree tree) {
				System.out.println(tree);
				return null;
			}

			@Override
			public Void visitChildren(RuleNode node) {
				System.out.println(node);
				return null;
			}

			@Override
			public Void visitTerminal(TerminalNode node) {
				System.out.println(node);
				return null;
			}

			@Override
			public Void visitErrorNode(ErrorNode node) {
				System.out.println(node);
				return null;
			}

		});
	}

	public HTMLParser getParser(String fileName) throws IOException{
		InputStream in = getInputStream(fileName);
		ANTLRInputStream input = new ANTLRInputStream(in);
		HTMLLexer lexer = new HTMLLexer(input);
		CommonTokenStream tokens = new CommonTokenStream(lexer);
		return new HTMLParser(tokens);
	}

	public InputStream getInputStream(String fileName) {
		return this.getClass().getResourceAsStream(fileName);
	}

}
