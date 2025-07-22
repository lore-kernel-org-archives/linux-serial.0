Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F16B27CCC4
	for <linux-serial@vger.kernel.org>; Tue, 22 Jul 2025 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753202475; cv=none; b=J22Bc5CsK1Qld9NVMo3Ah0SpgfajU9HrPzXbCcuUVqbDxfN6JO4ghLi2sa7tQsaK7Ge8iwSFxiizZdKfivSLh6gf3BJFfohOxZer1RBUNcZr7PGXDSBaDkbXlMPl11bgPaP/j9Zi5jVJAubWpV91ppJ5ONZfrGt9cNGWLjDMJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753202475; c=relaxed/simple;
	bh=tzgGh8n9BFmIg+YflW6QnNsQSlZ3ypzMjbaufVR/RfQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=V7KPv8vY7IJMv+ElTQQyZeZu+uPQHZY+6gIuv4nvQwaOuNRn+Y71LIixqV0w1qqN+a/zfVNJIeW/AqXkAAK1/heuLUz6FFpwlyp6d/m7fAS3vZ2xJqQaJHehEh5eDjZozdZrAPjF/Efz7sA9ZKU6w4OXrE2pGlzyn4QC27ZR0Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lf2jSrlo; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lf2jSrlo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753202473; x=1784738473;
  h=date:from:to:cc:subject:message-id;
  bh=tzgGh8n9BFmIg+YflW6QnNsQSlZ3ypzMjbaufVR/RfQ=;
  b=lf2jSrloxcRjD5McPwz4WtAS/zrL4BfUh8/ElO/Q4HEJR3QlhjhYFonJ
   uXY0S3Xz8RmQmbXw6wjFMnO/jZSsiJpNELi9OPgJryD4SpGIayW2N5LQb
   7yUh4A0o9/XHYkf7rnS/zI7EDhYFyysFi/zTaYGBts3HA+LeYJWH+qMAC
   nxPy6Gplk8cSwmgibsrQ25l02S+KiOvV0mqT72o5jn+94Y7IOqENAQ+GQ
   wkCd1jxQcz1P/uNEno1OHWIkk097V7Cp6C2oKSuSAmmih+AV0A475RzkN
   F8uWk97CHIHosm36uqci0jlZ61egFBpbqJCStp82KLt/TbF6vn5zLw6tc
   g==;
X-CSE-ConnectionGUID: YZrPYJQhQV+MNt4TdISsYA==
X-CSE-MsgGUID: imUDqD1ESQiyD9i4WKXK+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="66533128"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="66533128"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 09:41:12 -0700
X-CSE-ConnectionGUID: Fm06qwDxSV6zdjk/niAECA==
X-CSE-MsgGUID: VrXeJhhOSSu/AgBZBSuK8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="159269040"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 22 Jul 2025 09:41:11 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueG3B-000IXf-0J;
	Tue, 22 Jul 2025 16:41:09 +0000
Date: Wed, 23 Jul 2025 00:40:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 48f9034e024a4c6e279b0d040e1f5589bb544806
Message-ID: <202507230029.KWawW6D0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 48f9034e024a4c6e279b0d040e1f5589bb544806  dt-bindings: serial: 8250: spacemit: set clocks property as required

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
|-- arm-randconfig-051-20250722
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   `-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|-- arm-randconfig-052-20250722
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   `-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|-- arm-randconfig-053-20250722
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   `-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|-- arm-randconfig-054-20250722
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   `-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
`-- arm-randconfig-055-20250722
    |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
    |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
    |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
    |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
    |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
    |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
    |-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
    `-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:

elapsed time: 1435m

configs tested: 127
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                        nsimosci_defconfig    gcc-15.1.0
arc                   randconfig-001-20250722    gcc-10.5.0
arc                   randconfig-002-20250722    gcc-11.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20250722    gcc-12.5.0
arm                   randconfig-002-20250722    clang-22
arm                   randconfig-003-20250722    gcc-8.5.0
arm                   randconfig-004-20250722    clang-17
arm                           spitz_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250722    clang-22
arm64                 randconfig-002-20250722    clang-22
arm64                 randconfig-003-20250722    clang-22
arm64                 randconfig-004-20250722    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250722    gcc-11.5.0
csky                  randconfig-002-20250722    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250722    clang-20
hexagon               randconfig-002-20250722    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250722    gcc-12
i386        buildonly-randconfig-002-20250722    gcc-12
i386        buildonly-randconfig-003-20250722    clang-20
i386        buildonly-randconfig-004-20250722    gcc-12
i386        buildonly-randconfig-005-20250722    clang-20
i386        buildonly-randconfig-006-20250722    clang-20
i386                                defconfig    clang-20
loongarch                        alldefconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250722    gcc-15.1.0
loongarch             randconfig-002-20250722    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
microblaze                      mmu_defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250722    gcc-11.5.0
nios2                 randconfig-002-20250722    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250722    gcc-8.5.0
parisc                randconfig-002-20250722    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                 mpc832x_rdb_defconfig    gcc-15.1.0
powerpc                  mpc885_ads_defconfig    clang-22
powerpc               randconfig-001-20250722    gcc-13.4.0
powerpc               randconfig-002-20250722    clang-22
powerpc               randconfig-003-20250722    gcc-14.3.0
powerpc64             randconfig-001-20250722    gcc-8.5.0
powerpc64             randconfig-002-20250722    clang-22
powerpc64             randconfig-003-20250722    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250722    clang-16
riscv                 randconfig-002-20250722    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250722    clang-22
s390                  randconfig-002-20250722    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250722    gcc-15.1.0
sh                    randconfig-002-20250722    gcc-15.1.0
sh                           se7206_defconfig    gcc-15.1.0
sh                        sh7757lcr_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250722    gcc-13.4.0
sparc                 randconfig-002-20250722    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250722    gcc-8.5.0
sparc64               randconfig-002-20250722    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250722    gcc-12
um                    randconfig-002-20250722    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250722    gcc-12
x86_64      buildonly-randconfig-002-20250722    gcc-12
x86_64      buildonly-randconfig-003-20250722    gcc-12
x86_64      buildonly-randconfig-004-20250722    clang-20
x86_64      buildonly-randconfig-005-20250722    gcc-12
x86_64      buildonly-randconfig-006-20250722    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250722    gcc-15.1.0
xtensa                randconfig-002-20250722    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
