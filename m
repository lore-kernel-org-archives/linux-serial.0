Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OY2EMj/g"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D831725
	for <linux-serial@vger.kernel.org>; Fri,  8 Dec 2023 00:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702022861; x=1733558861;
  h=date:from:to:cc:subject:message-id;
  bh=wS5XSrLKISjIlJZOfrXrGYUSBE7D5jjr0WKAUKUWV5Q=;
  b=OY2EMj/gow6R6s1syH20Z/e0Gm6ueOcWC3ETFeATVBebSz74vwxq1IB7
   lPt11ysQVK0ksYqqwkg8OiOBiEoEfpXiueHhJVYWpxGZIBt/4MlXUBR4j
   sxAveaMtJSmndlJBy3nFjjMuZuq/TkTJ3tIFqPiN1JtlecGnm0RwPLkZL
   Ac9GBilP5iKxEVl+HCX8zG+gtmK13yS4Z8bWUNEhZKIqosocg1YLtmAzI
   yolvafrRxCzw6DdU2J82XhaSA5WqtaRrLKYz6pkfBLZdBdpp3ALUuQH8f
   uxDvRDWXfBstmn1IfhTCxyPsaP0HP+elMXUtl3sKSOSl/CuviLI3pCHrh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1253719"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="1253719"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 00:07:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="775720538"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="775720538"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 08 Dec 2023 00:07:40 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBVta-000DTD-1A;
	Fri, 08 Dec 2023 08:07:38 +0000
Date: Fri, 08 Dec 2023 16:07:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 ff16c54aa85101955638d09434169897474e073c
Message-ID: <202312081632.jYJudfZp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: ff16c54aa85101955638d09434169897474e073c  serial: msm: Use OPP table for DVFS support

elapsed time: 1475m

configs tested: 214
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231207   gcc  
arc                   randconfig-001-20231208   gcc  
arc                   randconfig-002-20231207   gcc  
arc                   randconfig-002-20231208   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                               allnoconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                   randconfig-001-20231207   gcc  
arm                   randconfig-002-20231207   gcc  
arm                   randconfig-003-20231207   gcc  
arm                   randconfig-004-20231207   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231207   gcc  
arm64                 randconfig-002-20231207   gcc  
arm64                 randconfig-003-20231207   gcc  
arm64                 randconfig-004-20231207   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231207   gcc  
csky                  randconfig-001-20231208   gcc  
csky                  randconfig-002-20231207   gcc  
csky                  randconfig-002-20231208   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
i386                  randconfig-011-20231207   clang
i386                  randconfig-011-20231208   gcc  
i386                  randconfig-012-20231207   clang
i386                  randconfig-012-20231208   gcc  
i386                  randconfig-013-20231207   clang
i386                  randconfig-013-20231208   gcc  
i386                  randconfig-014-20231207   clang
i386                  randconfig-014-20231208   gcc  
i386                  randconfig-015-20231207   clang
i386                  randconfig-015-20231208   gcc  
i386                  randconfig-016-20231207   clang
i386                  randconfig-016-20231208   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20231207   gcc  
loongarch             randconfig-001-20231208   gcc  
loongarch             randconfig-002-20231207   gcc  
loongarch             randconfig-002-20231208   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                         rt305x_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231207   gcc  
nios2                 randconfig-001-20231208   gcc  
nios2                 randconfig-002-20231207   gcc  
nios2                 randconfig-002-20231208   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231207   gcc  
parisc                randconfig-001-20231208   gcc  
parisc                randconfig-002-20231207   gcc  
parisc                randconfig-002-20231208   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ep88xc_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc               randconfig-001-20231207   gcc  
powerpc               randconfig-002-20231207   gcc  
powerpc               randconfig-003-20231207   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc64             randconfig-001-20231207   gcc  
powerpc64             randconfig-002-20231207   gcc  
powerpc64             randconfig-003-20231207   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20231207   gcc  
riscv                 randconfig-002-20231207   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231208   gcc  
s390                  randconfig-002-20231208   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20231207   gcc  
sh                    randconfig-001-20231208   gcc  
sh                    randconfig-002-20231207   gcc  
sh                    randconfig-002-20231208   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231207   gcc  
sparc64               randconfig-001-20231208   gcc  
sparc64               randconfig-002-20231207   gcc  
sparc64               randconfig-002-20231208   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231207   gcc  
um                    randconfig-002-20231207   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231207   gcc  
x86_64       buildonly-randconfig-001-20231208   clang
x86_64       buildonly-randconfig-002-20231207   gcc  
x86_64       buildonly-randconfig-002-20231208   clang
x86_64       buildonly-randconfig-003-20231207   gcc  
x86_64       buildonly-randconfig-003-20231208   clang
x86_64       buildonly-randconfig-004-20231207   gcc  
x86_64       buildonly-randconfig-004-20231208   clang
x86_64       buildonly-randconfig-005-20231207   gcc  
x86_64       buildonly-randconfig-005-20231208   clang
x86_64       buildonly-randconfig-006-20231207   gcc  
x86_64       buildonly-randconfig-006-20231208   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231207   gcc  
x86_64                randconfig-011-20231208   clang
x86_64                randconfig-012-20231207   gcc  
x86_64                randconfig-012-20231208   clang
x86_64                randconfig-013-20231207   gcc  
x86_64                randconfig-013-20231208   clang
x86_64                randconfig-014-20231207   gcc  
x86_64                randconfig-014-20231208   clang
x86_64                randconfig-015-20231207   gcc  
x86_64                randconfig-015-20231208   clang
x86_64                randconfig-016-20231207   gcc  
x86_64                randconfig-016-20231208   clang
x86_64                randconfig-071-20231207   gcc  
x86_64                randconfig-071-20231208   clang
x86_64                randconfig-072-20231207   gcc  
x86_64                randconfig-072-20231208   clang
x86_64                randconfig-073-20231207   gcc  
x86_64                randconfig-073-20231208   clang
x86_64                randconfig-074-20231207   gcc  
x86_64                randconfig-074-20231208   clang
x86_64                randconfig-075-20231207   gcc  
x86_64                randconfig-075-20231208   clang
x86_64                randconfig-076-20231207   gcc  
x86_64                randconfig-076-20231208   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20231207   gcc  
xtensa                randconfig-001-20231208   gcc  
xtensa                randconfig-002-20231207   gcc  
xtensa                randconfig-002-20231208   gcc  
xtensa                         virt_defconfig   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
