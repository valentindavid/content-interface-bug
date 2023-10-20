#!/bin/bash

set -eux

(cd A; snapcraft) &
(cd B; snapcraft) &
wait

(cd A; snapcraft) &
(cd B; snapcraft) &
wait

sudo snap remove --purge bug-a || true
sudo snap remove --purge bug-b || true
sudo snap remove --purge bug-c || true

sudo snap install --dangerous A/bug-a_0.1_amd64.snap
sudo snap install --dangerous B/bug-b_0.1_amd64.snap
sudo snap connect bug-b:my-interface bug-a:my-interface
sudo /snap/bin/bug-a
sudo /snap/bin/bug-b
