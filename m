Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C39335576
	for <linux-serial@vger.kernel.org>; Thu, 18 Dec 2025 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766068094; cv=none; b=doj/OVWsYlUAr09bdKs7fQtcdbUzUOPpVLN0bA/80WTib/Yol/jRb0LHsmbd7Hy5ssVYyguN3ykEOo9CMo9ekqO49maq4AXqOntGVRScpDEJ21SGtY/MApTrt3JToLzInPH1sEl0pBoHzNywvisb5MHi3uTpypvKaU+XnUT4OqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766068094; c=relaxed/simple;
	bh=fkRKbAqDcR248ovIdnVHQBTLFZeqdWKKpfxT5eZgg84=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mhdjOUMk/cF16I8XETSdm7JVf2cppyINjeEMhAS61nEwTFGAtOmMBwoQA1x4dED89XMmJT/gogYSbbW85ePcBeBmHDn45mTletlMs1xHaBvtb+6I5U9reJtSbHeL/ih4QbJeMQYz4o/2ZyA0rqRP/I/UHzMIEnmKO9fOHoX3ZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UjZTshFp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UjZTshFp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766068092; x=1797604092;
  h=date:from:to:cc:subject:message-id;
  bh=fkRKbAqDcR248ovIdnVHQBTLFZeqdWKKpfxT5eZgg84=;
  b=UjZTshFpVWboE/5ZRKkb0E+Evaw20IY7xqt3cnWMw/BWOCbzQEW0vriw
   Ivr3Zz26Yi0t9+2cgUiVxVKsZrOaFf++voreyrD23QYCJlV6DWOdjuf3m
   zeK8brR7UQPu7n0ncg9mq/FnEl8tP57TztC6ortp1WXJQ9gVm0KObdvVD
   Xq3/ylSPN07kQ/Oq+hDvpY4LyS070fZIaBvzupPwyT4jKmJ5v5jvBaeMj
   4AMWQHN7Q66+i7NXcfy0ya5tM+KloJZfT18b0ZOLkA7uHdPR7vNikk1J0
   gV+eiInIeOJgncH/Lz8Rg1CO/dxPYpWH7C1fUbfMUinvn6NaYOHtmC6WG
   A==;
X-CSE-ConnectionGUID: 1D2+ibcYRwC3txnqYocBGQ==
X-CSE-MsgGUID: MdVDw/8KQXa0cdtm8Op0Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="67216919"
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="67216919"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 06:28:09 -0800
X-CSE-ConnectionGUID: 7/A6/qIVThOo4KT2kqsACA==
X-CSE-MsgGUID: Pa4HXNDDTMeIDAvPIDdKxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="198654736"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 18 Dec 2025 06:28:08 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWEz7-000000002BV-2jz6;
	Thu, 18 Dec 2025 14:28:05 +0000
Date: Thu, 18 Dec 2025 22:27:41 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 5edb7338d6117bb0ce17ead7973c67390da42258
Message-ID: <202512182228.4zfCgL2d-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 5edb7338d6117bb0ce17ead7973c67390da42258  serial: 8250: longson: Fix NULL vs IS_ERR() bug in probe

elapsed time: 1453m

