#library("main");

#import("dart:html");
#import("dart:json");
#import("dart:core");
#import("about.dart");
#import("contributions.dart");
#import("project_parser.dart");

DivElement header;
DivElement left;
DivElement content_div;
DivElement footer;
about_box about;
project_box proj;
contrib_box contrib;

class main_layout {
  DivElement content;
  List<DivElement> rows;
  main_nav_bar nav_bar;
  side_nav_bar side_nav;
  main_layout()
  {
    header.nodes.add(new Element.html("<div style=\"margin:0% 3%;float:left\">Tom Alexander's Portfolio</div>"));
    DivElement nav_div = new Element.html("<div style=\"float:right; margin:0% 5%;\"></div>");
    header.nodes.add(nav_div);
    nav_bar = new main_nav_bar();
    nav_div.nodes.add(nav_bar.ul_element);


    side_nav = new side_nav_bar();
  }
}

class main_nav_bar {
  UListElement ul_element;
  List<LIElement> li_elements;
  main_nav_bar()
  {
    ul_element = new Element.html("<ul class=\"main_nav_bar\"></ul>");
    li_elements = new List<LIElement>();
    this.add_link("Home", "/");
    add_link("R&eacute;sum&eacute;", "tom_alexander_resume.pdf");
    add_link("Blog", "http://blog.paphus.com");
  }

  void add_link(title, action)
  {
    LIElement new_link = new Element.html("<li class=\"main_nav_item\"><a class=\"main_nav_item\" href=\"${action}\">${title}</a></li>");
    ul_element.nodes.add(new_link);
    li_elements.add(new_link);
  }
}

void nothing()
{
  
}

void display_about_history()
{
  display_about();
  window.history.pushState(null, "About", "${window.location.pathname}#about");
}

void display_about()
{
  if (about != null)
    {
      content_div.nodes.clear();
      content_div.nodes.add(about.content);
    } else {
    about = new about_box();
    content_div.nodes.clear();
    content_div.nodes.add(about.content);
  }
}

void display_projects_history()
{
  display_projects();
  window.history.pushState(null, "Projects", "${window.location.pathname}#projects");
}

void display_projects()
{
  content_div.nodes.clear();
  content_div.nodes.add(proj.content);
}

void display_contributions_to_open_source_history()
{
  display_contributions_to_open_source();
  window.history.pushState(null, "Contributions to Open Source", "${window.location.pathname}#contrib");
}

void display_contributions_to_open_source()
{
  if (contrib != null)
    {
      content_div.nodes.clear();
      content_div.nodes.add(contrib.content);
    } else {
    contrib = new contrib_box();
    content_div.nodes.clear();
    content_div.nodes.add(contrib.content);
  }
}

class side_nav_bar {
  UListElement ul_element;
  List<LIElement> li_elements;
  int link_index;
  side_nav_bar()
  {
    link_index = 0;
    ul_element = new Element.html("<ul class=\"side_nav_bar\"></ul>");
    left.nodes.add(ul_element);
    li_elements = new List<LIElement>();
    this.add_link("About", display_about_history);
    this.add_link("Programming Projects", display_projects_history);
    this.add_link("Contributions to Open Source", display_contributions_to_open_source_history);
    select_link(0);
  }

  void add_link(title, action)
  {
    LIElement new_link = new Element.html("<li class=\"side_nav_item\"><a class=\"side_nav_item\" href=\"javascript:void(0);\">${title}</a></li>");
    new_link.nodes[0].on.click.add( function(event) {select_link_li(new_link); action();});
    ul_element.nodes.add(new_link);
    li_elements.add(new_link);
  }

  void select_link_li(LIElement target)
  {
    for (int x = 0; x < li_elements.length; ++x)
      {
        li_elements[x].nodes[0].attributes["class"] = "side_nav_item";
      }
    target.nodes[0].attributes["class"] = "selected_side_nav_item";
  }

  void select_link(int index)
  {
    for (int x = 0; x < li_elements.length; ++x)
      {
        li_elements[x].nodes[0].attributes["class"] = "side_nav_item";
      }
    li_elements[index].nodes[0].attributes["class"] = "selected_side_nav_item";
  }
}

void handle_history()
{
  window.on.popState.add((event) {
    String page_name = window.location.hash.replaceFirst('#', '');
    if (page_name == "about" || page_name == "")
      display_about();
    else if (page_name == "contrib")
      display_contributions_to_open_source();
    else if (page_name == "projects")
      display_projects();
    else if (page_name.contains("projects"))
      {
        String proj_name = page_name.replaceFirst("projects_", "");
        proj.target_project = proj_name;
        if (proj.has_loaded)
          proj.update_projects();
        
        display_projects();
      }
  });
}

void main()
{
  try {
    header = document.query("#header");
    left = document.query("#left");
    content_div = document.query("#padded_center");
    footer = document.query("#footer");

    main_layout main_table = new main_layout();
    
    proj = new project_box();
    display_about();
    handle_history();
  }
  catch (Exception ex) {
    document.window.alert(ex.toString());
  }
}