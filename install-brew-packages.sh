#!/usr/bin/env bash
set -euo pipefail

script_dir="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
package_file="${1:-${script_dir}/brew-packages.txt}"

if ! command -v brew >/dev/null 2>&1; then
  printf '%s\n' 'Homebrew is required but was not found in PATH.' >&2
  exit 1
fi

if [[ ! -f "${package_file}" ]]; then
  printf 'Package manifest not found: %s\n' "${package_file}" >&2
  exit 1
fi

while IFS=$'\t' read -r kind package; do
  [[ -z "${kind}" || "${kind:0:1}" == '#' ]] && continue

  if [[ -z "${package:-}" ]]; then
    printf 'Invalid manifest line: %s\n' "${kind}" >&2
    exit 1
  fi

  case "${kind}" in
    formula)
      if brew list --formula --versions "${package}" >/dev/null 2>&1; then
        printf 'Already installed: %s\n' "${package}"
      else
        brew install "${package}"
      fi
      ;;
    cask)
      if brew list --cask --versions "${package}" >/dev/null 2>&1; then
        printf 'Already installed: %s\n' "${package}"
      else
        brew install --cask "${package}"
      fi
      ;;
    *)
      printf 'Unknown package kind: %s\n' "${kind}" >&2
      exit 1
      ;;
  esac
done < "${package_file}"
