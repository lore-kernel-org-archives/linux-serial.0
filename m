Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514D221170D
	for <linux-serial@vger.kernel.org>; Thu,  8 May 2025 05:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746681787; cv=none; b=ld07lhkki5PhTS5kY/3gKJIIb7nLBkECfbbVKiHVOHWqR0IEQk6N/CkXHGsAX42Y8TIZF2K5r1u1oUea3Kc9x1Zai2VprE5fwMlbIaNFstJxR9KJMmRrG+LeWF5gBAzS6FvFYnqapRRp827tHpC6Sv9NKzQaf05BcP1AGgM375Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746681787; c=relaxed/simple;
	bh=+ofAdt+rmspoiXJtIz1+s06Ke7HZh/s9YffoaWiwvxE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=br+Mcu7cQBD034n5wJEPqwqFkfeXziA4hwfnE/k76Rr/va3kJvKCuDNG+3bABG1bLrPvchNw+c5RSbVMBTB3XTkSWQwu5v/yELlm8bZe9m8Xbo5+2BN8ekerl4nSqkAAnbDlwNgTObZKt9Cgb2bz4OskSiNbLuVGmvw9aFpWR/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZAPtVcH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZAPtVcH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746681786; x=1778217786;
  h=date:from:to:cc:subject:message-id;
  bh=+ofAdt+rmspoiXJtIz1+s06Ke7HZh/s9YffoaWiwvxE=;
  b=jZAPtVcHVncGY0iqNodpywZYyywCrWHw9YkSqt93CRTRPJbmXG8fGFEi
   zIFpI9hrWRyAAYUuvd0WY0igGUzbRSFG3QVX0rtaO9KiCN/8H4DxvoXGf
   HVXBMFT0r67TyBu1wPS/p4wX7ckAY9TCELvT4/QSTFGYfnfrYCDZYiYNb
   hoFSGQnhNYcNIIAcrE/K4yY7dj0rtrNeS6NFfWOAyxEQCGileqpYc+uey
   nPZHj8v97uWTG6IQlr2xDRUeY9MWUROHzx1WKfM266ZMIM6LMOiIcoaUA
   lOIgGnn9eq4Grv/xOSOu/do564Ywa6b+yWcRPzLso6kbCq0YgUUZwaGr7
   w==;
X-CSE-ConnectionGUID: CeYwL2zCT5KOAA1Oo5ZYlA==
X-CSE-MsgGUID: N9BCF0OdQ5+4NOZ9GbggbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="36073413"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="36073413"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 22:23:03 -0700
X-CSE-ConnectionGUID: kDYQYy1dTY6A8IlDsgQoJA==
X-CSE-MsgGUID: 4mc8fN/lTPqeKcspwhHt2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="173390913"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 07 May 2025 22:23:01 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCtil-000AKq-1V;
	Thu, 08 May 2025 05:22:59 +0000
Date: Thu, 08 May 2025 13:22:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 5ee558c5d9e9c464bcecb68b3c1d1f9690747a64
Message-ID: <202505081328.4uvlim50-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 5ee558c5d9e9c464bcecb68b3c1d1f9690747a64  vt: add new dynamically generated files to .gitignore

elapsed time: 9408m

