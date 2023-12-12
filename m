Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dh8z2z5P"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BE0CD
	for <linux-serial@vger.kernel.org>; Tue, 12 Dec 2023 00:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702370880; x=1733906880;
  h=date:from:to:cc:subject:message-id;
  bh=W+asvE/SdMz5IE+Y0Kg+3OEBjkMa7p57CzxW4gtzz8o=;
  b=Dh8z2z5PbW/kDEoh/oNH3M8Ok5OCTn0jWl7Du1cWFAe863+MFwpKmKxY
   lVNvh3/u7iDPGW981f14ZPro8zY1ubkaoGkhbvb98P3OrjUP/+PIHAKmz
   457iaUDPMjbAtr4nXC5ltBE0MY8twahsOcclrhtmsDye2NO3tkciNuxQV
   cv8b/9sTxoKBp6+sv8aWHvI/QmhZN+9uPl9zinw3QemUlJBLfpRq2rjEH
   7CR6B74u7MhEbiUadFW99P/jHfU5pgBcPpAx3vQA/NqKsZhI/NFIfQqqD
   kAQFLUNvlGQYX0XJp3j2r4xR8TRo4RfGWAwHG94o9pA8zjWA0xjPvmBii
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="461248864"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="461248864"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 00:47:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="749632317"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="749632317"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Dec 2023 00:47:58 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rCyQh-000Iwp-0f;
	Tue, 12 Dec 2023 08:47:51 +0000
