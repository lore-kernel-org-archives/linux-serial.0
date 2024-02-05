Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D74E2C6A6
	for <linux-serial@vger.kernel.org>; Mon,  5 Feb 2024 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143795; cv=none; b=lpZN4tBuMyMJr9BKsTTdujCfDiurzqnhELflRiZmmfeVX3hwFeXtOMDkDQ7VVpsV0t+a4coZEGmtDdn5WQkbcyOQ4KufoJoWt8ltAx4bASjvC12lNuaNKJfIs2lKFFdpzLObYFoVgPklYFF5b6sSe+3EGQJtCYqZd3ZQZAebsBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143795; c=relaxed/simple;
	bh=5uJ0h+rxUUZx37lrrVSPGT1K8bXO/PnOFvOHgSiDMRQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UDN5TlBHbrtbIlKdQbE5e/wz6lN6UHDlGaDaRJOVv4rNSV1NDseXObPO+A+qIMRW+BjFR68ctw+raSWtv9T31vUYlSCZzFSIRJbOnWdmQ2r2Mp4MJ3ngHTyYHUe94h6HRqGwQLr+UCEPSxf6S1AkKgD8l6WtL87CDlJZyrcK3qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ChLCDOO8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ChLCDOO8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707143794; x=1738679794;
  h=date:from:to:cc:subject:message-id;
  bh=5uJ0h+rxUUZx37lrrVSPGT1K8bXO/PnOFvOHgSiDMRQ=;
  b=ChLCDOO8RHd2+vgrZZgcSno9FgcYLRXu+hKUJaHzodk1BTS5lK+jN2+Z
   skAaVroEdv/2jsFUJ++NRg0hvGNY2vVQNP9aB+PONR4v22IzXJphe3+2b
   iDlF786JfUfSg/JsE/Hg8PuyjkFZQPwVqtU7eICXVy9ze7+gCr2IZFEye
   u4LX9cXf2Vmr1pI6POOgEd6TtjCFroAA3YmGsC4D9oE20sjYCj5qeDStl
   WleOlyeuD90fIM8R+m76w1iMcLcisD4z2jDHQEjVAdFigt39Qmm/V4RCe
   9FX3h6mcHSlZJhoei6sTglFp8fIrhQFq+7q2M1/YaURd6jU3u21XVZrsk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="445244"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="445244"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 06:36:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5340227"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 05 Feb 2024 06:36:30 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rX05E-0000aO-2U;
	Mon, 05 Feb 2024 14:36:28 +0000
Date: Mon, 05 Feb 2024 22:36:03 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 a802f50d6e92298d44a806d326a2ba3eefa6db72
Message-ID: <202402052201.gWT0hGJK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: a802f50d6e92298d44a806d326a2ba3eefa6db72  Merge 6.8-rc3 into tty-next

elapsed time: 1447m

