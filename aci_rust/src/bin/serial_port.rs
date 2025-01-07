use cursive::views::{Button, Dialog, LinearLayout, SelectView};
use cursive::{Cursive, CursiveExt};
use std::process::Command;

fn main() {
    let mut siv = Cursive::default();
    siv.add_global_callback('q', Cursive::quit);

    let homepage = LinearLayout::vertical().child(Button::new("Serial Port", serial_port));
    siv.add_layer(homepage);
    siv.run();
}

fn serial_port(s: &mut Cursive) {
    // Execute the command and capture the output
    let output = Command::new("arduino-cli")
        .arg("board")
        .arg("list")
        .output()
        .expect("Failed to execute arduino-cli command");

    // Parse the output
    let stdout = String::from_utf8_lossy(&output.stdout).into_owned();
    let lines: Vec<String> = stdout.lines().map(|line| line.to_string()).collect();

    // Extract all `/dev/tty` paths
    let devices: Vec<String> = lines
        .iter()
        .filter_map(|line| {
            // Find lines containing '/dev/tty' and extract the path
            line.split_whitespace()
                .find(|&word| word.starts_with("/dev/tty"))
                .map(|s| s.to_string())
        })
        .collect();

    // Create a SelectView and populate it with the extracted paths
    let mut select_view = SelectView::new();
    if devices.is_empty() {
        select_view.add_item("No Arduino device found", String::new());
    } else {
        for device in devices {
            select_view.add_item(device.clone(), device);
        }
    }

    // Set up the on-submit action
    select_view.set_on_submit(|siv, selected: &String| {
        siv.add_layer(Dialog::info(format!("You selected: {}", selected)));
    });

    // Add the SelectView to the UI
    s.add_layer(
        Dialog::around(select_view)
            .title("Select an Arduino Device")
            .button("Quit", |s| s.quit()),
    );
}
