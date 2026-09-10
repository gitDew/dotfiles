#!/bin/sh
# Merge declared pi settings (~/.pi/agent/pi-packages.json) into the live
# ~/.pi/agent/settings.json without touching machine-local keys
# (defaultModel, defaultProvider, defaultThinkingLevel, lastChangelogVersion, ...).
#
# Rule: every key present in the fragment is synced from chezmoi and wins;
# every key absent from the fragment stays machine-local, forever.
# Keys starting with '_' in the fragment are documentation-only and are
# stripped before merging.
# Additionally, a '_comment' key is injected INTO settings.json itself so
# agents that edit settings.json directly see the warning. pi does not
# validate or strip unknown settings keys, and its saves are field-scoped
# (persistScopedSettings re-reads the file and only touches modified fields),
# so the comment survives pi's own rewrites. If anything removes it, the
# next apply re-adds it.
set -e
settings="$HOME/.pi/agent/settings.json"
fragment="$HOME/.pi/agent/pi-packages.json"
[ -f "$fragment" ] || exit 0
[ -f "$settings" ] || printf '{}' > "$settings"
doc="$settings.tmp.$$.doc"
cat > "$doc" <<'EOF'
{
  "_comment": [
    "This file is maintained by BOTH pi and chezmoi: run_pi-merge-settings.sh (a chezmoi run script) re-merges ~/.pi/agent/pi-packages.json into it on every 'chezmoi apply'.",
    "IMPORTANT for agents: to make a pi package persist across machines, do NOT add it to 'packages' here — the next 'chezmoi apply' REVERTS changes to keys managed in pi-packages.json. Instead, edit the chezmoi SOURCE file ~/.local/share/chezmoi/dot_pi/agent/pi-packages.json (add the source string, e.g. 'npm:@scope/pkg' or 'git:github.com/user/repo', to 'packages') and run 'chezmoi apply'.",
    "pi-packages.json keys override this file on apply; keys absent there (defaultModel, defaultProvider, defaultThinkingLevel, ...) are machine-local.",
    "pi ignores unknown settings keys and its own saves preserve them, so this comment is safe here; the merge script re-adds it if it disappears."
  ]
}
EOF
tmp="$settings.tmp.$$"
trap 'rm -f "$tmp" "$doc"' EXIT
jq -s '.[0] * (.[1] | with_entries(select(.key | test("^_") | not))) * .[2]' "$settings" "$fragment" "$doc" > "$tmp"
mv "$tmp" "$settings"
