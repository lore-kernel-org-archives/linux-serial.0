Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KuL/0RqH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DB9CF
	for <linux-serial@vger.kernel.org>; Sat,  9 Dec 2023 04:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702125738; x=1733661738;
  h=date:from:to:cc:subject:message-id;
  bh=Po+SOev7IkD2EIY+uSBdh7OisMigOeMlzLKeSzKaufs=;
  b=KuL/0RqH86BLMOvfv9j+4ZXc/eUsIolbpsmzFVLOm8uIFdQg0goqEbeA
   JZRJy3qvi48wYzmAn4/BVfwm9c1+tj5zmdHB9qDNHBkdkJfedFAWHdPLS
   TlDZeZ51EM63g+HofZOMYRexpn7jj2Tta3odv20z6pFn8rJAVNaUcvUS8
   zaknLvCMoWfaSni07QAasIi5c+nGZqYLQJk/lyK1mXpljsqid75tqKDf+
   NH1vPq9xhfG5Sk1IHY50+4bhqBhIkBmvhjEtrM9D+EvuWkneUpA55r8QZ
   /5eGM9pFmZeCp41SkeC2jYs40j/MGzZE4raCqTrtUQK8v3wRmv7kNKNFJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1579987"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="1579987"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 04:42:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="863195846"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="863195846"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Dec 2023 04:42:17 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBwet-000FMF-0X;
	Sat, 09 Dec 2023 12:42:15 +0000
Date: Sat, 09 Dec 2023 20:41:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 ae5af710f369a4d88792bf1d9da317884156cd87
Message-ID: <202312092013.jazkdagP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: ae5af710f369a4d88792bf1d9da317884156cd87  tty: xtensa/iss: use u8

elapsed time: 1489m

configs tested: 105
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231209   gcc  
arc                   randconfig-002-20231209   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                            dove_defconfig   clang
arm                        keystone_defconfig   gcc  
arm                   milbeaut_m10v_defconfig   clang
arm                         orion5x_defconfig   clang
arm                   randconfig-001-20231209   gcc  
arm                   randconfig-002-20231209   gcc  
arm                   randconfig-003-20231209   gcc  
arm                         s5pv210_defconfig   clang
arm                         socfpga_defconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231208   clang
i386         buildonly-randconfig-002-20231208   clang
i386         buildonly-randconfig-003-20231208   clang
i386         buildonly-randconfig-004-20231208   clang
i386         buildonly-randconfig-005-20231208   clang
i386         buildonly-randconfig-006-20231208   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231208   clang
i386                  randconfig-002-20231208   clang
i386                  randconfig-003-20231208   clang
i386                  randconfig-004-20231208   clang
i386                  randconfig-005-20231208   clang
i386                  randconfig-006-20231208   clang
i386                  randconfig-011-20231208   gcc  
i386                  randconfig-012-20231208   gcc  
i386                  randconfig-013-20231208   gcc  
i386                  randconfig-014-20231208   gcc  
i386                  randconfig-015-20231208   gcc  
i386                  randconfig-016-20231208   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips                  cavium_octeon_defconfig   clang
mips                     decstation_defconfig   gcc  
mips                      malta_kvm_defconfig   clang
mips                        qi_lb60_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
