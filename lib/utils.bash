#!/usr/bin/env bash

set -euo pipefail

TOOL_SITE="https://downloads.cloudbees.com/cloudbees-cd"
TOOL_NAME="cloudbees-flow-tools"
TOOL_TEST="ectool --version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

list_all_versions() {
	curl "${curl_opts[@]}" "$TOOL_SITE/" | grep -Eo 'Release[^"]+/index.html' | sed -r 's@^[^/]+/|/index.html@@g'
}

download_release() {
	local version filename url release_version
	version="$1"
	filename="$2"

	case "$(uname -s)" in
	Linux)
		if [[ "$(uname -m)" == "aarch64" || "$(uname -m)" == "arm64" ]]; then
			url="$(build_download_url "$version" "linux_ARM" "tar.gz")"
		else
			url="$(build_download_url "$version" "linux" "tar.gz")"
		fi
		;;
	Darwin)
		url="$(build_download_url "$version" "mac" "tar.gz")"
		;;
	MINGW* | MSYS* | CYGWIN*)
		url="$(build_download_url "$version" "windows" "zip")"
		;;
	*)
		fail "Unsupported OS: $(uname -s)"
		;;
	esac

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

uncompress_file() {
	local file_path dest_dir mime_type
	file_path="$1"
	dest_dir="$2"

	mime_type="$(file -b --mime-type "$file_path")"

	case "$mime_type" in
	application/zip)
		unzip -o "$file_path" -d "$dest_dir" || fail "Could not extract $file_path"
		;;
	application/gzip)
		tar -xzf "$file_path" -C "$dest_dir" --strip-components=1 || fail "Could not extract $file_path"
		;;
	*)
		fail "Unsupported file type for $file_path"
		;;
	esac
}

build_download_url() {
	local version os_variant file_ext release_version
	version="$1"
	os_variant="$2"
	file_ext="$3"

	# Example URL:
	# https://downloads.cloudbees.com/cloudbees-cd/Release_2025.03/2025.03.1.179360/linux/CloudBeesFlowTools-2025.03.1.179360.tar.gz

	# Variants:
	# linux_ARM/CloudBeesFlowTools-2025.03.1.179360.tar.gz
	# mac/CloudBeesFlowTools-2025.03.1.179360.tar.gz
	# windows/CloudBeesFlowTools-2025.03.1.179360.zip

	release_version=$(echo "$version" | cut -d. -f1,2)
	echo "${TOOL_SITE}/Release_${release_version}/${version}/${os_variant}/CloudBeesFlowTools-${version}.${file_ext}"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}"
	local tool_path="$install_path/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		# Assert cloudbees-flow-tools executables exist.
		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$tool_path/$tool_cmd" || fail "Expected $tool_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
