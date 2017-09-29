using Gtk;
using Utils;

namespace Widgets {
    public class EntryMenu : Object {
        public Gtk.Menu menu;
        
        public EntryMenu() {
            Intl.bindtextdomain(GETTEXT_PACKAGE, "/usr/share/locale");
        }

        public void create_entry_menu(Gtk.Entry entry, int x, int y) {
            // Init Menu
            menu = new Gtk.Menu();
            
            if (is_selection(entry)) {
                // Cut
                Gtk.MenuItem cut = new Gtk.MenuItem.with_label("Cut");
                cut.activate.connect (() => {
                     handle_menu_item_click(entry, "cut");
                });
                menu.append(cut);

                // Copy
                Gtk.MenuItem copy = new Gtk.MenuItem.with_label("Copy");
                copy.activate.connect (() => {
                    handle_menu_item_click(entry, "copy");
                });
                menu.append(copy);
            }

            // Paste
            Gtk.MenuItem paste = new Gtk.MenuItem.with_label("Paste");
             paste.activate.connect (() => {
                 handle_menu_item_click(entry, "paste");
            });
            menu.append(paste);

            // ------
            Gtk.SeparatorMenuItem separator_1 = new Gtk.SeparatorMenuItem ();
            menu.add(separator_1);
            if (is_selection(entry)) {
                // Delete
                Gtk.MenuItem delete_btn = new Gtk.MenuItem.with_label("Delete");
                delete_btn.activate.connect (() => {
                     handle_menu_item_click(entry, "delete");
                });
                menu.append(delete_btn);

                // ------
                Gtk.SeparatorMenuItem separator_2 = new Gtk.SeparatorMenuItem ();
                menu.add(separator_2);
            }

            // Select all
            Gtk.MenuItem select_all = new Gtk.MenuItem.with_label("Select all");
            select_all.activate.connect (() => {
                 handle_menu_item_click(entry, "select_all");
            });
            menu.append(select_all);
                        
            // Exec
            menu.show_all();
            menu.popup(null, null, null, 0, 0);
        }

        public void handle_menu_item_click(Gtk.Entry entry, string item_id) {
            switch(item_id) {
                case "cut":
                    entry.cut_clipboard();
                    break;
                case "copy":
                    entry.copy_clipboard();
                    break;
                case "paste":
                    entry.paste_clipboard();
                    break;
                case "delete":
                    entry.delete_selection();
                    break;
                case "select_all":
                    entry.select_region(0, -1);
                    break;
            }
        }        
            
        public bool is_selection(Gtk.Entry entry) {
            int start_pos, end_pos;
            entry.get_selection_bounds(out start_pos, out end_pos);
                
            return start_pos != end_pos;
        }
            
        public void handle_menu_destroy() {
            menu = null;
        }
    }
}