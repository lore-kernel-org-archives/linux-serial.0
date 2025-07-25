Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC8CA41
	for <linux-serial@vger.kernel.org>; Fri, 25 Jul 2025 06:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753425115; cv=none; b=pfhu7vzcOmuiuPv1cvMSGu9tRrRDfbb9D4SNrvbaT7JU8UNUYDDD/EA3P5mkPJ57aAvbn9Mnk97jBOYWio/BWOqyALmHxRua/8DLpPSBrNXavIdwKhm751IMsfYYfUp24CuiR6mCZaohz/f+4kYNiwQOsNpPXOnEFig7zMf+wV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753425115; c=relaxed/simple;
	bh=6Y8KkJwXB2+jaLllrfQXQ8NDoe/BePCRJd7VOhcfzBo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WoXnBYKfm1uEXi+2i5lvvff8/QRxVLKwpWN1eqj1ditpty7iCs6V/wKoa8bzvF1bW+q9jynK91trmhwphJBOEh+5SHnR8qcdhKvt8jM15d+rH8LcB1JhH1TY0+L9qo0j2OH5QSTAyzqBAFhQLYkZzmaxgWUu01LbAt3w9XNbhZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HvrhAYAW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HvrhAYAW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753425114; x=1784961114;
  h=date:from:to:cc:subject:message-id;
  bh=6Y8KkJwXB2+jaLllrfQXQ8NDoe/BePCRJd7VOhcfzBo=;
  b=HvrhAYAWzYk0L9XDWe4IZw4TxSlG/HmhlJj4hK5Wz26Whzn3p7k5QH82
   r5a18NgoHK/U307pepeGW6/3Otir8ufoG+3fL6GYAZ83miw1i+IEa32aC
   NqVs00j6xivPHGCBIjsHvH7YYaMJ724qbZrU9bhiVUlyVihggSDG+3Usd
   DmYoZqMcmMeo1O0H8m02t998ucOPkuZ3zKn36+Hlr5nrP3Ry2dW0DPZIa
   PjPQutwpG6PmuRvFCH+UY5lfiNj29bPI10wI9u8/ytlUHDRJBFDfgAXIv
   Do/hXQkQ8Avn913YgG/8gB72uvBdcIlQUBZBdDm8uHcueMHFSPMYIXxhN
   Q==;
X-CSE-ConnectionGUID: iDpBa0eGSC+rov5PmKg6rg==
X-CSE-MsgGUID: u42n/haqTguNiTwesDL9IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59408753"
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208";a="59408753"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 23:31:54 -0700
X-CSE-ConnectionGUID: 09t8YgqqQKKbDkdKFbCqCA==
X-CSE-MsgGUID: xgAdwVz7S0Oy7uxzoKtacg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208";a="160918041"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 24 Jul 2025 23:31:51 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufBy9-000L7D-2C;
	Fri, 25 Jul 2025 06:31:49 +0000
Date: Fri, 25 Jul 2025 14:31:45 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 57b4ca42359c63ad61548431c184a7d63efbd0b9
Message-ID: <202507251429.CDa7bZne-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 57b4ca42359c63ad61548431c184a7d63efbd0b9  dt-bindings: serial: snps-dw-apb-uart: Allow use of a power-domain

Unverified Warning (likely false positive, kindly check if interested):

    arch/arm/boot/dts/mediatek/mt7623a-rfb-emmc.dtb: serial@1100c000 (mediatek,mt7623-btif): clock-names: 'oneOf' conditional failed, one must be fixed:
    arch/arm/boot/dts/mediatek/mt7623a-rfb-emmc.dtb: serial@1100c000 (mediatek,mt7623-btif): clock-names: ['main'] is too short
    arch/arm/boot/dts/mediatek/mt7623a-rfb-nand.dtb: serial@1100c000 (mediatek,mt7623-btif): clock-names: 'oneOf' conditional failed, one must be fixed:
    arch/arm/boot/dts/mediatek/mt7623a-rfb-nand.dtb: serial@1100c000 (mediatek,mt7623-btif): clock-names: ['main'] is too short
    arch/arm/boot/dts/mediatek/mt7623n-bananapi-bpi-r2.dtb: serial@1100c000 (mediatek,mt7623-btif): clock-names: 'oneOf' conditional failed, one must be fixed:
    arch/arm/boot/dts/mediatek/mt7623n-bananapi-bpi-r2.dtb: serial@1100c000 (mediatek,mt7623-btif): clock-names: ['main'] is too short
    arch/arm/boot/dts/mediatek/mt7623n-rfb-emmc.dtb: serial@1100c000 (mediatek,mt7623-btif): clock-names: 'oneOf' conditional failed, one must be fixed:
    arch/arm/boot/dts/mediatek/mt7623n-rfb-emmc.dtb: serial@1100c000 (mediatek,mt7623-btif): clock-names: ['main'] is too short

Warning ids grouped by kconfigs:

recent_errors
|-- arm-randconfig-051-20250725
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   `-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|-- arm-randconfig-052-20250725
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   `-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|-- arm-randconfig-053-20250725
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   `-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|-- arm-randconfig-054-20250725
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   `-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
`-- arm-randconfig-055-20250725
    |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
    |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
    |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
    |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
    |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
    |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
    |-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
    `-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:

elapsed time: 1248m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250724    gcc-13.4.0
arc                   randconfig-002-20250724    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250724    gcc-10.5.0
arm                   randconfig-002-20250724    clang-22
arm                   randconfig-003-20250724    gcc-8.5.0
arm                   randconfig-004-20250724    gcc-12.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250724    gcc-8.5.0
arm64                 randconfig-002-20250724    clang-22
arm64                 randconfig-003-20250724    gcc-13.4.0
arm64                 randconfig-004-20250724    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250724    gcc-13.4.0
csky                  randconfig-002-20250724    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250724    clang-22
hexagon               randconfig-002-20250724    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250724    gcc-12
i386        buildonly-randconfig-002-20250724    clang-20
i386        buildonly-randconfig-003-20250724    clang-20
i386        buildonly-randconfig-004-20250724    clang-20
i386        buildonly-randconfig-005-20250724    clang-20
i386        buildonly-randconfig-006-20250724    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250724    clang-22
loongarch             randconfig-002-20250724    gcc-13.4.0
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
nios2                 randconfig-001-20250724    gcc-11.5.0
nios2                 randconfig-002-20250724    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250724    gcc-14.3.0
parisc                randconfig-002-20250724    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250724    clang-22
powerpc               randconfig-002-20250724    gcc-8.5.0
powerpc               randconfig-003-20250724    clang-22
powerpc64             randconfig-001-20250724    clang-22
powerpc64             randconfig-002-20250724    gcc-13.4.0
powerpc64             randconfig-003-20250724    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250724    gcc-13.4.0
riscv                 randconfig-002-20250724    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250724    clang-22
s390                  randconfig-002-20250724    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250724    gcc-13.4.0
sh                    randconfig-002-20250724    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250724    gcc-15.1.0
sparc                 randconfig-002-20250724    gcc-8.5.0
sparc64               randconfig-001-20250724    gcc-8.5.0
sparc64               randconfig-002-20250724    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250724    clang-22
um                    randconfig-002-20250724    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250724    gcc-12
x86_64      buildonly-randconfig-002-20250724    clang-20
x86_64      buildonly-randconfig-003-20250724    gcc-12
x86_64      buildonly-randconfig-004-20250724    gcc-12
x86_64      buildonly-randconfig-005-20250724    clang-20
x86_64      buildonly-randconfig-006-20250724    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250724    gcc-12.5.0
xtensa                randconfig-002-20250724    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