Date: Tue, 12 Dec 2023 16:47:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 e045e18dbf3eaac32cdeb2799a5ec84fa694636c
Message-ID: <202312121613.zls4KlNE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: e045e18dbf3eaac32cdeb2799a5ec84fa694636c  Merge 6.7-rc5 into tty-next

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-052-20231212
|   `-- drivers-iio-chemical-pms7003.c:WARNING-opportunity-for-min()
`-- i386-randconfig-053-20231212
    `-- drivers-iio-chemical-pms7003.c:WARNING-opportunity-for-min()

elapsed time: 1473m

configs tested: 244
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
arc                         haps_hs_defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20231211   gcc  
arc                   randconfig-001-20231212   gcc  
arc                   randconfig-002-20231211   gcc  
arc                   randconfig-002-20231212   gcc  
arc                           tb10x_defconfig   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                      jornada720_defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                   randconfig-001-20231212   gcc  
arm                   randconfig-002-20231212   gcc  
arm                   randconfig-003-20231212   gcc  
arm                   randconfig-004-20231212   gcc  
arm                        realview_defconfig   gcc  
arm                             rpc_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231212   gcc  
arm64                 randconfig-002-20231212   gcc  
arm64                 randconfig-003-20231212   gcc  
arm64                 randconfig-004-20231212   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231211   gcc  
csky                  randconfig-001-20231212   gcc  
csky                  randconfig-002-20231211   gcc  
csky                  randconfig-002-20231212   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231212   clang
hexagon               randconfig-002-20231212   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231211   clang
i386         buildonly-randconfig-002-20231211   clang
i386         buildonly-randconfig-003-20231211   clang
i386         buildonly-randconfig-004-20231211   clang
i386         buildonly-randconfig-005-20231211   clang
i386         buildonly-randconfig-006-20231211   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231211   clang
i386                  randconfig-002-20231211   clang
i386                  randconfig-003-20231211   clang
i386                  randconfig-004-20231211   clang
i386                  randconfig-005-20231211   clang
i386                  randconfig-006-20231211   clang
i386                  randconfig-011-20231211   gcc  
i386                  randconfig-011-20231212   clang
i386                  randconfig-012-20231211   gcc  
i386                  randconfig-012-20231212   clang
i386                  randconfig-013-20231211   gcc  
i386                  randconfig-013-20231212   clang
i386                  randconfig-014-20231211   gcc  
i386                  randconfig-014-20231212   clang
i386                  randconfig-015-20231211   gcc  
i386                  randconfig-015-20231212   clang
i386                  randconfig-016-20231211   gcc  
i386                  randconfig-016-20231212   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231211   gcc  
loongarch             randconfig-001-20231212   gcc  
loongarch             randconfig-002-20231211   gcc  
loongarch             randconfig-002-20231212   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                           rs90_defconfig   clang
mips                         rt305x_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231211   gcc  
nios2                 randconfig-001-20231212   gcc  
nios2                 randconfig-002-20231211   gcc  
nios2                 randconfig-002-20231212   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231211   gcc  
parisc                randconfig-001-20231212   gcc  
parisc                randconfig-002-20231211   gcc  
parisc                randconfig-002-20231212   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc                        icon_defconfig   clang
powerpc                 linkstation_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20231212   gcc  
powerpc               randconfig-002-20231212   gcc  
powerpc               randconfig-003-20231212   gcc  
powerpc                     tqm8541_defconfig   gcc  
powerpc64             randconfig-001-20231212   gcc  
powerpc64             randconfig-002-20231212   gcc  
powerpc64             randconfig-003-20231212   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                 randconfig-001-20231212   gcc  
riscv                 randconfig-002-20231212   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231211   gcc  
s390                  randconfig-001-20231212   clang
s390                  randconfig-002-20231211   gcc  
s390                  randconfig-002-20231212   clang
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                    randconfig-001-20231211   gcc  
sh                    randconfig-001-20231212   gcc  
sh                    randconfig-002-20231211   gcc  
sh                    randconfig-002-20231212   gcc  
sh                           se7722_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231211   gcc  
sparc64               randconfig-001-20231212   gcc  
sparc64               randconfig-002-20231211   gcc  
sparc64               randconfig-002-20231212   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231212   gcc  
um                    randconfig-002-20231212   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231211   clang
x86_64       buildonly-randconfig-001-20231212   gcc  
x86_64       buildonly-randconfig-002-20231211   clang
x86_64       buildonly-randconfig-002-20231212   gcc  
x86_64       buildonly-randconfig-003-20231211   clang
x86_64       buildonly-randconfig-003-20231212   gcc  
x86_64       buildonly-randconfig-004-20231211   clang
x86_64       buildonly-randconfig-004-20231212   gcc  
x86_64       buildonly-randconfig-005-20231211   clang
x86_64       buildonly-randconfig-005-20231212   gcc  
x86_64       buildonly-randconfig-006-20231211   clang
x86_64       buildonly-randconfig-006-20231212   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231212   clang
x86_64                randconfig-002-20231212   clang
x86_64                randconfig-011-20231211   clang
x86_64                randconfig-011-20231212   gcc  
x86_64                randconfig-012-20231211   clang
x86_64                randconfig-012-20231212   gcc  
x86_64                randconfig-013-20231211   clang
x86_64                randconfig-013-20231212   gcc  
x86_64                randconfig-014-20231211   clang
x86_64                randconfig-014-20231212   gcc  
x86_64                randconfig-015-20231211   clang
x86_64                randconfig-015-20231212   gcc  
x86_64                randconfig-016-20231211   clang
x86_64                randconfig-016-20231212   gcc  
x86_64                randconfig-071-20231211   clang
x86_64                randconfig-071-20231212   gcc  
x86_64                randconfig-072-20231211   clang
x86_64                randconfig-072-20231212   gcc  
x86_64                randconfig-073-20231211   clang
x86_64                randconfig-073-20231212   gcc  
x86_64                randconfig-074-20231211   clang
x86_64                randconfig-074-20231212   gcc  
x86_64                randconfig-075-20231211   clang
x86_64                randconfig-075-20231212   gcc  
x86_64                randconfig-076-20231211   clang
x86_64                randconfig-076-20231212   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20231211   gcc  
xtensa                randconfig-001-20231212   gcc  
xtensa                randconfig-002-20231211   gcc  
xtensa                randconfig-002-20231212   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
