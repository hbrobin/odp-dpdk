#!/bin/sh
#
# Copyright (c) 2017-2018, Linaro Limited
# All rights reserved.
#
# SPDX-License-Identifier:	BSD-3-Clause
#

# directories where traffic_mngr_main binary can be found:
# -in the validation dir when running make check (intree or out of tree)
# -in the script directory, when running after 'make install', or
# -in the validation when running standalone (./traffic_mngr) intree.
# -in the current directory.
# running stand alone out of tree requires setting PATH
PATH=${TEST_DIR}/api/traffic_mngr:$PATH
PATH=$(dirname $0)/../../../../validation/api/traffic_mngr:$PATH
PATH=$(dirname $0):$PATH
PATH=`pwd`:$PATH

traffic_mngr_main_path=$(which traffic_mngr_main${EXEEXT})
if [ -x "$traffic_mngr_main_path" ] ; then
	echo "running with traffic_mngr_main: $traffic_mngr_run_path"
else
	echo "cannot find traffic_mngr_main: please set you PATH for it."
	exit 1
fi

# exit codes expected by automake for skipped tests
TEST_SKIPPED=77

traffic_mngr_main${EXEEXT}
ret=$?

if [ "${CI}" = "true" ] && [ $ret -eq 255 ]; then
	echo "SKIP: skip due to not isolated environment"
	exit ${TEST_SKIPPED}
fi

exit $ret