configs tested: 182
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250502    gcc-14.2.0
arc                   randconfig-001-20250506    gcc-8.5.0
arc                   randconfig-002-20250502    gcc-12.4.0
arc                   randconfig-002-20250506    gcc-12.4.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                     am200epdkit_defconfig    gcc-14.2.0
arm                         bcm2835_defconfig    clang-21
arm                                 defconfig    clang-21
arm                             mxs_defconfig    clang-21
arm                       netwinder_defconfig    gcc-14.2.0
arm                   randconfig-001-20250502    gcc-8.5.0
arm                   randconfig-001-20250506    clang-21
arm                   randconfig-002-20250502    gcc-7.5.0
arm                   randconfig-002-20250506    clang-21
arm                   randconfig-003-20250502    gcc-7.5.0
arm                   randconfig-003-20250506    clang-17
arm                   randconfig-004-20250502    clang-20
arm                   randconfig-004-20250506    clang-21
arm                         socfpga_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250502    clang-21
arm64                 randconfig-001-20250506    clang-21
arm64                 randconfig-002-20250502    gcc-8.5.0
arm64                 randconfig-002-20250506    gcc-8.5.0
arm64                 randconfig-003-20250502    gcc-8.5.0
arm64                 randconfig-003-20250506    clang-21
arm64                 randconfig-004-20250502    gcc-6.5.0
arm64                 randconfig-004-20250506    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250502    gcc-12.4.0
csky                  randconfig-001-20250506    gcc-14.2.0
csky                  randconfig-002-20250502    gcc-10.5.0
csky                  randconfig-002-20250506    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250502    clang-21
hexagon               randconfig-001-20250506    clang-21
hexagon               randconfig-002-20250502    clang-21
hexagon               randconfig-002-20250506    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250502    clang-20
i386        buildonly-randconfig-001-20250506    clang-20
i386        buildonly-randconfig-002-20250502    clang-20
i386        buildonly-randconfig-002-20250506    clang-20
i386        buildonly-randconfig-003-20250502    clang-20
i386        buildonly-randconfig-003-20250506    clang-20
i386        buildonly-randconfig-004-20250502    clang-20
i386        buildonly-randconfig-004-20250506    gcc-12
i386        buildonly-randconfig-005-20250502    gcc-12
i386        buildonly-randconfig-005-20250506    clang-20
i386        buildonly-randconfig-006-20250502    gcc-12
i386        buildonly-randconfig-006-20250506    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250502    gcc-14.2.0
loongarch             randconfig-001-20250506    gcc-14.2.0
loongarch             randconfig-002-20250502    gcc-14.2.0
loongarch             randconfig-002-20250506    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        omega2p_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250502    gcc-14.2.0
nios2                 randconfig-001-20250506    gcc-8.5.0
nios2                 randconfig-002-20250502    gcc-6.5.0
nios2                 randconfig-002-20250506    gcc-6.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250502    gcc-5.5.0
parisc                randconfig-001-20250506    gcc-11.5.0
parisc                randconfig-002-20250502    gcc-5.5.0
parisc                randconfig-002-20250506    gcc-5.5.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                     mpc5200_defconfig    clang-21
powerpc               randconfig-001-20250502    clang-21
powerpc               randconfig-001-20250506    clang-21
powerpc               randconfig-002-20250502    clang-19
powerpc               randconfig-002-20250506    gcc-8.5.0
powerpc               randconfig-003-20250502    clang-21
powerpc               randconfig-003-20250506    gcc-8.5.0
powerpc64             randconfig-001-20250502    clang-21
powerpc64             randconfig-001-20250506    clang-20
powerpc64             randconfig-002-20250502    clang-17
powerpc64             randconfig-002-20250506    gcc-8.5.0
powerpc64             randconfig-003-20250502    clang-21
powerpc64             randconfig-003-20250506    clang-18
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250502    clang-19
riscv                 randconfig-001-20250506    clang-19
riscv                 randconfig-002-20250502    gcc-14.2.0
riscv                 randconfig-002-20250506    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250502    clang-21
s390                  randconfig-001-20250506    gcc-9.3.0
s390                  randconfig-002-20250502    clang-21
s390                  randconfig-002-20250506    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250502    gcc-14.2.0
sh                    randconfig-001-20250506    gcc-12.4.0
sh                    randconfig-002-20250502    gcc-14.2.0
sh                    randconfig-002-20250506    gcc-12.4.0
sh                           se7724_defconfig    gcc-14.2.0
sh                   secureedge5410_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250502    gcc-10.3.0
sparc                 randconfig-001-20250506    gcc-11.5.0
sparc                 randconfig-002-20250502    gcc-11.5.0
sparc                 randconfig-002-20250506    gcc-6.5.0
sparc64               randconfig-001-20250502    gcc-5.5.0
sparc64               randconfig-001-20250506    gcc-7.5.0
sparc64               randconfig-002-20250502    gcc-5.5.0
sparc64               randconfig-002-20250506    gcc-5.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250502    clang-21
um                    randconfig-001-20250506    clang-17
um                    randconfig-002-20250502    gcc-11
um                    randconfig-002-20250506    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250502    gcc-12
x86_64      buildonly-randconfig-001-20250506    clang-20
x86_64      buildonly-randconfig-002-20250502    clang-20
x86_64      buildonly-randconfig-002-20250506    gcc-12
x86_64      buildonly-randconfig-003-20250502    clang-20
x86_64      buildonly-randconfig-003-20250506    gcc-12
x86_64      buildonly-randconfig-004-20250502    clang-20
x86_64      buildonly-randconfig-004-20250506    clang-20
x86_64      buildonly-randconfig-005-20250502    gcc-12
x86_64      buildonly-randconfig-005-20250506    clang-20
x86_64      buildonly-randconfig-006-20250502    clang-20
x86_64      buildonly-randconfig-006-20250506    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250502    gcc-13.3.0
xtensa                randconfig-001-20250506    gcc-13.3.0
xtensa                randconfig-002-20250502    gcc-11.5.0
xtensa                randconfig-002-20250506    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
