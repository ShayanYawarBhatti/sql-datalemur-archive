from __future__ import annotations

import csv
import os
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CSV_PATH = ROOT / "problems.csv"

DIFF_TO_FOLDER = {
    "Easy": "easy",
    "Medium": "medium",
    "Hard": "hard",
}

def slugify(s: str) -> str:
    s = s.strip().lower()
    s = s.replace("&", "and")
    s = re.sub(r"[’']", "", s)                 # remove apostrophes
    s = re.sub(r"[^a-z0-9]+", "-", s)          # non-alnum to hyphen
    s = re.sub(r"-{2,}", "-", s).strip("-")
    return s

def company_slug(s: str) -> str:
    s = s.strip().lower()
    s = s.replace("&", "and")
    s = re.sub(r"[^a-z0-9]+", "_", s)
    s = re.sub(r"_{2,}", "_", s).strip("_")
    return s

def ensure_dirs() -> None:
    (ROOT / "tools").mkdir(exist_ok=True)
    for folder in DIFF_TO_FOLDER.values():
        (ROOT / folder).mkdir(exist_ok=True)

def write_index(folder: Path) -> None:
    files = sorted([p for p in folder.glob("*.sql")])
    lines = [f"# {folder.name.title()} Solutions", ""]
    for p in files:
        # Use filename as link text; GitHub renders these fine in private repos
        lines.append(f"- [{p.name}]({p.name})")
    (folder / "INDEX.md").write_text("\n".join(lines) + "\n", encoding="utf-8")

def main() -> None:
    if not CSV_PATH.exists():
        raise SystemExit(f"Missing {CSV_PATH}. Create problems.csv in repo root first.")

    ensure_dirs()

    rows = []
    with CSV_PATH.open(newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        for r in reader:
            # Expect: difficulty,access,company,title
            rows.append({
                "difficulty": r["difficulty"].strip(),
                "access": r["access"].strip(),
                "company": r["company"].strip(),
                "title": r["title"].strip(),
            })

    total = len(rows)
    width = 3  # 001 style

    for i, r in enumerate(rows, start=1):
        num = str(i).zfill(width)
        diff = r["difficulty"]
        folder = DIFF_TO_FOLDER.get(diff)
        if not folder:
            raise SystemExit(f"Unknown difficulty: {diff}")

        title_slug = slugify(r["title"])
        comp_slug = company_slug(r["company"])

        path = ROOT / folder / f"{num}_{title_slug}__{comp_slug}.sql"
        if path.exists():
            continue

        header = "\n".join([
            f"-- Title: {r['title']}",
            f"-- Company: {r['company']}",
            f"-- Difficulty: {r['difficulty']}",
            f"-- Access: {r['access']}",
            f"-- Summary: TODO (1–2 lines in your own words, no prompt text)",
            f"-- Dialect: TODO (e.g., PostgreSQL)  # optional",
            "",
            "-- SQL:",
            "-- TODO: paste your SQL solution below (no DataLemur prompt/schema/examples).",
            "",
        ])
        path.write_text(header, encoding="utf-8")

    # Index files
    for folder in DIFF_TO_FOLDER.values():
        write_index(ROOT / folder)

    print(f"Generated {total} skeleton files + INDEX.md files in easy/medium/hard.")

if __name__ == "__main__":
    main()
