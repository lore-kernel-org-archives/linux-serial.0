Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60E43FF1
	for <linux-serial@vger.kernel.org>; Sun,  3 Mar 2024 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709451818; cv=none; b=a8WOZhGm5WYaew2AXmqQ5M9Kn3eQlRHBYUdIeO+BpW/wNGK0tnTZnQUHoLKykIkmnpl2Sdvye3Rce6bNjAVTRm/tupVPm9eiyj1zrHjBBtR1DZQoFGMgIzgTElK9Bp3PFGg8KAkwZWX5HYZQJzpHT60JxLlx2vOj2iu2j+tPYAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709451818; c=relaxed/simple;
	bh=mjig1YerKx/jJB92UX2Bp09cXAro0vpX9S+y/HWsx+E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qFE9mMfJBNPEYcq6AeLrxAyPExEBBpGldd1AvSWO4qxjvm8G/zAXcL6cs2/NoXfq8zy3b+8C8K1B/f/l48jTJnpL0VqI5I3qIzbLEKK5X8EAQ7g1LJ2XGEWAyMbVgM4MBSrWhhPWpqMRVf9/tOZP1mOVqC27t9+sDnzcBg+95Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BxnlNyZg; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BxnlNyZg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709451816; x=1740987816;
  h=date:from:to:cc:subject:message-id;
  bh=mjig1YerKx/jJB92UX2Bp09cXAro0vpX9S+y/HWsx+E=;
  b=BxnlNyZgn3mc/HKvEzKmUrYxBZkDnFFSZccSwsIXtUvxgHwTR+GHtN5E
   2O53IlPDerlsHPGGWh3lScDY87zg9zPTITig0COvDjcmv2xzHRLRJXMkK
   mPGjqxNEAvQpODz43rTtKcnxs5BSzm+Sd+5Gl3MQLe0jJx8ia4VhSXwM6
   R1QHof/7gv+RsCbG2xBtvnKtbGSMNgVGeaHGQ7Uubb7FLtqLrbqNWBOVp
   ytR+KOviF3Ca7ymbPufDzyg98hXpObyP6HGZgESNpIfGnKFWSRddxmw/J
   CHQpcnUSFduasvrHgxI+T51RyfpvJsn18ROHloM2cXCL0/s8Yw8WWnrFK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11001"; a="4533102"
X-IronPort-AV: E=Sophos;i="6.06,200,1705392000"; 
   d="scan'208";a="4533102"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2024 23:43:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,200,1705392000"; 
   d="scan'208";a="13349864"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 02 Mar 2024 23:43:34 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rggVP-0001Jl-1W;
	Sun, 03 Mar 2024 07:43:31 +0000
Date: Sun, 03 Mar 2024 15:43:21 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-next] BUILD SUCCESS
 044591a6adef0aab7dde3e46bcbb8f5c55c33a12
Message-ID: <202403031518.7j3nNwyy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
branch HEAD: 044591a6adef0aab7dde3e46bcbb8f5c55c33a12  Merge tag 'w1-drv-6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1 into tty-next

elapsed time: 728m

configs tested: 178
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                   randconfig-001-20240303   gcc  
arc                   randconfig-002-20240303   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          ixp4xx_defconfig   gcc  
arm                        neponset_defconfig   gcc  
arm                   randconfig-001-20240303   gcc  
arm                   randconfig-002-20240303   clang
arm                   randconfig-003-20240303   clang
arm                   randconfig-004-20240303   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240303   clang
arm64                 randconfig-002-20240303   gcc  
arm64                 randconfig-003-20240303   gcc  
arm64                 randconfig-004-20240303   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240303   gcc  
csky                  randconfig-002-20240303   gcc  
hexagon                          alldefconfig   clang
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240303   clang
hexagon               randconfig-002-20240303   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240303   clang
i386         buildonly-randconfig-002-20240303   clang
i386         buildonly-randconfig-003-20240303   gcc  
i386         buildonly-randconfig-004-20240303   clang
i386         buildonly-randconfig-005-20240303   clang
i386         buildonly-randconfig-006-20240303   clang
i386                                defconfig   clang
i386                  randconfig-001-20240303   gcc  
i386                  randconfig-002-20240303   gcc  
i386                  randconfig-003-20240303   gcc  
i386                  randconfig-004-20240303   clang
i386                  randconfig-005-20240303   gcc  
i386                  randconfig-006-20240303   gcc  
i386                  randconfig-011-20240303   clang
i386                  randconfig-012-20240303   gcc  
i386                  randconfig-013-20240303   gcc  
i386                  randconfig-014-20240303   gcc  
i386                  randconfig-015-20240303   gcc  
i386                  randconfig-016-20240303   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240303   gcc  
loongarch             randconfig-002-20240303   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            q40_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   clang
mips                            gpr_defconfig   clang
mips                          rb532_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240303   gcc  
nios2                 randconfig-002-20240303   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240303   gcc  
parisc                randconfig-002-20240303   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc               randconfig-001-20240303   clang
powerpc               randconfig-002-20240303   gcc  
powerpc               randconfig-003-20240303   gcc  
powerpc                      walnut_defconfig   gcc  
powerpc64             randconfig-001-20240303   gcc  
powerpc64             randconfig-002-20240303   clang
powerpc64             randconfig-003-20240303   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240303   gcc  
riscv                 randconfig-002-20240303   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240303   clang
s390                  randconfig-002-20240303   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20240303   gcc  
sh                    randconfig-002-20240303   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240303   gcc  
sparc64               randconfig-002-20240303   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240303   clang
um                    randconfig-002-20240303   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240303   clang
x86_64       buildonly-randconfig-002-20240303   clang
x86_64       buildonly-randconfig-003-20240303   clang
x86_64       buildonly-randconfig-004-20240303   clang
x86_64       buildonly-randconfig-005-20240303   gcc  
x86_64       buildonly-randconfig-006-20240303   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240303   clang
x86_64                randconfig-002-20240303   gcc  
x86_64                randconfig-003-20240303   clang
x86_64                randconfig-004-20240303   clang
x86_64                randconfig-005-20240303   clang
x86_64                randconfig-006-20240303   gcc  
x86_64                randconfig-011-20240303   gcc  
x86_64                randconfig-012-20240303   gcc  
x86_64                randconfig-013-20240303   clang
x86_64                randconfig-014-20240303   gcc  
x86_64                randconfig-015-20240303   clang
x86_64                randconfig-016-20240303   gcc  
x86_64                randconfig-071-20240303   clang
x86_64                randconfig-072-20240303   gcc  
x86_64                randconfig-073-20240303   gcc  
x86_64                randconfig-074-20240303   gcc  
x86_64                randconfig-075-20240303   clang
x86_64                randconfig-076-20240303   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240303   gcc  
xtensa                randconfig-002-20240303   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
