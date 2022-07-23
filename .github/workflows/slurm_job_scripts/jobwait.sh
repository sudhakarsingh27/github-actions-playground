#! /bin/bash

# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -euo pipefail
shopt -s lastpipe

if [ "$#" -ne 1 ]; then
    exit 1
fi

JOBID="$1"

while true; do
    export STATE=$(./jobstate.sh "${JOBID}")
    case "${STATE}" in
        PENDING|RUNNING|REQUEUED)
            sleep 15s
            ;;
        *)
            sleep 30s
            echo "Exiting with SLURM job status '${STATE}'"
            exit 0
            ;;
    esac
done
