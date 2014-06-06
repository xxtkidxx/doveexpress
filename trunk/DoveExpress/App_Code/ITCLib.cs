/// <summary>
/// ITC Lib Create by ITC's team
/// </summary>
using System.Web.UI;
using System.Data;
using System;
using System.ComponentModel;
using System.Text;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Collections;
using System.Configuration;
using System.Xml;
using Telerik.Web.UI;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Net.Configuration;
using System.Net.Mail;
using System.Net;
using System.Globalization;
using System.Text.RegularExpressions;
using System.Web;
using System.IO;
using System.Collections.Generic;
using System.Web.UI.HtmlControls;
using System.Collections.Specialized;
namespace ITCLIB
{
    namespace HtmlStripTags
    {
        public class HtmlHelper
        {
            private static readonly string[][] htmlNamedEntities = new string[][] { 
            new string[] { "&quot;", "\"" },
            new string[] { "&lt;", "<" },
            new string[] { "&gt;", ">" },
            new string[] { "&nbsp;", " " },
            new string[] { "&iexcl;", "¡" },
            new string[] { "&cent;", "¢" },
            new string[] { "&pound;", "£" },
            new string[] { "&curren;", "¤" },
            new string[] { "&yen;", "¥" },
            new string[] { "&brvbar;", "¦" },
            new string[] { "&sect;", "§" },
            new string[] { "&uml;", "¨" },
            new string[] { "&copy;", "©" },
            new string[] { "&ordf;", "ª" },
            new string[] { "&laquo;", "«" },
            new string[] { "&not;", "¬" },
            new string[] { "&shy;", "­" },
            new string[] { "&reg;", "®" },
            new string[] { "&macr;", "¯" },
            new string[] { "&deg;", "°" },
            new string[] { "&plusmn;", "±" },
            new string[] { "&sup2;", "²" },
            new string[] { "&sup3;", "³" },
            new string[] { "&acute;", "´" },
            new string[] { "&micro;", "µ" },
            new string[] { "&para;", "¶" },
            new string[] { "&middot;", "·" },
            new string[] { "&cedil;", "¸" },
            new string[] { "&sup1;", "¹" },
            new string[] { "&ordm;", "º" },
            new string[] { "&raquo;", " »" },
            new string[] { "&frac14;", "¼" },
            new string[] { "&frac12;", "½" },
            new string[] { "&frac34;", "¾" },
            new string[] { "&iquest;", "¿" },
            new string[] { "&Agrave;", "À" },
            new string[] { "&Aacute;", "Á" },
            new string[] { "&Acirc;", "Â" },
            new string[] { "&Atilde;", "Ã" },
            new string[] { "&Auml;", "Ä" },
            new string[] { "&Aring;", "Å" },
            new string[] { "&AElig;", "Æ" },
            new string[] { "&Ccedil;", "Ç" },
            new string[] { "&Egrave;", "È" },
            new string[] { "&Eacute;", "É" },
            new string[] { "&Ecirc;", "Ê" },
            new string[] { "&Euml;", "Ë" },
            new string[] { "&Igrave;", "Ì" },
            new string[] { "&Iacute;", "Í" },
            new string[] { "&Icirc;", "Î" },
            new string[] { "&Iuml;", "Ï" },
            new string[] { "&ETH;", "Ð" },
            new string[] { "&Ntilde;", "Ñ" },
            new string[] { "&Ograve;", "Ò" },
            new string[] { "&Oacute;", "Ó" },
            new string[] { "&Ocirc;", "Ô" },
            new string[] { "&Otilde;", "Õ" },
            new string[] { "&Ouml;", "Ö" },
            new string[] { "&times;", "×" },
            new string[] { "&Oslash;", "Ø" },
            new string[] { "&Ugrave;", "Ù" },
            new string[] { "&Uacute;", "Ú" },
            new string[] { "&Ucirc;", "Û" },
            new string[] { "&Uuml;", "Ü" },
            new string[] { "&Yacute;", "Ý" },
            new string[] { "&THORN;", "Þ" },
            new string[] { "&szlig;", "ß" },
            new string[] { "&agrave;", "à" },
            new string[] { "&aacute;", "á" },
            new string[] { "&acirc;", "â" },
            new string[] { "&atilde;", "ã" },
            new string[] { "&auml;", "ä" },
            new string[] { "&aring;", "å" },
            new string[] { "&aelig;", "æ" },
            new string[] { "&ccedil;", "ç" },
            new string[] { "&egrave;", "è" },
            new string[] { "&eacute;", "é" },
            new string[] { "&ecirc;", "ê" },
            new string[] { "&euml;", "ë" },
            new string[] { "&igrave;", "ì" },
            new string[] { "&iacute;", "í" },
            new string[] { "&icirc;", "î" },
            new string[] { "&iuml;", "ï" },
            new string[] { "&eth;", "ð" },
            new string[] { "&ntilde;", "ñ" },
            new string[] { "&ograve;", "ò" },
            new string[] { "&oacute;", "ó" },
            new string[] { "&ocirc;", "ô" },
            new string[] { "&otilde;", "õ" },
            new string[] { "&ouml;", "ö" },
            new string[] { "&divide;", "÷" },
            new string[] { "&oslash;", "ø" },
            new string[] { "&ugrave;", "ù" },
            new string[] { "&uacute;", "ú" },
            new string[] { "&ucirc;", "û" },
            new string[] { "&uuml;", "ü" },
            new string[] { "&yacute;", "ý" },
            new string[] { "&thorn;", "þ" },
            new string[] { "&yuml;", "ÿ" },
            new string[] { "&OElig;", "Œ" },
            new string[] { "&oelig;", "œ" },
            new string[] { "&Scaron;", "Š" },
            new string[] { "&scaron;", "š" },
            new string[] { "&Yuml;", "Ÿ" },
            new string[] { "&fnof;", "ƒ" },
            new string[] { "&circ;", "ˆ" },
            new string[] { "&tilde;", "˜" },
            new string[] { "&Alpha;", "Α" },
            new string[] { "&Beta;", "Β" },
            new string[] { "&Gamma;", "Γ" },
            new string[] { "&Delta;", "Δ" },
            new string[] { "&Epsilon;", "Ε" },
            new string[] { "&Zeta;", "Ζ" },
            new string[] { "&Eta;", "Η" },
            new string[] { "&Theta;", "Θ" },
            new string[] { "&Iota;", "Ι" },
            new string[] { "&Kappa;", "Κ" },
            new string[] { "&Lambda;", "Λ" },
            new string[] { "&Mu;", "Μ" },
            new string[] { "&Nu;", "Ν" },
            new string[] { "&Xi;", "Ξ" },
            new string[] { "&Omicron;", "Ο" },
            new string[] { "&Pi;", "Π" },
            new string[] { "&Rho;", "Ρ" },
            new string[] { "&Sigma;", "Σ" },
            new string[] { "&Tau;", "Τ" },
            new string[] { "&Upsilon;", "Υ" },
            new string[] { "&Phi;", "Φ" },
            new string[] { "&Chi;", "Χ" },
            new string[] { "&Psi;", "Ψ" },
            new string[] { "&Omega;", "Ω" },
            new string[] { "&alpha;", "α" },
            new string[] { "&beta;", "β" },
            new string[] { "&gamma;", "γ" },
            new string[] { "&delta;", "δ" },
            new string[] { "&epsilon;", "ε" },
            new string[] { "&zeta;", "ζ" },
            new string[] { "&eta;", "η" },
            new string[] { "&theta;", "θ" },
            new string[] { "&iota;", "ι" },
            new string[] { "&kappa;", "κ" },
            new string[] { "&lambda;", "λ" },
            new string[] { "&mu;", "μ" },
            new string[] { "&nu;", "ν" },
            new string[] { "&xi;", "ξ" },
            new string[] { "&omicron;", "ο" },
            new string[] { "&pi;", "π" },
            new string[] { "&rho;", "ρ" },
            new string[] { "&sigmaf;", "ς" },
            new string[] { "&sigma;", "σ" },
            new string[] { "&tau;", "τ" },
            new string[] { "&upsilon;", "υ" },
            new string[] { "&phi;", "φ" },
            new string[] { "&chi;", "χ" },
            new string[] { "&psi;", "ψ" },
            new string[] { "&omega;", "ω" },
            new string[] { "&thetasym;", "ϑ" },
            new string[] { "&upsih;", "ϒ" },
            new string[] { "&piv;", "ϖ" },
            new string[] { "&ensp;", " " },
            new string[] { "&emsp;", " " },
            new string[] { "&thinsp;", " " },
            new string[] { "&zwnj;", "‌" },
            new string[] { "&zwj;", "‍" },
            new string[] { "&lrm;", "‎" },
            new string[] { "&rlm;", "‏" },
            new string[] { "&ndash;", "–" },
            new string[] { "&mdash;", "—" },
            new string[] { "&lsquo;", "‘" },
            new string[] { "&rsquo;", "’" },
            new string[] { "&sbquo;", "‚" },
            new string[] { "&ldquo;", "“" },
            new string[] { "&rdquo;", "”" },
            new string[] { "&bdquo;", "„" },
            new string[] { "&dagger;", "†" },
            new string[] { "&Dagger;", "‡" },
            new string[] { "&bull;", "•" },
            new string[] { "&hellip;", "…" },
            new string[] { "&permil;", "‰" },
            new string[] { "&prime;", "′" },
            new string[] { "&Prime;", "″" },
            new string[] { "&lsaquo;", "‹" },
            new string[] { "&rsaquo;", "›" },
            new string[] { "&oline;", "‾" },
            new string[] { "&frasl;", "⁄" },
            new string[] { "&euro;", "€" },
            new string[] { "&image;", "ℑ" },
            new string[] { "&weierp;", "℘" },
            new string[] { "&real;", "ℜ" },
            new string[] { "&trade;", "™" },
            new string[] { "&alefsym;", "ℵ" },
            new string[] { "&larr;", "←" },
            new string[] { "&uarr;", "↑" },
            new string[] { "&rarr;", "→" },
            new string[] { "&darr;", "↓" },
            new string[] { "&harr;", "↔" },
            new string[] { "&crarr;", "↵" },
            new string[] { "&lArr;", "⇐" },
            new string[] { "&uArr;", "⇑" },
            new string[] { "&rArr;", "⇒" },
            new string[] { "&dArr;", "⇓" },
            new string[] { "&hArr;", "⇔" },
            new string[] { "&forall;", "∀" },
            new string[] { "&part;", "∂" },
            new string[] { "&exist;", "∃" },
            new string[] { "&empty;", "∅" },
            new string[] { "&nabla;", "∇" },
            new string[] { "&isin;", "∈" },
            new string[] { "&notin;", "∉" },
            new string[] { "&ni;", "∋" },
            new string[] { "&prod;", "∏" },
            new string[] { "&sum;", "∑" },
            new string[] { "&minus;", "−" },
            new string[] { "&lowast;", "∗" },
            new string[] { "&radic;", "√" },
            new string[] { "&prop;", "∝" },
            new string[] { "&infin;", "∞" },
            new string[] { "&ang;", "∠" },
            new string[] { "&and;", "∧" },
            new string[] { "&or;", "∨" },
            new string[] { "&cap;", "∩" },
            new string[] { "&cup;", "∪" },
            new string[] { "&int;", "∫" },
            new string[] { "&there4;", "∴" },
            new string[] { "&sim;", "∼" },
            new string[] { "&cong;", "≅" },
            new string[] { "&asymp;", "≈" },
            new string[] { "&ne;", "≠" },
            new string[] { "&equiv;", "≡" },
            new string[] { "&le;", "≤" },
            new string[] { "&ge;", "≥" },
            new string[] { "&sub;", "⊂" },
            new string[] { "&sup;", "⊃" },
            new string[] { "&nsub;", "⊄" },
            new string[] { "&sube;", "⊆" },
            new string[] { "&supe;", "⊇" },
            new string[] { "&oplus;", "⊕" },
            new string[] { "&otimes;", "⊗" },
            new string[] { "&perp;", "⊥" },
            new string[] { "&sdot;", "⋅" },
            new string[] { "&lceil;", "⌈" },
            new string[] { "&rceil;", "⌉" },
            new string[] { "&lfloor;", "⌊" },
            new string[] { "&rfloor;", "⌋" },
            new string[] { "&lang;", "〈" },
            new string[] { "&rang;", "〉" },
            new string[] { "&loz;", "◊" },
            new string[] { "&spades;", "♠" },
            new string[] { "&clubs;", "♣" },
            new string[] { "&hearts;", "♥" },
            new string[] { "&diams;", "♦" },
            new string[] { "&amp;", "&" }
        };

