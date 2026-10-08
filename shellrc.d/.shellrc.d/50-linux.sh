[[ "$(uname -s)" != Linux ]] && return

vault_remain() {
  local now aws_expire curr left_sec left_hour left_min
  now=$(TZ=UTC date -u +%Y-%m-%dT%H:%M:%SZ)
  aws_expire=$()

  echo "${left_hour}"
}
