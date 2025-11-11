# -*- mode:bash; tab-with=2; indent-tabs-mode=0; -*-
# vim:ft=bash
#
# Functions
vault_remain() {
  local now=$(TZ=UTC date -u +%Y-%m-%dT%H:%M:%SZ)
  local aws_expire=$(TZ=UTC date -u -d "${AWS_CREDENTIAL_EXPIRATION:-$now}" +%s)
  local curr=$(TZ=UTC date -u +%s)
  local left_sec=$((aws_expire-curr))
  let "left_hour=(left_sec/3600)"
  let "left_sec=(left_sec - (left_hour * 3600))"
  let "left_min=(left_sec/60)"
  let "left_sec=(left_sec - (left_min*60))"
  echo ${left_min}:${left_sec}
}
