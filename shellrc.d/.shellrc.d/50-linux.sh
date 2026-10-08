[[ "$(uname -s)" != Linux ]] && return

vault_remain() {
  local now aws_expire curr left_sec left_hour left_min
  now=$(TZ=UTC date -u +%Y-%m-%dT%H:%M:%SZ)
  aws_expire=$(TZ=UTC date -u -d "${AWS_CREDENTIAL_EXPIRATION:-$now}" +%s)
  curr=$(TZ=UTC date -u +%s)
  left_sec=$((aws_expire - curr))
  left_hour=$((left_sec / 3600))
  left_sec=$((left_sec - left_hour * 3600))
  left_min=$((left_sec / 60))
  left_sec=$((left_sec - left_min * 60))
  echo "${left_hour}:${left_min}:${left_sec}"
}
