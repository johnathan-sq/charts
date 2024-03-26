#!/bin/bash

# Configuration
export CHART_DIR="chart"
export CHART_NAME="mychart"
export CHART_VERSION="0.1.0"
export CHARTMUSEUM_URL="http://localhost:8080"

# Navigate to the chart directory
cd "$CHART_DIR"

# Package the Helm chart
helm package . --version "$CHART_VERSION"

# Upload the chart to ChartMuseum
curl --data-binary "@${CHART_NAME}-${CHART_VERSION}.tgz" $CHARTMUSEUM_URL/api/charts

echo "Chart uploaded successfully."
