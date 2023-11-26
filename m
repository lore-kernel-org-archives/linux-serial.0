Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F33Py6Qr"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F4710D
	for <linux-serial@vger.kernel.org>; Sat, 25 Nov 2023 23:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700984247; x=1732520247;
  h=date:from:to:cc:subject:message-id;
  bh=MnQx0jZ7kF0VzqfTCztVfwZ9N52YMEXFoCSuWLQsf6c=;
  b=F33Py6QrvQuGWQ2d5LqYvAzdnXJTVL8vMYPe1jpy0BXr1SePj0O6twst
   LRxC3zt/oFWWPHIfE/DSoNxlo1BzAkg+CEw1NFZ8YOYtHl4S/xM6BAM7e
   Xe1Al/JImaTpGnXxUHLvDySIikPc7ZX2R20OzoOGHdZCT7LT9dBdHhAOI
   Y3OJM9Y3iaDERxmyIIkCg3tzq++fW6nXDHpHeD1ANI57E3wCqdkpCFi/2
   gmWuaklXPWoG9/BU4qjgUVkka6zeXKoIxdSB25dCKeKOLw4I8toAnBBJ1
   3sLlLQTNURK0ECqBNBCQk7YN0Xd6s2bpjpEOAt22wVgXMpxzixdd05uTH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="392316314"
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="392316314"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2023 23:37:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="744244765"
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="744244765"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Nov 2023 23:37:23 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r79hg-0004xE-1z;
	Sun, 26 Nov 2023 07:37:20 +0000
Date: Sun, 26 Nov 2023 15:36:50 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 ab58841ab9fca536e5579312d7b46cbc4822e29c
Message-ID: <202311261547.IzxK24rM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: ab58841ab9fca536e5579312d7b46cbc4822e29c  tty: srmcons: use 'buf' directly in srmcons_do_write()

elapsed time: 1446m

