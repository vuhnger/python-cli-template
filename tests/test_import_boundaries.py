from __future__ import annotations

import ast
from pathlib import Path

import pytest

PACKAGE_ROOT = Path(__file__).resolve().parents[1] / "src" / "appname"

RESTRICTED_MODULES: dict[str, set[str]] = {}


def _imported_roots(path: Path) -> set[str]:
    tree = ast.parse(path.read_text(encoding="utf-8"))
    roots: set[str] = set()
    for node in ast.walk(tree):
        if isinstance(node, ast.Import):
            roots.update(alias.name.split(".")[0] for alias in node.names)
        elif isinstance(node, ast.ImportFrom) and node.module and node.level == 0:
            roots.add(node.module.split(".")[0])
    return roots


@pytest.mark.parametrize("restricted,allowed", sorted(RESTRICTED_MODULES.items()))
def test_restricted_module_is_only_imported_where_it_belongs(restricted, allowed):
    offenders = [
        path.relative_to(PACKAGE_ROOT).as_posix()
        for path in sorted(PACKAGE_ROOT.rglob("*.py"))
        if path.relative_to(PACKAGE_ROOT).as_posix() not in allowed
        and restricted in _imported_roots(path)
    ]

    assert offenders == [], (
        f"{restricted!r} may only be imported from {sorted(allowed)}, "
        f"but is also imported in {offenders}"
    )
