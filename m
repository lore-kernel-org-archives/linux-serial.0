Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7582F4A
	for <linux-serial@vger.kernel.org>; Mon, 30 Jun 2025 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751307498; cv=none; b=JlZ+m1Q6ztYwUEGASs1r4Rn6OCaLUNy+pRUBX3aniwXLWAg9YaCdGWw2iClA33C9ws3Us6PfGWJ98eHGSGVgbgbU3gc7oJJVtOVUgcy78K2RqNXbJXTHqSgDCIOUPcz9Ww0o9BSIrZLiaX+/KEOB/zlSHL1ceBfpqgbwLD/2YlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751307498; c=relaxed/simple;
	bh=UTNTTLWc7Utez/JXmpnQLn4zhuQHq2l//RN4LEX4KmY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ESX0rWGMN7dHToxPCQhvRdXiPbfOv9KBuPQ6kY8SyheJQRPAX1BQ/9zbOAWwQfwsBsypFHeWCMqVji2TGfbfDnPhl/aW5HDVWmllImsE3QbqmzD2FnSxx7MX/efoPv5xCu3SNZl5CcKHu9yKesFXN8pGA1Tm9omDhwbo5NoLZVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kU8ZUQxg; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kU8ZUQxg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751307497; x=1782843497;
  h=date:from:to:cc:subject:message-id;
  bh=UTNTTLWc7Utez/JXmpnQLn4zhuQHq2l//RN4LEX4KmY=;
  b=kU8ZUQxgIKQo8jy3ODROdQdHVSAeKqJbiDT/GpnGmlcTn+sPhV2YhVem
   PAORx6YV59weDyGm7OgzZMmXWvCf6s5Qcy66gURqCNcl/1IazLoBNpEKo
   rSGPjSDEbthVPedVw34AZO3rd044FoZ+W5+0mFZ41qLRN0p/uueauHupM
   xKXFC7annoJub2hBgY/ml2lpXHrIQdS69uHbKxWXOcSA1Oa8TgDxbnaw0
   YCc2lyPdy4LVWEo5rSeLmSgnl74hkJ7NEnV2sg3PJXBcm1aUUZk8x+wMC
   /yhpcT8ff+jPpU/mS/Ba1w88PRijG0LkyeDDA/z1cxGz3dxV8FrSWfES7
   w==;
X-CSE-ConnectionGUID: PQrY/GAXRtWxxMTLZ4tY6A==
X-CSE-MsgGUID: 26CUmEEqRpSSPElIwDeGOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="64145561"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="64145561"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 11:18:16 -0700
X-CSE-ConnectionGUID: 4qFp5nqQQaGLcbs5EaPZQQ==
X-CSE-MsgGUID: SXsSiPAnShCyEuFN69R4RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="154243139"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 Jun 2025 11:18:14 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWJ52-000ZGC-29;
	Mon, 30 Jun 2025 18:18:12 +0000
Date: Tue, 01 Jul 2025 02:17:22 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 815ac67919148f9d65537af550fd26e2cbbd47bb
Message-ID: <202507010212.r4yY6agJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 815ac67919148f9d65537af550fd26e2cbbd47bb  Merge 6.16-rc4 into tty-next

elapsed time: 726m

