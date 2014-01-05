--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: fn; Type: SCHEMA; Schema: -; Owner: wordpress
--

CREATE SCHEMA fn;


ALTER SCHEMA fn OWNER TO wordpress;

SET search_path = fn, pg_catalog;

--
-- Name: __particular__text__512__idx(text); Type: FUNCTION; Schema: fn; Owner: wordpress
--

CREATE FUNCTION __particular__text__512__idx(text text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT CASE WHEN length($1) <= 500 THEN substring($1,0,500) ELSE NULL END$_$;


ALTER FUNCTION fn.__particular__text__512__idx(text text) OWNER TO wordpress;

--
-- Name: _stock(bigint); Type: FUNCTION; Schema: fn; Owner: postgres
--

CREATE FUNCTION _stock(post_id bigint) RETURNS numeric
    LANGUAGE sql
    AS $_$SELECT
  sum( coalesce( meta_value::numeric, 0 ) )
FROM wp_postmeta
WHERE
  meta_key = '_stock' AND 
  post_id IN (
    SELECT "ID"
    FROM wp_posts
    WHERE ("ID" = $1 AND post_type='product') OR ( post_parent = $1 AND post_type='product_variation')
  )$_$;


ALTER FUNCTION fn._stock(post_id bigint) OWNER TO postgres;

--
-- Name: _transient_wc_attribute_taxonomies(); Type: FUNCTION; Schema: fn; Owner: wordpress
--

CREATE FUNCTION _transient_wc_attribute_taxonomies() RETURNS text
    LANGUAGE plperlu
    AS $_$
use JSON;
my $r = spi_exec_query('SELECT * FROM wp_woocommerce_attribute_taxonomies');
return to_json( $r->{rows} );
$_$;


ALTER FUNCTION fn._transient_wc_attribute_taxonomies() OWNER TO wordpress;

--
-- Name: between(time without time zone, time without time zone, time without time zone); Type: FUNCTION; Schema: fn; Owner: wordpress
--

CREATE FUNCTION "between"("from" time without time zone, "to" time without time zone, it time without time zone) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT
  CASE WHEN (($1 <= $3 OR $1 IS NULL) AND ($3 <= $2 OR $2 IS NULL)) THEN true
       WHEN ($2 < $1 AND (($3 >= $1 OR $1 IS NULL) OR ($2 >= $3 OR $2 IS NULL))) THEN true
       ELSE false
  END;
 $_$;


ALTER FUNCTION fn."between"("from" time without time zone, "to" time without time zone, it time without time zone) OWNER TO wordpress;

--
-- Name: is_attribute(text, text, bigint); Type: FUNCTION; Schema: fn; Owner: wordpress
--

CREATE FUNCTION is_attribute(taxonomy text, name text, post_id bigint) RETURNS boolean
    LANGUAGE sql
    AS $_$
SELECT
  (fn.jpath( '/' || fn.uri_escape($2) || '/is_' || $1, fn.unserialize(meta_value)))[1]::bool
FROM wp_postmeta
WHERE
  post_id = fn.real_post_id($3) AND
  meta_key='_product_attributes'
        
$_$;


ALTER FUNCTION fn.is_attribute(taxonomy text, name text, post_id bigint) OWNER TO wordpress;

--
-- Name: is_positive(numeric); Type: FUNCTION; Schema: fn; Owner: wordpress
--

CREATE FUNCTION is_positive(digit numeric) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT coalesce($1>0, false, true);
$_$;


ALTER FUNCTION fn.is_positive(digit numeric) OWNER TO wordpress;

--
-- Name: jpath(text, text); Type: FUNCTION; Schema: fn; Owner: wordpress
--

CREATE FUNCTION jpath(path text, object text) RETURNS text[]
    LANGUAGE plv8 IMMUTABLE STRICT
    AS $_$
/* Usage: XPath style Javascript object selection

    This is an implementation of the abbreviated syntax of XPath. You can't use axis::nodetest
    No functions are supported other than last()
    Only node name tests are allowed, no nodetype tests. So you can't do text() and node()
    Indices are zero-based, not 1-based

============
    Here are some examples of how it would work:

    jpath(context, "para")	returns context.para
    jpath(context, "*")	returns all values of context (for both arrays and objects)
    jpath(context, "para[0]")	returns context.para[0]
    jpath(context, "para[last()]")	returns context.para[context.para.length]
!\  jpath(context, "*\/para")	returns context[all children].para  
    jpath(context, "/doc/chapter[5]/section[2]")	returns context.doc.chapter[5].section[2]
    jpath(context, "chapter//para")	returns all para elements inside context.chapter
    jpath(context, "//para")	returns all para elements inside context
    jpath(context, "//olist/item")	returns all olist.item elements inside context
    jpath(context, ".")	returns the context
    jpath(context, ".//para")	same as //para
    jpath(context, "//para/..")	returns the parent of all para elements inside context
============

    para                        selects the para child of the context       -- not all para children of the context
    *                           selects all children of the context
    para[0]                     selects the first para child of the context -- same as /para/0
    para[last()]                selects the last para child of the context  -- same as /para/last()
    * /para                     selects all para grandchildren of the context
    /doc/chapter[5]/section[2]  same as /doc/chapter/5/section/2
    chapter//para               selects the para descendants of the chapter children of the context
    //para                      selects all the para descendants of the context
    //olist/item                selects all the item children of having an olist parent under the context
    .                           selects the context
    .//para                     selects the para element descendants of the context
    ..                          selects the parent of the context

    Not done: (and won't be unless someone asks for it)
        chapter[title] selects the chapter children of the context that have one or more title children
        chapter[title="Introduction"] selects the chapter children of the context that have one or more title children with string-value equal to Introduction

    Limitations:
        Cannot handle self-linked structures (e.g. a.x = a )
 */

var jpath = (function() {
    function _u(arr) { for (var a=arr.slice(0), i=1, l=arguments.length; i<l; i++) { a.unshift(arguments[i]); } return a; }
    function merge(a,b) { return a.push.apply(a, b); }
    function jp(obj, path, parents) {
        if (!path.length)           { return [ obj ]; }
        var id = path[0];
        if (id == "..")             { return jp(parents.shift(), path.slice(1), parents); }
        if (typeof obj != "object") { return path.length == 1 && id == "*" ? [ obj ] : []; }
        if (id == "last()")         { return obj.length ? jp(obj[obj.length-1], path.slice(1), _u(parents, obj)) : []; }
        var out = [];
        if (id !== "") { // Find children
                if (obj.hasOwnProperty(id))     { merge(out, jp(obj[id], path.slice(1), _u(parents, obj))); }
                else if (id == "*")             { for (var i in obj) { if (obj.hasOwnProperty(i)) { merge(out, jp(obj[i], path.slice(1), _u(parents, obj))); } } }
        }
        else { // Find desendants
            id = path[1];
            for (var i in obj) { if (obj.hasOwnProperty(i)) {
                if (obj[i].hasOwnProperty(id))  { merge(out, jp(obj[i][id], path.slice(2), _u(parents, obj, obj[i]))); }
                else if (id == "*" || i === id) { merge(out, jp(obj[i],     path.slice(2), _u(parents, obj        ))); }
                else                            { merge(out, jp(obj[i],     path,          _u(parents, obj        ))); }
            } }
        }
        // TODO: Remove duplicates in out
        return out;
    }

    function jpstr(obj, str) {
        if (str.charAt(0) != "/") { str = "/" + str; }  // Add leading slash if required
        var arr = str.replace(/\/+$/, "")               // Remove trailing slashes
                     .replace(/\/\/+/, "//")            // Convert /// -> //
                     .replace(/\[(\d+)\]/, "/$1")       // Convert chapter[0]/para to chapter/0/para
                     .replace(/\/(\.\/)+/g, "/").replace(/^\.\//, "/").replace(/\/\.$/, "")    // Ignore "."
                     .split("/").slice(1);

        var arr2 = [];
        for (var i=0,l=arr.length,depth=0; i<l; i++) {
            if (depth <= 0) { arr2.push(arr[i]); } else { arr2[arr2.length-1] += "/" + arr[i]; }
            var open  = arr[i].match(/\[/g);
            var close = arr[i].match(/\]/g);
            depth += (open ? open.length : 0) - (close ? close.length : 0);
        }

        return jp(obj, arr2, []);
    }

    return jpstr;
})();

var result = jpath( JSON.parse(object), path );
var out    = Array();

for( var i in result ) {
  if (typeof result[i] != "object") out.push( result[i] );
  else out.push( JSON.stringify( result[i] ));
}

return out;

$_$;


ALTER FUNCTION fn.jpath(path text, object text) OWNER TO wordpress;

--
-- Name: json2php(text); Type: FUNCTION; Schema: fn; Owner: wordpress
--

CREATE FUNCTION json2php(json text) RETURNS text
    LANGUAGE plv8 IMMUTABLE STRICT
    AS $$
function serialize(jsonstr) { // Generates a storable representation of a value
  //
  // +   original by: Ates Goral (http://magnetiq.com)
  // +   adapted for IE: Ilia Kantor (http://javascript.ru)

  switch (typeof (jsonstr)) {
  case "number":
    if (isNaN(jsonstr) || !isFinite(jsonstr)) {
      return false;
    } else {
      return (Math.floor(jsonstr) == jsonstr ? "i" : "d") + ":" + jsonstr + ";";
    }
  case "string":
    return "s:" + mb_length(jsonstr) + ":\"" + jsonstr + "\";";
  case "boolean":
    return "b:" + (jsonstr ? "1" : "0") + ";";
  case "object":
    if (jsonstr == null) {
      return "N;";
    } else if (jsonstr instanceof Array) {
      var idxobj = {
        idx: -1
      };
      var map = []
      for (var i = 0; i < jsonstr.length; i++) {
        idxobj.idx++;
        var ser = serialize(jsonstr[i]);

        if (ser) {
          map.push(serialize(idxobj.idx) + ser)
        }
      }

      return "a:" + jsonstr.length + ":{" + map.join("") + "}"

    } else {
      var class_name = get_class(jsonstr);

      if (class_name == undefined) {
        return false;
      }

      var props = new Array();
      for (var prop in jsonstr) {
        var ser = serialize(jsonstr[prop]);

        if (ser) {
          props.push(serialize(prop) + ser);
        }
      }
      return "O:" + class_name.length + ":\"" + class_name + "\":" + props.length + ":{" + props.join("") + "}";
    }
  case "undefined":
    return "N;";
  }

  return false;
} //end serialize

function get_class(obj) { // Returns the name of the class of an object
  //
  // +   original by: Ates Goral (http://magnetiq.com)
  // +   improved by: David James

  if (obj instanceof Object && !(obj instanceof Array) && !(obj instanceof Function) && obj.constructor) {
    var arr = obj.constructor.toString().match(/function\s*(\w+)/);

    if (arr && arr.length == 2) {
      if (arr[1] == 'Object') return 'stdClass';
      else return arr[1];
    }
  }

  return false;
}

function mb_length(str) {
  if (/[абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ]/.test(str)) {
    var counter = 0;
    for (i = 0; str.length > i; i++) {
      if (/[абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ]/.test(str[i])) counter += 2;
      else counter++;
    }
    return counter;
  } else {
    return str.length;
  }
}

return serialize( eval(json) );
$$;


ALTER FUNCTION fn.json2php(json text) OWNER TO wordpress;

--
-- Name: php2json(text); Type: FUNCTION; Schema: fn; Owner: wordpress
--

CREATE FUNCTION php2json(php text) RETURNS text
    LANGUAGE plv8 IMMUTABLE STRICT
    AS $$
/*!
 * php-unserialize-js JavaScript Library
 * https://github.com/bd808/php-unserialize-js
 *
 * Copyright 2013 Bryan Davis and contributors
 * Released under the MIT license
 * http://www.opensource.org/licenses/MIT
 */

/**
 * Parse php serialized data into js objects.
 *
 * @param {String} phpstr Php serialized string to parse
 * @return {mixed} Parsed result
 */
function phpUnserialize (phpstr) {
  var idx = 0
    , rstack = []
    , ridx = 0

    , readLength = function () {
        var del = phpstr.indexOf(':', idx)
          , val = phpstr.substring(idx, del);
        idx = del + 2;
        return parseInt(val);
      } //end readLength

    , parseAsInt = function () {
        var del = phpstr.indexOf(';', idx)
          , val = phpstr.substring(idx, del);
        idx = del + 1;
        return parseInt(val);
      } //end parseAsInt

    , parseAsFloat = function () {
        var del = phpstr.indexOf(';', idx)
          , val = phpstr.substring(idx, del);
        idx = del + 1;
        return parseFloat(val);
      } //end parseAsFloat

    , parseAsBoolean = function () {
        var del = phpstr.indexOf(';', idx)
          , val = phpstr.substring(idx, del);
        idx = del + 1;
        return ("1" === val)? true: false;
      } //end parseAsBoolean

    , parseAsString = function () {
        var len = readLength()
          , utfLen = 0
          , bytes = 0
          , ch
          , val;
        while (bytes < len) {
          ch = phpstr.charCodeAt(idx + utfLen++);
          if (ch <= 0x007F) {
            bytes++;
          } else if (ch > 0x07FF) {
            bytes += 3;
          } else {
            bytes += 2;
          }
        }
        val = phpstr.substring(idx, idx + utfLen);
        idx += utfLen + 2;
        return val;
      } //end parseAsString

    , parseAsArray = function () {
        var len = readLength()
          , resultArray = []
          , resultHash = {}
          , keep = resultArray
          , lref = ridx++
          , key
          , val;

        rstack[lref] = keep;
        for (var i = 0; i < len; i++) {
          key = parseNext();
          val = parseNext();
          if (keep === resultArray && parseInt(key) == i) {
            // store in array version
            resultArray.push(val);
          } else {
            if (keep !== resultHash) {
              // found first non-sequential numeric key
              // convert existing data to hash
              for (var j = 0, alen = resultArray.length; j < alen; j++) {
                resultHash[j] = resultArray[j];
              }
              keep = resultHash;
              rstack[lref] = keep;
            }
            resultHash[key] = val;
          } //end if
        } //end for

        idx++;
        return keep;
      } //end parseAsArray

    , parseAsObject = function () {
        var len = readLength()
          , obj = {}
          , lref = ridx++
          , clazzname = phpstr.substring(idx, idx + len)
          , re_strip = new RegExp("^\u0000(\\*|" + clazzname + ")\u0000")
          , key
          , val;

        rstack[lref] = obj;
        idx += len + 2;
        len = readLength();
        for (var i = 0; i < len; i++) {
          key = parseNext();
          // private members start with "\u0000CLASSNAME\u0000"
          // protected members start with "\u0000*\u0000"
          // we will strip these prefixes
          key = key.replace(re_strip, '');
          val = parseNext();
          obj[key] = val;
        }
        idx++;
        return obj;
      } //end parseAsObject

    , parseAsRef = function () {
        var ref = parseAsInt();
        // php's ref counter is 1-based; our stack is 0-based.
        return rstack[ref - 1];
      } //end parseAsRef

    , readType = function () {
        var type = phpstr.charAt(idx);
        idx += 2;
        return type;
      } //end readType

    , parseNext = function () {
        var type = readType();
        switch (type) {
          case 'i': return parseAsInt();
          case 'd': return parseAsFloat();
          case 'b': return parseAsBoolean();
          case 's': return parseAsString();
          case 'a': return parseAsArray();
          case 'O': return parseAsObject();
          case 'r': return parseAsRef();
          case 'R': return parseAsRef();
          case 'N': return null;
          default:
            throw {
              name: "Parse Error",
              message: "Unknown type '" + type + "' at postion " + (idx - 2)
            }
        } //end switch
    }; //end parseNext

    return parseNext();
} //end phpUnserialize

return JSON.stringify( phpUnserialize(php) );$$;


ALTER FUNCTION fn.php2json(php text) OWNER TO wordpress;

--
-- Name: post_tsv(); Type: FUNCTION; Schema: fn; Owner: wordpress
--

CREATE FUNCTION post_tsv() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (NEW.post_type IN ('product','page','post') ) THEN
        NEW.tsv = fn.post_tsv(NEW."ID");
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION fn.post_tsv() OWNER TO wordpress;

--
-- Name: post_tsv(bigint); Type: FUNCTION; Schema: fn; Owner: wordpress
--

CREATE FUNCTION post_tsv(post_id bigint) RETURNS tsvector
    LANGUAGE plperlu
    AS $_X$  # Сюда, для правильной индексации, должен передаваться ID родительского поста

  my @words;
  my $sth = spi_query( 
    qq(
      SELECT
        CASE
          WHEN meta_key ~ '^attribute_pa_' THEN (
            SELECT CASE WHEN fn.uri_unescape(slug)=name THEN fn.uri_unescape(slug) ELSE fn.uri_unescape(slug) || ' ' || name END::text
            FROM wp_terms
            WHERE fn.uri_unescape(slug)=m.meta_value LIMIT 1
          )
          ELSE meta_value
        END::text AS word
      FROM wp_postmeta m
      WHERE post_id IN (
        SELECT "ID"
        FROM wp_posts
        WHERE ( post_parent = $_[0] AND post_type = 'product_variation') OR "ID" = $_[0] ) AND
              ( meta_key IN ('_sku' , '_seo-title', '_seo-description' ) OR meta_key ~ '^attribute_pa_' OR meta_key ~ '-keywords\$' )
--              ( meta_key IN ('_sku' , '_seo-title', '_seo-description' ) OR meta_key ~ '^attribute_pa_' )
      UNION
      SELECT
      fn.uri_unescape(t.slug) || ' ' || t.name AS word
      FROM wp_terms t, wp_term_taxonomy tt, wp_term_relationships tr, wp_postmeta pm
      WHERE
        (tr.object_id=pm.post_id AND pm.meta_key='_product_attributes') AND
        tr.term_taxonomy_id = tt.term_taxonomy_id AND
        tt.term_id = t.term_id AND
        fn.tax_is_attribute(tt.taxonomy) AND
        NOT EXISTS (
          SELECT true
          FROM wp_postmeta pm
          WHERE
            fn.real_post_id(pm.post_id) = $_[0] AND
            pm.meta_key = 'attribute_'||tt.taxonomy AND
            pm.meta_value = fn.uri_unescape(t.slug)
        ) AND 
        NOT (
          fn.is_attribute('variation',tt.taxonomy,$_[0])
          OR
          fn.is_attribute('changeable',tt.taxonomy,$_[0])
        )
    )
  );
  while (defined ($row = spi_fetchrow($sth))) { push( @words, $row->{word} ) }

  $plan = spi_prepare(
    qq(
      SELECT
        setweight(to_tsvector('russian', coalesce(post_title,'')), 'A') ||
        setweight(to_tsvector('russian', coalesce(regexp_replace(post_content, '(\[[^]]+\])','','g'),'')), 'D') ||
        setweight(to_tsvector('russian', coalesce(\$2)), 'B') AS tsv
      FROM wp_posts WHERE "ID"=\$1
    ),
    'BIGINT',
    'TEXT'
  );

  my $tsv = spi_exec_prepared($plan, $_[0], join(' ',@words))->{rows}->[0]->{tsv};
  spi_freeplan($plan);
  return $tsv;$_X$;


ALTER FUNCTION fn.post_tsv(post_id bigint) OWNER TO wordpress;

--
-- Name: real_post_id(bigint); Type: FUNCTION; Schema: fn; Owner: wordpress
--

CREATE FUNCTION real_post_id(id bigint) RETURNS bigint
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT DISTINCT
  CASE
    WHEN post_type='product_variation' THEN post_parent
    ELSE "ID"
  END
FROM wp_posts
WHERE "ID" = $1
LIMIT 1
$_$;


ALTER FUNCTION fn.real_post_id(id bigint) OWNER TO wordpress;

--
-- Name: tax_is_attribute(text); Type: FUNCTION; Schema: fn; Owner: wordpress
--

CREATE FUNCTION tax_is_attribute(taxonomy text) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
  SELECT ($1 ~ '^pa_')::bool
$_$;


ALTER FUNCTION fn.tax_is_attribute(taxonomy text) OWNER TO wordpress;

--
-- Name: transient_wc_attribute_taxonomies(); Type: FUNCTION; Schema: fn; Owner: wordpress
--

CREATE FUNCTION transient_wc_attribute_taxonomies() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

  INSERT INTO wp_options (option_name, option_value )
  SELECT '_transient_wc_attribute_taxonomies'::text, fn.json2php( fn._transient_wc_attribute_taxonomies() )::text
  WHERE NOT EXISTS (SELECT 1 FROM wp_options WHERE option_name = '_transient_wc_attribute_taxonomies');

  UPDATE wp_options SET option_value = fn.json2php( fn._transient_wc_attribute_taxonomies())
  WHERE option_name = '_transient_wc_attribute_taxonomies';

  RETURN NEW;
END;$$;


ALTER FUNCTION fn.transient_wc_attribute_taxonomies() OWNER TO wordpress;

--
-- Name: unserialize(text); Type: FUNCTION; Schema: fn; Owner: wordpress
--

CREATE FUNCTION unserialize(php text) RETURNS text
    LANGUAGE plv8 IMMUTABLE STRICT
    AS $$
/*!
 * php-unserialize-js JavaScript Library
 * https://github.com/bd808/php-unserialize-js
 *
 * Copyright 2013 Bryan Davis and contributors
 * Released under the MIT license
 * http://www.opensource.org/licenses/MIT
 */

/**
 * Parse php serialized data into js objects.
 *
 * @param {String} phpstr Php serialized string to parse
 * @return {mixed} Parsed result
 */
function phpUnserialize (phpstr) {
  var idx = 0
    , rstack = []
    , ridx = 0

    , readLength = function () {
        var del = phpstr.indexOf(':', idx)
          , val = phpstr.substring(idx, del);
        idx = del + 2;
        return parseInt(val);
      } //end readLength

    , parseAsInt = function () {
        var del = phpstr.indexOf(';', idx)
          , val = phpstr.substring(idx, del);
        idx = del + 1;
        return parseInt(val);
      } //end parseAsInt

    , parseAsFloat = function () {
        var del = phpstr.indexOf(';', idx)
          , val = phpstr.substring(idx, del);
        idx = del + 1;
        return parseFloat(val);
      } //end parseAsFloat

    , parseAsBoolean = function () {
        var del = phpstr.indexOf(';', idx)
          , val = phpstr.substring(idx, del);
        idx = del + 1;
        return ("1" === val)? true: false;
      } //end parseAsBoolean

    , parseAsString = function () {
        var len = readLength()
          , utfLen = 0
          , bytes = 0
          , ch
          , val;
        while (bytes < len) {
          ch = phpstr.charCodeAt(idx + utfLen++);
          if (ch <= 0x007F) {
            bytes++;
          } else if (ch > 0x07FF) {
            bytes += 3;
          } else {
            bytes += 2;
          }
        }
        val = phpstr.substring(idx, idx + utfLen);
        idx += utfLen + 2;
        return val;
      } //end parseAsString

    , parseAsArray = function () {
        var len = readLength()
          , resultArray = []
          , resultHash = {}
          , keep = resultArray
          , lref = ridx++
          , key
          , val;

        rstack[lref] = keep;
        for (var i = 0; i < len; i++) {
          key = parseNext();
          val = parseNext();
          if (keep === resultArray && parseInt(key) == i) {
            // store in array version
            resultArray.push(val);
          } else {
            if (keep !== resultHash) {
              // found first non-sequential numeric key
              // convert existing data to hash
              for (var j = 0, alen = resultArray.length; j < alen; j++) {
                resultHash[j] = resultArray[j];
              }
              keep = resultHash;
              rstack[lref] = keep;
            }
            resultHash[key] = val;
          } //end if
        } //end for

        idx++;
        return keep;
      } //end parseAsArray

    , parseAsObject = function () {
        var len = readLength()
          , obj = {}
          , lref = ridx++
          , clazzname = phpstr.substring(idx, idx + len)
          , re_strip = new RegExp("^\u0000(\\*|" + clazzname + ")\u0000")
          , key
          , val;

        rstack[lref] = obj;
        idx += len + 2;
        len = readLength();
        for (var i = 0; i < len; i++) {
          key = parseNext();
          // private members start with "\u0000CLASSNAME\u0000"
          // protected members start with "\u0000*\u0000"
          // we will strip these prefixes
          key = key.replace(re_strip, '');
          val = parseNext();
          obj[key] = val;
        }
        idx++;
        return obj;
      } //end parseAsObject

    , parseAsRef = function () {
        var ref = parseAsInt();
        // php's ref counter is 1-based; our stack is 0-based.
        return rstack[ref - 1];
      } //end parseAsRef

    , readType = function () {
        var type = phpstr.charAt(idx);
        idx += 2;
        return type;
      } //end readType

    , parseNext = function () {
        var type = readType();
        switch (type) {
          case 'i': return parseAsInt();
          case 'd': return parseAsFloat();
          case 'b': return parseAsBoolean();
          case 's': return parseAsString();
          case 'a': return parseAsArray();
          case 'O': return parseAsObject();
          case 'r': return parseAsRef();
          case 'R': return parseAsRef();
          case 'N': return null;
          default:
            throw {
              name: "Parse Error",
              message: "Unknown type '" + type + "' at postion " + (idx - 2)
            }
        } //end switch
    }; //end parseNext

    return parseNext();
} //end phpUnserialize

return JSON.stringify( phpUnserialize(php) );$$;


ALTER FUNCTION fn.unserialize(php text) OWNER TO wordpress;

--
-- Name: uri_escape(text); Type: FUNCTION; Schema: fn; Owner: wordpress
--

CREATE FUNCTION uri_escape(uri text) RETURNS text
    LANGUAGE plperlu IMMUTABLE
    AS $_X$
use URI::Escape qw(uri_escape_utf8);
my $uri = uri_escape_utf8($_[0]);
$uri =~ s/(%[0-9A-F]{2})/lc($1)/ge;
return $uri;
$_X$;


ALTER FUNCTION fn.uri_escape(uri text) OWNER TO wordpress;

--
-- Name: uri_unescape(text); Type: FUNCTION; Schema: fn; Owner: wordpress
--

CREATE FUNCTION uri_unescape(uri text) RETURNS text
    LANGUAGE plperlu IMMUTABLE
    AS $_X$
use URI::Escape qw(uri_unescape);
use Encode qw(decode);
return decode('utf-8', uri_unescape($_[0]) );
$_X$;


ALTER FUNCTION fn.uri_unescape(uri text) OWNER TO wordpress;

--
-- Name: wp_plainto_tsquery(regconfig, text); Type: FUNCTION; Schema: fn; Owner: wordpress
--

CREATE FUNCTION wp_plainto_tsquery(regconfig, text) RETURNS tsquery
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT plainto_tsquery($1,$2);
$_$;


ALTER FUNCTION fn.wp_plainto_tsquery(regconfig, text) OWNER TO wordpress;

--
-- PostgreSQL database dump complete
--

