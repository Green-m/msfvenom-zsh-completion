msfvenom-recache() {
  local cache_dir="$HOME/.zsh/venom-cache"
  local types=(payloads archs formats encoders platforms nops)
  
  echo "[!] Clearing msfvenom completion cache..."
  rm -rf "$cache_dir"
  mkdir -p "$cache_dir/options"

  for t in $types; do
    echo -n "[#] Indexing $t... "
    msfvenom --list "$t" 2>/dev/null | \
      awk '/^[[:space:]]{4}[a-z0-9]/ {print $1}' | \
      grep -vE '^(Name|----|Framework|^$)' > "$cache_dir/$t"
    echo "Done."
  done
  echo "Cache fully rebuilt."
}
