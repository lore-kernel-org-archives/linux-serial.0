Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD6F2F068E
	for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2025 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202752; cv=none; b=JNApF79esIyFfpctI+4RPm5LcAy3z5vbvcy3hTB6Wq0gRedE9XvcVtkT+iHuWP3uGTM5PCR6ET2PbzbHOuttZDCsXhDzskc87KzbhVbcD1yTOpF1AraYukNSB/Ji/UVp19hz0qWtnYFrABTKBss6C0VK171AgW8esV0isJX+PtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202752; c=relaxed/simple;
	bh=k9ePSu/jqI3cuOYJmC5VComfae8Esek1uMq7O2e5xYs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LXS1BJYCKbHrIOakriVxu5n1a9nb8U4WTGfqLlJsxNE5xfivKB11TFs3sl2xCSrO9g/BXVGtn19aGkLRx/+yP0wKp9hxBzDxXGSAFl+3Y2R+1UCttBebjrUI2Cv9SR56/rMNisTjzW+xdDwB764FAf6xYcujxwxTTbzJTPBhPKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFYYgUPj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFYYgUPj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758202751; x=1789738751;
  h=date:from:to:cc:subject:message-id;
  bh=k9ePSu/jqI3cuOYJmC5VComfae8Esek1uMq7O2e5xYs=;
  b=WFYYgUPjTEArJ2xzVjtwbVGiq0ZZ9ccAV+6ECRxQe+jBdBlL2uwxqOKC
   mMY0z6CugQS7EDjnr7pbqFCDj8Dd5rlBRUopbfNaD+gn8w/VD5V65QPjb
   s64UREQkDlne7abChFFsboFs7ZOVk+QfLohZ4c93tXFJqRXdyOR70HiRf
   r62qUII6h40vj+9unO+r/b4cRlEKn6GHNmSPQ6AkP+9CE1WxRN046nVG/
   k8qomzDOiGSjfdxVLnBN+PAFZKsDIprEqPWClkChLA48pG7EJ3y6/SQRP
   ymJTQc1MSai0vFFn8UHwVtorouTjEqNuKHIRX9ke3KiScWJYyug6Pf86E
   A==;
X-CSE-ConnectionGUID: NYUuxd7CTIKYul8ysM0jnQ==
X-CSE-MsgGUID: +9zkv5BfR3GjGdo1aaquxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="77973244"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="77973244"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 06:39:10 -0700
X-CSE-ConnectionGUID: txT/fdO4RqW3yQ5UeDJiVQ==
X-CSE-MsgGUID: 8Yyx5uYKQFidSB3mvFplGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="180655998"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 18 Sep 2025 06:39:09 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzEqo-0003Jp-21;
	Thu, 18 Sep 2025 13:39:06 +0000
Date: Thu, 18 Sep 2025 21:38:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS WITH WARNING
 f4abab350840d58d69814c6993736f03ac27df83
Message-ID: <202509182122.VA6BkPOM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: f4abab350840d58d69814c6993736f03ac27df83  tty: serial: fix help message for SERIAL_CPM

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202509070003.ozCgvRti-lkp@intel.com
    https://lore.kernel.org/oe-kbuild/202509132206.Kxk7Pfcw-lkp@intel.com

    Warning: drivers/tty/n_gsm.c:4175 function parameter 'dlci' not described in 'gsm_modem_send_initial_msc'

