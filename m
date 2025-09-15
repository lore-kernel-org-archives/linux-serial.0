Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FE2BA3D
	for <linux-serial@vger.kernel.org>; Mon, 15 Sep 2025 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757962756; cv=none; b=K54h3AgxtUe35VZgoHdDZDM/Ncxw6mFwP5H/9kT/rs+/AswF6UrXpoWTwnsbHdH+1+sXd9oSoZdXCkCwooQr2FybCfCwlX7znmoajZ0iqhvMA3QDwDA0v+mIHKEecCsDY3EzwSye8gNj2mobFcejZi3+VTudOQq/qzMwMY9yWe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757962756; c=relaxed/simple;
	bh=Dr3N5tcHmDIK3HESgfwWYns7Fl4s4j2xAw0IHBe1SrE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=miWIw7GRY0FV4N0ngYG9H1uU+k1a6SCDsEKd2ic8hAGm0eZIaXvzNKifV2WZ9KAHYLtpwplzbFHKalDVgTmoNOjIK5uFWNrFdKkIkwa6OglPJ+VzeWC3Y7maxdEJWfB8FRFpqUPT9ZJNgJcii7i1eHTRbJKFsPtnaKUtso+cSrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emRDBarm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emRDBarm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757962754; x=1789498754;
  h=date:from:to:cc:subject:message-id;
  bh=Dr3N5tcHmDIK3HESgfwWYns7Fl4s4j2xAw0IHBe1SrE=;
  b=emRDBarmo+Zq0WaOdP/DBM+oupKMIDL42A7YITaVdmq5a8x0VUAJRu3/
   cVWAFxdap0Xz5HiZY22b4Rd9aD6mpNoyl0JI9etVngcQAc9EB3sglT2HX
   CyPXK72yHSRbYtq08mi7kKZ7upqujy+r4tyOGau8/O33/e7QiiE/gusDI
   fyZFVnHKf+6d4fpUGorf17cySekJoB7XXRc7mV8qOUEjFCuz71oMxw90P
   imhxIlNoRW447GB9ESbr9n3mECejJmjvYtCRnzNFyl/edv782caDYrjb1
   J1uBwfzPrZMduXzJBsEqmkbFRHa7H2iXSOg0BqnqcwSwFCIBctJa0H5Xe
   g==;
