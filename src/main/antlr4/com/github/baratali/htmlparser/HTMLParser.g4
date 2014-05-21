/*
 [The "BSD licence"]
 Copyright (c) 2013 Tom Everett
 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
 1. Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.
 3. The name of the author may not be used to endorse or promote products
    derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

parser grammar HTMLParser;

options { tokenVocab=HTMLLexer; }

whiteSpace: (WS | NEW_LINE)+;

start: (javadoc | singleLineComment| multiLineComment| whiteSpace)*;
javadoc  : START_JAVADOC whiteSpace? (tag | htmlElements | htmlChardata)* whiteSpace? END_MULTILINE_COMMENT;
tag: TAG_CUSTOM;

singleLineComment: START_SINGLELINE_COMMENT .*? NEW_LINE?;
multiLineComment: START_MULTILINE_COMMENT .*? END_MULTILINE_COMMENT;

htmlDocument    
    : whiteSpace? xml? whiteSpace? dtd? whiteSpace? scriptlet*  whiteSpace? htmlElements+
    ;

htmlElements
    : htmlMisc* htmlElement htmlMisc*
    ;

htmlElement     
    : htmlOpenTag htmlContent htmlCloseTag
    | htmlSingleCloseTag 
    | htmlOpenTag
    | scriptlet
    | script
    | style
    ;
    
htmlOpenTag
	: TAG_OPEN htmlTagName htmlAttribute* TAG_CLOSE
	;

htmlCloseTag
	: TAG_OPEN TAG_SLASH htmlTagName TAG_CLOSE
	;

htmlSingleCloseTag
	: TAG_OPEN htmlTagName htmlAttribute* TAG_SLASH_CLOSE
	;

htmlContent     
    : htmlChardata? ((htmlElement | xhtmlCDATA | htmlComment) htmlChardata?)*
    ;

htmlAttribute   
    : htmlAttributeName TAG_EQUALS htmlAttributeValue
    | htmlAttributeName
    ;

htmlAttributeName
    : TAG_NAME
    ;

htmlAttributeValue
    : ATTVALUE_VALUE
    ;

htmlTagName
    : TAG_NAME
    ;

htmlChardata    
    : (HTML_TEXT | WS | NEW_LINE)+ 
    ;

htmlMisc        
    : htmlComment 
    | whiteSpace
    ;

htmlComment
    : HTML_COMMENT
    ;

xhtmlCDATA
    : CDATA
    ;

dtd
    : DTD
    ;

xml
    : XML_DECLARATION
    ;

scriptlet
    : SCRIPTLET
    ;

script
    : SCRIPT_OPEN ( SCRIPT_BODY | SCRIPT_SHORT_BODY)
    ;

style
    : STYLE_OPEN ( STYLE_BODY | STYLE_SHORT_BODY)
    ;
