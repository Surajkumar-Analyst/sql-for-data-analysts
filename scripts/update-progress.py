#!/usr/bin/env python3

import os
import re
import glob

REPO_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MAIN_README = os.path.join(REPO_ROOT, "README.md")

START_MARKER = "<!-- PROGRESS_TABLE_START -->"
END_MARKER = "<!-- PROGRESS_TABLE_END -->"

FIELD_PATTERN = re.compile(r"-\s*(Difficulty|Topic|Link)\s*:\s*(.+)", re.IGNORECASE)


def find_problem_folders():
    """Return sorted list of folders matching NNNN-slug pattern."""
    folders = []
    for entry in os.listdir(REPO_ROOT):
        full_path = os.path.join(REPO_ROOT, entry)
        if os.path.isdir(full_path) and re.match(r"^\d{4}-", entry):
            folders.append(entry)
    return sorted(folders)


def parse_folder_metadata(folder_name):
    """Read the folder's README.md and extract Difficulty/Topic/Link."""
    readme_path = os.path.join(REPO_ROOT, folder_name, "README.md")
    metadata = {"Difficulty": "-", "Topic": "-", "Link": "-"}

    if not os.path.exists(readme_path):
        return metadata

    with open(readme_path, "r", encoding="utf-8") as f:
        content = f.read()

    for line in content.splitlines():
        match = FIELD_PATTERN.match(line.strip())
        if match:
            key = match.group(1).capitalize()
            value = match.group(2).strip()
            metadata[key] = value

    return metadata


def find_sql_file(folder_name):
    """Find the .sql file inside the problem folder."""
    sql_files = glob.glob(os.path.join(REPO_ROOT, folder_name, "*.sql"))
    if not sql_files:
        return None
    return os.path.relpath(sql_files[0], REPO_ROOT)


def folder_to_title(folder_name):
    """Convert '0185-department-top-three-salaries' -> ('185', 'Department Top Three Salaries')"""
    number, _, slug = folder_name.partition("-")
    number = number.lstrip("0") or "0"
    title = slug.replace("-", " ").title()
    return number, title


def build_table_rows():
    rows = []
    for folder in find_problem_folders():
        number, title = folder_to_title(folder)
        metadata = parse_folder_metadata(folder)
        sql_path = find_sql_file(folder)

        problem_link = metadata["Link"] if metadata["Link"] != "-" else "#"
        solution_link = sql_path if sql_path else "#"

        row = (
            f"| {number} | [{title}]({problem_link}) | {metadata['Difficulty']} "
            f"| {metadata['Topic']} | [Link]({solution_link}) |"
        )
        rows.append((int(number), row))

    rows.sort(key=lambda x: x[0])
    return [r[1] for r in rows]


def rebuild_readme():
    if not os.path.exists(MAIN_README):
        raise FileNotFoundError(f"Main README.md not found at {MAIN_README}")

    with open(MAIN_README, "r", encoding="utf-8") as f:
        content = f.read()

    if START_MARKER not in content or END_MARKER not in content:
        raise ValueError(
            f"README.md must contain {START_MARKER} and {END_MARKER} markers "
            "around the progress table."
        )

    header = "| # | Problem | Difficulty | Topic | Solution |\n|---|---------|------------|-------|----------|"
    rows = build_table_rows()
    table = "\n".join([header] + rows) if rows else header

    new_block = f"{START_MARKER}\n{table}\n{END_MARKER}"

    updated_content = re.sub(
        f"{re.escape(START_MARKER)}.*?{re.escape(END_MARKER)}",
        new_block,
        content,
        flags=re.DOTALL,
    )

    with open(MAIN_README, "w", encoding="utf-8") as f:
        f.write(updated_content)

    print(f"Updated progress table with {len(rows)} problem(s).")


if __name__ == "__main__":
    rebuild_readme()
