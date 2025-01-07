use cursive::traits::*;
use cursive::views::{Dialog, SelectView};
use cursive::{Cursive, CursiveExt};
use std::path::PathBuf;
use walkdir::WalkDir;

fn main() {
    let mut siv = Cursive::default();
    siv.add_global_callback('q', Cursive::quit);

    // Add an initial button to start browsing directories
    siv.add_layer(
        Dialog::text("Welcome to the Directory Browser!")
            .button("Browse", |siv| {
                // Call show_directory on button click
                show_directory(siv, PathBuf::from("."));
            })
            .button("Quit", |siv| siv.quit()),
    );

    siv.run();
}

fn show_directory(siv: &mut Cursive, path: PathBuf) {
    let mut select_view = SelectView::new();

    // Read the contents of the directory
    for entry in WalkDir::new(&path)
        .min_depth(1)
        .max_depth(1)
        .into_iter()
        .filter_map(Result::ok)
    {
        let file_name = entry.file_name().to_string_lossy().to_string();
        let entry_path = entry.path().to_path_buf();
        if entry.file_type().is_dir() {
            select_view.add_item(format!("📁 {}", file_name), entry_path);
        } else {
            select_view.add_item(file_name, entry_path);
        }
    }

    select_view.set_on_submit(move |siv, selected_path: &PathBuf| {
        if selected_path.is_dir() {
            // If it's a directory, show its contents
            show_directory(siv, selected_path.clone());
        } else {
            // If it's a file, show a message
            siv.add_layer(Dialog::info(format!(
                "You selected the file: {}",
                selected_path.display()
            )));
        }
    });

    // Replace the current layer with the new SelectView
    siv.add_layer(
        Dialog::around(select_view.scrollable())
            .title(format!("Contents of: {}", path.display()))
            .button("Back", back),
    );
}

fn back(s: &mut Cursive) {
    s.pop_layer();
}
