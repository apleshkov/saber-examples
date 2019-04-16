#!/usr/bin/env sh

project_dir="."
saber="mint run apleshkov/saber@0.2.1 saber"

${saber} sources \
	--workDir "${project_dir}/Sources/Application" \
	--from . \
	--out SaberContainers