configs tested: 171
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250630    gcc-10.5.0
arc                   randconfig-002-20250630    gcc-12.4.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                        clps711x_defconfig    clang-21
arm                                 defconfig    clang-21
arm                          gemini_defconfig    clang-20
arm                   randconfig-001-20250630    clang-21
arm                   randconfig-002-20250630    gcc-12.4.0
arm                   randconfig-003-20250630    gcc-14.3.0
arm                   randconfig-004-20250630    clang-21
arm                        realview_defconfig    clang-16
arm                           sama5_defconfig    gcc-15.1.0
arm                           u8500_defconfig    gcc-15.1.0
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250630    gcc-9.5.0
arm64                 randconfig-002-20250630    gcc-14.3.0
arm64                 randconfig-003-20250630    clang-21
arm64                 randconfig-004-20250630    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250630    gcc-15.1.0
csky                  randconfig-002-20250630    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250630    clang-16
hexagon               randconfig-002-20250630    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250630    clang-20
i386        buildonly-randconfig-002-20250630    gcc-12
i386        buildonly-randconfig-003-20250630    clang-20
i386        buildonly-randconfig-004-20250630    gcc-12
i386        buildonly-randconfig-005-20250630    gcc-12
i386        buildonly-randconfig-006-20250630    clang-20
i386                                defconfig    clang-20
i386                  randconfig-011-20250701    clang-20
i386                  randconfig-012-20250701    clang-20
i386                  randconfig-013-20250701    clang-20
i386                  randconfig-014-20250701    clang-20
i386                  randconfig-015-20250701    clang-20
i386                  randconfig-016-20250701    clang-20
i386                  randconfig-017-20250701    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250630    gcc-15.1.0
loongarch             randconfig-002-20250630    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm47xx_defconfig    clang-18
mips                       bmips_be_defconfig    gcc-15.1.0
mips                           ip32_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250630    gcc-14.2.0
nios2                 randconfig-002-20250630    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250630    gcc-8.5.0
parisc                randconfig-002-20250630    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                        cell_defconfig    gcc-15.1.0
powerpc                      chrp32_defconfig    clang-19
powerpc                     mpc512x_defconfig    clang-21
powerpc                 mpc832x_rdb_defconfig    gcc-15.1.0
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250630    clang-18
powerpc               randconfig-002-20250630    clang-21
powerpc               randconfig-003-20250630    gcc-13.3.0
powerpc                     tqm8540_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250630    gcc-10.5.0
powerpc64             randconfig-002-20250630    gcc-14.3.0
powerpc64             randconfig-003-20250630    gcc-10.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                    nommu_virt_defconfig    clang-21
riscv                 randconfig-001-20250630    gcc-8.5.0
riscv                 randconfig-002-20250630    clang-16
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250630    gcc-8.5.0
s390                  randconfig-002-20250630    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                             espt_defconfig    gcc-15.1.0
sh                            hp6xx_defconfig    gcc-15.1.0
sh                     magicpanelr2_defconfig    gcc-15.1.0
sh                    randconfig-001-20250630    gcc-15.1.0
sh                    randconfig-002-20250630    gcc-15.1.0
sh                           se7619_defconfig    gcc-15.1.0
sh                           se7750_defconfig    gcc-15.1.0
sh                           se7780_defconfig    gcc-15.1.0
sh                     sh7710voipgw_defconfig    gcc-15.1.0
sh                            titan_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250630    gcc-8.5.0
sparc                 randconfig-002-20250630    gcc-8.5.0
sparc                       sparc64_defconfig    gcc-15.1.0
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250630    gcc-8.5.0
sparc64               randconfig-002-20250630    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250630    clang-21
um                    randconfig-002-20250630    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250630    gcc-12
x86_64      buildonly-randconfig-002-20250630    clang-20
x86_64      buildonly-randconfig-003-20250630    clang-20
x86_64      buildonly-randconfig-004-20250630    clang-20
x86_64      buildonly-randconfig-005-20250630    gcc-12
x86_64      buildonly-randconfig-006-20250630    gcc-12
x86_64                              defconfig    gcc-11
x86_64                randconfig-071-20250701    gcc-12
x86_64                randconfig-072-20250701    gcc-12
x86_64                randconfig-073-20250701    gcc-12
x86_64                randconfig-074-20250701    gcc-12
x86_64                randconfig-075-20250701    gcc-12
x86_64                randconfig-076-20250701    gcc-12
x86_64                randconfig-077-20250701    gcc-12
x86_64                randconfig-078-20250701    gcc-12
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                       common_defconfig    gcc-15.1.0
xtensa                  nommu_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250630    gcc-13.3.0
xtensa                randconfig-002-20250630    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