X-CSE-ConnectionGUID: SEIaSVX7Rz2yT0U7oBBw/g==
X-CSE-MsgGUID: 9ZXpr1s3Ta2YCvkYq9DHHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="71596670"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="71596670"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 11:59:14 -0700
X-CSE-ConnectionGUID: /YS/2+p0QfGz5iAWp8qewA==
X-CSE-MsgGUID: /HYE2zRdQdy7EdkCNehWlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="179878929"
Received: from lkp-server01.sh.intel.com (HELO 5b01dd97f97c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 15 Sep 2025 11:59:13 -0700
Received: from kbuild by 5b01dd97f97c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyEPt-0000az-1o;
	Mon, 15 Sep 2025 18:59:09 +0000
Date: Tue, 16 Sep 2025 02:58:33 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS WITH WARNING
 d21b26cad33250be758ea9d860ff9d5c3992c459
Message-ID: <202509160254.ZfnX5eeH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: d21b26cad33250be758ea9d860ff9d5c3992c459  Merge 6.17-rc6 into tty-next

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
|-- arc-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arc-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arc-randconfig-002-20250915
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arm-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arm-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arm-randconfig-002-20250915
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- arm-randconfig-051-20250915
|   |-- arch-arm-boot-dts-ti-omap-am335x-myirtech-myd.dtb:serial-(ti-am3352-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am335x-myirtech-myd.dtb:serial-(ti-am3352-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am437x-gp-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am437x-gp-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am437x-sk-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am437x-sk-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am43x-epos-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   `-- arch-arm-boot-dts-ti-omap-am43x-epos-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|-- arm-randconfig-052-20250915
|   |-- arch-arm-boot-dts-ti-omap-am335x-myirtech-myd.dtb:serial-(ti-am3352-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am335x-myirtech-myd.dtb:serial-(ti-am3352-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am437x-gp-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am437x-gp-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am437x-sk-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am437x-sk-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am43x-epos-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   `-- arch-arm-boot-dts-ti-omap-am43x-epos-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|-- arm-randconfig-053-20250915
|   |-- arch-arm-boot-dts-ti-omap-am335x-myirtech-myd.dtb:serial-(ti-am3352-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am335x-myirtech-myd.dtb:serial-(ti-am3352-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am437x-gp-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am437x-gp-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am437x-sk-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am437x-sk-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am43x-epos-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   `-- arch-arm-boot-dts-ti-omap-am43x-epos-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|-- arm-randconfig-054-20250915
|   |-- arch-arm-boot-dts-ti-omap-am335x-myirtech-myd.dtb:serial-(ti-am3352-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am335x-myirtech-myd.dtb:serial-(ti-am3352-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am437x-gp-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am437x-gp-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am437x-sk-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   |-- arch-arm-boot-dts-ti-omap-am437x-sk-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|   |-- arch-arm-boot-dts-ti-omap-am43x-epos-evm.dtb:serial-(ti-am4372-uart):Unevaluated-properties-are-not-allowed-(-pinctrl-names-was-unexpected)
|   `-- arch-arm-boot-dts-ti-omap-am43x-epos-evm.dtb:serial-(ti-am4372-uart):pinctrl-names:wakeup-was-expected
|-- arm-randconfig-055-20250915
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
|-- arm64-randconfig-001-20250915
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- hexagon-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- hexagon-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- hexagon-randconfig-001-20250915
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- i386-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- i386-buildonly-randconfig-002-20250915
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- i386-buildonly-randconfig-004-20250915
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- loongarch-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- loongarch-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- m68k-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- m68k-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- microblaze-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- microblaze-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- mips-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- mips-allyesconfig
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
|-- sh-randconfig-002-20250915
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- sparc-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- sparc-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- um-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- um-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-allmodconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-allyesconfig
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-buildonly-randconfig-003-20250915
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
|-- x86_64-buildonly-randconfig-005-20250915
|   `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc
`-- x86_64-rhel-9.4-rust
    `-- Warning:drivers-tty-n_gsm.c-function-parameter-dlci-not-described-in-gsm_modem_send_initial_msc

elapsed time: 738m

configs tested: 136
configs skipped: 3

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250915    gcc-9.5.0
arc                   randconfig-002-20250915    gcc-9.5.0
arc                    vdk_hs38_smp_defconfig    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                        clps711x_defconfig    clang-22
arm                   randconfig-001-20250915    gcc-13.4.0
arm                   randconfig-002-20250915    clang-20
arm                   randconfig-003-20250915    gcc-8.5.0
arm                   randconfig-004-20250915    gcc-11.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250915    clang-22
arm64                 randconfig-002-20250915    clang-22
arm64                 randconfig-003-20250915    gcc-8.5.0
arm64                 randconfig-004-20250915    gcc-11.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250915    gcc-15.1.0
csky                  randconfig-002-20250915    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250915    clang-22
hexagon               randconfig-002-20250915    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250915    clang-20
i386        buildonly-randconfig-002-20250915    gcc-14
i386        buildonly-randconfig-003-20250915    gcc-14
i386        buildonly-randconfig-004-20250915    gcc-14
i386        buildonly-randconfig-005-20250915    gcc-14
i386        buildonly-randconfig-006-20250915    gcc-14
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250915    clang-22
loongarch             randconfig-002-20250915    gcc-12.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                       bmips_be_defconfig    gcc-15.1.0
mips                          rb532_defconfig    clang-18
mips                         rt305x_defconfig    clang-22
mips                           xway_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250915    gcc-11.5.0
nios2                 randconfig-002-20250915    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           alldefconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250915    gcc-9.5.0
parisc                randconfig-002-20250915    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                     kmeter1_defconfig    gcc-15.1.0
powerpc                   motionpro_defconfig    clang-22
powerpc                     mpc512x_defconfig    clang-22
powerpc               randconfig-001-20250915    gcc-14.3.0
powerpc               randconfig-002-20250915    gcc-8.5.0
powerpc               randconfig-003-20250915    clang-22
powerpc                     redwood_defconfig    clang-22
powerpc64             randconfig-001-20250915    clang-20
powerpc64             randconfig-002-20250915    clang-22
powerpc64             randconfig-003-20250915    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250915    gcc-8.5.0
riscv                 randconfig-002-20250915    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250915    clang-22
s390                  randconfig-002-20250915    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          landisk_defconfig    gcc-15.1.0
sh                          lboxre2_defconfig    gcc-15.1.0
sh                    randconfig-001-20250915    gcc-15.1.0
sh                    randconfig-002-20250915    gcc-13.4.0
sh                          rsk7203_defconfig    gcc-15.1.0
sh                      rts7751r2d1_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250915    gcc-8.5.0
sparc                 randconfig-002-20250915    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250915    gcc-13.4.0
sparc64               randconfig-002-20250915    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250915    gcc-14
um                    randconfig-002-20250915    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250915    clang-20
x86_64      buildonly-randconfig-002-20250915    gcc-12
x86_64      buildonly-randconfig-003-20250915    gcc-14
x86_64      buildonly-randconfig-004-20250915    clang-20
x86_64      buildonly-randconfig-005-20250915    clang-20
x86_64      buildonly-randconfig-006-20250915    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250915    gcc-9.5.0
xtensa                randconfig-002-20250915    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