configs tested: 184
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251218    clang-22
arc                   randconfig-002-20251218    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.1.0
arm                       imx_v6_v7_defconfig    gcc-15.1.0
arm                         lpc32xx_defconfig    clang-22
arm                         orion5x_defconfig    clang-22
arm                   randconfig-001-20251218    clang-22
arm                   randconfig-002-20251218    clang-22
arm                   randconfig-003-20251218    clang-22
arm                   randconfig-004-20251218    clang-22
arm                        spear3xx_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251218    gcc-14.3.0
arm64                 randconfig-002-20251218    gcc-14.3.0
arm64                 randconfig-003-20251218    gcc-14.3.0
arm64                 randconfig-004-20251218    gcc-14.3.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251218    gcc-14.3.0
csky                  randconfig-002-20251218    gcc-14.3.0
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251218    gcc-11.5.0
hexagon               randconfig-002-20251218    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251218    gcc-14
i386        buildonly-randconfig-002-20251218    gcc-14
i386        buildonly-randconfig-003-20251218    gcc-14
i386        buildonly-randconfig-004-20251218    gcc-14
i386        buildonly-randconfig-005-20251218    gcc-14
i386        buildonly-randconfig-006-20251218    gcc-14
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251218    gcc-12
i386                  randconfig-002-20251218    gcc-12
i386                  randconfig-003-20251218    gcc-12
i386                  randconfig-004-20251218    gcc-12
i386                  randconfig-005-20251218    gcc-12
i386                  randconfig-006-20251218    gcc-12
i386                  randconfig-007-20251218    gcc-12
i386                  randconfig-011-20251218    clang-20
i386                  randconfig-012-20251218    clang-20
i386                  randconfig-013-20251218    clang-20
i386                  randconfig-014-20251218    clang-20
i386                  randconfig-015-20251218    clang-20
i386                  randconfig-016-20251218    clang-20
i386                  randconfig-017-20251218    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251218    gcc-11.5.0
loongarch             randconfig-002-20251218    gcc-11.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                           sun3_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                          ath25_defconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251218    gcc-11.5.0
nios2                 randconfig-002-20251218    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
openrisc                  or1klitex_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251218    gcc-8.5.0
parisc                randconfig-002-20251218    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                     ppa8548_defconfig    clang-22
powerpc               randconfig-001-20251218    gcc-8.5.0
powerpc               randconfig-002-20251218    gcc-8.5.0
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251218    gcc-8.5.0
powerpc64             randconfig-002-20251218    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.1.0
riscv                    nommu_virt_defconfig    gcc-15.1.0
riscv                 randconfig-001-20251218    gcc-8.5.0
riscv                 randconfig-002-20251218    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251218    gcc-8.5.0
s390                  randconfig-002-20251218    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                        apsh4ad0a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                          r7780mp_defconfig    clang-22
sh                    randconfig-001-20251218    gcc-8.5.0
sh                    randconfig-002-20251218    gcc-8.5.0
sh                           se7750_defconfig    clang-22
sh                          urquell_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251218    gcc-15.1.0
sparc                 randconfig-002-20251218    gcc-15.1.0
sparc                       sparc32_defconfig    clang-22
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251218    gcc-15.1.0
sparc64               randconfig-002-20251218    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251218    gcc-15.1.0
um                    randconfig-002-20251218    gcc-15.1.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251218    gcc-14
x86_64      buildonly-randconfig-002-20251218    gcc-14
x86_64      buildonly-randconfig-003-20251218    gcc-14
x86_64      buildonly-randconfig-004-20251218    gcc-14
x86_64      buildonly-randconfig-005-20251218    gcc-14
x86_64      buildonly-randconfig-006-20251218    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251218    clang-20
x86_64                randconfig-002-20251218    clang-20
x86_64                randconfig-003-20251218    clang-20
x86_64                randconfig-004-20251218    clang-20
x86_64                randconfig-005-20251218    clang-20
x86_64                randconfig-006-20251218    clang-20
x86_64                randconfig-011-20251218    gcc-14
x86_64                randconfig-012-20251218    gcc-14
x86_64                randconfig-013-20251218    gcc-14
x86_64                randconfig-014-20251218    gcc-14
x86_64                randconfig-015-20251218    gcc-14
x86_64                randconfig-016-20251218    gcc-14
x86_64                randconfig-071-20251218    gcc-12
x86_64                randconfig-072-20251218    gcc-12
x86_64                randconfig-073-20251218    gcc-12
x86_64                randconfig-074-20251218    gcc-12
x86_64                randconfig-075-20251218    gcc-12
x86_64                randconfig-076-20251218    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251218    gcc-15.1.0
xtensa                randconfig-002-20251218    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
