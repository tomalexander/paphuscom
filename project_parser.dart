#library("main");

#import("dart:html");
#import("dart:json");


class project_box
{
  DivElement content;
  List parsed_projects;
  String target_project;
  bool has_loaded;

  project_box()
  {
    content = new Element.html("<div>Loading Projects...</div>");
    target_project = "";
    has_loaded = false;
    get_projects();
  }

  void set_filter(String new_filter)
  {

  }

  void update_projects()
  {
    content.nodes.clear();
    if (target_project == "")
      {
        for (int x = 0; x < parsed_projects.length; ++x)
          {
            project proj = new project(parsed_projects[x]);
            content.nodes.add(proj.content);
          }
      } else {
      for (int x = 0; x < parsed_projects.length; ++x)
        {
          if (parsed_projects[x]["title"].replaceAll(" ", "") == target_project)
            {
              project proj = new project(parsed_projects[x]);
              proj.show_long();
              content.nodes.add(proj.content);
            }
        }
      for (int x = 0; x < parsed_projects.length; ++x)
        {
          if (parsed_projects[x]["title"].replaceAll(" ", "") != target_project)
            {
              project proj = new project(parsed_projects[x]);
              content.nodes.add(proj.content);
            }
        }
    }
  }

  void get_projects()
  {
    var url = "projects.json"; 
  
    // call the web server asynchronously 
    var request = new XMLHttpRequest.get(url, process_projects);
  }

  void process_projects(XMLHttpRequest req)
  {
    try {
      parsed_projects = JSON.parse(req.responseText);
    } catch (Exception ex) {
      document.window.alert(ex.toString());
    }
    update_projects();
    has_loaded = true;
  }
  
}

class project
{
  DivElement content;
  DivElement short_div = null;
  DivElement long_div = null;
  Map data;
  project(proj)
  {
    data = proj;
    content = new Element.html("<div>Project!</div>");
    show_short();
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

  void add_image(target_div, src)
  {
    Element link = new Element.html("<a href=\"${src}.png\"></a>");
    ImageElement tmp = new ImageElement("${src}_thumbnail.png");
    link.nodes.add(tmp);
    target_div.nodes.add(link);
  }

  void add_picture_list(target_div)
  {
    if (data["pictures"] != null)
      {
        for (int x = 0; x < data["pictures"].length; ++x)
          {
            add_image(target_div, data["pictures"][x]);
          }
        target_div.nodes.add(new Element.tag("br"));
      }
  }

  void add_video(target_div, src)
  {
    VideoElement ret = new Element.html("<video width=480 height=360 controls>You appear to not have HTML5 support! Try Google Chrome</video>");
    SourceElement src_elem = new Element.html("<source src=\"${src}\" type='video/webm; codecs=\"vp8, vorbis\"'>");
    ret.nodes.add(src_elem);
    target_div.nodes.add(ret);
  }

  void add_video_list(target_div)
  {
    if (data["videos"] != null)
      {
        for (int x = 0; x < data["videos"].length; ++x)
          {
            add_video(target_div, data["videos"][x]);
          }
        target_div.nodes.add(new Element.tag("br"));
      }
  }

  void show_short_history()
  {
    show_short();
    String without_hash = window.location.toString().replaceFirst(window.location.hash, "");
    window.history.replaceState(null, "Projects", "${without_hash}#projects");
  }

  void show_short()
  {
    content.nodes.clear();
    content.nodes.add(new Element.html("<font style=\"font-size:1.5em;\">${data["title"]}</font>"));
    //content.nodes.add(new Text(data["title"]));
    if (short_div == null)
      {
        short_div = new Element.html("<div style=\"font-size:1em; background: #FFFFFFFF;\" class=\"rounded_tile\"></div>");
        add_text_field(short_div, "shortdesc", "Short Description");
        add_text_field(short_div, "type", "Type");
        add_text_field(short_div, "startyear", "Start Year");

        add_picture_list(short_div);
    
        short_div.nodes.add(generate_button("Expand Project", show_long_history));
        if (data["github"] != null)
          short_div.nodes.add(generate_link_button("Github", data["github"]));
        if (data["documentation"] != null)
          short_div.nodes.add(generate_link_button("Documentation", data["documentation"]));
        if (data["source"] != null)
          short_div.nodes.add(generate_link_button("Source Code", data["source"]));
        if (data["binaries"] != null)
          short_div.nodes.add(generate_link_button("Compiled Binaries", data["binaries"]));
      }

    content.nodes.add(short_div);
  }

  void show_long_history()
  {
    try {
    show_long();
    String without_hash = window.location.toString().replaceFirst(window.location.hash, "");
    String without_spaces = data["title"].replaceAll(" ", "");
    if (window.location.hash == "#projects")
      window.history.pushState(null, "Projects", "${without_hash}#projects_${without_spaces}");
    else
      window.history.replaceState(null, "Projects", "${without_hash}#projects_${without_spaces}");
    } catch (Exception ex) {
    document.window.alert(ex.toString());
  }
  }

  void show_long()
  {
    content.nodes.clear();
    content.nodes.add(new Element.html("<font style=\"font-size:1.5em;\">${data["title"]}</font>"));
    //content.nodes.add(new Text(data["title"]));
    if (long_div == null)
      {
        long_div = new Element.html("<div style=\"font-size:1em; background: #FFFFFFFF;\" class=\"rounded_tile\"></div>");

        add_text_field(long_div, "fulldesc", "Full Description");
        add_text_field(long_div, "type", "Type");
        add_text_field(long_div, "class", "Class");
        add_text_field(long_div, "startyear", "Start Year");
        add_comma_list(long_div, "contributors", "Contributors");
        add_text_field(long_div, "role", "My Role");
        add_text_field(long_div, "purpose", "Purpose");
        add_comma_list(long_div, "skills", "Skills Used");
        add_text_field(long_div, "status", "Current Status");
    
        add_picture_list(long_div);
        add_video_list(long_div);

        long_div.nodes.add(generate_button("Shrink Project", show_short_history));
        if (data["github"] != null)
          long_div.nodes.add(generate_link_button("Github", data["github"]));
        if (data["documentation"] != null)
          long_div.nodes.add(generate_link_button("Documentation", data["documentation"]));
        if (data["source"] != null)
          long_div.nodes.add(generate_link_button("Source Code", data["source"]));
        if (data["binaries"] != null)
          long_div.nodes.add(generate_link_button("Compiled Binaries", data["binaries"]));
        if (data["postmortem"] != null)
          long_div.nodes.add(generate_link_button("Post Mortem", data["postmortem"]));
      }

    content.nodes.add(long_div);
  }

  Element generate_button(String title, void action())
  {
    DivElement ret = new Element.html("<div class=\"paphusbutton\"></div>");
    Element ln = new Element.html("<a href=\"javascript:void(0);\">${title}</a>");
    ret.nodes.add(ln);
    ln.on.click.add( (event) {action();} );
    ln.attributes["class"] = "blocklink";
    
    return ret;
  }

  Element generate_link_button(title, dest)
  {
    DivElement ret = new Element.html("<div class=\"paphusbutton\"></div>");
    Element ln = new Element.html("<a href=\"${dest}\">${title}</a>");
    ret.nodes.add(ln);
    ln.attributes["class"] = "blocklink";
    
    return ret;
  }


}
