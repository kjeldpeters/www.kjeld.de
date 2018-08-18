#!/bin/bash

ROOT_DIR="$(dirname $0)/.."

S3_BUCKET="s3://www.kjeld.de"
CLOUDFRONT_DISTRIBUTION_ID="E3H6AVCQEEZ8QR"

aws --profile kjeld s3 sync $ROOT_DIR/htdocs $S3_BUCKET --delete || { echo "ERROR: s3 sync failed! exiting now."; exit 1; }
aws --profile kjeld cloudfront create-invalidation --distribution-id $CLOUDFRONT_DISTRIBUTION_ID --paths '/*' || { echo "ERROR: cloudfrontd invalidation failed! exiting now."; exit 1; }
