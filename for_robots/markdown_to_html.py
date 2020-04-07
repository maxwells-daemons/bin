#!/usr/bin/env python3
# See:  https://github.com/vimwiki/vimwiki/issues/642#issuecomment-477815553

import re
import shutil
import subprocess
import sys
from os import path


def convert(
    force,
    syntax,
    extension,
    output_dir,
    input_file,
    css_file,
    template_path,
    template_default,
    template_ext,
    root_path,
    custom_args,
):
    if shutil.which("pandoc") is None:
        print("Error: pandoc not found", file=sys.stderr)
        sys.exit(1)

    if syntax != "markdown":
        print("Error: Unsupported syntax", file=sys.stderr)
        sys.exit(1)

    input_file_name = path.splitext(path.basename(input_file))[0]
    output_file = path.join(output_dir, input_file_name) + path.extsep + "html"

    with open(input_file, "r", encoding="utf8") as f:
        lines = f.read()

    lines = re.sub(r"\[([^]]+)\]\((.+)\)", repl, lines)

    # Look for title in metadata
    match = re.search(
        "^(?:---|\.\.\.)$\n.*title: ([^\n]+)$\n.*^(?:---|\.\.\.)$",  # noqa
        lines,
        re.MULTILINE | re.DOTALL,
    )
    title = match.group(1) if match else input_file_name.title()

    template = path.join(
        template_path, template_default + path.extsep + template_ext
    )
    # TODO: fix theme location
    command = [
        "pandoc",
        "--section-divs",
        "--mathjax",
        "--standalone",
        "--from=markdown+lists_without_preceding_blankline+backtick_code_blocks+latex_macros",
        "--highlight-style=~/dotfiles/tools/vim/vimwiki/solarized_light.theme",
        "--include-in-header={}".format(template)
        if path.isfile(template)
        else "",
        "--metadata",
        "pagetitle={}".format(title),
        custom_args if custom_args != "-" else "",
        "--from",
        "markdown",
        "--to",
        "html",
        "--output",
        output_file,
        "-",
    ]

    #  "--template={}".format(template) if path.isfile(template) else "",

    # Prune empty elements from command list
    command = list(filter(None, command))

    # Run command
    subprocess.run(command, check=True, encoding="utf8", input=lines)


def repl(match):
    link = path.splitext(match.group(2))[0] + ".html"
    return "[{}]({})".format(match.group(1), link)


if __name__ == "__main__":
    convert(*sys.argv[1:])
