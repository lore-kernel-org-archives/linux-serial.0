Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F98460
	for <linux-serial@vger.kernel.org>; Sat, 13 Sep 2025 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757775390; cv=none; b=alsBvjr1X9IHbMXIfRpLm1M3ZOhkcaxKLnB/oXybvuGFw3Wkdc8dpqqYGBH7Zew5VKuLG0ielaek9TbrzS2BvMwa1152uCKiEDvPRzB2aV2pynluj4U2WfzDvQ0Bog5DGpMOoB6dVOEHBUoiNzS7Cjyx/bgLXanieDCgHCRfylE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757775390; c=relaxed/simple;
	bh=g1cAm16KR/k6pJWeo62yTDhD17+ylawLvN6jMnYd9Zw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=o0Tz9iCZFmMhFl82LD/NPq5zdZ6pRxV2+/yxh0bZwZ81ECvaft/Rqh66sOHcADDCsMxdRQJ/5ZOXf7nw6uOCKYof+Yl8qx7zRCC2iMbWV9MY2Cgb4PGFfyclCsuGxSFof+g3HPDMYXvhV/CJoHCJdjU02oPmbZ1JkWw4xkQNSG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNmz67DP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNmz67DP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757775388; x=1789311388;
  h=date:from:to:cc:subject:message-id;
  bh=g1cAm16KR/k6pJWeo62yTDhD17+ylawLvN6jMnYd9Zw=;
  b=lNmz67DP4Z46WFUAoG9F9JPNjRzvX5ZORhoYZrrJ/DbT55J9zGhIYocL
   XvYClXUDcx/cDlkfqzHyipC22Gjb3LiY9mEs7AdckaZLWwE4hnMvlQ8Jt
   Z17fLkD7Aj4mLDgO63fw2UMnNPsWfz/eUIxw/NNqCYqnC0ZsHYI+r0UbU
   /OzmG+b5AnEHfACwEz7vxbLHPIhW2liV+JO6DIELRSprFVQJ96Qd2hdoz
   XIQwm5LaB5lUtsETOfonze6VrNIAXsbMyciAgpYFJu0ttvMzoATvhZFNJ
   3gryggeEYDVBaEGHm1Re2eglfvOpP8L8p4OlWZhgrvjS56HXOk35EXsuV
   w==;
X-CSE-ConnectionGUID: cpMGd/IARw2n/gz6wYp8qA==
X-CSE-MsgGUID: eZr83fyWSxWy73gDesYblA==
X-IronPort-AV: E=McAfee;i="6800,10657,11552"; a="60241604"
X-IronPort-AV: E=Sophos;i="6.18,262,1751266800"; 
   d="scan'208";a="60241604"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2025 07:56:28 -0700
X-CSE-ConnectionGUID: aIMkzAf7QQmW0C26txAN2A==
X-CSE-MsgGUID: fHSkqzhxRNWBNnsCME15YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,262,1751266800"; 
   d="scan'208";a="178249072"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 13 Sep 2025 07:56:26 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uxRfs-0001bs-1s;
	Sat, 13 Sep 2025 14:56:24 +0000
Date: Sat, 13 Sep 2025 22:55:37 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS WITH WARNING
 ed68411e879e9bd512e266d3c46d4b35c5f5fbbc
Message-ID: <202509132220.HOSerLdo-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: ed68411e879e9bd512e266d3c46d4b35c5f5fbbc  serial: 8250: omap: Support wakeup pinctrl state on suspend

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
|-- alpha-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arc-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arc-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arm-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arm-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arm-randconfig-003-20250913
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arm-randconfig-051-20250913
|   |-- arch-arm-boot-dts-ti-omap-am335x-myirtech-myd.dtb:serial-(ti-am3352-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am335x-myirtech-myd.dtb:serial-(ti-am3352-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am437x-gp-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am437x-gp-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am437x-sk-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am437x-sk-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am43x-epos-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   `-- arch-arm-boot-dts-ti-omap-am43x-epos-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|-- arm64-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arm64-randconfig-001-20250913
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arm64-randconfig-004-20250913
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- hexagon-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- hexagon-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- hexagon-randconfig-001-20250913
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- hexagon-randconfig-002-20250913
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- loongarch-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- m68k-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- m68k-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- microblaze-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- microblaze-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- openrisc-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- parisc-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- parisc-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- powerpc-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- powerpc-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- riscv-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- riscv-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- s390-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- s390-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- sh-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- sh-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- sparc-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- um-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- um-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- um-randconfig-001-20250913
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
`-- x86_64-buildonly-randconfig-005-20250912
    `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc

elapsed time: 1451m

configs tested: 104
configs skipped: 3

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250913    gcc-10.5.0
arc                   randconfig-002-20250913    gcc-11.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250913    clang-20
arm                   randconfig-002-20250913    clang-22
arm                   randconfig-003-20250913    clang-22
arm                   randconfig-004-20250913    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250913    clang-22
arm64                 randconfig-002-20250913    gcc-14.3.0
arm64                 randconfig-003-20250913    clang-22
arm64                 randconfig-004-20250913    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250913    gcc-11.5.0
csky                  randconfig-002-20250913    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250913    clang-16
hexagon               randconfig-002-20250913    clang-22
i386        buildonly-randconfig-001-20250912    gcc-14
i386        buildonly-randconfig-002-20250912    clang-20
i386        buildonly-randconfig-003-20250912    gcc-13
i386        buildonly-randconfig-004-20250912    clang-20
i386        buildonly-randconfig-005-20250912    gcc-14
i386        buildonly-randconfig-006-20250912    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250913    clang-18
loongarch             randconfig-002-20250913    clang-22
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
nios2                 randconfig-001-20250913    gcc-8.5.0
nios2                 randconfig-002-20250913    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250913    gcc-12.5.0
parisc                randconfig-002-20250913    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250913    gcc-8.5.0
powerpc               randconfig-002-20250913    clang-22
powerpc               randconfig-003-20250913    gcc-10.5.0
powerpc64             randconfig-001-20250913    gcc-10.5.0
powerpc64             randconfig-002-20250913    clang-22
powerpc64             randconfig-003-20250913    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250913    gcc-13.4.0
riscv                 randconfig-002-20250913    clang-20
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250913    clang-22
s390                  randconfig-002-20250913    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250913    gcc-9.5.0
sh                    randconfig-002-20250913    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250913    gcc-15.1.0
sparc                 randconfig-002-20250913    gcc-8.5.0
sparc64               randconfig-001-20250913    gcc-8.5.0
sparc64               randconfig-002-20250913    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250913    gcc-14
um                    randconfig-002-20250913    clang-22
x86_64      buildonly-randconfig-001-20250912    gcc-14
x86_64      buildonly-randconfig-002-20250912    gcc-14
x86_64      buildonly-randconfig-003-20250912    clang-20
x86_64      buildonly-randconfig-004-20250912    clang-20
x86_64      buildonly-randconfig-005-20250912    clang-20
x86_64      buildonly-randconfig-006-20250912    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250913    gcc-14.3.0
xtensa                randconfig-002-20250913    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
