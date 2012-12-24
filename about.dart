library about;

import "dart:html";
import "dart:json";

class about_box
{
  DivElement content;
  about_me_box about_me;
  about_box()
  {
    content = new Element.html("<div><font style=\"font-size:1.5em\">Welcome to my portfolio website written in <font style=\"font-weight:900;\">Google Dart</font>.</font><p>I wrote this website to learn the exciting new language Dart. The language is barely documented and rapidly changing, which meant I got to <font style=\"font-weight:700;\">explore</font> a new language on the bleeding edge.</p><p>I am a student at Rennsselaer Polytechnic Institute and an Intern at <font style=\"font-weight:700;\">Intel Mobile Communications</font></p></div>");
    DivElement about_me_div = new Element.html("<div style=\"font-size:1em;\"></div>");
    content.nodes.add(about_me_div);
    about_me = new about_me_box();
    about_me_div.nodes.add(about_me.content);
  }
}

class about_me_box
{
  DivElement content;
  Map data;
  about_me_box()
  {
    content = new Element.html("<div class=\"rounded_tile\">Loading...</div>");
    get_about_me();
  }

  void get_about_me()
  {
    var url = "about_me.json"; 
  
    // call the web server asynchronously 
    var request = new HttpRequest.get(url, process_me);
  }

  void process_me(HttpRequest req)
  {
    try {
      data = JSON.parse(req.responseText);
    }
    on Exception catch (ex) {
      document.window.alert(ex.toString());
    }
    update_me();
  }

  void update_me()
  {
    content.nodes.clear();
    content.nodes.add(new Element.html("<p><font style=\"font-size:1.5em;margin-left:auto;margin-right:auto;\">About Me</font></p>"));
    add_text_field(content, "name", "Name");
    add_text_field(content, "email", "E-Mail");
    add_text_field(content, "phone", "Phone Number");

    add_text_field(content, "college", "College");
    add_text_field(content, "class", "Class");
    add_text_field(content, "major", "Major");
    add_text_field(content, "status", "Status");

    add_text_field(content, "editor", "Editor");
    add_comma_list(content, "engines", "Game Engines");
    add_comma_list(content, "languages", "Languages");
    add_comma_list(content, "libraries", "Libraries");
    add_comma_list(content, "vcs", "Version Control Systems");
    add_comma_list(content, "build_systems", "Build Systems");
    add_comma_list(content, "os", "Operating Systems");
    add_comma_list(content, "comment_system", "Comment System");

  }

  void add_text_field(target_div, id_in_data, label)
  {
    if (data[id_in_data] != null)
      {
        target_div.nodes.add(new Element.html("<font style=\"font-weight:900;\">${label}</font>"));
        target_div.nodes.add(new Text(": ${data[id_in_data]}"));
        target_div.nodes.add(new Element.tag("br"));
      }
  }

  void add_comma_list(target_div, id_in_data, label)
  {
    if (data[id_in_data] != null)
      {
        target_div.nodes.add(new Element.html("<font style=\"font-weight:900;\">${label}</font>"));
        target_div.nodes.add(new Text(": "));
        for (int x = 0; x < data[id_in_data].length; ++x)
          {
            if (x != 0)
              target_div.nodes.add(new Text(", "));
            target_div.nodes.add(new Text("${data[id_in_data][x]}"));
          }
        target_div.nodes.add(new Element.tag("br"));
      }
  }
}