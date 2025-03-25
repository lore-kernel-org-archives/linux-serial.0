Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC452561A2
	for <linux-serial@vger.kernel.org>; Tue, 25 Mar 2025 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910690; cv=none; b=rWwbvKcIeTKRa9Azy9yEoksRPSwRzRI7n50G8P3mXzrRWUtp2gGqhCP7SzhUiSLR0FI8NP7shvHUOsUu9sntz2nmFFw3haH5rprZocyI93UaG0vqvI4cLfHhBZr8XC965G8ozZ39sdCy0/HopEDFoxNM8Fqrvvj81TseMOQEVNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910690; c=relaxed/simple;
	bh=fhUqi2MbhwQOJx/sI4hxxvkRtMcE9MHgzb1GkV3RsFw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OQl1yHvsDE4F332r7vEID279wevXaj8VgvI9sk7Xwf3vMkoOAawscd3VMhV9XyBCEIsLcvhTWRfORtzVmDcfqfzGnrbRgwVU+n0fl1FJ1Gh01jCcTnI2rVbIy19C3wjJnKm91wO0zajS6bKlvsEsLYj32W0Bq6JnJzVpLb1rfrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1UoYFIh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1UoYFIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742910689; x=1774446689;
  h=date:from:to:cc:subject:message-id;
  bh=fhUqi2MbhwQOJx/sI4hxxvkRtMcE9MHgzb1GkV3RsFw=;
  b=m1UoYFIh5p6hYq6SxJ5ZV4Tbfw66xcg4t+bhCOXMJuY/1trG81fUETbT
   0wefqKgJLb7Oj/M0gmCD9Aew+PvNN2qqPDEhRsSZuLOCBgSqJQwq8tpsJ
   QbeR8gihhLhEveOjksIwo8RwLpJqCDv/328uxqULM9rOdZ0b5s2AGe4Dq
   ZbQwsJUdoayMq5bbZz5U182ahiYPJKVVeFUuPIkLjZwdEq06U0LhG+Phc
   6Lqe6V/kuf3S5SmcBkpD1QsGC6Us2meZL67BROK7hhQ2wa4y3qUiUWXD9
   3pqKPbP6YeV4rZOd0akD09kuhm+fF+eSSNfyDIKWQwOut0+EH0JLKl9QX
   A==;
X-CSE-ConnectionGUID: d/ff5le+Qo2UPgWNslx5Ow==
X-CSE-MsgGUID: V6yO03BoTmqEYbSNwq5FmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="43314392"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="43314392"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 06:51:28 -0700
X-CSE-ConnectionGUID: cZXYbCfRT0u49vMecLYhJg==
X-CSE-MsgGUID: UJS6x+QwQ/G+m1bUN3iRhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="124098376"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 25 Mar 2025 06:51:27 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tx4ga-0004vV-2S;
	Tue, 25 Mar 2025 13:51:22 +0000
Date: Tue, 25 Mar 2025 21:50:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 9f8fe348ac9544f6855f82565e754bf085d81f88
Message-ID: <202503252149.YSROiA4n-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 9f8fe348ac9544f6855f82565e754bf085d81f88  tty: serial: fsl_lpuart: Fix unused variable 'sport' build warning

elapsed time: 1452m

configs tested: 144
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250324    gcc-12.4.0
arc                   randconfig-002-20250324    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                       imx_v4_v5_defconfig    clang-15
arm                            mmp2_defconfig    gcc-14.2.0
arm                        multi_v7_defconfig    gcc-14.2.0
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                   randconfig-001-20250324    gcc-8.5.0
arm                   randconfig-002-20250324    gcc-7.5.0
arm                   randconfig-003-20250324    clang-21
arm                   randconfig-004-20250324    clang-21
arm                           sama7_defconfig    clang-21
arm                          sp7021_defconfig    gcc-14.2.0
arm                           spitz_defconfig    gcc-14.2.0
arm                    vt8500_v6_v7_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250324    gcc-8.5.0
arm64                 randconfig-002-20250324    clang-14
arm64                 randconfig-003-20250324    clang-21
arm64                 randconfig-004-20250324    gcc-6.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250324    gcc-14.2.0
csky                  randconfig-002-20250324    gcc-14.2.0
hexagon                          alldefconfig    clang-21
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250324    clang-21
hexagon               randconfig-002-20250324    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250324    clang-20
i386        buildonly-randconfig-002-20250324    clang-20
i386        buildonly-randconfig-003-20250324    gcc-12
i386        buildonly-randconfig-004-20250324    clang-20
i386        buildonly-randconfig-005-20250324    gcc-12
i386        buildonly-randconfig-006-20250324    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250324    gcc-14.2.0
loongarch             randconfig-002-20250324    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                            mac_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        qi_lb60_defconfig    clang-21
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250324    gcc-8.5.0
nios2                 randconfig-002-20250324    gcc-10.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                  or1klitex_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                generic-64bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250324    gcc-13.3.0
parisc                randconfig-002-20250324    gcc-5.5.0
powerpc                    adder875_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                      cm5200_defconfig    clang-21
powerpc                        fsp2_defconfig    gcc-14.2.0
powerpc                      pmac32_defconfig    clang-21
powerpc                      ppc44x_defconfig    clang-21
powerpc               randconfig-001-20250324    gcc-6.5.0
powerpc               randconfig-002-20250324    clang-19
powerpc               randconfig-003-20250324    clang-21
powerpc                     redwood_defconfig    clang-21
powerpc                  storcenter_defconfig    gcc-14.2.0
powerpc                 xes_mpc85xx_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250324    gcc-6.5.0
powerpc64             randconfig-002-20250324    clang-15
powerpc64             randconfig-003-20250324    gcc-6.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250324    clang-21
riscv                 randconfig-002-20250324    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250324    clang-15
s390                  randconfig-002-20250324    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250324    gcc-12.4.0
sh                    randconfig-002-20250324    gcc-12.4.0
sh                           se7206_defconfig    gcc-14.2.0
sh                           se7722_defconfig    gcc-14.2.0
sh                            shmin_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250324    gcc-5.5.0
sparc                 randconfig-002-20250324    gcc-11.5.0
sparc64                          alldefconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250324    gcc-13.3.0
sparc64               randconfig-002-20250324    gcc-5.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250324    clang-21
um                    randconfig-002-20250324    clang-21
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250324    clang-20
x86_64      buildonly-randconfig-002-20250324    gcc-12
x86_64      buildonly-randconfig-003-20250324    clang-20
x86_64      buildonly-randconfig-004-20250324    clang-20
x86_64      buildonly-randconfig-005-20250324    clang-20
x86_64      buildonly-randconfig-006-20250324    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250324    gcc-13.3.0
xtensa                randconfig-002-20250324    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
