Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF582219E1
	for <linux-serial@vger.kernel.org>; Wed, 28 Feb 2024 04:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709094142; cv=none; b=mNq6NtKfnJLGD21hy7xodzN14m9WJXMvNbPKpnGRSz/yfHxxP2BoPAdJaQFp2nTeTw+45wlSq1B+RUOT7e0DMmLuUtWYZtROFG1aiZYF11KhDKMzlzfLV7+yadTJZICmvQMTfBsYirtej43pR6Ge8fnoG/SKPwx8+U9tJPfkBZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709094142; c=relaxed/simple;
	bh=B4kdS6EK0hRwSNxnayjDz8Z7xH015cxR3v40vzwsDc8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZDjsSPcFnxUUpEQYKxUYTiWeZZRnIPlGHbjb8QGMXqMs59HZIb80z/UeX77YQLO7+W4L+OvmDmE7jQjdKy6osGAiQ/h3tNgFLvEQMCRMxM7BkBmyvkEGkzbKHxYo9fep9M9+G45mEonF8ProS3UUswbsfHMq/XgedPc5eSgEp6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nF9oN57h; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nF9oN57h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709094140; x=1740630140;
  h=date:from:to:cc:subject:message-id;
  bh=B4kdS6EK0hRwSNxnayjDz8Z7xH015cxR3v40vzwsDc8=;
  b=nF9oN57huQPZE18ajsBUTpJMeWsDbbJX7pbgHqYlSkHKQcpizsOrrgQE
   UkpYM+OnCJTHuEXaJgpdJnwFqczrKgxcR+OY8sH6F4fHEcFboT8mBp4v6
   HZLlxP9s57qRL/uNjsWTE0knWaWJ+F+tvzCdV/tWOupZQ7wKvAgHmHl8o
   KTCs0sXQpACFXz+EDYMlRRJfZQ6HupG9LfetR4Y0IVDI+sMzfE37jYU3Z
   VS5KavCpRyFx8AcC4DR7DGG0Kg6mO61FIyOksQYzmFvtdo5xFz8oTRyQT
   +yCWyHmCx2jQt+NjFJxjekimp8CWTQXYySe+wnJcg4t+Bf6/eoO6w/+DO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3640971"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3640971"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 20:22:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="30481541"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 27 Feb 2024 20:22:18 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfBSR-000BnX-1x;
	Wed, 28 Feb 2024 04:22:15 +0000
Date: Wed, 28 Feb 2024 12:21:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 13a44ba0dca8c133a4368323683a270a3874d88c
Message-ID: <202402281235.aItadROZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 13a44ba0dca8c133a4368323683a270a3874d88c  Merge 6.8-rc6 into tty-next

elapsed time: 1363m

configs tested: 213
configs skipped: 3

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
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240227   gcc  
arc                   randconfig-001-20240228   gcc  
arc                   randconfig-002-20240227   gcc  
arc                   randconfig-002-20240228   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20240227   gcc  
arm                   randconfig-002-20240227   gcc  
arm                   randconfig-003-20240227   gcc  
arm                   randconfig-004-20240227   gcc  
arm                   randconfig-004-20240228   gcc  
arm                        shmobile_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240227   gcc  
arm64                 randconfig-002-20240228   gcc  
arm64                 randconfig-003-20240227   gcc  
arm64                 randconfig-003-20240228   gcc  
arm64                 randconfig-004-20240227   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240227   gcc  
csky                  randconfig-001-20240228   gcc  
csky                  randconfig-002-20240227   gcc  
csky                  randconfig-002-20240228   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240227   gcc  
i386         buildonly-randconfig-001-20240228   clang
i386         buildonly-randconfig-002-20240227   gcc  
i386         buildonly-randconfig-002-20240228   clang
i386         buildonly-randconfig-003-20240228   clang
i386         buildonly-randconfig-004-20240227   gcc  
i386         buildonly-randconfig-004-20240228   clang
i386         buildonly-randconfig-005-20240227   gcc  
i386         buildonly-randconfig-006-20240227   gcc  
i386         buildonly-randconfig-006-20240228   clang
i386                                defconfig   clang
i386                  randconfig-001-20240227   gcc  
i386                  randconfig-001-20240228   clang
i386                  randconfig-002-20240227   gcc  
i386                  randconfig-002-20240228   clang
i386                  randconfig-004-20240228   clang
i386                  randconfig-005-20240228   clang
i386                  randconfig-006-20240227   gcc  
i386                  randconfig-011-20240228   clang
i386                  randconfig-012-20240228   clang
i386                  randconfig-016-20240227   gcc  
i386                  randconfig-016-20240228   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240227   gcc  
loongarch             randconfig-001-20240228   gcc  
loongarch             randconfig-002-20240227   gcc  
loongarch             randconfig-002-20240228   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
microblaze                       alldefconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                       lemote2f_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240227   gcc  
nios2                 randconfig-001-20240228   gcc  
nios2                 randconfig-002-20240227   gcc  
nios2                 randconfig-002-20240228   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240227   gcc  
parisc                randconfig-001-20240228   gcc  
parisc                randconfig-002-20240227   gcc  
parisc                randconfig-002-20240228   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc               randconfig-002-20240227   gcc  
powerpc               randconfig-003-20240228   gcc  
powerpc                    socrates_defconfig   gcc  
powerpc                      walnut_defconfig   gcc  
powerpc64             randconfig-002-20240227   gcc  
powerpc64             randconfig-003-20240227   gcc  
powerpc64             randconfig-003-20240228   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240227   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240227   gcc  
s390                  randconfig-002-20240228   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                    randconfig-001-20240227   gcc  
sh                    randconfig-001-20240228   gcc  
sh                    randconfig-002-20240227   gcc  
sh                    randconfig-002-20240228   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240227   gcc  
sparc64               randconfig-001-20240228   gcc  
sparc64               randconfig-002-20240227   gcc  
sparc64               randconfig-002-20240228   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240227   clang
x86_64       buildonly-randconfig-002-20240228   clang
x86_64       buildonly-randconfig-003-20240227   clang
x86_64       buildonly-randconfig-003-20240228   clang
x86_64       buildonly-randconfig-004-20240227   clang
x86_64       buildonly-randconfig-005-20240227   clang
x86_64       buildonly-randconfig-006-20240228   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240227   clang
x86_64                randconfig-001-20240228   clang
x86_64                randconfig-002-20240227   clang
x86_64                randconfig-006-20240228   clang
x86_64                randconfig-011-20240228   clang
x86_64                randconfig-012-20240228   clang
x86_64                randconfig-013-20240227   clang
x86_64                randconfig-013-20240228   clang
x86_64                randconfig-072-20240227   clang
x86_64                randconfig-072-20240228   clang
x86_64                randconfig-074-20240227   clang
x86_64                randconfig-075-20240227   clang
x86_64                randconfig-075-20240228   clang
x86_64                randconfig-076-20240227   clang
x86_64                randconfig-076-20240228   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                randconfig-001-20240227   gcc  
xtensa                randconfig-001-20240228   gcc  
xtensa                randconfig-002-20240227   gcc  
xtensa                randconfig-002-20240228   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
