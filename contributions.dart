library contributions;

import "dart:html";

class contrib_box
{
  DivElement content;
  contrib_box()
  {
    content = new Element.html("<div><font style=\"font-size:1.5em; text-align: center;\">Emacs Org-Mode</font><br><font style=\"font-size:1.2em; text-align: center;\">Tables for Generic Exporter</font><font style=\"font-size:0.9em;\"><p>Emacs Org-Mode has a generic exporter that acts as a framework for writing new formats that can be written from org-mode markup. At the time, I needed an exporting for wiki markup which the generic exporter contained, but they lacked the ability to export tables. I wrote a patch which got merged into master on March 20th 2012.</p><p><a href=\"http://thread.gmane.org/gmane.emacs.orgmode/52142/focus=52142\">http://thread.gmane.org/gmane.emacs.orgmode/52142/focus=52142</a></font></div>");
  }
}