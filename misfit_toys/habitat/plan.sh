pkg_name=misfit_toys
pkg_origin=core
pkg_version="0.1.0"
pkg_deps=(core/node core/coreutils)
pkg_build_deps=(core/git core/coreutils)
pkg_svc_run="npm start"
pkg_svc_user="root"

do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  # Copies all files to $HAB_CACHE_SRC_PATH
  # TODO: Do not copy unnecessary files
  pushd "$PLAN_CONTEXT/.." > /dev/null
  cp -R . "${HAB_CACHE_SRC_PATH}"
  popd > /dev/null
}

do_build() {
  # Install all node modules with npm
  pushd $HAB_CACHE_SRC_PATH > /dev/null
  export HOME=$HAB_CACHE_SRC_PATH
  export PATH=./node_modules/.bin:$PATH
  npm install

  # Make any binaries executable
  for b in node_modules/.bin/*; do
  fix_interpreter $(readlink -f -n $b) core/coreutils bin/env
  done
  popd > /dev/null
}

do_install() {
	cp -a "${HAB_CACHE_SRC_PATH}" "${pkg_prefix}/app/"
}
