Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExnWQCp3"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760451990
	for <linux-serial@vger.kernel.org>; Fri, 24 Nov 2023 12:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700859320; x=1732395320;
  h=date:from:to:cc:subject:message-id;
  bh=6leJ681XkwiJceFWGuzEs97PamhioJtfHwz1yjNeI7w=;
  b=ExnWQCp3c1TsCpCtGZeguTndKpXZ/zWa7sMv9Dcx88sgHIMsdSePpHWk
   lCZ7/ZoIk+/RkxAUlDG38zq2Tz/0+wRugyo78JtauYRclqJgY46xJVtDa
   LW1LdYDtdiUWw1sdjlCeH/W8TAdOMjPvo82W3zlwtCkxuTpMvLNg34kX8
   qgE14l1ZM8R2OKkWXBVErckyv4QQqP5pJpgzKoazZBF5eif5rBWGJKCSo
   9z+eHKUlB0FoZOdR0ZwIMb1lJQV34Wdj8dFXVDxULn4EVY3hFZydkBs+W
   q1TrVfpUHSvGG2HMnfOlUCWzvcgONj0di9iVW6I20FhqmXMwXzq7uqZ1E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="382867139"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="382867139"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 12:55:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="9061342"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 24 Nov 2023 12:55:18 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r6dCm-0003H5-1e;
	Fri, 24 Nov 2023 20:55:16 +0000
Date: Sat, 25 Nov 2023 04:54:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 58ac1b3799799069d53f5bf95c093f2fe8dd3cc5
Message-ID: <202311250438.BD33fRWm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 58ac1b3799799069d53f5bf95c093f2fe8dd3cc5  ARM: PL011: Fix DMA support

elapsed time: 1447m

configs tested: 221
configs skipped: 2

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
arc                   randconfig-001-20231124   gcc  
arc                   randconfig-002-20231124   gcc  
arc                           tb10x_defconfig   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   clang
arm                      footbridge_defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                          moxart_defconfig   clang
arm                        mvebu_v7_defconfig   gcc  
arm                   randconfig-001-20231124   clang
arm                   randconfig-002-20231124   clang
arm                   randconfig-003-20231124   clang
arm                   randconfig-004-20231124   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231124   clang
arm64                 randconfig-002-20231124   clang
arm64                 randconfig-003-20231124   clang
arm64                 randconfig-004-20231124   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231124   gcc  
csky                  randconfig-002-20231124   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231124   clang
hexagon               randconfig-002-20231124   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20231124   gcc  
i386                  randconfig-011-20231125   clang
i386                  randconfig-012-20231124   gcc  
i386                  randconfig-012-20231125   clang
i386                  randconfig-013-20231124   gcc  
i386                  randconfig-013-20231125   clang
i386                  randconfig-014-20231124   gcc  
i386                  randconfig-014-20231125   clang
i386                  randconfig-015-20231124   gcc  
i386                  randconfig-015-20231125   clang
i386                  randconfig-016-20231124   gcc  
i386                  randconfig-016-20231125   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231124   gcc  
loongarch             randconfig-002-20231124   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                        omega2p_defconfig   clang
mips                          rb532_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231124   gcc  
nios2                 randconfig-002-20231124   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20231124   gcc  
parisc                randconfig-002-20231124   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        cell_defconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                      ppc40x_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20231124   clang
powerpc               randconfig-002-20231124   clang
powerpc               randconfig-003-20231124   clang
powerpc                  storcenter_defconfig   gcc  
powerpc64             randconfig-001-20231124   clang
powerpc64             randconfig-002-20231124   clang
powerpc64             randconfig-003-20231124   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231124   clang
riscv                 randconfig-002-20231124   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231124   gcc  
s390                  randconfig-002-20231124   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                    randconfig-001-20231124   gcc  
sh                    randconfig-002-20231124   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231124   gcc  
sparc64               randconfig-002-20231124   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231124   clang
um                    randconfig-002-20231124   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231124   clang
x86_64       buildonly-randconfig-002-20231124   clang
x86_64       buildonly-randconfig-003-20231124   clang
x86_64       buildonly-randconfig-004-20231124   clang
x86_64       buildonly-randconfig-005-20231124   clang
x86_64       buildonly-randconfig-006-20231124   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231124   gcc  
x86_64                randconfig-002-20231124   gcc  
x86_64                randconfig-003-20231124   gcc  
x86_64                randconfig-004-20231124   gcc  
x86_64                randconfig-005-20231124   gcc  
x86_64                randconfig-006-20231124   gcc  
x86_64                randconfig-011-20231124   clang
x86_64                randconfig-012-20231124   clang
x86_64                randconfig-013-20231124   clang
x86_64                randconfig-014-20231124   clang
x86_64                randconfig-015-20231124   clang
x86_64                randconfig-016-20231124   clang
x86_64                randconfig-071-20231124   clang
x86_64                randconfig-072-20231124   clang
x86_64                randconfig-073-20231124   clang
x86_64                randconfig-074-20231124   clang
x86_64                randconfig-075-20231124   clang
x86_64                randconfig-076-20231124   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20231124   gcc  
xtensa                randconfig-002-20231124   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
