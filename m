Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49E5202996
	for <linux-serial@vger.kernel.org>; Thu, 17 Jul 2025 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745150; cv=none; b=PeUhHqwpPgsmGapEQmAmYxqodEN1uDd6MZSIiNTQi3n8uRjV+MeAN3t8WVxB13NSIsdo44TrrTAmHyWkzA/OxBaOPleUuAqU5YXg00PgwoCZI8/H1OJcaWTe2mVI/7PV4QtD+wDMh1QJt+2m9JKgU3FUUcf80T/0tkCIpp5/p7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745150; c=relaxed/simple;
	bh=x/nkF9Kcn8YREMeCauxudVK/2lC24hstmqKLajGCCiI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tffWfTCiaYlVb9F8nKlDG7PU4y5KoWJxQcO7qN7GXAvqLXRwgfJdLSWX6gxsiEwcvlQIIonLsRlZlKnMxZg2m8aNr5xC1eDDoyk3HE008dkItdYsMBauow5oSvkFp55ZEDH51sZrN0OTxoJa9XyBRrj9io9ZpnJvPklzVbmv/hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BsbRl/Rb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BsbRl/Rb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752745147; x=1784281147;
  h=date:from:to:cc:subject:message-id;
  bh=x/nkF9Kcn8YREMeCauxudVK/2lC24hstmqKLajGCCiI=;
  b=BsbRl/RbFsz4voU4IR1E3HlG4BdWPEMNOiROqzLUoI8f7Xd8vnC3SaE4
   HYGXAKj5EwwfgZ/0revmHr6qeCZSjeRIExc7/hbGFP8dVDS/Q+3XjScpe
   1SpDKHGbcNsDAe9BtCnIVQiCHVy1TTNPrR8VvOyxMrCyezHfZsJb7rLJo
   GgkGQ/L69r6uWhX7L6U88L6PvfvXMxW5Bg6z1BYAEOz7I62RCNRZMdFJ/
   52Rw9/2qoinSXLzOS2tEcd1xV1xpZyn2G0WM570Tt2/lbaGVAJhOpXqIY
   iBKdBYmD4cpOoDLoda92j569/HQVCCHIVfv9pLeJqZVPxZeEhESU2Zk5j
   w==;
X-CSE-ConnectionGUID: E/ZWDASIQVGgu5UtFYDnBg==
X-CSE-MsgGUID: 4xyq9LzYTQmuZ8WxCQAbog==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="80460345"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="80460345"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 02:39:07 -0700
X-CSE-ConnectionGUID: HwncwZy3QHussZ+Tgf7alw==
X-CSE-MsgGUID: stewcpwFRnync31h4vc7pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="158456325"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 17 Jul 2025 02:39:07 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucL4y-000DTv-2X;
	Thu, 17 Jul 2025 09:39:04 +0000
Date: Thu, 17 Jul 2025 17:38:36 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 103f5d8c35b3d22b700f1f6d585e499b2df62df6
Message-ID: <202507171719.nUVORgnl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 103f5d8c35b3d22b700f1f6d585e499b2df62df6  tty: omit need_resched() before cond_resched()

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
|-- arm-randconfig-051-20250717
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   `-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|-- arm-randconfig-052-20250717
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   `-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|-- arm-randconfig-053-20250717
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   `-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|-- arm-randconfig-054-20250717
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   `-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
`-- arm-randconfig-055-20250717
    |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
    |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
    |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
    |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
    |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
    |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
    |-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
    `-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:

elapsed time: 1447m

configs tested: 105
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                         haps_hs_defconfig    gcc-15.1.0
arc                            hsdk_defconfig    gcc-15.1.0
arc                   randconfig-001-20250716    gcc-13.4.0
arc                   randconfig-002-20250716    gcc-8.5.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                           omap1_defconfig    gcc-15.1.0
arm                   randconfig-001-20250716    clang-20
arm                   randconfig-002-20250716    gcc-12.4.0
arm                   randconfig-003-20250716    gcc-8.5.0
arm                   randconfig-004-20250716    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250716    gcc-9.5.0
arm64                 randconfig-002-20250716    gcc-8.5.0
arm64                 randconfig-003-20250716    gcc-8.5.0
arm64                 randconfig-004-20250716    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250716    gcc-14.3.0
csky                  randconfig-002-20250716    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250716    clang-21
hexagon               randconfig-002-20250716    clang-21
i386        buildonly-randconfig-001-20250716    gcc-12
i386        buildonly-randconfig-002-20250716    clang-20
i386        buildonly-randconfig-003-20250716    gcc-12
i386        buildonly-randconfig-004-20250716    gcc-11
i386        buildonly-randconfig-005-20250716    gcc-12
i386        buildonly-randconfig-006-20250716    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250716    clang-18
loongarch             randconfig-002-20250716    clang-21
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250716    gcc-14.2.0
nios2                 randconfig-002-20250716    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                    or1ksim_defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250716    gcc-8.5.0
parisc                randconfig-002-20250716    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      mgcoge_defconfig    clang-21
powerpc               randconfig-001-20250716    gcc-8.5.0
powerpc               randconfig-002-20250716    clang-21
powerpc               randconfig-003-20250716    gcc-14.3.0
powerpc64             randconfig-001-20250716    gcc-10.5.0
powerpc64             randconfig-003-20250716    gcc-13.4.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250716    gcc-8.5.0
riscv                 randconfig-002-20250716    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250716    gcc-11.5.0
s390                  randconfig-002-20250716    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                          r7780mp_defconfig    gcc-15.1.0
sh                    randconfig-001-20250716    gcc-15.1.0
sh                    randconfig-002-20250716    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250716    gcc-8.5.0
sparc                 randconfig-002-20250716    gcc-14.3.0
sparc64               randconfig-001-20250716    clang-20
sparc64               randconfig-002-20250716    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250716    gcc-11
um                    randconfig-002-20250716    gcc-12
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250716    gcc-12
x86_64      buildonly-randconfig-002-20250716    clang-20
x86_64      buildonly-randconfig-003-20250716    clang-20
x86_64      buildonly-randconfig-004-20250716    clang-20
x86_64      buildonly-randconfig-005-20250716    clang-20
x86_64      buildonly-randconfig-006-20250716    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  cadence_csp_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250716    gcc-9.3.0
xtensa                randconfig-002-20250716    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
