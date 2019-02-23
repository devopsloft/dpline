
#!/usr/bin/env bash

set -euox pipefail

artifacts=(one two three)

i=1
for artifact in "${artifacts[@]}"; do
  curl -X PUT "http://localhost:9200/cnv/_doc/$i" \
    -H "Content-Type: application/json" -d "{\"name\": \"$artifact\"}"
  let i=i+1
done
