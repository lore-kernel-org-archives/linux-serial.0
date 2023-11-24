Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/oFuBKM"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F3212B
	for <linux-serial@vger.kernel.org>; Fri, 24 Nov 2023 12:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700859318; x=1732395318;
  h=date:from:to:cc:subject:message-id;
  bh=kvkBoL6EJBcdQh0GSjdGYWLXzfLrFgl+xSe0bTvw+Ps=;
  b=m/oFuBKMirTFazMfdWd7z9MP9dcjEA6M2X2gAVPvxI2m/I4Nxw/1YNAs
   m1M29HIKZUM2s0og/QbjitKO2EwbGMLhyNHmTYwtVVmR8CQKRjzQbCTDB
   4dmX7CKj1kBKWvgKEZiVp/cDMBiZ3i2aXitOdpVXFSysj06gb4/BUiXRh
   vHiyBBjyhvR7WKDS2ppiMSj88Tz6tzZznwzv1zP3DmOytaFTTXne+UqqI
   AIf6XUtli5aWKkWaxJU5bXHR7QgN0+WQzr3tHklRFXflG2WF8X0rL2QHN
   FNgdS7RGGxWWqP1RTEy4PazC8fZsy2G7e+J1APrdwWOFlTkMHdLWsIBCx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="382867135"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="382867135"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 12:55:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="9061341"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 24 Nov 2023 12:55:17 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r6dCk-0003Gw-1a;
	Fri, 24 Nov 2023 20:55:14 +0000
Date: Sat, 25 Nov 2023 04:54:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD REGRESSION
 53d40bb0f146410c58d791da5bd66451513e96ec
Message-ID: <202311250412.4NYKOlgM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 53d40bb0f146410c58d791da5bd66451513e96ec  tty: srmcons: use 'buf' directly in srmcons_do_write()

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202311241341.8QD0WOgN-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202311241523.IZ8ifBRi-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/tty/serial/amba-pl011.c:128:12: error: call to undeclared function 'FIELD_PREP_CONST'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
drivers/tty/serial/amba-pl011.c:128:12: error: implicit declaration of function 'FIELD_PREP_CONST' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
drivers/tty/serial/amba-pl011.c:128:12: error: initializer element is not a compile-time constant
include/linux/amba/serial.h:158:33: error: implicit declaration of function 'FIELD_PREP_CONST' [-Werror=implicit-function-declaration]
include/linux/amba/serial.h:158:33: error: initializer element is not constant

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- arm-allmodconfig
    |-- include-linux-amba-serial.h:error:implicit-declaration-of-function-FIELD_PREP_CONST
    `-- include-linux-amba-serial.h:error:initializer-element-is-not-constant
clang_recent_errors
|-- arm-defconfig
|   `-- drivers-tty-serial-amba-pl011.c:error:implicit-declaration-of-function-FIELD_PREP_CONST-is-invalid-in-C99-Werror-Wimplicit-function-declaration
|-- arm-randconfig-001-20231124
|   `-- drivers-tty-serial-amba-pl011.c:error:implicit-declaration-of-function-FIELD_PREP_CONST-is-invalid-in-C99-Werror-Wimplicit-function-declaration
|-- arm-randconfig-003-20231124
|   |-- drivers-tty-serial-amba-pl011.c:error:call-to-undeclared-function-FIELD_PREP_CONST-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- drivers-tty-serial-amba-pl011.c:error:initializer-element-is-not-a-compile-time-constant
`-- arm-randconfig-r131-20231124
    |-- drivers-tty-serial-amba-pl011.c:error:call-to-undeclared-function-FIELD_PREP_CONST-ISO-C99-and-later-do-not-support-implicit-function-declarations
    `-- drivers-tty-serial-amba-pl011.c:error:initializer-element-is-not-a-compile-time-constant

elapsed time: 1446m

configs tested: 162
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231124   gcc  
arc                   randconfig-002-20231124   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                      integrator_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
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
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20231124   gcc  
i386                  randconfig-012-20231124   gcc  
i386                  randconfig-013-20231124   gcc  
i386                  randconfig-014-20231124   gcc  
i386                  randconfig-015-20231124   gcc  
i386                  randconfig-016-20231124   gcc  
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
m68k                        m5272c3_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
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
powerpc                       maple_defconfig   gcc  
powerpc                      ppc40x_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231124   gcc  
s390                  randconfig-002-20231124   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231124   gcc  
sh                    randconfig-002-20231124   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                            shmin_defconfig   gcc  
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
