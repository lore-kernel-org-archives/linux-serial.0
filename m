Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B9A2E657
	for <linux-serial@vger.kernel.org>; Sun, 14 Apr 2024 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713092732; cv=none; b=LgStH1bEjh87D4DwlzsWWkMzZVSzyIKooU9mnTlKAlIZc5RNKPocW19T0rdJhfTpNkU6LN5B4HgaOJk1jHX/xNrx4a7f7a9t5oHQE6A3B1PHg9ivNhiBQO3cL5IAVZZzxau4qSKWmV3KfD0mP71M/2dfKJRJYO+8Z5SJDI6OznI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713092732; c=relaxed/simple;
	bh=UHFm85LBJymrYs4h13kHY0H95lsN3JUnKV4IyNq2PCU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Rf8KKTIHpShRn6vRVzI3Dw1fR15J3hl6cWUSsE70w4hOFD6j4cxS0jIQ3JLZlbGiUDOjh+wBdOIU+esAN67obhVrUDOEzD7e3Lc49GspxZRyawAhTOv4KsOX6qwGmFiBqM34RXHnNx0W/ES9nxfpnkn+vok2zLhkYgWl1hSuijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CT7bpJAH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CT7bpJAH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713092729; x=1744628729;
  h=date:from:to:cc:subject:message-id;
  bh=UHFm85LBJymrYs4h13kHY0H95lsN3JUnKV4IyNq2PCU=;
  b=CT7bpJAH8MdEQ6nekf7ysPmmk/TZdyRTb4yYCKMD1Ql6y3+QRIXMFa+F
   0yb9OWUegMh8ZgbVFBoVhDgFKoKBLRwacem40izQo6iOgQZrBHO/0NKJn
   nljR2EdFr9E3FGg1CCOFv26w7pKX+5Ls7F27UKceOmVshGI0UstDN3f1I
   cE6Lkj3iWLaidQwUCPe0zBgl9DHWihPNREYs169aBl7L1YLLlr5W0jOew
   8Iq5fEu38SS9crsGUdeGZb542g1Pdf8orU+rHO6xRldrh5e+/wo06wOwk
   nHvERJgabzxDowASzDEp5Nd5pyYQ+Z8wj3ZHZXgVPhOjARhZAaxHteH9+
   A==;
X-CSE-ConnectionGUID: vcup5q1bRV2tLuCgjruiaA==
X-CSE-MsgGUID: fjIqP5dzQ/eVMXx4LgSlig==
X-IronPort-AV: E=McAfee;i="6600,9927,11043"; a="26006371"
X-IronPort-AV: E=Sophos;i="6.07,201,1708416000"; 
   d="scan'208";a="26006371"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 04:05:28 -0700
X-CSE-ConnectionGUID: 5R02ewjES86QkeoNab/MRw==
X-CSE-MsgGUID: qxT+FTdxRsux8U8//Bfi/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,201,1708416000"; 
   d="scan'208";a="59073864"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 14 Apr 2024 04:05:27 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rvxfo-0003a8-0x;
	Sun, 14 Apr 2024 11:05:24 +0000
Date: Sun, 14 Apr 2024 19:05:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 b20172ca6bf489534892b801a5db41bbf5ceec75
Message-ID: <202404141916.tPBZZNEp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: b20172ca6bf489534892b801a5db41bbf5ceec75  serial: core: Fix ifdef for serial base console functions

elapsed time: 1441m

configs tested: 161
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20240414   gcc  
arc                   randconfig-002-20240414   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-003-20240414   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240414   gcc  
arm64                 randconfig-003-20240414   gcc  
arm64                 randconfig-004-20240414   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240414   gcc  
csky                  randconfig-002-20240414   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240413   gcc  
i386         buildonly-randconfig-001-20240414   gcc  
i386         buildonly-randconfig-002-20240413   gcc  
i386         buildonly-randconfig-003-20240413   clang
i386         buildonly-randconfig-003-20240414   gcc  
i386         buildonly-randconfig-004-20240413   clang
i386         buildonly-randconfig-004-20240414   gcc  
i386         buildonly-randconfig-005-20240413   clang
i386         buildonly-randconfig-005-20240414   gcc  
i386         buildonly-randconfig-006-20240413   clang
i386         buildonly-randconfig-006-20240414   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240413   clang
i386                  randconfig-002-20240413   gcc  
i386                  randconfig-002-20240414   gcc  
i386                  randconfig-003-20240413   clang
i386                  randconfig-003-20240414   gcc  
i386                  randconfig-004-20240413   gcc  
i386                  randconfig-004-20240414   gcc  
i386                  randconfig-005-20240413   clang
i386                  randconfig-005-20240414   gcc  
i386                  randconfig-006-20240413   clang
i386                  randconfig-011-20240413   gcc  
i386                  randconfig-012-20240413   clang
i386                  randconfig-013-20240413   gcc  
i386                  randconfig-013-20240414   gcc  
i386                  randconfig-014-20240413   gcc  
i386                  randconfig-014-20240414   gcc  
i386                  randconfig-015-20240413   clang
i386                  randconfig-016-20240413   gcc  
i386                  randconfig-016-20240414   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240414   gcc  
loongarch             randconfig-002-20240414   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240414   gcc  
nios2                 randconfig-002-20240414   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240414   gcc  
parisc                randconfig-002-20240414   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-003-20240414   gcc  
powerpc                     tqm8560_defconfig   gcc  
powerpc64             randconfig-002-20240414   gcc  
powerpc64             randconfig-003-20240414   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240414   gcc  
sh                    randconfig-002-20240414   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240414   gcc  
sparc64               randconfig-002-20240414   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240414   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240414   clang
x86_64       buildonly-randconfig-002-20240414   clang
x86_64       buildonly-randconfig-003-20240414   clang
x86_64       buildonly-randconfig-004-20240414   clang
x86_64       buildonly-randconfig-006-20240414   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240414   clang
x86_64                randconfig-005-20240414   clang
x86_64                randconfig-006-20240414   clang
x86_64                randconfig-011-20240414   clang
x86_64                randconfig-072-20240414   clang
x86_64                randconfig-073-20240414   clang
x86_64                randconfig-075-20240414   clang
x86_64                randconfig-076-20240414   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240414   gcc  
xtensa                randconfig-002-20240414   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
