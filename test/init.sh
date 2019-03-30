#!/usr/bin/env bash

declare spec_exit_code
declare spec_filter="$1"
declare tty_color

export PATH="$PWD/bin:$PWD/test/bin:$PATH"

# scan the available tests & filter them:
read -d '' -r -a specs < <(
  find "$PWD"/test/src -type f -name '*.sh' | grep -ie "${spec_filter}"
)

for spec in "${specs[@]}"; do
  spec_name="$(basename "${spec}")"
  spec_name="${spec_name/.sh/}"
  spec_header="${tty_color}${spec_name}\033[0m |"

  # grab the next color in the palette to use for this test's header:
  tty_color="$(bb-colorize "$tty_color")"

  # run the test:
  bb-logprefix "$spec_header" echo "starting" 1>&2
  bb-logprefix "$spec_header" bash "$spec"

  spec_exit_code=$?

  # remove the container
  if docker inspect ggg-megaman-test 1>/dev/null 2>&1; then
    docker container rm -f ggg-megaman-test 1>/dev/null 2>/dev/null
  fi

  # fail as soon as any test fails:
  if [[ $spec_exit_code -eq 0 ]]; then
    bb-logprefix "$spec_header" echo -e "\033[32mok!\033[0m" 1>&2
  else
    bb-logprefix "$spec_header" echo -e "\033[31mfailed!\033[0m (exit code $spec_exit_code)" 1>&2

    exit $spec_exit_code
  fi
done
