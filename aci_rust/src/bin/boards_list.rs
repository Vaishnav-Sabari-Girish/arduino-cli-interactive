use cursive::view::{Nameable, Resizable};
use cursive::views::{Button, Dialog, EditView, LinearLayout, ScrollView, SelectView};
use cursive::{Cursive, CursiveExt};
use lazy_static::lazy_static;
use std::process::Command;
use std::sync::Mutex;

lazy_static! {
    static ref BOARDS: Mutex<Vec<(String, String)>> = Mutex::new(Vec::new());
}

fn main() {
    let mut siv = Cursive::default();
    let homepage =
        LinearLayout::vertical().child(Button::new("Click me to List all Boards", list_boards));
    siv.add_layer(homepage);
    siv.run();
}

fn list_boards(s: &mut Cursive) {
    // Execute the `arduino-cli board listall` command
    let output = Command::new("arduino-cli")
        .args(&["board", "listall"])
        .output()
        .expect("Failed to execute arduino-cli");

    if output.status.success() {
        let stdout = String::from_utf8_lossy(&output.stdout);
        // Parse the output into a vector of (board_name, fqbn)
        let boards: Vec<(String, String)> = stdout.lines().filter_map(parse_board_line).collect();

        // Update the global BOARDS variable
        *BOARDS.lock().unwrap() = boards.clone();

        // Create the initial SelectView
        let select_view = create_select_view(&boards);

        // Create the search bar
        let search_bar = EditView::new()
            .on_submit(move |s, query| {
                let boards = BOARDS.lock().unwrap();
                let filtered_boards: Vec<(String, String)> = boards
                    .iter()
                    .filter(|(board_name, _)| {
                        board_name.to_lowercase().contains(&query.to_lowercase())
                    })
                    .cloned()
                    .collect();
                // Replace the SelectView with a new filtered one
                let new_select_view = create_select_view(&filtered_boards);
                let new_scroll_view = ScrollView::new(new_select_view).with_name("select_view");
                s.call_on_name("list_container", |view: &mut LinearLayout| {
                    view.clear();
                    view.add_child(new_scroll_view);
                });
            })
            .with_name("search_bar")
            .fixed_width(30);

        // Wrap the SelectView in a ScrollView and a container
        let scrollable_select = ScrollView::new(select_view).with_name("select_view");
        let container = LinearLayout::vertical()
            .child(scrollable_select)
            .with_name("list_container");

        // Add the search bar and container to a dialog
        s.add_layer(
            Dialog::around(LinearLayout::vertical().child(search_bar).child(container))
                .title("Available Boards")
                .button("Back", back),
        );
    } else {
        let stderr = String::from_utf8_lossy(&output.stderr);
        s.add_layer(Dialog::info(format!(
            "Error executing arduino-cli:\n{}",
            stderr
        )));
    }
}

// Function to parse a line into board name and FQBN
fn parse_board_line(line: &str) -> Option<(String, String)> {
    let parts: Vec<&str> = line.split_whitespace().collect();
    if let Some(pos) = parts.iter().position(|&part| part.contains(':')) {
        let board_name = parts[..pos].join(" ");
        let fqbn = parts[pos..].join(":");
        Some((board_name, fqbn))
    } else {
        None
    }
}

// Function to create a SelectView from a vector of boards
fn create_select_view(boards: &[(String, String)]) -> SelectView<String> {
    let mut select_view = SelectView::new();
    for (board_name, fqbn) in boards {
        select_view.add_item(format!("Board: {}", board_name), fqbn.clone());
    }
    select_view.on_submit(|s, fqbn: &String| {
        s.add_layer(Dialog::info(format!("Selected FQBN: {}", fqbn)));
    })
}

fn back(s: &mut Cursive) {
    s.pop_layer();
}