            public static string HtmlStripTags(string htmlContent, bool replaceNamedEntities, bool replaceNumberedEntities)
            {
                if (htmlContent == null)
                    return null;
                htmlContent = htmlContent.Trim();
                if (htmlContent == string.Empty)
                    return string.Empty;

                int bodyStartTagIdx = htmlContent.IndexOf("<body", StringComparison.CurrentCultureIgnoreCase);
                int bodyEndTagIdx = htmlContent.IndexOf("</body>", StringComparison.CurrentCultureIgnoreCase);

                int startIdx = 0, endIdx = htmlContent.Length - 1;
                if (bodyStartTagIdx >= 0)
                    startIdx = bodyStartTagIdx;
                if (bodyEndTagIdx >= 0)
                    endIdx = bodyEndTagIdx;

                bool insideTag = false,
                        insideAttributeValue = false,
                        insideHtmlComment = false,
                        insideScriptBlock = false,
                        insideNoScriptBlock = false,
                        insideStyleBlock = false;
                char attributeValueDelimiter = '"';

                StringBuilder sb = new StringBuilder(htmlContent.Length);
                for (int i = startIdx; i <= endIdx; i++)
                {

                    // html comment block
                    if (!insideHtmlComment)
                    {
                        if (i + 3 < htmlContent.Length &&
                            htmlContent[i] == '<' &&
                            htmlContent[i + 1] == '!' &&
                            htmlContent[i + 2] == '-' &&
                            htmlContent[i + 3] == '-')
                        {
                            i += 3;
                            insideHtmlComment = true;
                            continue;
                        }
                    }
                    else // inside html comment
                    {
                        if (i + 2 < htmlContent.Length &&
                            htmlContent[i] == '-' &&
                            htmlContent[i + 1] == '-' &&
                            htmlContent[i + 2] == '>')
                        {
                            i += 2;
                            insideHtmlComment = false;
                            continue;
                        }
                        else
                            continue;
                    }

                    // noscript block
                    if (!insideNoScriptBlock)
                    {
                        if (i + 9 < htmlContent.Length &&
                            htmlContent[i] == '<' &&
                            (htmlContent[i + 1] == 'n' || htmlContent[i + 1] == 'N') &&
                            (htmlContent[i + 2] == 'o' || htmlContent[i + 2] == 'O') &&
                            (htmlContent[i + 3] == 's' || htmlContent[i + 3] == 'S') &&
                            (htmlContent[i + 4] == 'c' || htmlContent[i + 4] == 'C') &&
                            (htmlContent[i + 5] == 'r' || htmlContent[i + 5] == 'R') &&
                            (htmlContent[i + 6] == 'i' || htmlContent[i + 6] == 'I') &&
                            (htmlContent[i + 7] == 'p' || htmlContent[i + 7] == 'P') &&
                            (htmlContent[i + 8] == 't' || htmlContent[i + 8] == 'T') &&
                            (char.IsWhiteSpace(htmlContent[i + 9]) || htmlContent[i + 9] == '>'))
                        {
                            i += 9;
                            insideNoScriptBlock = true;
                            continue;
                        }
                    }
                    else // inside noscript block
                    {
                        if (i + 10 < htmlContent.Length &&
                            htmlContent[i] == '<' &&
                            htmlContent[i + 1] == '/' &&
                            (htmlContent[i + 2] == 'n' || htmlContent[i + 2] == 'N') &&
                            (htmlContent[i + 3] == 'o' || htmlContent[i + 3] == 'O') &&
                            (htmlContent[i + 4] == 's' || htmlContent[i + 4] == 'S') &&
                            (htmlContent[i + 5] == 'c' || htmlContent[i + 5] == 'C') &&
                            (htmlContent[i + 6] == 'r' || htmlContent[i + 6] == 'R') &&
                            (htmlContent[i + 7] == 'i' || htmlContent[i + 7] == 'I') &&
                            (htmlContent[i + 8] == 'p' || htmlContent[i + 8] == 'P') &&
                            (htmlContent[i + 9] == 't' || htmlContent[i + 9] == 'T') &&
                            (char.IsWhiteSpace(htmlContent[i + 10]) || htmlContent[i + 10] == '>'))
                        {
                            if (htmlContent[i + 10] != '>')
                            {
                                i += 9;
                                while (i < htmlContent.Length && htmlContent[i] != '>')
                                    i++;
                            }
                            else
                                i += 10;
                            insideNoScriptBlock = false;
                        }
                        continue;
                    }

                    // script block
                    if (!insideScriptBlock)
                    {
                        if (i + 7 < htmlContent.Length &&
                            htmlContent[i] == '<' &&
                            (htmlContent[i + 1] == 's' || htmlContent[i + 1] == 'S') &&
                            (htmlContent[i + 2] == 'c' || htmlContent[i + 2] == 'C') &&
                            (htmlContent[i + 3] == 'r' || htmlContent[i + 3] == 'R') &&
                            (htmlContent[i + 4] == 'i' || htmlContent[i + 4] == 'I') &&
                            (htmlContent[i + 5] == 'p' || htmlContent[i + 5] == 'P') &&
                            (htmlContent[i + 6] == 't' || htmlContent[i + 6] == 'T') &&
                            (char.IsWhiteSpace(htmlContent[i + 7]) || htmlContent[i + 7] == '>'))
                        {
                            i += 6;
                            insideScriptBlock = true;
                            continue;
                        }
                    }
                    else // inside script block
                    {
                        if (i + 8 < htmlContent.Length &&
                            htmlContent[i] == '<' &&
                            htmlContent[i + 1] == '/' &&
                            (htmlContent[i + 2] == 's' || htmlContent[i + 2] == 'S') &&
                            (htmlContent[i + 3] == 'c' || htmlContent[i + 3] == 'C') &&
                            (htmlContent[i + 4] == 'r' || htmlContent[i + 4] == 'R') &&
                            (htmlContent[i + 5] == 'i' || htmlContent[i + 5] == 'I') &&
                            (htmlContent[i + 6] == 'p' || htmlContent[i + 6] == 'P') &&
                            (htmlContent[i + 7] == 't' || htmlContent[i + 7] == 'T') &&
                            (char.IsWhiteSpace(htmlContent[i + 8]) || htmlContent[i + 8] == '>'))
                        {
                            if (htmlContent[i + 8] != '>')
                            {
                                i += 7;
                                while (i < htmlContent.Length && htmlContent[i] != '>')
                                    i++;
                            }
                            else
                                i += 8;
                            insideScriptBlock = false;
                        }
                        continue;
                    }

                    // style block
                    if (!insideStyleBlock)
                    {
                        if (i + 7 < htmlContent.Length &&
                            htmlContent[i] == '<' &&
                            (htmlContent[i + 1] == 's' || htmlContent[i + 1] == 'S') &&
                            (htmlContent[i + 2] == 't' || htmlContent[i + 2] == 'T') &&
                            (htmlContent[i + 3] == 'y' || htmlContent[i + 3] == 'Y') &&
                            (htmlContent[i + 4] == 'l' || htmlContent[i + 4] == 'L') &&
                            (htmlContent[i + 5] == 'e' || htmlContent[i + 5] == 'E') &&
                            (char.IsWhiteSpace(htmlContent[i + 6]) || htmlContent[i + 6] == '>'))
                        {
                            i += 5;
                            insideStyleBlock = true;
                            continue;
                        }
                    }
                    else // inside script block
                    {
                        if (i + 8 < htmlContent.Length &&
                            htmlContent[i] == '<' &&
                            htmlContent[i + 1] == '/' &&
                            (htmlContent[i + 2] == 's' || htmlContent[i + 2] == 'S') &&
                            (htmlContent[i + 3] == 't' || htmlContent[i + 3] == 'C') &&
                            (htmlContent[i + 4] == 'y' || htmlContent[i + 4] == 'R') &&
                            (htmlContent[i + 5] == 'l' || htmlContent[i + 5] == 'I') &&
                            (htmlContent[i + 6] == 'e' || htmlContent[i + 6] == 'P') &&
                            (char.IsWhiteSpace(htmlContent[i + 7]) || htmlContent[i + 7] == '>'))
                        {
                            if (htmlContent[i + 7] != '>')
                            {
                                i += 7;
                                while (i < htmlContent.Length && htmlContent[i] != '>')
                                    i++;
                            }
                            else
                                i += 7;
                            insideStyleBlock = false;
                        }
                        continue;
                    }

                    if (!insideTag)
                    {
                        if (i < htmlContent.Length &&
                            htmlContent[i] == '<')
                        {
                            insideTag = true;
                            continue;
                        }
                    }
                    else // inside tag
                    {
                        if (!insideAttributeValue)
                        {
                            if (htmlContent[i] == '"' || htmlContent[i] == '\'')
                            {
                                attributeValueDelimiter = htmlContent[i];
                                insideAttributeValue = true;
                                continue;
                            }
                            if (htmlContent[i] == '>')
                            {
                                insideTag = false;
                                sb.Append(' '); // prevent words from different tags (<td>s for example) from joining together
                                continue;
                            }
                        }
                        else // inside tag and inside attribute value
                        {
                            if (htmlContent[i] == attributeValueDelimiter)
                            {
                                insideAttributeValue = false;
                                continue;
                            }
                        }
                        continue;
                    }

                    sb.Append(htmlContent[i]);
                }

                if (replaceNamedEntities)
                    foreach (string[] htmlNamedEntity in htmlNamedEntities)
                        sb.Replace(htmlNamedEntity[0], htmlNamedEntity[1]);

                if (replaceNumberedEntities)
                    for (int i = 0; i < 512; i++)
                        sb.Replace("&#" + i + ";", ((char)i).ToString());

                return sb.ToString();
            }
        }
    }
    namespace Admin
    {
        //TuanDA
        public class CreateRandom
        {
            public static int RandomNumber(int min, int max)
            {
                Random random = new Random();
                return random.Next(min, max);
            }
            public static string RandomString(int size, bool lowerCase)
            {
                StringBuilder builder = new StringBuilder();
                Random random = new Random();
                char ch;
                for (int i = 0; i < size; i++)
                {
                    ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * random.NextDouble() + 65)));
                    builder.Append(ch);
                }
                if (lowerCase)
                    return builder.ToString().ToLower();
                return builder.ToString();
            }
            public static string GenPassword()
            {
                StringBuilder builder = new StringBuilder();
                builder.Append(RandomString(4, true));
                builder.Append(RandomNumber(1000, 9999));
                builder.Append(RandomString(2, false));
                return builder.ToString();
            }
        }
        public class JavaScript
        {
            public static void ShowMessage(string message, Control owner)
            {
                Page page = (owner as Page) ?? owner.Page;
                if (page == null) return;
                page.ClientScript.RegisterStartupScript(owner.GetType(),
                "ShowMessage", string.Format("<script type='text/javascript'>alert('{0}')</script>", message));
            }
            //TuanDA
            public static void RunScript(string func, Control owner)
            {
                Page page = (owner as Page) ?? owner.Page;
                if (page == null) return;
                page.ClientScript.RegisterStartupScript(owner.GetType(),
                "RunScript", string.Format("<script type='text/javascript'>{0}</script>",
                func));
            }
        }
        public static class RadControlex
        {
            public static void ShowMessage(this RadAjaxManager ajax, string message)
            {
                //HtmlEncode string to prevent JavaScript hacks 
                string alertMsg = message;//HttpContext.Current.Server.HtmlEncode(message);
                //String.Format breaks this function due to the extra { } brackets 
                //so we must resort to usign the old fashion string concat 
                ajax.ResponseScripts.Add("try{radalert('" + alertMsg + "');}catch(err){alert('" + alertMsg + "');}");
            }
        }
        public class SQL
        {
            //TuanDA
            public int ExecuteNonQuery(string SqlStr)
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DOVEEXPRESSConnectionString"].ConnectionString);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                SqlCommand cmd = new SqlCommand();
                try
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = SqlStr;
                    cmd.Connection = con;
                    int rowaffect = cmd.ExecuteNonQuery();
                    con.Close();
                    return rowaffect;
                }
                catch (SqlException ex)
                {
                    con.Close();
                    string errorMsg = "Lỗi truy vấn cơ sở dữ liệu";
                    errorMsg += ex.Message;
                    throw new Exception(errorMsg);
                    return 0;
                }
                finally
                {
                    con.Close();
                }
            }
            public object ExecuteScalar(string SqlStr)
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DOVEEXPRESSConnectionString"].ConnectionString);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                SqlCommand cmd = new SqlCommand();
                try
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = SqlStr;
                    cmd.Connection = con;
                    object value = cmd.ExecuteScalar();
                    con.Close();
                    return value;
                }
                catch (SqlException ex)
                {
                    con.Close();
                    string errorMsg = "Lỗi truy vấn cơ sở dữ liệu";
                    errorMsg += ex.Message;
                    throw new Exception(errorMsg);
                    return 0;
                }
                finally
                {
                    con.Close();
                }
            }
            public DataTable query_data(string strsql)
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DOVEEXPRESSConnectionString"].ConnectionString);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                SqlDataAdapter da = new SqlDataAdapter(strsql, con);
                DataTable data = new DataTable();
                try
                {
                    da.Fill(data);
                }
                catch { }
                con.Close();
                return data;
            }
        }
        //TuanDA
        public class Email
        {
            public static string Send(string sEmail)
            {
                System.Text.RegularExpressions.Regex regex = new System.Text.RegularExpressions.Regex(@"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*");
                bool result = regex.IsMatch(sEmail);
                if (result == false)
                {
                    return "Địa chỉ email không hợp lệ.";
                }
                else
                {
                    Configuration configurationFile = WebConfigurationManager.OpenWebConfiguration("~\\web.config");
                    MailSettingsSectionGroup mailSettings = configurationFile.GetSectionGroup("system.net/mailSettings") as
                    MailSettingsSectionGroup;
                    if (mailSettings != null)
                    {
                        int port = mailSettings.Smtp.Network.Port;
                        string host = mailSettings.Smtp.Network.Host;
                        string password = mailSettings.Smtp.Network.Password;
                        string username = mailSettings.Smtp.Network.UserName;
                        string sendfrom = mailSettings.Smtp.From;
                        SmtpClient client = new SmtpClient(host, port);
                        client.EnableSsl = true;
                        MailAddress from = new MailAddress(sendfrom, "");
                        MailAddress to = new MailAddress(sEmail, "");
                        MailMessage message = new MailMessage(from, to);
                        message.IsBodyHtml = true;
                        message.Body = "This is a test e-mail message sent using gmail as a relay server ";
                        message.Subject = "Gmail test email with SSL and Credentials";
                        NetworkCredential myCreds = new NetworkCredential(username, password, "");
                        client.Credentials = myCreds;
                        try
                        {
                            client.Send(message);
                            return "Gửi mail thành công";
                        }
                        catch (Exception ex)
                        {
                            return "Gửi mail không thành công";
                        }
                    }
                    else
                    {
                        return "Không tìm thấy thông tin cấu hình";
                    }
                }
            }
            public static string Send_Email(string SendTo, string Subject, string Body)
            {
                System.Text.RegularExpressions.Regex regex = new System.Text.RegularExpressions.Regex(@"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*");
                bool result = regex.IsMatch(SendTo);
                if (result == false)
                {
                    return "Địa chỉ email không hợp lệ.";
                }
                else
                {
                    Configuration configurationFile = WebConfigurationManager.OpenWebConfiguration("~\\web.config");
                    MailSettingsSectionGroup mailSettings = configurationFile.GetSectionGroup("system.net/mailSettings") as
                    MailSettingsSectionGroup;
                    if (mailSettings != null)
                    {
                        int port = mailSettings.Smtp.Network.Port;
                        string host = mailSettings.Smtp.Network.Host;
                        string password = mailSettings.Smtp.Network.Password;
                        string username = mailSettings.Smtp.Network.UserName;
                        string SendFrom = mailSettings.Smtp.From;
                        SmtpClient client = new SmtpClient(host, port);
                        client.EnableSsl = true;
                        MailAddress from = new MailAddress(SendFrom, "Quản trị");
                        MailAddress to = new MailAddress(SendTo, "");
                        MailMessage message = new MailMessage(from, to);
                        message.Body = Body;
                        message.IsBodyHtml = true;
                        message.Subject = Subject;
                        NetworkCredential myCreds = new NetworkCredential(username, password, "");
                        client.Credentials = myCreds;
                        try
                        {
                            client.Send(message);
                            return "Gửi mail thành công";
                        }
                        catch (Exception ex)
                        {
                            return "Gửi mail không thành công";
                        }
                    }
                    else
                    {
                        return "Không tìm thấy thông tin cấu hình";
                    }
                }
            }
            public static string Send_Email_With_Attachment(string SendTo, string Subject, string Body, string AttachmentPath)
            {
                System.Text.RegularExpressions.Regex regex = new System.Text.RegularExpressions.Regex(@"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*");
                bool result = regex.IsMatch(SendTo);
                if (result == false)
                {
                    return "Địa chỉ email không hợp lệ.";
                }
                else
                {
                    Configuration configurationFile = WebConfigurationManager.OpenWebConfiguration("~\\web.config");
                    MailSettingsSectionGroup mailSettings = configurationFile.GetSectionGroup("system.net/mailSettings") as
                    MailSettingsSectionGroup;
                    if (mailSettings != null)
                    {
                        int port = mailSettings.Smtp.Network.Port;
                        string host = mailSettings.Smtp.Network.Host;
                        string password = mailSettings.Smtp.Network.Password;
                        string username = mailSettings.Smtp.Network.UserName;
                        string SendFrom = mailSettings.Smtp.From;
                        SmtpClient client = new SmtpClient(host, port);
                        client.EnableSsl = true;
                        MailAddress from = new MailAddress(SendFrom, "");
                        MailAddress to = new MailAddress(SendTo, "");
                        MailMessage message = new MailMessage(from, to);
                        message.IsBodyHtml = true;
                        message.Body = Body;
                        message.Subject = Subject;
                        Attachment attach = new Attachment(AttachmentPath);
                        message.Attachments.Add(attach);
                        NetworkCredential myCreds = new NetworkCredential(username, password, "");
                        client.Credentials = myCreds;
                        try
                        {
                            client.Send(message);
                            return "Gửi mail thành công";
                        }
                        catch (Exception ex)
                        {
                            return "Gửi mail không thành công";
                        }
                    }
                    else
                    {
                        return "Không tìm thấy thông tin cấu hình";
                    }
                }
            }
            public static string Send_Email_With_BCC_Attachment(string SendTo, string SendBCC, string Subject, string Body, string AttachmentPath)
            {
                System.Text.RegularExpressions.Regex regex = new System.Text.RegularExpressions.Regex(@"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*");
                bool result = regex.IsMatch(SendTo);
                if (result == false)
                {
                    return "Địa chỉ email không hợp lệ.";
                }
                else
                {
                    Configuration configurationFile = WebConfigurationManager.OpenWebConfiguration("~\\web.config");
                    MailSettingsSectionGroup mailSettings = configurationFile.GetSectionGroup("system.net/mailSettings") as
                    MailSettingsSectionGroup;
                    if (mailSettings != null)
                    {
                        int port = mailSettings.Smtp.Network.Port;
                        string host = mailSettings.Smtp.Network.Host;
                        string password = mailSettings.Smtp.Network.Password;
                        string username = mailSettings.Smtp.Network.UserName;
                        string SendFrom = mailSettings.Smtp.From;
                        SmtpClient client = new SmtpClient(host, port);
                        client.EnableSsl = true;
                        MailAddress from = new MailAddress(SendFrom, "");
                        MailAddress to = new MailAddress(SendTo, "");
                        MailMessage message = new MailMessage(from, to);
                        message.IsBodyHtml = true;
                        message.Body = Body;
                        message.Subject = Subject;
                        Attachment attach = new Attachment(AttachmentPath);
                        message.Attachments.Add(attach);
                        message.Bcc.Add(SendBCC);
                        NetworkCredential myCreds = new NetworkCredential(username, password, "");
                        client.Credentials = myCreds;
                        try
                        {
                            client.Send(message);
                            return "Gửi mail thành công";
                        }
                        catch (Exception ex)
                        {
                            return "Gửi mail không thành công";
                        }
                    }
                    else
                    {
                        return "Không tìm thấy thông tin cấu hình";
                    }
                }
            }
        }
        //TuanDA
        public class cFunction
        {
            public static string TruncateMemo(string str, int ln)
            {
                if (str.Length > 0 && str.Length > ln)
                {
                    string[] temp;
                    temp = str.Split(' ');
                    string temp1 = "";
                    for (int i = 0; i < temp.Length; i++)
                    {
                        if (temp1.Length < ln - 1)
                        {
                            temp1 += temp[i];
                            temp1 += " ";
                        }
                    }
                    temp1 += "...";
                    return temp1;
                }
                else
                {
                    return str;
                }
            }
            public static string getname(string id, string table)
            {
                string SelectSQL = "SELECT c_name FROM " + table + " where pk_id =" + id;
                DataTable oDataTable = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                oDataTable = SelectQuery.query_data(SelectSQL);
                if (oDataTable.Rows.Count != 0)
                {
                    return oDataTable.Rows[0]["c_name"].ToString();
                }
                else
                {
                    return "";
                }
            }
            public static string getnamefix(string ID, string table)
            {
                string Result = "";
                if (ID != "")
                {
                    string SelectSQL = "SELECT c_name FROM " + table + " where pk_id in (" + ID + ")";
                    ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                    DataTable oDataTable = SelectQuery.query_data(SelectSQL);
                    if (oDataTable.Rows.Count != 0)
                    {
                        for (int i = 0; i < oDataTable.Rows.Count; i++)
                        {
                            if (i == 0)
                            {
                                Result += oDataTable.Rows[i]["C_NAME"].ToString();
                            }
                            else
                            {
                                Result += " - " + oDataTable.Rows[i]["C_NAME"].ToString();
                            }
                        }
                    }
                }
                return Result;
            }
            public static bool ShowHide(object a, string type)
            {
                string[] names = new string[5] { "jpg", "gif", "bmp", "tif", "png" };
                string file_name = (string)a;
                if (file_name != "" && file_name.Length > 3)
                {
                    string _type = file_name.Substring(file_name.Length - 3, 3);
                    if ((_type == "swf") && (type == "f"))
                    {
                        return true;
                    }
                    else
                    {
                        if ((_type != "swf") && (type != "f"))
                        {
                            bool temp = false;
                            foreach (string t in names)
                            {
                                if (_type.ToLower() == t.ToLower()) { temp = true; }
                            }
                            return temp;
                        }
                        else
                        {
                            return false;

                        }
                    }
                }
                else
                {
                    return false;
                }
            }
            public static string LoadUserName(string PK_USER)
            {
                string SelectSQL = "SELECT C_NAME FROM USERS WHERE PK_ID = " + PK_USER;
                ITCLIB.Admin.SQL rs = new ITCLIB.Admin.SQL();
                DataTable oDataTable = rs.query_data(SelectSQL);
                if (oDataTable.Rows.Count != 0)
                {
                    return (string)oDataTable.Rows[0]["C_NAME"];
                }
                else
                {
                    return PK_USER;
                }
            }
            public static string KillChars(string sInput)
            {
                string newChars = "";
                if (sInput != null && sInput != "")
                {
                    string[] badChars = { "select", "drop", ";", "--", "insert", "delete", "xp_", "update", "'or'", "=" };
                    newChars = sInput.ToLower(new CultureInfo("vi-VN", false));
                    for (int i = 0; i < badChars.Length; i++)
                    {
                        newChars = newChars.Replace(badChars[i], "");

                    }
                    if (!Regex.IsMatch(newChars, @"^([\u0080-\ua7ffa-zA-Z0-9'\s\.])+$"))
                    {
                        newChars = "";
                    }
                }
                return HttpUtility.HtmlEncode(newChars);
            }
            public static string KillCharsFix(string sInput)
            {
                string newChars = "";
                if (sInput != null && sInput != "")
                {
                    string[] badChars = { "select", "drop", ";", "--", "insert", "delete", "xp_", "update", "'or'", "=" };
                    newChars = sInput;
                    for (int i = 0; i < badChars.Length; i++)
                    {
                        newChars = newChars.Replace(badChars[i], "");

                    }
                    if (!Regex.IsMatch(newChars, @"^([\u0080-\ua7ffa-zA-Z0-9'\s\.])+$"))
                    {
                        newChars = "";
                    }
                }
                return HttpUtility.HtmlEncode(newChars);
            }
            public static int GetInt(string sInput)
            {
                int intvalue;
                if (sInput == null) intvalue = 0;
                if (!Int32.TryParse(sInput, out intvalue)) intvalue = 0;
                return intvalue;
            }
            public static string ReturnExtension(string fileExtension)
            {
                switch (fileExtension)
                {
                    case ".htm":
                    case ".html":
                    case ".log":
                        return "text/HTML";
                    case ".txt":
                        return "text/plain";
                    case ".doc":
                    case ".docx":
                        return "application/ms-word";
                    case ".tiff":
                    case ".tif":
                        return "image/tiff";
                    case ".asf":
                        return "video/x-ms-asf";
                    case ".avi":
                        return "video/avi";
                    case ".zip":
                        return "application/zip";
                    case ".xls":
                    case ".xlsx":
                    case ".csv":
                        return "application/vnd.ms-excel";
                    case ".gif":
                        return "image/gif";
                    case ".jpg":
                    case "jpeg":
                        return "image/jpeg";
                    case ".bmp":
                        return "image/bmp";
                    case ".wav":
                        return "audio/wav";
                    case ".mp3":
                        return "audio/mpeg3";
                    case ".mpg":
                    case "mpeg":
                        return "video/mpeg";
                    case ".rtf":
                        return "application/rtf";
                    case ".asp":
                        return "text/asp";
                    case ".pdf":
                        return "application/pdf";
                    case ".fdf":
                        return "application/vnd.fdf";
                    case ".ppt":
                    case ".pptx":
                        return "application/mspowerpoint";
                    case ".dwg":
                        return "image/vnd.dwg";
                    case ".msg":
                        return "application/msoutlook";
                    case ".xml":
                    case ".sdxl":
                        return "application/xml";
                    case ".xdp":
                        return "application/vnd.adobe.xdp+xml";
                    default:
                        return "application/octet-stream";
                }
            }
            public static string LoadFieldfromTable(string ivalue, string para, string table)
            {
                string SelectSQL = String.Format("SELECT {0} FROM {1} where PK_ID ={2}", para, table, ivalue);
                DataTable oDataTable = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                oDataTable = SelectQuery.query_data(SelectSQL);
                if (oDataTable.Rows.Count != 0 && oDataTable.Rows[0][para] != null)
                {
                    return oDataTable.Rows[0][para].ToString();
                }
                else
                {
                    return "";
                }
            }
            public static string GetStringForList(string ivalue, string ovalue)
            {
                string result = ovalue;
                if (result == "")
                {
                    result = ivalue;
                }
                else
                {
                    result += ";" + ivalue;
                }
                return result;
            }
            public static string GetStringForList(string ivalue, string ovalue, char ichar)
            {
                string result = ovalue;
                if (result == "")
                {
                    result = ivalue;
                }
                else
                {
                    result += ichar + ivalue;
                }
                return result;
            }
            public static bool CheckHasStrings(string ivalue, string iString)
            {
                bool result = false;
                if (iString != null)
                {
                    string[] eles = iString.Split(';');
                    foreach (string ele in eles)
                    {
                        if (ele.Trim() == ivalue)
                        {
                            result = true;
                            break;
                        }
                    }
                }
                return result;
            }
            public static bool CheckHasStrings(string ivalue, string iString, char ichar)
            {
                bool result = false;
                if (iString != null)
                {
                    string[] eles = iString.Split(ichar);
                    foreach (string ele in eles)
                    {
                        if (ele.Trim() == ivalue)
                        {
                            result = true;
                            break;
                        }
                    }
                }
                return result;
            }
            public static string LoadIDQuocGia(string ID)
            {
                string Result = "";
                if (ID != "")
                {
                    string SelectSQL = "SELECT DMQUOCGIA.PK_ID FROM DMQUOCGIA LEFT OUTER JOIN DMTINHTHANH ON DMQUOCGIA.PK_ID = DMTINHTHANH.FK_QUOCGIA LEFT OUTER JOIN DMQUANHUYEN ON DMTINHTHANH.PK_ID = DMQUANHUYEN.FK_TINHTHANH WHERE DMQUANHUYEN.PK_ID IN (" + ID + ")";
                    ITCLIB.Admin.SQL rs = new ITCLIB.Admin.SQL();
                    DataTable oDataTable = rs.query_data(SelectSQL);

                    if (oDataTable.Rows.Count != 0)
                    {
                        for (int i = 0; i < oDataTable.Rows.Count; i++)
                        {
                            if (i == 0)
                            {
                                Result += oDataTable.Rows[i]["PK_ID"].ToString();
                            }
                            else
                            {
                                Result += "-" + oDataTable.Rows[i]["PK_ID"].ToString();
                            }
                        }
                    }
                }
                return Result;
            }
            public static string LoadIDTinhThanh(string ID)
            {
                string Result = "";
                if (ID != "")
                {
                    string SelectSQL = "SELECT DMTINHTHANH.PK_ID FROM DMTINHTHANH LEFT OUTER JOIN DMQUANHUYEN ON DMTINHTHANH.PK_ID = DMQUANHUYEN.FK_TINHTHANH WHERE DMQUANHUYEN.PK_ID IN (" + ID + ")";
                    ITCLIB.Admin.SQL rs = new ITCLIB.Admin.SQL();
                    DataTable oDataTable = rs.query_data(SelectSQL);

                    if (oDataTable.Rows.Count != 0)
                    {
                        for (int i = 0; i < oDataTable.Rows.Count; i++)
                        {
                            if (i == 0)
                            {
                                Result += oDataTable.Rows[i]["PK_ID"].ToString();
                            }
                            else
                            {
                                Result += "-" + oDataTable.Rows[i]["PK_ID"].ToString();
                            }
                        }
                    }
                }
                return Result;
            }
            public static string LoadIDTinhThanhCode(string Code)
            {
                string Result = "";
                if (Code != "")
                {
                    string SelectSQL = "SELECT DMTINHTHANH.PK_ID FROM DMTINHTHANH LEFT OUTER JOIN DMQUANHUYEN ON DMTINHTHANH.PK_ID = DMQUANHUYEN.FK_TINHTHANH WHERE DMQUANHUYEN.C_CODE = '" + Code + "'";
                    ITCLIB.Admin.SQL rs = new ITCLIB.Admin.SQL();
                    DataTable oDataTable = rs.query_data(SelectSQL);

                    if (oDataTable.Rows.Count != 0)
                    {
                        for (int i = 0; i < oDataTable.Rows.Count; i++)
                        {
                            if (i == 0)
                            {
                                Result += oDataTable.Rows[i]["PK_ID"].ToString();
                            }
                            else
                            {
                                Result += "-" + oDataTable.Rows[i]["PK_ID"].ToString();
                            }
                        }
                    }
                }
                return Result;
            }
            public static string LoadIDTinhThanhName(string Name)
            {
                string Result = "";
                if (Name != "")
                {
                    string SelectSQL = "SELECT DMTINHTHANH.PK_ID FROM DMTINHTHANH WHERE DMTINHTHANH.C_NAME = N'" + Name + "'";
                    ITCLIB.Admin.SQL rs = new ITCLIB.Admin.SQL();
                    DataTable oDataTable = rs.query_data(SelectSQL);

                    if (oDataTable.Rows.Count != 0)
                    {
                        for (int i = 0; i < oDataTable.Rows.Count; i++)
                        {
                            if (i == 0)
                            {
                                Result += oDataTable.Rows[i]["PK_ID"].ToString();
                            }
                            else
                            {
                                Result += "-" + oDataTable.Rows[i]["PK_ID"].ToString();
                            }
                        }
                    }
                }
                return Result;
            }
            public static string LoadTinhThanhName(string QuanHuyenCode)
            {
                string Result = "";
                if (QuanHuyenCode != "")
                {
                    string SelectSQL = "SELECT DMTINHTHANH.C_NAME FROM DMTINHTHANH LEFT OUTER JOIN DMQUANHUYEN ON DMTINHTHANH.PK_ID = DMQUANHUYEN.FK_TINHTHANH WHERE DMQUANHUYEN.C_CODE = '" + QuanHuyenCode + "'";
                    ITCLIB.Admin.SQL rs = new ITCLIB.Admin.SQL();
                    DataTable oDataTable = rs.query_data(SelectSQL);

                    if (oDataTable.Rows.Count != 0)
                    {
                        for (int i = 0; i < oDataTable.Rows.Count; i++)
                        {
                            if (i == 0)
                            {
                                Result += oDataTable.Rows[i]["C_NAME"].ToString();
                            }
                            else
                            {
                                Result += "-" + oDataTable.Rows[i]["C_NAME"].ToString();
                            }
                        }
                    }
                }
                return Result;
            }
            public static string LoadQuanHuyenName(string C_CODE)
            {
                string SelectSQL = "SELECT C_NAME FROM DMQUANHUYEN where C_CODE =" + C_CODE;
                DataTable oDataTable = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                oDataTable = SelectQuery.query_data(SelectSQL);
                if (oDataTable.Rows.Count != 0)
                {
                    return oDataTable.Rows[0]["C_NAME"].ToString();
                }
                else
                {
                    return "";
                }
            }
            public static string LoadQuocGiaName(string C_CODE)
            {
                string SelectSQL = "SELECT C_NAME FROM DMQUOCGIA where C_CODE ='" + C_CODE + "'";
                DataTable oDataTable = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                oDataTable = SelectQuery.query_data(SelectSQL);
                if (oDataTable.Rows.Count != 0)
                {
                    return oDataTable.Rows[0]["C_NAME"].ToString();
                }
                else
                {
                    return "";
                }
            }
            public static string LoadIDDoiTacName(string Name)
            {
                string Result = "NULL";
                if (Name != "")
                {
                    string SelectSQL = "SELECT DMDOITAC.PK_ID FROM DMDOITAC WHERE DMDOITAC.C_NAME = N'" + Name + "'";
                    ITCLIB.Admin.SQL rs = new ITCLIB.Admin.SQL();
                    DataTable oDataTable = rs.query_data(SelectSQL);
                    if (oDataTable.Rows.Count != 0)
                    {
                        Result = oDataTable.Rows[0]["PK_ID"].ToString();
                    }
                }
                return Result;
            }
        }
    }
    namespace Controls
    {
        public class Status : System.Web.UI.WebControls.Label
        {
            private string atext;
            private string iatext;
            private bool vvalue;
            private int ivalue;
            private bool _Color;
            public string ActiveText
            {
                get { return atext; }
                set { atext = value; }
            }
            public string InActiveText
            {
                get { return iatext; }
                set { iatext = value; }
            }
            public bool Value
            {
                get { return vvalue; }
                set { vvalue = value; }

            }
            public int iValue
            {
                get { return ivalue; }
                set { ivalue = value; }

            }
            public bool Color
            {
                get { return _Color; }
                set { _Color = value; }

            }
            public override string Text
            {
                get
                {
                    if (Value == true)
                    {
                        return ActiveText;
                    }
                    else if (Value == false && iValue == null)
                    {
                        if (Color == true)
                        {
                            return "<font color=\"#FF0000\">" + InActiveText + "</font></i>";
                        }
                        else
                        {
                            return InActiveText;
                        }
                    }
                    else if (iValue == 1)
                    {
                        return ActiveText;
                    }
                    else
                    {
                        return InActiveText;
                    }
                }
            }
        }
        public class Label : System.Web.UI.WebControls.Label
        {
            private string _TableName;
            private object _PkVColumn;
            private string _PkColumn;
            private string _Column;
            public string Column
            {
                get { return _Column; }
                set { _Column = value; }
            }
            public string TableName
            {
                get { return _TableName; }
                set { _TableName = value; }
            }
            public object PkVColumn
            {
                get { return _PkVColumn; }
                set { _PkVColumn = value; }

            }
            public string PkColumn
            {
                get { return _PkColumn; }
                set { _PkColumn = value; }

            }
            public string build_label()
            {

                try
                {
                    int va = (int)this.PkVColumn;
                    String str1 = "SELECT " + this.Column + " FROM " + this.TableName + " WHERE (" + this.PkColumn + " = " + va + ") ";
                    ITCLIB.Admin.SQL thu = new ITCLIB.Admin.SQL();
                    DataTable data1 = thu.query_data(str1);
                    try
                    {
                        return data1.Rows[0][this.Column].ToString();
                    }
                    catch
                    {
                        return "";
                    }
                }
                catch
                {
                    return "";
                }

            }
            public override string Text
            {
                get
                {
                    return build_label();
                }
            }
        }
        public class Label_ck : System.Web.UI.WebControls.Label
        {
            private string col_Name;
            public string Col_Name
            {
                get { return col_Name; }
                set { col_Name = value; }
            }
            protected void Page_Load(object sender, EventArgs e)
            {
                string script = "<script type=\"text/javascript\"> function checkAll(form,value){ for (i = 0; i < form.elements.length; i++){ if(form.elements[i].name == \"" + Col_Name + "\") form.elements[i].checked = value; } }</script> ";
                Page.RegisterClientScriptBlock("ClientScript", script);
            }
            public override string Text
            {
                get
                {
                    return "<script type=\"text/javascript\"> function Checkbox1_onclick() { var myTextField = document.getElementById('Checkbox1'); checkAll(document.forms[0],myTextField.checked); } </script> <input id=\"Checkbox1\" type=\"checkbox\" onclick=\"return Checkbox1_onclick()\" />";
                }

            }
        }
        public class msgBox : System.Web.UI.WebControls.WebControl
        {
            //private string msg;
            private string content;

            [Bindable(true),
                Category("Appearance"),
                DefaultValue("")]

            public void alert(string msg)
            {
                string sMsg = msg.Replace("\n", "\\n");
                sMsg = msg.Replace("\"", "'");

                StringBuilder sb = new StringBuilder();

                sb.Append(@"<script language='javascript'>");

                sb.Append(@"alert( """ + sMsg + @""" );");

                sb.Append(@"</script>");

                content = sb.ToString();
            }

            //good for the page with only one form
            public void confirm(string msg, string hiddenfield_name)
            {
                string sMsg = msg.Replace("\n", "\\n");
                sMsg = msg.Replace("\"", "'");

                StringBuilder sb = new StringBuilder();

                sb.Append(@"<INPUT type=hidden value='0' name='" + hiddenfield_name + "'>");

                sb.Append(@"<script language='javascript'>");

                sb.Append(@" if(confirm( """ + sMsg + @""" ))");
                sb.Append(@" { ");
                sb.Append("document.forms[0]." + hiddenfield_name + ".value='1';" + "document.forms[0].submit(); }");
                sb.Append(@" else { ");
                sb.Append("document.forms[0]." + hiddenfield_name + ".value='0'; }");

                sb.Append(@"</script>");

                content = sb.ToString();
            }

            //good for the page with multiple forms; NOT VERY NECESSARY
            /*public void confirm(string msg,string hiddenfield_name,string formname)
            {
                string  sMsg = msg.Replace( "\n", "\\n" );
                sMsg =  msg.Replace( "\"", "'" );
 
                StringBuilder sb = new StringBuilder();
			
                sb.Append( @"<INPUT type=hidden value='0' name='" + hiddenfield_name + "'>");

                sb.Append( @"<script language='javascript'>" );
			
                sb.Append( @" if(confirm( """ + sMsg + @""" ))" );
                sb.Append( @" { ");
                sb.Append( formname +"." + hiddenfield_name + ".value='1';" + formname + ".submit(); }" );
                sb.Append( @" else { ");
                sb.Append(formname +"." + hiddenfield_name + ".value='0'; }" );

                sb.Append( @"</script>" );

                content=sb.ToString();
            }*/

            /// <summary>
            /// Render this control to the output parameter specified.
            /// </summary>
            /// <param name="output"> The HTML writer to write out to </param>
            protected override void Render(HtmlTextWriter output)
            {
                output.Write(this.content);
            }
        }
        public class CheckAll : System.Web.UI.UserControl
        {
            private string link;
            private string fname;
            public string CssClass
            {
                get
                {
                    return this.link;
                }
                set
                {
                    this.link = value;
                }
            }
            public string FieldName
            {
                get
                {
                    return this.fname;
                }
                set
                {
                    this.fname = value;
                }
            }
            protected void Page_Load(object sender, EventArgs e)
            {
                string script = "<script type=\"text/javascript\"> function checkAll(form,value){ for (i = 0; i < form.elements.length; i++){ if(form.elements[i].type == \"checkbox\") form.elements[i].checked = value; } }</script> ";
                Page.RegisterClientScriptBlock("ClientScript", script);
                HyperLink a1 = new HyperLink();
                a1.Text = "Chọn tất cả - ";
                a1.CssClass = CssClass;
                a1.NavigateUrl = "javascript:checkAll(document.forms[0],1)";
                this.Controls.Add(a1);
                Label p1 = new Label();
                p1.Text = " -- ";
                this.Controls.Add(p1);
                HyperLink a2 = new HyperLink();
                a2.Text = "Bỏ chọn";
                a2.CssClass = CssClass;
                a2.NavigateUrl = "javascript:checkAll(document.forms[0],0)";
                this.Controls.Add(a2);
            }
        }
        //TuanDA
        public class Map : System.Web.UI.WebControls.WebControl
        {
            public Map()
            {
                PreRender += new EventHandler(Control_PreRender);
            }
            private string _CssClass;
            public string CssClass
            {
                get
                {
                    return this._CssClass;
                }
                set
                {
                    this._CssClass = value;
                }
            }
            private string _FieldParent;
            public string FieldParent
            {
                get
                {
                    switch ((string)ModuleName)
                    {
                        case "menus":
                            return "C_PARENT";
                            break;
                        case "careers":
                            return "C_PARENT";
                            break;
                        default:
                            return _FieldParent;
                            break;
                    }

                }
                set
                {
                    this._FieldParent = value;
                }
            }
            private string _FieldText;
            public string FieldText
            {
                get
                {
                    switch ((string)ModuleName)
                    {
                        case "menus":
                            return "C_NAME";
                            break;
                        case "careers":
                            return "C_NAME";
                            break;
                        default:
                            return _FieldText;
                            break;
                    }
                }
                set
                {
                    this._FieldText = value;
                }
            }
            private string _FieldValue;
            public string FieldValue
            {
                get
                {
                    return this._FieldValue;
                }
                set
                {
                    this._FieldValue = value;
                }
            }
            private bool _IsCache;
            public bool IsCache
            {
                get
                {
                    return this._IsCache;
                }
                set
                {
                    this._IsCache = value;
                }
            }
            private bool _IsHome;
            public bool IsHome
            {
                get
                {
                    return this._IsHome;
                }
                set
                {
                    this._IsHome = value;
                }
            }
            private bool _IsLink;
            public bool IsLink
            {
                get
                {
                    return this._IsLink;
                }
                set
                {
                    this._IsLink = value;
                }
            }
            private string _ModuleName;
            public string ModuleName
            {
                get
                {
                    return this._ModuleName;
                }
                set
                {
                    this._ModuleName = value;
                }
            }
            private string _ModuleText;
            public string ModuleText
            {
                get
                {
                    return this._ModuleText;
                }
                set
                {
                    this._ModuleText = value;
                }
            }
            private string _TableName;
            public string TableName
            {
                get
                {
                    return this._TableName;
                }
                set
                {
                    this._TableName = value;
                }
            }
            private string _Text;
            public string Text
            {
                get
                {
                    string str = "SELECT " + FieldText + " FROM " + TableName + " WHERE " + FieldValue + " = " + _Value;
                    Admin.SQL obj = new Admin.SQL();
                    DataTable oTable = obj.query_data(str);
                    if (!(oTable.Rows.Count == 0))
                    {
                        this._Text = (string)oTable.Rows[0][0];
                    }
                    return this._Text;
                }
                set
                {
                    this._Text = value;
                }
            }
            private Int32 _Value;
            public Int32 Value
            {
                get
                {
                    if (!string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["pID"]))
                    {
                        _Value = Int32.Parse(System.Web.HttpContext.Current.Request.QueryString["pID"]);
                    }
                    else
                    {
                        _Value = 0;
                    }
                    return _Value;
                }
                set
                {
                    this._Value = value;
                }
            }
            private Int32 _ValueMin;
            public Int32 ValueMin
            {
                get
                {
                    string str = "SELECT " + FieldParent + " FROM " + TableName + " WHERE " + FieldValue + " = " + _Value;
                    Console.WriteLine(str);
                    Admin.SQL obj = new Admin.SQL();
                    DataTable oTable = obj.query_data(str);
                    if (!(oTable.Rows.Count == 0))
                    {
                        this._ValueMin = (Int32)oTable.Rows[0][0];
                    }
                    else
                    {
                        this._ValueMin = -1;
                    }
                    return this._ValueMin;
                }
                set
                {
                    this._ValueMin = value;
                }
            }
            StringBuilder sbResult = new StringBuilder();
            protected override void Render(HtmlTextWriter output)
            {
                output.Write(sbResult.ToString());
            }
            private string Separator;
            protected void Control_PreRender(Object sender, EventArgs e)
            {
                Separator = ">>";
                if (Value > 0)
                {
                    string str = "";
                    while (ValueMin > -1)
                    {
                        str = Separator + "<a class=\"" + CssClass + "\" href=\"?ctl=" + ModuleName + "&pID=" + _Value + "\">" + Text + "</a>" + str;
                        _Value = ValueMin;

                    }
                    sbResult.Append("<a class=\"" + CssClass + "\" href=\"?ctl=" + ModuleName + "&pID=0\">" + ModuleText + "</a>" + str);
                }
                else
                {
                    sbResult.Append("<a class=\"" + CssClass + "\" href=\"?ctl=" + ModuleName + "&pID=0\">" + ModuleText + "</a>");
                }
            }
        }
        //TuanDA
        public class MapHome : System.Web.UI.WebControls.WebControl
        {
            public MapHome()
            {
                PreRender += new EventHandler(Control_PreRender);
            }
            private string _CssClass;
            public string CssClass
            {
                get
                {
                    return this._CssClass;
                }
                set
                {
                    this._CssClass = value;
                }
            }
            private string _FieldParent;
            public string FieldParent
            {
                get
                {
                    switch ((string)ModuleName)
                    {
                        case "news":
                            return "C_PARENT";
                            break;
                        default:
                            return _FieldParent;
                            break;
                    }

                }
                set
                {
                    this._FieldParent = value;
                }
            }
            private string _FieldText;
            public string FieldText
            {
                get
                {
                    switch ((string)ModuleName)
                    {
                        case "news":
                            return "C_NAME";
                            break;
                        default:
                            return _FieldText;
                            break;
                    }
                }
                set
                {
                    this._FieldText = value;
                }
            }
            private string _FieldValue;
            public string FieldValue
            {
                get
                {
                    return this._FieldValue;
                }
                set
                {
                    this._FieldValue = value;
                }
            }
            private string _ModuleName;
            public string ModuleName
            {
                get
                {
                    return this._ModuleName;
                }
                set
                {
                    this._ModuleName = value;
                }
            }
            private string _ModuleText;
            public string ModuleText
            {
                get
                {
                    return this._ModuleText;
                }
                set
                {
                    this._ModuleText = value;
                }
            }
            private string _TableName;
            public string TableName
            {
                get
                {
                    return this._TableName;
                }
                set
                {
                    this._TableName = value;
                }
            }
            private string _Text;
            public string Text
            {
                get
                {
                    string str = "SELECT " + FieldText + " FROM " + TableName + " WHERE " + FieldValue + " = " + _Value;
                    Admin.SQL obj = new Admin.SQL();
                    DataTable oTable = obj.query_data(str);
                    if (!(oTable.Rows.Count == 0))
                    {
                        this._Text = (string)oTable.Rows[0][0];
                    }
                    return this._Text;
                }
                set
                {
                    this._Text = value;
                }
            }
            private Int32 _Value;
            public Int32 Value
            {
                get
                {
                    if (!string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["mID"]))
                    {
                        _Value = Int32.Parse(System.Web.HttpContext.Current.Request.QueryString["mID"]);
                    }
                    return this._Value;
                }
                set
                {
                    this._Value = value;
                }
            }
            private Int32 _ValueMin;
            public Int32 ValueMin
            {
                get
                {
                    string str = "SELECT " + FieldParent + " FROM " + TableName + " WHERE " + FieldValue + " = " + _Value;
                    Console.WriteLine(str);
                    Admin.SQL obj = new Admin.SQL();
                    DataTable oTable = obj.query_data(str);
                    if (!(oTable.Rows.Count == 0))
                    {
                        this._ValueMin = (Int32)oTable.Rows[0][0];
                    }
                    else
                    {
                        this._ValueMin = -1;
                    }
                    return this._ValueMin;
                }
                set
                {
                    this._ValueMin = value;
                }
            }
            StringBuilder sbResult = new StringBuilder();
            protected override void Render(HtmlTextWriter output)
            {
                output.Write(sbResult.ToString());
            }
            private string Separator;
            protected void Control_PreRender(Object sender, EventArgs e)
            {
                Separator = "<a class=\"" + CssClass + "\"> > </a>";
                if (Value > 0)
                {
                    string str = "";
                    int count = 1;
                    while (ValueMin > -1)
                    {
                        if (count == 1)
                        {
                            str = Separator + "<a class=\"menulevel\" href=\"?ctl=" + ModuleName + "&mID=" + _Value + "\">" + Text + "</a>" + str;
                        }
                        else
                        {
                            str = Separator + "<a class=\"" + CssClass + "\" href=\"?ctl=" + ModuleName + "&mID=" + _Value + "\">" + Text + "</a>" + str;
                        }
                        count += 1;
                        _Value = ValueMin;

                    }
                    sbResult.Append("<a class=\"" + CssClass + "\" href=\"Office.aspx\">" + ModuleText + "</a>" + str);
                }
                else
                {
                    sbResult.Append("<a class=\"" + CssClass + "\" href=\"Office.aspx\">" + ModuleText + "</a>");
                }
            }
        }
        public class DropDownList : System.Web.UI.WebControls.DropDownList
        {

            private string _Type;
            private string _LText;
            private bool _IsCache;
            private string _FieldValue;
            private string _CValue;
            private string _FieldLang;
            private string _FieldParent;
            private string _FieldText;
            private string _TableName;
            private int _Value;
            private int _LangValue;
            public string CValue
            {
                get { return _CValue; }
                set { _CValue = value; }
            }
            public string FieldLang
            {
                get { return _FieldLang; }
                set { _FieldLang = value; }
            }
            public string FieldParent
            {
                get { return _FieldParent; }
                set { _FieldParent = value; }
            }
            public string FieldText
            {
                get { return _FieldText; }
                set { _FieldText = value; }
            }
            public string FieldValue
            {
                get { return _FieldValue; }
                set { _FieldValue = value; }
            }
            public bool IsCache
            {
                get { return _IsCache; }
                set { _IsCache = value; }
            }
            public int LangValue
            {
                get { return _LangValue; }
                set { _LangValue = value; }
            }
            public string LText
            {
                get { return _LText; }
                set { _LText = value; }
            }
            public string TableName
            {
                get { return _TableName; }
                set { _TableName = value; }
            }
            public string Type
            {
                get { return _Type; }
                set { _Type = value; }
            }
            public int Value
            {
                get { return _Value; }
                set { _Value = value; }
            }
            public override string SelectedValue
            {
                get
                {
                    return base.SelectedValue;
                }
                set
                {
                    if (this.Items.Count > 0)
                    { base.SelectedValue = value; }
                }
            }
            public void bindToDropDown(DropDownList ddl)
            {
                if (ddl.Items.Count == 0)
                {
                    string str1;

                    if (this.Type != null)
                    {
                        str1 = "SELECT * FROM " + this.TableName + " WHERE (" + this.FieldLang + " =0 OR " + this.FieldLang + " = " + this.LangValue + ") and (PK_MENU <> " + this.Value + " ) and (C_TYPE IN (" + this.Type + ")) ORDER BY C_ORDER";
                    }
                    else
                    {
                        str1 = "SELECT * FROM " + this.TableName + " WHERE (" + this.FieldLang + " = 0 OR " + this.FieldLang + " = " + this.LangValue + ") and (PK_MENU <> " + this.Value + " ) ORDER BY C_ORDER";
                    }


                    ITCLIB.Admin.SQL thu = new ITCLIB.Admin.SQL();
                    DataTable data1 = thu.query_data(str1);

                    foreach (DataRow dr in data1.Rows)
                    {
                        string child = "-----";
                        if (dr[this.FieldParent].ToString() == "0")
                        {
                            ListItem item = new ListItem();
                            item.Text = dr[this.FieldText].ToString();
                            item.Value = dr[this.FieldValue].ToString();
                            item.Attributes.Add("class", "ddlMenu_1");
                            string tempkey = dr[this.FieldValue].ToString();
                            ddl.Items.Add(item);
                            GetChildItems(tempkey, data1, ddl, child);
                        }
                    }
                    ListItem topitem = new ListItem();
                    topitem.Text = this.LText;
                    topitem.Value = "0";
                    topitem.Attributes.Add("class", "ddlMenu_0");
                    ddl.Items.Insert(0, topitem);
                }
            }
            private void GetChildItems(string parentID, DataTable dtTemp, DropDownList ddl, string child)
            {
                foreach (DataRow drr in dtTemp.Rows)
                {
                    string temp = child;
                    if (drr[this.FieldParent].ToString() == parentID.ToString())
                    {
                        ListItem chilitem = new ListItem();
                        chilitem.Text = child + drr[this.FieldText].ToString();
                        chilitem.Value = drr[this.FieldValue].ToString();
                        child = child + "-----";
                        chilitem.Attributes.Add("class", "ddlMenu_2");
                        ddl.Items.Add(chilitem);
                        string tempkeyr = drr[this.FieldValue].ToString();
                        GetChildItems(tempkeyr, dtTemp, ddl, child);
                    }
                    child = temp;
                }
            }
            protected void PreRender_Control(object sender, EventArgs e)
            {
                bindToDropDown(this);
                //  HttpContext.Current.Response.Write("vhjg" + CValue +"thu" + SelectedValue);    
                if (CValue != null)
                {
                    SelectedValue = CValue;
                }

            }
            public DropDownList()
            {

                PreRender += new EventHandler(PreRender_Control);
            }

        }
        //TuanDA
        public class DropDownCareer : System.Web.UI.WebControls.DropDownList
        {

            private string _LText;
            private string _FieldValue;
            private string _CValue;
            private string _FieldParent;
            private string _FieldText;
            private string _TableName;
            private int _Value;
            public string CValue
            {
                get { return _CValue; }
                set { _CValue = value; }
            }
            public string FieldParent
            {
                get { return _FieldParent; }
                set { _FieldParent = value; }
            }
            public string FieldText
            {
                get { return _FieldText; }
                set { _FieldText = value; }
            }
            public string FieldValue
            {
                get { return _FieldValue; }
                set { _FieldValue = value; }
            }
            public string LText
            {
                get { return _LText; }
                set { _LText = value; }
            }
            public string TableName
            {
                get { return _TableName; }
                set { _TableName = value; }
            }
            public int Value
            {
                get { return _Value; }
                set { _Value = value; }
            }
            public override string SelectedValue
            {
                get
                {
                    return base.SelectedValue;
                }
                set
                {
                    if (this.Items.Count > 0)
                    { base.SelectedValue = value; }
                }
            }
            public void bindToDropDown(DropDownCareer ddl)
            {
                if (ddl.Items.Count == 0)
                {
                    string str1;
                    str1 = "SELECT * FROM " + this.TableName + " WHERE ((PK_CAREER <> " + this.Value + " ) ) ORDER BY C_ORDER";
                    ITCLIB.Admin.SQL thu = new ITCLIB.Admin.SQL();
                    DataTable data1 = thu.query_data(str1);
                    foreach (DataRow dr in data1.Rows)
                    {
                        string child = "-----";
                        if (dr[this.FieldParent].ToString() == "0")
                        {
                            ListItem item = new ListItem();
                            item.Text = dr[this.FieldText].ToString();
                            item.Value = dr[this.FieldValue].ToString();
                            item.Attributes.Add("class", "ddlCareer_1");
                            string tempkey = dr[this.FieldValue].ToString();
                            ddl.Items.Add(item);
                            GetChildItems(tempkey, data1, ddl, child);
                        }
                    }
                    ListItem topitem = new ListItem();
                    topitem.Text = this.LText;
                    topitem.Value = "0";
                    topitem.Attributes.Add("class", "ddlCareer_0");
                    ddl.Items.Insert(0, topitem);
                }
            }
            private void GetChildItems(string parentID, DataTable dtTemp, DropDownCareer ddl, string child)
            {
                foreach (DataRow drr in dtTemp.Rows)
                {
                    string temp = child;
                    if (drr[this.FieldParent].ToString() == parentID.ToString())
                    {
                        ListItem chilitem = new ListItem();
                        chilitem.Text = child + drr[this.FieldText].ToString();
                        chilitem.Value = drr[this.FieldValue].ToString();
                        child = child + "-----";
                        chilitem.Attributes.Add("class", "ddlCareer_2");
                        ddl.Items.Add(chilitem);
                        string tempkeyr = drr[this.FieldValue].ToString();
                        GetChildItems(tempkeyr, dtTemp, ddl, child);
                    }
                    child = temp;
                }
            }
            protected void PreRender_Control(object sender, EventArgs e)
            {
                bindToDropDown(this);
                //  HttpContext.Current.Response.Write("vhjg" + CValue +"thu" + SelectedValue);    
                if (CValue != null)
                {
                    SelectedValue = CValue;
                }

            }
            public DropDownCareer()
            {

                PreRender += new EventHandler(PreRender_Control);
            }

        }
    }
    //TuanDA
    namespace Security
    {
        public class User
        {
            private int userid, usertype, companyID;
            private string loginname;
            private string username;
            public int Userid { set { userid = value; } get { return userid; } }
            public int Companyid { set { companyID = value; } get { return companyID; } }
            public string LoginName { set { loginname = value; } get { return loginname; } }
            public string UserName { set { username = value; } get { return username; } }
            public int UsertypeID { set { usertype = value; } get { return usertype; } }
        }
        public class Security
        {
            public static void ReturnUrl()
            {
                if (HttpContext.Current.Session["LastUrl"] == null)
                {
                    HttpContext.Current.Response.Redirect("Login.aspx", true);
                }
                else if (HttpContext.Current.Session["LastUrl"].ToString() == HttpContext.Current.Request.Url.ToString())
                {
                    HttpContext.Current.Response.Redirect("Default.aspx", true);
                }
                else
                {
                    HttpContext.Current.Response.Redirect(HttpContext.Current.Session["LastUrl"].ToString(), true);
                }
            }
            public static string Encrypt(string sPassword)
            {
                System.Security.Cryptography.MD5CryptoServiceProvider x = new System.Security.Cryptography.MD5CryptoServiceProvider();
                byte[] bs = System.Text.Encoding.UTF8.GetBytes(sPassword);
                bs = x.ComputeHash(bs);
                System.Text.StringBuilder s = new System.Text.StringBuilder();
                foreach (byte b in bs)
                {
                    s.Append(b.ToString("x2").ToLower());
                }
                return s.ToString();
            }
            public static void CheckPermissionModule(int guID)
            {
                string SelectPK_Module = "Select MODULE.PK_ID FROM MODULE";
                DataTable oDataTable = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                oDataTable = SelectQuery.query_data(SelectPK_Module);
                string InsertT_USERTYPE_MODULE = "";
                foreach (DataRow oRow in oDataTable.Rows)
                {
                    string SelectC_LEVELPERMISSION = "Select C_LEVELPERMISSION FROM GROUPUSER_MODULE WHERE FK_GROUPUSER=" + guID + " AND FK_MODULE=" + oRow["PK_ID"];
                    DataTable oDataTable1 = new DataTable();
                    ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
                    oDataTable1 = SelectQuery1.query_data(SelectC_LEVELPERMISSION);
                    if (oDataTable1.Rows.Count == 0)
                    {
                        InsertT_USERTYPE_MODULE += ";INSERT INTO GROUPUSER_MODULE(FK_GROUPUSER,FK_MODULE,C_LEVELPERMISSION) VALUES(" + guID + "," + oRow["PK_ID"] + ",0)";
                    }
                }
                if (InsertT_USERTYPE_MODULE != "")
                {
                    ITCLIB.Admin.SQL result = new ITCLIB.Admin.SQL();
                    result.ExecuteNonQuery(InsertT_USERTYPE_MODULE);
                }
            }
            public int ConvertPermissionToDB(bool value1, bool value2, bool value3, bool value4, bool value5)
            {
                int result1, result2, result3, result4, result5;
                int result;
                if (value1 == true)
                {
                    result1 = 1;
                }
                else
                {
                    result1 = 0;
                }
                if (value2 == true)
                {
                    result2 = 1;
                }
                else
                {
                    result2 = 0;
                }
                if (value3 == true)
                {
                    result3 = 1;
                }
                else
                {
                    result3 = 0;
                }
                if (value4 == true)
                {
                    result4 = 1;
                }
                else
                {
                    result4 = 0;
                }

                if (value5 == true)
                {
                    result5 = 1;
                }
                else
                {
                    result5 = 0;
                }

                result = result5 * 16 + result4 * 8 + result3 * 4 + result2 * 2 + result1;
                return result;
            }
            public static bool ConvertPermissionToView(int value, int pos)
            {
                bool Result = false;
                int[] result = new int[5];
                int[] result1 = new int[5];
                result[4] = value % 2;
                double temp = value / 2;
                result1[4] = (int)System.Math.Floor(temp);

                result[3] = result1[4] % 2;
                temp = result1[4] / 2;
                result1[3] = (int)System.Math.Floor(temp);

                result[2] = result1[3] % 2;
                temp = result1[3] / 2;
                result1[2] = (int)System.Math.Floor(temp);

                result[1] = result1[2] % 2;
                temp = result1[2] / 2;
                result[0] = (int)System.Math.Floor(temp);
                switch (pos)
                {
                    case 1: //View
                        if (result[4] == 1)
                        {
                            Result = true;
                        }
                        else
                        {
                            Result = false;
                        }
                        break;
                    case 2: // Add
                        if (result[3] == 1)
                        {
                            Result = true;
                        }
                        else
                        {
                            Result = false;
                        }
                        break;
                    case 3: //Edit
                        if (result[2] == 1)
                        {
                            Result = true;
                        }
                        else
                        {
                            Result = false;
                        }
                        break;
                    case 4: //Delete
                        if (result[1] == 1)
                        {
                            Result = true;
                        }
                        else
                        {
                            Result = false;
                        }
                        break;
                    case 5: //Active
                        if (result[0] == 1)
                        {
                            Result = true;
                        }
                        else
                        {
                            Result = false;
                        }
                        break;
                }
                return Result;
            }
            public static void Config()
            {
                if (HttpContext.Current.Request.QueryString["config"] == "config")
                {
                    HttpContext.Current.Session.Timeout = 300;
                    User sUser = new User();
                    sUser.UsertypeID = 0;
                    sUser.Userid = 1;
                    HttpContext.Current.Session["User"] = sUser;
                    HttpContext.Current.Session["UserID"] = 1;
                    HttpContext.Current.Response.Redirect("Default.aspx", true);
                }
            }
            public static bool IsLogedIn()
            {
                System.Web.SessionState.HttpSessionState session = System.Web.HttpContext.Current.Session;
                if (session["User"] != null)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            public static bool IsSysAdmin()
            {
                System.Web.SessionState.HttpSessionState session = System.Web.HttpContext.Current.Session;
                if (session["User"] != null)
                {
                    User user = new User();
                    user = (User)session["User"];
                    if (user.UsertypeID == 0)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                else
                {
                    return false;
                }
            }
            public static bool CanViewModule(string ModuleType)
            {
                bool Result = false;
                int permission = 0;
                int guID;
                System.Web.SessionState.HttpSessionState session = System.Web.HttpContext.Current.Session;
                if (session["User"] != null)
                {
                    User user = new User();
                    user = (User)session["User"];
                    guID = user.UsertypeID;
                    if (guID == 0)
                    {
                        Result = true;
                    }
                    else
                    {
                        string SelectC_LEVELPERMISSION = "Select GROUPUSER_MODULE.C_LEVELPERMISSION FROM GROUPUSER_MODULE INNER JOIN MODULE ON GROUPUSER_MODULE.FK_MODULE = MODULE.PK_ID WHERE GROUPUSER_MODULE.FK_GROUPUSER=" + guID + " AND MODULE.C_TYPE='" + ModuleType + "'";
                        DataTable oDataTable = new DataTable();
                        ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
                        oDataTable = SelectQuery1.query_data(SelectC_LEVELPERMISSION);
                        if (oDataTable.Rows.Count != 0)
                        {
                            permission = (int)oDataTable.Rows[0]["C_LEVELPERMISSION"];
                        }
                        if (permission != 0)
                        {
                            Result = true;
                        }
                        else
                        {
                            Result = false;
                        }
                    }
                }
                else
                {
                    Result = false;
                }
                return Result;
            }
            public static bool CanAddModule(string ModuleType)
            {
                int permission = 0;
                int guID;
                System.Web.SessionState.HttpSessionState session = System.Web.HttpContext.Current.Session;
                if (session["User"] != null)
                {
                    User user = new User();
                    user = (User)session["User"];
                    guID = user.UsertypeID;
                    if (guID == 0)
                    {
                        return true;
                    }
                    else
                    {
                        string SelectC_LEVELPERMISSION = "Select GROUPUSER_MODULE.C_LEVELPERMISSION FROM GROUPUSER_MODULE INNER JOIN MODULE ON GROUPUSER_MODULE.FK_MODULE = MODULE.PK_ID WHERE GROUPUSER_MODULE.FK_GROUPUSER=" + guID + " AND MODULE.C_TYPE='" + ModuleType + "'";
                        DataTable oDataTable = new DataTable();
                        ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
                        oDataTable = SelectQuery1.query_data(SelectC_LEVELPERMISSION);
                        if (oDataTable.Rows.Count != 0)
                        {
                            permission = (int)oDataTable.Rows[0]["C_LEVELPERMISSION"];

                        }
                        if (ConvertPermissionToView(permission, 2))
                        {
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                    }
                }
                else
                {
                    return false;
                }
            }
            public static bool CanEditModule(string ModuleType)
            {
                int permission = 0;
                int guID;
                System.Web.SessionState.HttpSessionState session = System.Web.HttpContext.Current.Session;
                if (session["User"] != null)
                {
                    User user = new User();
                    user = (User)session["User"];
                    guID = user.UsertypeID;
                    if (guID == 0)
                    {
                        return true;
                    }
                    else
                    {
                        string SelectC_LEVELPERMISSION = "Select GROUPUSER_MODULE.C_LEVELPERMISSION FROM GROUPUSER_MODULE INNER JOIN MODULE ON GROUPUSER_MODULE.FK_MODULE = MODULE.PK_ID WHERE GROUPUSER_MODULE.FK_GROUPUSER=" + guID + " AND MODULE.C_TYPE='" + ModuleType + "'";
                        DataTable oDataTable = new DataTable();
                        ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
                        oDataTable = SelectQuery1.query_data(SelectC_LEVELPERMISSION);
                        if (oDataTable.Rows.Count != 0)
                        {
                            permission = (int)oDataTable.Rows[0]["C_LEVELPERMISSION"];

                        }
                        if (ConvertPermissionToView(permission, 3))
                        {
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                    }
                }
                else
                {
                    return false;
                }
            }
            public static bool CanDeleteModule(string ModuleType)
            {
                int permission = 0;
                int guID;
                System.Web.SessionState.HttpSessionState session = System.Web.HttpContext.Current.Session;
                if (session["User"] != null)
                {
                    User user = new User();
                    user = (User)session["User"];
                    guID = user.UsertypeID;
                    if (guID == 0)
                    {
                        return true;
                    }
                    else
                    {
                        string SelectC_LEVELPERMISSION = "Select GROUPUSER_MODULE.C_LEVELPERMISSION FROM GROUPUSER_MODULE INNER JOIN MODULE ON GROUPUSER_MODULE.FK_MODULE = MODULE.PK_ID WHERE GROUPUSER_MODULE.FK_GROUPUSER=" + guID + " AND MODULE.C_TYPE='" + ModuleType + "'";
                        DataTable oDataTable = new DataTable();
                        ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
                        oDataTable = SelectQuery1.query_data(SelectC_LEVELPERMISSION);
                        if (oDataTable.Rows.Count != 0)
                        {
                            permission = (int)oDataTable.Rows[0]["C_LEVELPERMISSION"];

                        }
                        if (ConvertPermissionToView(permission, 4))
                        {
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                    }
                }
                else
                {
                    return false;
                }
            }
            public static bool CanPrintModule(string ModuleType)
            {
                int permission = 0;
                int guID;
                System.Web.SessionState.HttpSessionState session = System.Web.HttpContext.Current.Session;
                if (session["User"] != null)
                {
                    User user = new User();
                    user = (User)session["User"];
                    guID = user.UsertypeID;
                    if (guID == 0)
                    {
                        return true;
                    }
                    else
                    {
                        string SelectC_LEVELPERMISSION = "Select GROUPUSER_MODULE.C_LEVELPERMISSION FROM GROUPUSER_MODULE INNER JOIN MODULE ON GROUPUSER_MODULE.FK_MODULE = MODULE.PK_ID WHERE GROUPUSER_MODULE.FK_GROUPUSER=" + guID + " AND MODULE.C_TYPE='" + ModuleType + "'";
                        DataTable oDataTable = new DataTable();
                        ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
                        oDataTable = SelectQuery1.query_data(SelectC_LEVELPERMISSION);
                        if (oDataTable.Rows.Count != 0)
                        {
                            permission = (int)oDataTable.Rows[0]["C_LEVELPERMISSION"];

                        }
                        if (ConvertPermissionToView(permission, 5))
                        {
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                    }
                }
                else
                {
                    return false;
                }
            }
            public static User LoadUser(string PK_USER)
            {
                string SelectSQL = "Select USERS.* FROM USERS WHERE USERS.PK_USER=" + PK_USER;
                DataTable oDataTable = new DataTable();
                ITCLIB.Admin.SQL SelectQuery1 = new ITCLIB.Admin.SQL();
                oDataTable = SelectQuery1.query_data(SelectSQL);
                ITCLIB.Security.User sUser = new ITCLIB.Security.User();
                if (oDataTable.Rows.Count == 1)
                {
                    sUser.UsertypeID = (int)oDataTable.Rows[0]["FK_GROUPUSER"];
                    sUser.Userid = (int)oDataTable.Rows[0]["PK_USER"];
                    sUser.LoginName = oDataTable.Rows[0]["LOGINNAME"].ToString(); ;
                    sUser.UserName = oDataTable.Rows[0]["FULLNAME"].ToString();
                }
                return sUser;
            }
        }
    }
    //TuanDA
    namespace ErrorLog
    {
        public class ErrorLog
        {
            public static void WriteError(string errorMessage)
            {
                try
                {
                    string path = "~/Log" + "/ErrorLog/" + DateTime.Today.Year + "/" + DateTime.Today.Month;
                    if (!Directory.Exists(System.Web.HttpContext.Current.Server.MapPath(path)))
                    {
                        System.IO.Directory.CreateDirectory(System.Web.HttpContext.Current.Server.MapPath(path));
                    }
                    string pathFile = path + "/" + DateTime.Today.Day + ".txt";
                    if (!File.Exists(System.Web.HttpContext.Current.Server.MapPath(pathFile)))
                    {
                        File.Create(System.Web.HttpContext.Current.Server.MapPath(pathFile)).Close();
                    }
                    using (StreamWriter w = File.AppendText(System.Web.HttpContext.Current.Server.MapPath(pathFile)))
                    {
                        w.Write("Thời gian lỗi : ");
                        w.WriteLine("{0}", String.Format("{0:yyyy-MM-dd HH:mm:ss tt}", System.DateTime.Now));
                        w.Write("Địa chỉ IP : ");
                        w.WriteLine(System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"]);
                        string err = "Đường dẫn lỗi: " + System.Web.HttpContext.Current.Request.Url.ToString() +
                                      ". \r\nNội dung lỗi:" + errorMessage;
                        w.WriteLine(err);
                        w.WriteLine("__________________________");
                        w.Flush();
                        w.Close();
                    }
                }
                catch (Exception ex)
                {
                    WriteError(ex.Message);
                }
            }
        }
    }
    //TuanDA
    namespace ActionLog
    {
        public class ActionLog
        {
            public static void WriteLog(string username, string module, string action)
            {
                try
                {
                    string path = "~/Log" + "/ActionLog/" + DateTime.Today.Year + "/" + DateTime.Today.Month;
                    if (!Directory.Exists(System.Web.HttpContext.Current.Server.MapPath(path)))
                    {
                        System.IO.Directory.CreateDirectory(System.Web.HttpContext.Current.Server.MapPath(path));
                    }
                    string pathFile = path + "/" + DateTime.Today.Day + ".txt";
                    if (!File.Exists(System.Web.HttpContext.Current.Server.MapPath(pathFile)))
                    {
                        File.Create(System.Web.HttpContext.Current.Server.MapPath(pathFile)).Close();
                    }
                    using (StreamWriter w = File.AppendText(System.Web.HttpContext.Current.Server.MapPath(pathFile)))
                    {
                        w.Write("Thời gian: ");
                        w.WriteLine("{0}", String.Format("{0:yyyy-MM-dd HH:mm:ss tt}", System.DateTime.Now));
                        w.Write("Địa chỉ IP : ");
                        w.WriteLine(System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"]);
                        w.Write("Tài khoản : ");
                        w.WriteLine(username);
                        w.Write("Module : ");
                        w.WriteLine(module);
                        w.Write("Kết quả : ");
                        w.WriteLine(action);
                        w.WriteLine("__________________________");
                        w.Flush();
                        w.Close();
                    }
                }
                catch (Exception ex)
                {
                    WriteLog(username, "Lỗi", ex.Message);
                }
            }
        }
    }
    //TuanDA
    namespace Filter
    {
        public class FilteringGroupUserOffice : GridTemplateColumn
        {
            protected override void SetupFilterControls(TableCell cell)
            {
                RadComboBox rcBox = new RadComboBox();
                rcBox.ID = "DropDownList1";
                rcBox.AutoPostBack = true;
                rcBox.Filter = RadComboBoxFilter.Contains;
                rcBox.DataTextField = this.DataField;
                rcBox.DataValueField = this.DataField;
                rcBox.SelectedIndexChanged += rcBox_SelectedIndexChanged;
                DataTable oDataTable = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                string SelectStr = (string.Format("SELECT DISTINCT {0} AS GROUPUSERNAME FROM {1} WHERE PK_ID <> 0 AND C_TYPE = 0", "C_NAME", "GROUPUSER"));
                oDataTable = SelectQuery.query_data(SelectStr);
                DataRow row = oDataTable.NewRow();
                row[this.DataField] = "";
                oDataTable.Rows.InsertAt(row, 0);
                rcBox.DataSource = oDataTable;
                cell.Controls.Add(rcBox);
            }
            protected override void SetCurrentFilterValueToControl(TableCell cell)
            {
                if (!(this.CurrentFilterValue == ""))
                {
                    ((RadComboBox)cell.Controls[0]).Items.FindItemByText(this.CurrentFilterValue).Selected = true;
                }
            }

            protected override string GetCurrentFilterValueFromControl(TableCell cell)
            {
                string currentValue = ((RadComboBox)cell.Controls[0]).SelectedItem.Value;
                this.CurrentFilterFunction = (currentValue != "") ? GridKnownFunction.EqualTo : GridKnownFunction.NoFilter;
                return currentValue;
            }

            private void rcBox_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
            {
                ((GridFilteringItem)(((RadComboBox)sender).Parent.Parent)).FireCommandEvent("Filter", new Pair());
            }
        }
        public class Filtering : GridTemplateColumn
        {
            private string _TableName;
            private string _Conditions;
            private string _FieldRoot;
            public string TableName
            {
                get
                {
                    return this._TableName;
                }
                set
                {
                    this._TableName = value;
                }
            }
            public string Conditions
            {
                get
                {
                    return this._Conditions;
                }
                set
                {
                    this._Conditions = value;
                }
            }
            public string FieldRoot
            {
                get
                {
                    return this._FieldRoot;
                }
                set
                {
                    this._FieldRoot = value;
                }
            }
            protected override void SetupFilterControls(TableCell cell)
            {
                RadComboBox rcBox = new RadComboBox();
                rcBox.ID = "DropDownList1";
                rcBox.AutoPostBack = true;
                rcBox.Filter = RadComboBoxFilter.Contains;
                rcBox.DataTextField = this.DataField;
                rcBox.DataValueField = this.DataField;
                rcBox.SelectedIndexChanged += rcBox_SelectedIndexChanged;
                DataTable oDataTable = new DataTable();
                Admin.SQL SelectQuery = new Admin.SQL();
                string SelectStr;
                if (this.FieldRoot.Trim() != "")
                {
                    if (this.Conditions.Trim() != "")
                    {
                        SelectStr = string.Format("SELECT {0} AS {1} FROM {2} WHERE {3}", this.FieldRoot, this.DataField, this.TableName, this.Conditions);
                    }
                    else
                    {
                        SelectStr = string.Format("SELECT {0} AS {1} FROM {2}", this.FieldRoot, this.DataField, this.TableName);
                    }
                }
                else
                {
                    if (this.Conditions.Trim() != "")
                    {
                        SelectStr = string.Format("SELECT {0} FROM {1} WHERE {2}", this.DataField, this.TableName, this.Conditions);
                    }
                    else
                    {
                        SelectStr = string.Format("SELECT {0} FROM {1}", this.DataField, this.TableName);
                    }
                }

                oDataTable = SelectQuery.query_data(SelectStr);
                DataRow row = oDataTable.NewRow();
                row[this.DataField] = "";
                oDataTable.Rows.InsertAt(row, 0);
                rcBox.DataSource = oDataTable;
                cell.Controls.Add(rcBox);
            }

            protected override void SetCurrentFilterValueToControl(TableCell cell)
            {
                if (!(this.CurrentFilterValue == ""))
                {
                    ((RadComboBox)cell.Controls[0]).Items.FindItemByText(this.CurrentFilterValue).Selected = true;
                }
            }

            protected override string GetCurrentFilterValueFromControl(TableCell cell)
            {
                string currentValue = ((RadComboBox)cell.Controls[0]).SelectedItem.Value;
                this.CurrentFilterFunction = (currentValue != "") ? GridKnownFunction.EqualTo : GridKnownFunction.NoFilter;
                return currentValue;
            }

            private void rcBox_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
            {
                ((GridFilteringItem)(((RadComboBox)sender).Parent.Parent)).FireCommandEvent("Filter", new Pair());
            }
        }
        public class FilteringGroupUserCompany : GridTemplateColumn
        {
            protected override void SetupFilterControls(TableCell cell)
            {
                RadComboBox rcBox = new RadComboBox();
                rcBox.ID = "DropDownList1";
                rcBox.AutoPostBack = true;
                rcBox.Filter = RadComboBoxFilter.Contains;
                rcBox.DataTextField = this.DataField;
                rcBox.DataValueField = this.DataField;
                rcBox.SelectedIndexChanged += rcBox_SelectedIndexChanged;
                DataTable oDataTable = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                string SelectStr = (string.Format("SELECT DISTINCT {0} AS GROUPUSERNAME FROM {1} WHERE PK_ID <> 0 AND C_TYPE = 1", "C_NAME", "GROUPUSER"));
                oDataTable = SelectQuery.query_data(SelectStr);
                DataRow row = oDataTable.NewRow();
                row[this.DataField] = "";
                oDataTable.Rows.InsertAt(row, 0);
                rcBox.DataSource = oDataTable;
                cell.Controls.Add(rcBox);
            }

            protected override void SetCurrentFilterValueToControl(TableCell cell)
            {
                if (!(this.CurrentFilterValue == ""))
                {
                    ((RadComboBox)cell.Controls[0]).Items.FindItemByText(this.CurrentFilterValue).Selected = true;
                }
            }

            protected override string GetCurrentFilterValueFromControl(TableCell cell)
            {
                string currentValue = ((RadComboBox)cell.Controls[0]).SelectedItem.Value;
                this.CurrentFilterFunction = (currentValue != "") ? GridKnownFunction.EqualTo : GridKnownFunction.NoFilter;
                return currentValue;
            }

            private void rcBox_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
            {
                ((GridFilteringItem)(((RadComboBox)sender).Parent.Parent)).FireCommandEvent("Filter", new Pair());
            }
        }
        public class FilteringGroupUserAdmin : GridTemplateColumn
        {
            protected override void SetupFilterControls(TableCell cell)
            {
                RadComboBox rcBox = new RadComboBox();
                rcBox.ID = "DropDownList1";
                rcBox.AutoPostBack = true;
                rcBox.Filter = RadComboBoxFilter.Contains;
                rcBox.DataTextField = this.DataField;
                rcBox.DataValueField = this.DataField;
                rcBox.SelectedIndexChanged += rcBox_SelectedIndexChanged;
                DataTable oDataTable = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                string SelectStr = (string.Format("SELECT DISTINCT {0} AS GROUPUSERNAME FROM {1} WHERE PK_ID <> 0 AND C_TYPE = 0", "C_NAME", "GROUPUSER"));
                oDataTable = SelectQuery.query_data(SelectStr);
                DataRow row = oDataTable.NewRow();
                row[this.DataField] = "";
                oDataTable.Rows.InsertAt(row, 0);
                rcBox.DataSource = oDataTable;
                cell.Controls.Add(rcBox);
            }

            protected override void SetCurrentFilterValueToControl(TableCell cell)
            {
                if (!(this.CurrentFilterValue == ""))
                {
                    ((RadComboBox)cell.Controls[0]).Items.FindItemByText(this.CurrentFilterValue).Selected = true;
                }
            }

            protected override string GetCurrentFilterValueFromControl(TableCell cell)
            {
                string currentValue = ((RadComboBox)cell.Controls[0]).SelectedItem.Value;
                this.CurrentFilterFunction = (currentValue != "") ? GridKnownFunction.EqualTo : GridKnownFunction.NoFilter;
                return currentValue;
            }

            private void rcBox_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
            {
                ((GridFilteringItem)(((RadComboBox)sender).Parent.Parent)).FireCommandEvent("Filter", new Pair());
            }
        }
        public class FilteringGroupDTKH : GridTemplateColumn
        {
            protected override void SetupFilterControls(TableCell cell)
            {
                RadComboBox rcBox = new RadComboBox();
                rcBox.ID = "DropDownList1";
                rcBox.AutoPostBack = true;
                rcBox.Filter = RadComboBoxFilter.Contains;
                rcBox.DataTextField = this.DataField;
                rcBox.DataValueField = this.DataField;
                rcBox.SelectedIndexChanged += rcBox_SelectedIndexChanged;
                RadComboBoxItem Item0 = new RadComboBoxItem("Tất cả", "");
                RadComboBoxItem Item1 = new RadComboBoxItem("Không thực hiện", "Không thực hiện");
                RadComboBoxItem Item2 = new RadComboBoxItem("Chưa nghiệm thu", "Chưa nghiệm thu");
                RadComboBoxItem Item3 = new RadComboBoxItem("Đã nghiệm thu", "Đã nghiệm thu");
                rcBox.Items.Add(Item0);
                rcBox.Items.Add(Item1);
                rcBox.Items.Add(Item2);
                rcBox.Items.Add(Item3);
                cell.Controls.Add(rcBox);
            }

            protected override void SetCurrentFilterValueToControl(TableCell cell)
            {
                if (!(this.CurrentFilterValue == ""))
                {
                    ((RadComboBox)cell.Controls[0]).Items.FindItemByText(this.CurrentFilterValue).Selected = true;
                }
            }

            protected override string GetCurrentFilterValueFromControl(TableCell cell)
            {
                string currentValue = ((RadComboBox)cell.Controls[0]).SelectedItem.Value;
                this.CurrentFilterFunction = (currentValue != "") ? GridKnownFunction.EqualTo : GridKnownFunction.NoFilter;
                return currentValue;
            }

            private void rcBox_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
            {
                ((GridFilteringItem)(((RadComboBox)sender).Parent.Parent)).FireCommandEvent("Filter", new Pair());
            }
        }
        public class FilteringGroupDUAN : GridTemplateColumn
        {
            protected override void SetupFilterControls(TableCell cell)
            {
                RadComboBox rcBox = new RadComboBox();
                rcBox.ID = "DropDownList1";
                rcBox.AutoPostBack = true;
                rcBox.Filter = RadComboBoxFilter.Contains;
                rcBox.DataTextField = this.DataField;
                rcBox.DataValueField = this.DataField;
                rcBox.SelectedIndexChanged += rcBox_SelectedIndexChanged;
                DataTable oDataTable = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                string SelectStr = (string.Format("SELECT DISTINCT {0} AS TRANGTHAIDUAN FROM {1}", "C_NAME", "DMTTDUAN"));
                oDataTable = SelectQuery.query_data(SelectStr);
                DataRow row = oDataTable.NewRow();
                row[this.DataField] = "";
                oDataTable.Rows.InsertAt(row, 0);
                rcBox.DataSource = oDataTable;
                cell.Controls.Add(rcBox);
            }

            protected override void SetCurrentFilterValueToControl(TableCell cell)
            {
                if (!(this.CurrentFilterValue == ""))
                {
                    ((RadComboBox)cell.Controls[0]).Items.FindItemByText(this.CurrentFilterValue).Selected = true;
                }
            }

            protected override string GetCurrentFilterValueFromControl(TableCell cell)
            {
                string currentValue = ((RadComboBox)cell.Controls[0]).SelectedItem.Value;
                this.CurrentFilterFunction = (currentValue != "") ? GridKnownFunction.EqualTo : GridKnownFunction.NoFilter;
                return currentValue;
            }

            private void rcBox_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
            {
                ((GridFilteringItem)(((RadComboBox)sender).Parent.Parent)).FireCommandEvent("Filter", new Pair());
            }
        }
        public class FilteringGroupNguonKP : GridTemplateColumn
        {
            protected override void SetupFilterControls(TableCell cell)
            {
                RadComboBox rcBox = new RadComboBox();
                rcBox.ID = "DropDownList1";
                rcBox.AutoPostBack = true;
                rcBox.Filter = RadComboBoxFilter.Contains;
                rcBox.DataTextField = this.DataField;
                rcBox.DataValueField = this.DataField;
                rcBox.SelectedIndexChanged += rcBox_SelectedIndexChanged;
                DataTable oDataTable = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                string SelectStr = (string.Format("SELECT DISTINCT {0} AS NGUONKINHPHI FROM {1}", "C_NAME", "DMNGUONKINHPHI"));
                oDataTable = SelectQuery.query_data(SelectStr);
                DataRow row = oDataTable.NewRow();
                row[this.DataField] = "";
                oDataTable.Rows.InsertAt(row, 0);
                rcBox.DataSource = oDataTable;
                cell.Controls.Add(rcBox);
            }

            protected override void SetCurrentFilterValueToControl(TableCell cell)
            {
                if (!(this.CurrentFilterValue == ""))
                {
                    ((RadComboBox)cell.Controls[0]).Items.FindItemByText(this.CurrentFilterValue).Selected = true;
                }
            }

            protected override string GetCurrentFilterValueFromControl(TableCell cell)
            {
                string currentValue = ((RadComboBox)cell.Controls[0]).SelectedItem.Value;
                this.CurrentFilterFunction = (currentValue != "") ? GridKnownFunction.EqualTo : GridKnownFunction.NoFilter;
                return currentValue;
            }

            private void rcBox_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
            {
                ((GridFilteringItem)(((RadComboBox)sender).Parent.Parent)).FireCommandEvent("Filter", new Pair());
            }
        }
        public class FilteringGroupNguonVon : GridTemplateColumn
        {
            protected override void SetupFilterControls(TableCell cell)
            {
                RadComboBox rcBox = new RadComboBox();
                rcBox.ID = "DropDownList1";
                rcBox.AutoPostBack = true;
                rcBox.Filter = RadComboBoxFilter.Contains;
                rcBox.DataTextField = this.DataField;
                rcBox.DataValueField = this.DataField;
                rcBox.SelectedIndexChanged += rcBox_SelectedIndexChanged;
                DataTable oDataTable = new DataTable();
                ITCLIB.Admin.SQL SelectQuery = new ITCLIB.Admin.SQL();
                string SelectStr = (string.Format("SELECT DISTINCT {0} AS NGUONVON FROM {1}", "C_NAME", "DMNGUONVON"));
                oDataTable = SelectQuery.query_data(SelectStr);
                DataRow row = oDataTable.NewRow();
                row[this.DataField] = "";
                oDataTable.Rows.InsertAt(row, 0);
                rcBox.DataSource = oDataTable;
                cell.Controls.Add(rcBox);
            }

            protected override void SetCurrentFilterValueToControl(TableCell cell)
            {
                if (!(this.CurrentFilterValue == ""))
                {
                    ((RadComboBox)cell.Controls[0]).Items.FindItemByText(this.CurrentFilterValue).Selected = true;
                }
            }

            protected override string GetCurrentFilterValueFromControl(TableCell cell)
            {
                string currentValue = ((RadComboBox)cell.Controls[0]).SelectedItem.Value;
                this.CurrentFilterFunction = (currentValue != "") ? GridKnownFunction.EqualTo : GridKnownFunction.NoFilter;
                return currentValue;
            }

            private void rcBox_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
            {
                ((GridFilteringItem)(((RadComboBox)sender).Parent.Parent)).FireCommandEvent("Filter", new Pair());
            }
        }
    }
    //TuanDA
    namespace KHIEUNAI
    {
        public class KHIEUNAI
        {
            #region Private fields
            private int _PK_ID;
            private string _C_CODE;
            private string _C_TYPE;
            private DateTime _C_DATE;
            private string _C_BILL;
            private string _FK_KHACHHANG;
            private string _C_TENKH;
            private string _C_SDT;
            private string _C_NOIDUNG;
            private int _FK_NGUOITAO;
            private string _C_STATUS;
            #endregion
            #region Constructors
            public KHIEUNAI()
            {
            }
            public KHIEUNAI(SqlDataReader reader)
            {
                _PK_ID = Convert.ToInt32(reader["PK_ID"]);
                _C_CODE = reader["C_CODE"].ToString();
                _C_TYPE = reader["C_TYPE"].ToString();
                _C_DATE = Convert.ToDateTime(reader["C_DATE"]);
                _C_BILL = reader["C_BILL"].ToString();
                _FK_KHACHHANG = reader["FK_KHACHHANG"].ToString();
                _C_TENKH = reader["C_TENKH"].ToString();
                _C_SDT = reader["C_SDT"].ToString();
                _C_NOIDUNG = reader["C_NOIDUNG"].ToString();
                _FK_NGUOITAO = Convert.ToInt32(reader["FK_NGUOITAO"]);
                _C_STATUS = reader["C_STATUS"].ToString();
            }
            #endregion
            #region Public properties
            public int PK_ID
            {
                get
                {
                    return this._PK_ID;
                }
                set
                {
                    if ((this._PK_ID != value))
                    {
                        this._PK_ID = value;
                    }
                }
            }
            public string C_CODE
            {
                get
                {
                    return this._C_CODE;
                }
                set
                {
                    if ((this._C_CODE != value))
                    {
                        this._C_CODE = value;
                    }
                }
            }
            public string C_TYPE
            {
                get
                {
                    return this._C_TYPE;
                }
                set
                {
                    if ((this._C_TYPE != value))
                    {
                        this._C_TYPE = value;
                    }
                }
            }
            public DateTime C_DATE
            {
                get
                {
                    return this._C_DATE;
                }
                set
                {
                    if ((this._C_DATE != value))
                    {
                        this._C_DATE = value;
                    }
                }
            }
            public string C_BILL
            {
                get
                {
                    return this._C_BILL;
                }
                set
                {
                    if ((this._C_BILL != value))
                    {
                        this._C_BILL = value;
                    }
                }
            }
            public string FK_KHACHHANG
            {
                get
                {
                    return this._FK_KHACHHANG;
                }
                set
                {
                    if ((this._FK_KHACHHANG != value))
                    {
                        this._FK_KHACHHANG = value;
                    }
                }
            }
            public string C_TENKH
            {
                get
                {
                    return this._C_TENKH;
                }
                set
                {
                    if ((this._C_TENKH != value))
                    {

                        this._C_TENKH = value;
                    }
                }
            }
            public string C_SDT
            {
                get
                {
                    return this._C_SDT;
                }
                set
                {
                    if ((this._C_SDT != value))
                    {

                        this._C_SDT = value;
                    }
                }
            }
            public string C_NOIDUNG
            {
                get
                {
                    return this._C_NOIDUNG;
                }
                set
                {
                    if ((this._C_NOIDUNG != value))
                    {

                        this._C_NOIDUNG = value;
                    }
                }
            }
            public int FK_NGUOITAO
            {
                get
                {
                    return this._FK_NGUOITAO;
                }
                set
                {
                    if ((this._FK_NGUOITAO != value))
                    {

                        this._FK_NGUOITAO = value;
                    }
                }
            }
            public string C_STATUS
            {
                get
                {
                    return this._C_STATUS;
                }
                set
                {
                    if ((this._C_STATUS != value))
                    {

                        this._C_STATUS = value;
                    }
                }
            }
            #endregion
        }
        public class KHIEUNAIList : List<KHIEUNAI>
        {
            #region Constuctors

            public KHIEUNAIList()
            {
                LoadAllKHIEUNAI();
            }

            #endregion

            #region Helper methods

            private void LoadAllKHIEUNAI()
            {
                if (this.Count > 0)
                    this.Clear();

                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DOVEEXPRESSConnectionString"].ConnectionString);
                SqlCommand cmd = new SqlCommand("SELECT [KHIEUNAI].[PK_ID], [KHIEUNAI].[C_CODE], [KHIEUNAI].[C_TYPE], [KHIEUNAI].[C_DATE], [KHIEUNAI].[C_BILL], [KHIEUNAI].[FK_KHACHHANG], [KHIEUNAI].[C_TENKH], [KHIEUNAI].[C_SDT], [KHIEUNAI].[C_NOIDUNG], [KHIEUNAI].[FK_NGUOITAO], [KHIEUNAI].[C_STATUS], USERS.C_NAME as NGUOITAONAME FROM [KHIEUNAI] LEFT OUTER JOIN USERS ON KHIEUNAI.FK_NGUOITAO =USERS.PK_ID ORDER BY C_STATUS ASC, C_DATE DESC", conn);
                cmd.CommandType = CommandType.Text;

                try
                {
                    conn.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        this.Add(new KHIEUNAI(dr));
                    }
                }
                finally
                {
                    conn.Close();
                }
            }

            public KHIEUNAI GetKHIEUNAIByPK_ID(int id)
            {
                foreach (KHIEUNAI khieunai in this)
                {
                    if (khieunai.PK_ID == id)
                    {
                        return khieunai;
                    }
                }
                return null;
            }

            #endregion
        }
    }
    //TuanDA
    namespace BAOGIA
    {
        public class BAOGIA
        {
            #region Private fields
            private int _PK_ID;
            private string _C_CODE;
            private DateTime _C_DATE;
            private string _FK_KHACHHANG;
            private string _C_TENKH;
            private string _C_SDT;
            private string _C_NOIDUNG;
            private int _FK_NGUOITAO;
            private string _C_STATUS;
            #endregion
            #region Constructors
            public BAOGIA()
            {
            }
            public BAOGIA(SqlDataReader reader)
            {
                _PK_ID = Convert.ToInt32(reader["PK_ID"]);
                _C_CODE = reader["C_CODE"].ToString();
                _C_DATE = Convert.ToDateTime(reader["C_DATE"]);
                _FK_KHACHHANG = reader["FK_KHACHHANG"].ToString();
                _C_TENKH = reader["C_TENKH"].ToString();
                _C_SDT = reader["C_SDT"].ToString();
                _C_NOIDUNG = reader["C_NOIDUNG"].ToString();
                _FK_NGUOITAO = Convert.ToInt32(reader["FK_NGUOITAO"]);
                _C_STATUS = reader["C_STATUS"].ToString();
            }
            #endregion
            #region Public properties
            public int PK_ID
            {
                get
                {
                    return this._PK_ID;
                }
                set
                {
                    if ((this._PK_ID != value))
                    {
                        this._PK_ID = value;
                    }
                }
            }
            public string C_CODE
            {
                get
                {
                    return this._C_CODE;
                }
                set
                {
                    if ((this._C_CODE != value))
                    {
                        this._C_CODE = value;
                    }
                }
            }
            public DateTime C_DATE
            {
                get
                {
                    return this._C_DATE;
                }
                set
                {
                    if ((this._C_DATE != value))
                    {
                        this._C_DATE = value;
                    }
                }
            }
            public string FK_KHACHHANG
            {
                get
                {
                    return this._FK_KHACHHANG;
                }
                set
                {
                    if ((this._FK_KHACHHANG != value))
                    {
                        this._FK_KHACHHANG = value;
                    }
                }
            }
            public string C_TENKH
            {
                get
                {
                    return this._C_TENKH;
                }
                set
                {
                    if ((this._C_TENKH != value))
                    {

                        this._C_TENKH = value;
                    }
                }
            }
            public string C_SDT
            {
                get
                {
                    return this._C_SDT;
                }
                set
                {
                    if ((this._C_SDT != value))
                    {

                        this._C_SDT = value;
                    }
                }
            }
            public string C_NOIDUNG
            {
                get
                {
                    return this._C_NOIDUNG;
                }
                set
                {
                    if ((this._C_NOIDUNG != value))
                    {

                        this._C_NOIDUNG = value;
                    }
                }
            }
            public int FK_NGUOITAO
            {
                get
                {
                    return this._FK_NGUOITAO;
                }
                set
                {
                    if ((this._FK_NGUOITAO != value))
                    {

                        this._FK_NGUOITAO = value;
                    }
                }
            }
            public string C_STATUS
            {
                get
                {
                    return this._C_STATUS;
                }
                set
                {
                    if ((this._C_STATUS != value))
                    {

                        this._C_STATUS = value;
                    }
                }
            }
            #endregion
        }
        public class BAOGIAList : List<BAOGIA>
        {
            #region Constuctors

            public BAOGIAList()
            {
                LoadAllBAOGIA();
            }

            #endregion

            #region Helper methods

            private void LoadAllBAOGIA()
            {
                if (this.Count > 0)
                    this.Clear();

                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DOVEEXPRESSConnectionString"].ConnectionString);
                SqlCommand cmd = new SqlCommand("SELECT [BAOGIA].[PK_ID], [BAOGIA].[C_CODE], [BAOGIA].[C_DATE], [BAOGIA].[FK_KHACHHANG], [BAOGIA].[C_TENKH], [BAOGIA].[C_SDT], [BAOGIA].[C_NOIDUNG], [BAOGIA].[FK_NGUOITAO], [BAOGIA].[C_STATUS], USERS.C_NAME as NGUOITAONAME FROM [BAOGIA] LEFT OUTER JOIN USERS ON BAOGIA.FK_NGUOITAO =USERS.PK_ID ORDER BY C_STATUS ASC, C_DATE DESC", conn);
                cmd.CommandType = CommandType.Text;

                try
                {
                    conn.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        this.Add(new BAOGIA(dr));
                    }
                }
                finally
                {
                    conn.Close();
                }
            }

            public BAOGIA GetBAOGIAByPK_ID(int id)
            {
                foreach (BAOGIA baogia in this)
                {
                    if (baogia.PK_ID == id)
                    {
                        return baogia;
                    }
                }
                return null;
            }

            #endregion
        }
    }
}

