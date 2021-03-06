﻿/*	CASA Lib for ActionScript 3.0	Copyright (c) 2010, Aaron Clinger & Contributors of CASA Lib	All rights reserved.		Redistribution and use in source and binary forms, with or without	modification, are permitted provided that the following conditions are met:		- Redistributions of source code must retain the above copyright notice,	  this list of conditions and the following disclaimer.		- Redistributions in binary form must reproduce the above copyright notice,	  this list of conditions and the following disclaimer in the documentation	  and/or other materials provided with the distribution.		- Neither the name of the CASA Lib nor the names of its contributors	  may be used to endorse or promote products derived from this software	  without specific prior written permission.		THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE	ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE	LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR	CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF	SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS	INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN	CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE	POSSIBILITY OF SUCH DAMAGE.*/package org.casalib.util;
	import org.casalib.core.UInt;
	import org.casalib.util.NumberUtil;
		/**		Utilities for manipulating and searching Strings.				@author Aaron Clinger		@author Mike Creighton		@author David Nelson		@author Jon Adams
		@version 03/29/10	*/	class StringUtil  {
			inline public static var WHITESPACE:String = " \t\n\r"; /**< Whitespace characters (space, tab, new line and return). */		inline public static var SMALL_WORDS:Array<String> = ["a", "an", "and", "as", "at", "but", "by", "en", "for", "if", "is", "in", "of", "on", "or", "the", "to", "v", "via", "vs"]; /**< The default list of small/short words to be used with {@link #toTitleCase}. */						/**			Transforms source String to title case.						@param source: String to return as title cased.			@param lowerCaseSmallWords: Indicates to make {@link #SMALL_WORDS small words} lower case <code>true</code>, or to capitalized small words <code>false</code>.			@return String with capitalized words.		*/		public static function toTitleCase(source:String, ?lowerCaseSmallWords:Bool = true):String {			source = StringUtil._checkWords(source, ' ', true, lowerCaseSmallWords);						var parts:Array<String> = source.split(' ');			var last:Int    = parts.length - 1;						if (!StringUtil._isIgnoredWord(parts[0]))				parts[0] = StringUtil._capitalizeFirstLetter(parts[0]);							if (!StringUtil._isIgnoredWord(parts[last]) && (!lowerCaseSmallWords || !StringUtil._isSmallWord(parts[last])))				parts[last] = StringUtil._capitalizeFirstLetter(parts[last]);						source = parts.join(' ');						if (StringUtil.contains(source, ': ') > 0) {				var i:Int = -1;				parts     = source.split(': ');								while (++i < parts.length)					parts[i] = StringUtil._capitalizeFirstLetter(parts[i]);								source = parts.join(': ');			}						return source;		}				static function _checkWords(source:String, delimiter:String, ?checkForDashes:Bool = false, ?lowerCaseSmallWords:Bool = false):String {			var words:Array<String> = source.split(delimiter);			var l:Int       = words.length;			var word:String;						while (l-- > 0) {				word = words[l];								words[l] = StringUtil._checkWord(word, checkForDashes, lowerCaseSmallWords);			}						return words.join(delimiter);		}				static function _checkWord(word:String, checkForDashes:Bool, lowerCaseSmallWords:Bool):String {			if (StringUtil._isIgnoredWord(word))				return word;						if (lowerCaseSmallWords)				if (StringUtil._isSmallWord(word))					return word.toLowerCase();						if (checkForDashes) {				var dashes:Array<String> = ['-', '–', '—'];				var i:Int = -1;				var dashFound:Bool = false;								while (++i < dashes.length) {					if (StringUtil.contains(word, dashes[i]) != 0) {						word = StringUtil._checkWords(word, dashes[i], false, true);						dashFound = true;					}				}								if (dashFound)					return word;			}						return StringUtil._capitalizeFirstLetter(word);		}				static function _isIgnoredWord(word:String):Bool {			var periodIndex:Int = word.indexOf('.');			var upperIndex:Int  = StringUtil.indexOfUpperCase(word);						if (periodIndex != -1 && periodIndex != word.length - 1 || upperIndex != -1 && upperIndex != 0)				return true;						return false;		}				static function _isSmallWord(word:String):Bool {			return ArrayUtil.indexOf(StringUtil.SMALL_WORDS,StringUtil.getLettersFromString(word).toLowerCase()) > -1;		}				static function _capitalizeFirstLetter(source:String):String {			var i:Int = -1;			while (++i < source.length)				if (!StringUtil.isPunctuation(source.charAt(i)))					return StringUtil.replaceAt(source, i, source.charAt(i).toUpperCase());						return source;		}
		
		/**
			Creates an "universally unique" identifier (RFC 4122, version 4).
			
			@return Returns an UUID.
		*/
		public static function uuid():String {
			var specialChars = ['8', '9', 'A', 'B'];
			
			return StringUtil.createRandomIdentifier(8, 15) + '-' + StringUtil.createRandomIdentifier(4, 15) + '-4' + StringUtil.createRandomIdentifier(3, 15) + '-' + specialChars[NumberUtil.randomIntegerWithinRange(0, 3)] + StringUtil.createRandomIdentifier(3, 15) + '-' + StringUtil.createRandomIdentifier(12, 15);
		}
		
		/**
			Creates a random identifier of a specified length and complexity.
			
			@param length: The character length of the random identifier.
			@param radix: The number of unique/allowed values for each character (61 is the maximum complexity).
			@return Returns a random identifier.
			@usageNote For a case-insensitive identifier pass in a max <code>radix</code> of 35, for a numberic identifier pass in a max <code>radix</code> of 9.
		*/
		public static function createRandomIdentifier(length:UInt, radix:UInt = 61):String {
			var characters = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];
			var id:Array<String>   = new Array<String>();
			radix                  = (radix > 61) ? 61 : radix;
			
			while (length-- > 0) {
				id.push(characters[NumberUtil.randomIntegerWithinRange(0, radix)]);
			}
			
			return id.join('');
		}
		
		/**
			Detects URLs in a String and wraps them in a link.
			
			@param source: String in which to automatically wrap links around URLs.
			@param window: The browser window or HTML frame in which to display the URL.
			@param className: An optional CSS class name to add to the link. You can specify multiple classes by seperating the class names with spaces.
			@return Returns the String with any URLs wrapped in a link.
			@see <a href="http://daringfireball.net/2009/11/liberal_regex_for_matching_urls">Read more about the regular expression used by this method.</a>
		*/
		public static function autoLink(source:String, ?window:String = "_blank", ?className:String = null):String {
			var pattern:EReg = ~/\b(([\w-]+\:\/\/?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/)))/g;
			className            = (className != "" && className != null) ? ' class="' + className + '"' : '';
			window               = (window != null) ? ' target="' + window + '"' : '';
			
			return pattern.replace(source, '<a href="$1"' + window + className + '>$1</a>');
		}				/**			Converts all applicable characters to HTML entities.						@param source: String to convert.			@return Returns the converted string.		*/		inline public static function htmlEncode(source:String):String {			return StringTools.htmlEscape(source);		}				/**			Converts all HTML entities to their applicable characters.						@param source: String to convert.			@return Returns the converted string.		*/		inline public static function htmlDecode(source:String):String {			return StringTools.htmlUnescape(source);		}				/**			Determines if String is only comprised of punctuation characters (any character other than the letters or numbers).						@param source: String to check.			@param allowSpaces: Indicates to count spaces as punctuation <code>true</code>, or not to <code>false</code>.			@return Returns <code>true</code> if String is only punctuation; otherwise <code>false</code>.		*/		public static function isPunctuation(source:String, ?allowSpaces:Bool = true):Bool {
			var pAry:Array<String> = ("[-!\"#$%&'()*+,./:;<=>?@[\\]^_`{|}~]").split("");
			if (allowSpaces) pAry.push(" ");
			return !ArrayUtil.retainItems(source.split(""),pAry);		}				/**			Determines if String is only comprised of upper case letters.						@param source: String to check.			@return Returns <code>true</code> if String is only upper case characters; otherwise <code>false</code>.			@usageNote This function counts numbers, spaces, punctuation and special characters as upper case.		*/		inline public static function isUpperCase(source:String):Bool {			return !(source != source.toUpperCase());		}				/**			Determines if String is only comprised of lower case letters.						@param source: String to check.			@return Returns <code>true</code> if String is only lower case characters; otherwise <code>false</code>.			@usageNote This function counts numbers, spaces, punctuation and special characters as lower case.		*/		inline public static function isLowerCase(source:String):Bool {			return !(source != source.toLowerCase());		}				/**			Determines if String is only comprised of numbers.						@param source: String to check.			@return Returns <code>true</code> if String is a number; otherwise <code>false</code>.		*/		public static function isNumber(source:String):Bool {			var trimmed:String = StringUtil.trim(source);						if (source.length == 0 || StringUtil.trim(source).length < source.length){
				return false;
			} else {
				var num = Std.parseFloat(source);
				
				if (Math.isNaN(num)) return false;
				
				if (num != 0) return true;
				
				source = source.toLowerCase();
				
				if (ArrayUtil.retainItems(source.split(""),["0",".","-","x","f"])) return false;
				
				if (!(ArrayUtil.retainItems(source.split(""),["0"])) ) return true;
				
				if (source.length == 1 && source != "0") return false;
				
				if (source.indexOf("0") == -1) return false;
				
				//for -0, -0000...
				if (source.lastIndexOf('-') > 0) return false;
				
				//for 0x0, 0x0000
				var oxo = source.indexOf("0x0");
				if (oxo != -1){
					var noOxO = (source.substr(0,oxo)+source.substr(oxo+3)).split("");
					if (ArrayUtil.retainItems(noOxO,["0",".","-"])) return false;
				}
				
				//for 0.00
				if (StringUtil.contains(source,'.') > 1) return false;
				
				//for 0f, 0.0f...
				var indF = source.indexOf('f');
				if (indF != -1 && indF < source.length-1) return false;
				
				return true;
			}		}				/**			Searches the String for an occurrence of an upper case letter.						@param source: String to search for a upper case letter.			@return The index of the first occurrence of a upper case letter or <code>-1</code>.		*/		public static function indexOfUpperCase(source:String, ?startIndex:UInt = 0):Int {			var letters:Array<String> = source.split('');			var i:Int         = startIndex - 1;						while (++i < letters.length)				if (letters[i] == letters[i].toUpperCase() && letters[i] != letters[i].toLowerCase())					return i;						return -1;		}				/**			Searches the String for an occurrence of a lower case letter.						@param source: String to search for a lower case letter.			@return The index of the first occurrence of a lower case letter or <code>-1</code>.		*/		public static function indexOfLowerCase(source:String, ?startIndex:UInt = 0):Int {			var letters:Array<String> = source.split('');			var i:Int = startIndex - 1;						while (++i < letters.length)				if (letters[i] == letters[i].toLowerCase() && letters[i] != letters[i].toUpperCase())					return i;						return -1;		}				/**			Returns all the numeric characters from a String.						@param source: String to return numbers from.			@return String containing only numbers.		*/		inline public static function getNumbersFromString(source:String):String {			var pattern:EReg = ~/[^0-9]/g;			return pattern.replace(source, "");		}				/**			Returns all the letter characters from a String.						@param source: String to return letters from.			@return String containing only letters.		*/		inline public static function getLettersFromString(source:String):String {
			#if !js			var pattern:EReg = ~/[[:digit:]|[:punct:]|\s]/g;
			#else
			var pattern:EReg = new EReg("[[0-9]|[-!\"#$%&'()*+,./:;<=>?@[\\\\]^_`{|}~]|\\s]",'g');
			#end			return pattern.replace(source, '');		}				/**			Determines if String contains search String.						@param source: String to search in.			@param search: String to search for.			@return Returns the frequency of the search term found in source String.		*/		inline public static function contains(source:String, search:String):UInt {			return source.split(search).length-1;		}				/**			Strips whitespace (or other characters) from the beginning of a String.						@param source: String to remove characters from.			@param removeChars: Characters to strip (case sensitive). Defaults to whitespace characters.			@return String with characters removed.		*/		inline public static function trimLeft(source:String, ?removeChars:String):String {			if (removeChars == null) removeChars = StringUtil.WHITESPACE;
			var pattern:EReg = new EReg('^[' + removeChars + ']+', '');			return pattern.replace(source, '');		}				/**			Strips whitespace (or other characters) from the end of a String.						@param source: String to remove characters from.			@param removeChars: Characters to strip (case sensitive). Defaults to whitespace characters.			@return String with characters removed.		*/		inline public static function trimRight(source:String, ?removeChars:String):String {
			if (removeChars == null) removeChars = StringUtil.WHITESPACE;			var pattern:EReg = new EReg('[' + removeChars + ']+$', '');			return pattern.replace(source, '');		}				/**			Strips whitespace (or other characters) from the beginning and end of a String.						@param source: String to remove characters from.			@param removeChars: Characters to strip (case sensitive). Defaults to whitespace characters.			@return String with characters removed.		*/		inline public static function trim(source:String, ?removeChars:String):String {
			if (removeChars == null) removeChars = StringUtil.WHITESPACE;			var pattern:EReg = new EReg('^[' + removeChars + ']+|[' + removeChars + ']+$', 'g');			return pattern.replace(source, '');		}				/**			Removes additional spaces from String.						@param source: String to remove extra spaces from.			@return String with additional spaces removed.		*/		public static function removeExtraSpaces(source:String):String {			var pattern:EReg = ~/( )+/g;			return StringUtil.trim(pattern.replace(source, ' '), ' ');		}				/**			Removes tabs, linefeeds, carriage returns and spaces from String.						@param source: String to remove whitespace from.			@return String with whitespace removed.		*/		inline public static function removeWhitespace(source:String):String {			var pattern:EReg = new EReg('[' + StringUtil.WHITESPACE + ']', 'g');			return pattern.replace(source, '');		}				/**			Removes characters from a source String.						@param source: String to remove characters from.			@param remove: String describing characters to remove.			@return String with characters removed.		*/		inline public static function remove(source:String, remove:String):String {
			return StringUtil.replace(source, remove, '');		}				/**			Replaces target characters with new characters.						@param source: String to replace characters from.			@param remove: String describing characters to remove.			@param replace: String to replace removed characters.			@return String with characters replaced.		*/		inline public static function replace(source:String, remove:String, replace:String):String {			return source.split(remove).join(replace);		}				/**			Removes a character at a specific index.						@param source: String to remove character from.			@param position: Position of character to remove.			@return String with character removed.		*/		inline public static function removeAt(source:String, position:Int):String {			return StringUtil.replaceAt(source, position, '');		}				/**			Replaces a character at a specific index with new characters.						@param source: String to replace characters from.			@param position: Position of character to replace.			@param replace: String to replace removed character.			@return String with character replaced.		*/		inline public static function replaceAt(source:String, position:Int, replace:String):String {			return source.substr(0,position)+replace+source.substr(position+1);		}				/**			Adds characters at a specific index.						@param source: String to add characters to.			@param position: Position in which to add characters.			@param addition: String to add.			@return String with characters added.		*/		inline public static function addAt(source:String, position:Int, addition:String):String {			return source.substr(0,position)+addition+source.substr(position);		}				/**			Counts the number of words in a String.						@param source: String in which to count words.			@return The amount of words.		*/		public static function getWordCount(source:String):UInt {			return StringUtil.removeExtraSpaces(StringUtil.trim(source)).split(' ').length;		}				/**			Extracts all the unique characters from a source String.						@param source: String to find unique characters within.			@return String containing unique characters from source String.		*/		public static function getUniqueCharacters(source:String):String {			var unique:String = '';			var i:UInt        = 0;			var char:String;						while (i < source.length) {				char = source.charAt(i);								if (unique.indexOf(char) == -1)					unique += char;								i++;			}						return unique;		}	}
