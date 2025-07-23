Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F4C2DA74A
	for <linux-serial@vger.kernel.org>; Wed, 23 Jul 2025 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281805; cv=none; b=ChBZbGUFEZedA4nE1X8XqYFMMYWBTs4Qa/0eFYqAhY/QY32uAdFQ2+mbxq659gGXyZXXlHmQLXPPuaFahzV0DqMm/+VLuZ5d+13MFS9onJBHvSfg63GL8EyKbAPMNk4noEAuwSBkQynNDHtAryXnElXz0YPSbSX3p3XUhn7/LI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281805; c=relaxed/simple;
	bh=S4EAyOik+WJeNtLo3j2VlNgxDKUAn/U6ufX1PGt+4SA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LYeFPmZo33FuFgNJjCfqyKfZzEqGwhvDzFa+8b64QbbDH6dboW1DoaxNwpVFv84gQi39hLrXqxlrckEtHdyiVc23uGNcJeZsGXbDvge1gWzHAfvwVxIXaiWQ7pfT8OoOMkfll9aFufVrcoMzEFWjflH5ygfrI3pNvYoMxuahLeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3ixBjpF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3ixBjpF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753281804; x=1784817804;
  h=date:from:to:cc:subject:message-id;
  bh=S4EAyOik+WJeNtLo3j2VlNgxDKUAn/U6ufX1PGt+4SA=;
  b=M3ixBjpFoM17iXT++4y47euDSMR4A46uCN2fjwd8PSy6f8LZAGMAxtP1
   Qa3+KsEpn6rFX3R+I+Kw7Dj3V+OQ8FO0iDxaDQ6Dm7Dvk7LOH07cy/KEY
   Jy11Cz9Q87qG+rG2LpZL5isApvXwEi3syzbmeWROMcOdCZ4Ft7YZPB7I3
   sxAC34Ac4zUXspEtgIWMe1fPWgWPPsrnGoLWClZtAj0PJjXlJNgOCv6lk
   0ko/RGdYOfspych8fwMsNkYFx+XJvweGmiAdKL9FETGHdZstpZB3J41wf
   2KPO8xH27V9dNSQ7gF5ixLUgkLDJYa+Z6GLoXF6+BdYxWNwUsjCEPbEmw
   w==;
X-CSE-ConnectionGUID: AWQnylb1QmmZL7ucinZtIw==
X-CSE-MsgGUID: rki7UHXeS+aeNmh9L598Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="43186167"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="43186167"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 07:43:23 -0700
X-CSE-ConnectionGUID: CeyIWIkVSoSTwf34YZBLLw==
X-CSE-MsgGUID: I7xgiZefRDCCm69hOTth0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="164024814"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 23 Jul 2025 07:43:22 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueagh-000JRv-2s;
	Wed, 23 Jul 2025 14:43:19 +0000
Date: Wed, 23 Jul 2025 22:42:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 b43cb4ff85da5cf29c4cd351ef1d7dd8210780f7
Message-ID: <202507232226.HwBe0p1k-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: b43cb4ff85da5cf29c4cd351ef1d7dd8210780f7  vt: defkeymap: Map keycodes above 127 to K_HOLE

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
|-- arm-randconfig-051-20250723
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   `-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|-- arm-randconfig-052-20250723
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   `-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|-- arm-randconfig-053-20250723
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   `-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|-- arm-randconfig-054-20250723
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
|   |-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
|   `-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
`-- arm-randconfig-055-20250723
    |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
    |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
    |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
    |-- arch-arm-boot-dts-mediatek-mt7623a-rfb-nand.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
    |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
    |-- arch-arm-boot-dts-mediatek-mt7623n-bananapi-bpi-r2.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:
    |-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:main-is-too-short
    `-- arch-arm-boot-dts-mediatek-mt7623n-rfb-emmc.dtb:serial-1100c000-(mediatek-mt7623-btif):clock-names:oneOf-conditional-failed-one-must-be-fixed:

elapsed time: 1289m

configs tested: 122
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250723    gcc-8.5.0
arc                   randconfig-002-20250723    gcc-9.5.0
arm                              alldefconfig    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250723    gcc-13.4.0
arm                   randconfig-002-20250723    gcc-13.4.0
arm                   randconfig-003-20250723    clang-16
arm                   randconfig-004-20250723    clang-22
arm                        spear6xx_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250723    clang-22
arm64                 randconfig-002-20250723    clang-16
arm64                 randconfig-003-20250723    clang-16
arm64                 randconfig-004-20250723    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250723    gcc-12.5.0
csky                  randconfig-002-20250723    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250723    clang-22
hexagon               randconfig-002-20250723    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250723    clang-20
i386        buildonly-randconfig-002-20250723    clang-20
i386        buildonly-randconfig-003-20250723    clang-20
i386        buildonly-randconfig-004-20250723    clang-20
i386        buildonly-randconfig-005-20250723    gcc-11
i386        buildonly-randconfig-006-20250723    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250723    gcc-15.1.0
loongarch             randconfig-002-20250723    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                       bmips_be_defconfig    gcc-15.1.0
mips                           jazz_defconfig    clang-17
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250723    gcc-8.5.0
nios2                 randconfig-002-20250723    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250723    gcc-8.5.0
parisc                randconfig-002-20250723    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250723    gcc-10.5.0
powerpc               randconfig-002-20250723    gcc-8.5.0
powerpc               randconfig-003-20250723    gcc-12.5.0
powerpc                     tqm8540_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250723    clang-22
powerpc64             randconfig-002-20250723    clang-22
powerpc64             randconfig-003-20250723    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250723    gcc-9.5.0
riscv                 randconfig-002-20250723    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250723    clang-22
s390                  randconfig-002-20250723    clang-20
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250723    gcc-12.5.0
sh                    randconfig-002-20250723    gcc-9.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250723    gcc-8.5.0
sparc                 randconfig-002-20250723    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250723    gcc-12.5.0
sparc64               randconfig-002-20250723    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250723    gcc-12
um                    randconfig-002-20250723    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250723    gcc-12
x86_64      buildonly-randconfig-002-20250723    gcc-11
x86_64      buildonly-randconfig-003-20250723    gcc-11
x86_64      buildonly-randconfig-004-20250723    clang-20
x86_64      buildonly-randconfig-005-20250723    gcc-12
x86_64      buildonly-randconfig-006-20250723    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250723    gcc-13.4.0
xtensa                randconfig-002-20250723    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