Unverified Warning (likely false positive, kindly check if interested):

    arch/arm/boot/dts/ti/omap/am335x-myirtech-myd.dtb: serial@0 (ti,am3352-uart): Unevaluated properties are not allowed ('pinctrl-names' was unexpected)
    arch/arm/boot/dts/ti/omap/am335x-myirtech-myd.dtb: serial@0 (ti,am3352-uart): pinctrl-names:1: 'wakeup' was expected
    arch/arm/boot/dts/ti/omap/am437x-gp-evm.dtb: serial@0 (ti,am4372-uart): Unevaluated properties are not allowed ('pinctrl-names' was unexpected)
    arch/arm/boot/dts/ti/omap/am437x-gp-evm.dtb: serial@0 (ti,am4372-uart): pinctrl-names:1: 'wakeup' was expected
    arch/arm/boot/dts/ti/omap/am437x-sk-evm.dtb: serial@0 (ti,am4372-uart): Unevaluated properties are not allowed ('pinctrl-names' was unexpected)
    arch/arm/boot/dts/ti/omap/am437x-sk-evm.dtb: serial@0 (ti,am4372-uart): pinctrl-names:1: 'wakeup' was expected
    arch/arm/boot/dts/ti/omap/am43x-epos-evm.dtb: serial@0 (ti,am4372-uart): Unevaluated properties are not allowed ('pinctrl-names' was unexpected)
    arch/arm/boot/dts/ti/omap/am43x-epos-evm.dtb: serial@0 (ti,am4372-uart): pinctrl-names:1: 'wakeup' was expected

Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- alpha-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arm-randconfig-002-20250917
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arm-randconfig-004-20250917
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arm-randconfig-051-20250918
|   |-- arch-arm-boot-dts-ti-omap-am335x-myirtech-myd.dtb:serial-(ti-am3352-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am335x-myirtech-myd.dtb:serial-(ti-am3352-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am437x-gp-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am437x-gp-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am437x-sk-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am437x-sk-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am43x-epos-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   `-- arch-arm-boot-dts-ti-omap-am43x-epos-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|-- arm-randconfig-052-20250918
|   |-- arch-arm-boot-dts-ti-omap-am335x-myirtech-myd.dtb:serial-(ti-am3352-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am335x-myirtech-myd.dtb:serial-(ti-am3352-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am437x-gp-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am437x-gp-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am437x-sk-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am437x-sk-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am43x-epos-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   `-- arch-arm-boot-dts-ti-omap-am43x-epos-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|-- arm-randconfig-053-20250918
|   |-- arch-arm-boot-dts-ti-omap-am335x-myirtech-myd.dtb:serial-(ti-am3352-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am335x-myirtech-myd.dtb:serial-(ti-am3352-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am437x-gp-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am437x-gp-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am437x-sk-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am437x-sk-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am43x-epos-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   `-- arch-arm-boot-dts-ti-omap-am43x-epos-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|-- arm64-randconfig-001-20250917
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- hexagon-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- hexagon-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- i386-buildonly-randconfig-003-20250917
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- loongarch-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- loongarch-randconfig-002-20250917
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- m68k-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- m68k-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- microblaze-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- microblaze-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- nios2-randconfig-001-20250917
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- openrisc-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- parisc-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- parisc-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- parisc-randconfig-002-20250917
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- powerpc64-randconfig-001-20250917
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- riscv-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- riscv-randconfig-002-20250918
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- s390-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- s390-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- s390-randconfig-002-20250918
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- sh-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- sh-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- sparc-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- sparc64-randconfig-001-20250918
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- um-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- um-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-buildonly-randconfig-001-20250917
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
`-- xtensa-randconfig-001-20250918
    `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc

elapsed time: 1516m

configs tested: 100
configs skipped: 5

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250917    gcc-8.5.0
arc                   randconfig-002-20250917    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20250917    clang-22
arm                   randconfig-002-20250917    gcc-12.5.0
arm                   randconfig-003-20250917    gcc-10.5.0
arm                   randconfig-004-20250917    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250917    clang-22
arm64                 randconfig-002-20250917    clang-19
arm64                 randconfig-003-20250917    gcc-10.5.0
arm64                 randconfig-004-20250917    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250917    gcc-12.5.0
csky                  randconfig-002-20250917    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250917    clang-22
hexagon               randconfig-002-20250917    clang-22
i386        buildonly-randconfig-001-20250917    gcc-14
i386        buildonly-randconfig-002-20250917    clang-20
i386        buildonly-randconfig-003-20250917    gcc-14
i386        buildonly-randconfig-004-20250917    gcc-14
i386        buildonly-randconfig-005-20250917    gcc-14
i386        buildonly-randconfig-006-20250917    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250917    gcc-15.1.0
loongarch             randconfig-002-20250917    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250917    gcc-11.5.0
nios2                 randconfig-002-20250917    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250917    gcc-14.3.0
parisc                randconfig-002-20250917    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc               randconfig-001-20250917    clang-18
powerpc               randconfig-002-20250917    clang-22
powerpc               randconfig-003-20250917    gcc-9.5.0
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20250917    clang-19
powerpc64             randconfig-002-20250917    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250918    clang-22
riscv                 randconfig-002-20250918    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250918    gcc-11.5.0
s390                  randconfig-002-20250918    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                          r7785rp_defconfig    gcc-15.1.0
sh                    randconfig-001-20250918    gcc-15.1.0
sh                    randconfig-002-20250918    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250918    gcc-11.5.0
sparc                 randconfig-002-20250918    gcc-15.1.0
sparc64               randconfig-001-20250918    clang-20
sparc64               randconfig-002-20250918    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250918    clang-22
um                    randconfig-002-20250918    clang-18
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250917    gcc-14
x86_64      buildonly-randconfig-002-20250917    clang-20
x86_64      buildonly-randconfig-003-20250917    clang-20
x86_64      buildonly-randconfig-004-20250917    clang-20
x86_64      buildonly-randconfig-005-20250917    clang-20
x86_64      buildonly-randconfig-006-20250917    gcc-12
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250918    gcc-8.5.0
xtensa                randconfig-002-20250918    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
