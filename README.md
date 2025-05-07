#  Unix Trash Bin

A simple Unix shell script that provides a safer alternative to `rm` by implementing a trash system. Instead of permanently deleting files, this tool moves them to a hidden `.trash` folder, allowing you to restore or permanently delete them later.

---

##  Features

- `put <file>` – Moves the file to the `~/.trash` directory and logs its original path.
- `list` – Lists all trashed files along with their original locations.
- `restore <filename>` – Restores a file to its original location.
- `empty` – Permanently deletes all trashed files.

---

##  Installation

```bash
git clone https://github.com/your-username/unix-trash-bin.git
cd unix-trash-bin
chmod +x trash.sh