configs tested: 288
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
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20231125   gcc  
arc                   randconfig-001-20231126   gcc  
arc                   randconfig-002-20231125   gcc  
arc                   randconfig-002-20231126   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                      integrator_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                        neponset_defconfig   clang
arm                          pxa3xx_defconfig   gcc  
arm                   randconfig-001-20231125   gcc  
arm                   randconfig-001-20231126   clang
arm                   randconfig-002-20231125   gcc  
arm                   randconfig-002-20231126   clang
arm                   randconfig-003-20231125   gcc  
arm                   randconfig-003-20231126   clang
arm                   randconfig-004-20231125   gcc  
arm                   randconfig-004-20231126   clang
arm                             rpc_defconfig   gcc  
arm                        spear3xx_defconfig   clang
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231125   gcc  
arm64                 randconfig-001-20231126   clang
arm64                 randconfig-002-20231125   gcc  
arm64                 randconfig-002-20231126   clang
arm64                 randconfig-003-20231125   gcc  
arm64                 randconfig-003-20231126   clang
arm64                 randconfig-004-20231125   gcc  
arm64                 randconfig-004-20231126   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231125   gcc  
csky                  randconfig-001-20231126   gcc  
csky                  randconfig-002-20231125   gcc  
csky                  randconfig-002-20231126   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231125   clang
hexagon               randconfig-001-20231126   clang
hexagon               randconfig-002-20231125   clang
hexagon               randconfig-002-20231126   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231125   gcc  
i386         buildonly-randconfig-002-20231125   gcc  
i386         buildonly-randconfig-003-20231125   gcc  
i386         buildonly-randconfig-004-20231125   gcc  
i386         buildonly-randconfig-005-20231125   gcc  
i386         buildonly-randconfig-006-20231125   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231125   gcc  
i386                  randconfig-002-20231125   gcc  
i386                  randconfig-003-20231125   gcc  
i386                  randconfig-004-20231125   gcc  
i386                  randconfig-005-20231125   gcc  
i386                  randconfig-006-20231125   gcc  
i386                  randconfig-011-20231125   clang
i386                  randconfig-011-20231126   gcc  
i386                  randconfig-012-20231125   clang
i386                  randconfig-012-20231126   gcc  
i386                  randconfig-013-20231125   clang
i386                  randconfig-013-20231126   gcc  
i386                  randconfig-014-20231125   clang
i386                  randconfig-014-20231126   gcc  
i386                  randconfig-015-20231125   clang
i386                  randconfig-015-20231126   gcc  
i386                  randconfig-016-20231125   clang
i386                  randconfig-016-20231126   gcc  
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231125   gcc  
loongarch             randconfig-001-20231126   gcc  
loongarch             randconfig-002-20231125   gcc  
loongarch             randconfig-002-20231126   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                     cu1830-neo_defconfig   clang
mips                      fuloong2e_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                      pic32mzda_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231125   gcc  
nios2                 randconfig-001-20231126   gcc  
nios2                 randconfig-002-20231125   gcc  
nios2                 randconfig-002-20231126   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231125   gcc  
parisc                randconfig-001-20231126   gcc  
parisc                randconfig-002-20231125   gcc  
parisc                randconfig-002-20231126   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   bluestone_defconfig   clang
powerpc                       eiger_defconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                   microwatt_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc               randconfig-001-20231125   gcc  
powerpc               randconfig-001-20231126   clang
powerpc               randconfig-002-20231125   gcc  
powerpc               randconfig-002-20231126   clang
powerpc               randconfig-003-20231125   gcc  
powerpc               randconfig-003-20231126   clang
powerpc                  storcenter_defconfig   gcc  
powerpc                     taishan_defconfig   gcc  
powerpc                     tqm8548_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc64                        alldefconfig   gcc  
powerpc64             randconfig-001-20231125   gcc  
powerpc64             randconfig-001-20231126   clang
powerpc64             randconfig-002-20231125   gcc  
powerpc64             randconfig-002-20231126   clang
powerpc64             randconfig-003-20231125   gcc  
powerpc64             randconfig-003-20231126   clang
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231125   gcc  
riscv                 randconfig-001-20231126   clang
riscv                 randconfig-002-20231125   gcc  
riscv                 randconfig-002-20231126   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231125   clang
s390                  randconfig-001-20231126   gcc  
s390                  randconfig-002-20231125   clang
s390                  randconfig-002-20231126   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                    randconfig-001-20231125   gcc  
sh                    randconfig-001-20231126   gcc  
sh                    randconfig-002-20231125   gcc  
sh                    randconfig-002-20231126   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231125   gcc  
sparc64               randconfig-001-20231126   gcc  
sparc64               randconfig-002-20231125   gcc  
sparc64               randconfig-002-20231126   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231125   gcc  
um                    randconfig-001-20231126   clang
um                    randconfig-002-20231125   gcc  
um                    randconfig-002-20231126   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231125   gcc  
x86_64       buildonly-randconfig-001-20231126   clang
x86_64       buildonly-randconfig-002-20231125   gcc  
x86_64       buildonly-randconfig-002-20231126   clang
x86_64       buildonly-randconfig-003-20231125   gcc  
x86_64       buildonly-randconfig-003-20231126   clang
x86_64       buildonly-randconfig-004-20231125   gcc  
x86_64       buildonly-randconfig-004-20231126   clang
x86_64       buildonly-randconfig-005-20231125   gcc  
x86_64       buildonly-randconfig-005-20231126   clang
x86_64       buildonly-randconfig-006-20231125   gcc  
x86_64       buildonly-randconfig-006-20231126   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231125   clang
x86_64                randconfig-002-20231125   clang
x86_64                randconfig-003-20231125   clang
x86_64                randconfig-004-20231125   clang
x86_64                randconfig-005-20231125   clang
x86_64                randconfig-006-20231125   clang
x86_64                randconfig-011-20231125   gcc  
x86_64                randconfig-011-20231126   clang
x86_64                randconfig-012-20231125   gcc  
x86_64                randconfig-012-20231126   clang
x86_64                randconfig-013-20231125   gcc  
x86_64                randconfig-013-20231126   clang
x86_64                randconfig-014-20231125   gcc  
x86_64                randconfig-014-20231126   clang
x86_64                randconfig-015-20231125   gcc  
x86_64                randconfig-015-20231126   clang
x86_64                randconfig-016-20231125   gcc  
x86_64                randconfig-016-20231126   clang
x86_64                randconfig-071-20231125   gcc  
x86_64                randconfig-071-20231126   clang
x86_64                randconfig-072-20231125   gcc  
x86_64                randconfig-072-20231126   clang
x86_64                randconfig-073-20231125   gcc  
x86_64                randconfig-073-20231126   clang
x86_64                randconfig-074-20231125   gcc  
x86_64                randconfig-074-20231126   clang
x86_64                randconfig-075-20231125   gcc  
x86_64                randconfig-075-20231126   clang
x86_64                randconfig-076-20231125   gcc  
x86_64                randconfig-076-20231126   clang
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20231125   gcc  
xtensa                randconfig-001-20231126   gcc  
xtensa                randconfig-002-20231125   gcc  
xtensa                randconfig-002-20231126   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