configs tested: 233
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20240205   gcc  
arc                   randconfig-002-20240205   gcc  
arc                           tb10x_defconfig   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   clang
arm                         axm55xx_defconfig   clang
arm                                 defconfig   clang
arm                       imx_v6_v7_defconfig   clang
arm                            mmp2_defconfig   gcc  
arm                          moxart_defconfig   gcc  
arm                       multi_v4t_defconfig   clang
arm                         mv78xx0_defconfig   clang
arm                   randconfig-001-20240205   clang
arm                   randconfig-002-20240205   gcc  
arm                   randconfig-003-20240205   clang
arm                   randconfig-004-20240205   clang
arm                             rpc_defconfig   clang
arm                         s5pv210_defconfig   gcc  
arm                        spear6xx_defconfig   clang
arm                           stm32_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240205   gcc  
arm64                 randconfig-002-20240205   gcc  
arm64                 randconfig-003-20240205   gcc  
arm64                 randconfig-004-20240205   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240205   gcc  
csky                  randconfig-002-20240205   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240205   clang
hexagon               randconfig-002-20240205   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240204   gcc  
i386         buildonly-randconfig-002-20240204   gcc  
i386         buildonly-randconfig-003-20240204   gcc  
i386         buildonly-randconfig-004-20240204   gcc  
i386         buildonly-randconfig-005-20240204   gcc  
i386         buildonly-randconfig-006-20240204   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240204   clang
i386                  randconfig-002-20240204   clang
i386                  randconfig-003-20240204   clang
i386                  randconfig-004-20240204   gcc  
i386                  randconfig-004-20240205   gcc  
i386                  randconfig-005-20240204   clang
i386                  randconfig-006-20240204   gcc  
i386                  randconfig-006-20240205   gcc  
i386                  randconfig-011-20240204   clang
i386                  randconfig-011-20240205   gcc  
i386                  randconfig-012-20240204   gcc  
i386                  randconfig-013-20240204   clang
i386                  randconfig-013-20240205   gcc  
i386                  randconfig-014-20240204   clang
i386                  randconfig-014-20240205   gcc  
i386                  randconfig-015-20240204   clang
i386                  randconfig-016-20240204   gcc  
i386                  randconfig-016-20240205   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240205   gcc  
loongarch             randconfig-002-20240205   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                          rm200_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240205   gcc  
nios2                 randconfig-002-20240205   gcc  
openrisc                         alldefconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240205   gcc  
parisc                randconfig-002-20240205   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc                       holly_defconfig   clang
powerpc                        icon_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                   microwatt_defconfig   gcc  
powerpc                     ppa8548_defconfig   gcc  
powerpc               randconfig-001-20240205   clang
powerpc               randconfig-002-20240205   clang
powerpc               randconfig-003-20240205   gcc  
powerpc                     sequoia_defconfig   clang
powerpc                    socrates_defconfig   gcc  
powerpc64             randconfig-001-20240205   clang
powerpc64             randconfig-002-20240205   clang
powerpc64             randconfig-003-20240205   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240205   clang
riscv                 randconfig-002-20240205   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240205   clang
s390                  randconfig-002-20240205   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240205   gcc  
sh                    randconfig-002-20240205   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240205   gcc  
sparc64               randconfig-002-20240205   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240205   clang
um                    randconfig-002-20240205   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240204   clang
x86_64       buildonly-randconfig-002-20240204   clang
x86_64       buildonly-randconfig-003-20240204   gcc  
x86_64       buildonly-randconfig-003-20240205   gcc  
x86_64       buildonly-randconfig-004-20240204   gcc  
x86_64       buildonly-randconfig-004-20240205   gcc  
x86_64       buildonly-randconfig-005-20240204   clang
x86_64       buildonly-randconfig-005-20240205   gcc  
x86_64       buildonly-randconfig-006-20240204   gcc  
x86_64       buildonly-randconfig-006-20240205   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240204   gcc  
x86_64                randconfig-001-20240205   gcc  
x86_64                randconfig-002-20240204   gcc  
x86_64                randconfig-002-20240205   gcc  
x86_64                randconfig-003-20240204   clang
x86_64                randconfig-004-20240204   clang
x86_64                randconfig-004-20240205   gcc  
x86_64                randconfig-005-20240204   gcc  
x86_64                randconfig-005-20240205   gcc  
x86_64                randconfig-006-20240204   gcc  
x86_64                randconfig-006-20240205   gcc  
x86_64                randconfig-011-20240204   gcc  
x86_64                randconfig-011-20240205   gcc  
x86_64                randconfig-012-20240204   gcc  
x86_64                randconfig-012-20240205   gcc  
x86_64                randconfig-013-20240204   gcc  
x86_64                randconfig-014-20240204   gcc  
x86_64                randconfig-015-20240204   clang
x86_64                randconfig-015-20240205   gcc  
x86_64                randconfig-016-20240204   clang
x86_64                randconfig-071-20240204   gcc  
x86_64                randconfig-072-20240204   gcc  
x86_64                randconfig-072-20240205   gcc  
x86_64                randconfig-073-20240204   gcc  
x86_64                randconfig-074-20240204   clang
x86_64                randconfig-075-20240204   clang
x86_64                randconfig-075-20240205   gcc  
x86_64                randconfig-076-20240204   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20240205   gcc  
xtensa                randconfig-002-20240205   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
