Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwpiN2QR"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62C01B4
	for <linux-serial@vger.kernel.org>; Fri,  1 Dec 2023 04:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701432128; x=1732968128;
  h=date:from:to:cc:subject:message-id;
  bh=XLwXhu8AITzB6QU4z9H0pM43r9QgCEpKZfNqtOkvWyM=;
  b=iwpiN2QRbLF6dtAqh6650uDjLG01HFjn83+7WbF5vZILw7gDt1aTSSl5
   7fgg9BN72DdfrK7P8/heltQS/eQTY/2OsHk2rLRF8CIfOurD9SaOXb8YQ
   oZul8ZDeMgNOZlis7Yxe+dtxzVSWXwMENvPuLeoLxv8bzSFTAzG29qsOu
   AjNddTbnOvXyA9i8traBqmpfv6hClzwkRD81vfJb+iq+ZZ/QdIX63Imz7
   Ot868rw0R/U/b4IFt7ejj1yIJLaZYzvFO3jBRRaZBjNGy4qrecasdbTmB
   hMSC5fn0lJc972h7k0YDL9PUKuafXrl8lZhaLhht1LawOLe0sdsG97geX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="383881970"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="383881970"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 04:02:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="893205989"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="893205989"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 01 Dec 2023 04:02:06 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r92Dc-0003c9-2D;
	Fri, 01 Dec 2023 12:02:04 +0000
Date: Fri, 01 Dec 2023 20:01:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-next] BUILD SUCCESS
 d804987153e7bedf503f8e4ba649afe52cfd7f6d
Message-ID: <202312012040.Vd6aBXUm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
branch HEAD: d804987153e7bedf503f8e4ba649afe52cfd7f6d  serial: 8250_dw: Decouple DLF register check from UCV

elapsed time: 1453m

configs tested: 194
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
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20231201   gcc  
arc                   randconfig-002-20231201   gcc  
arc                           tb10x_defconfig   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20231201   gcc  
arm                   randconfig-002-20231201   gcc  
arm                   randconfig-003-20231201   gcc  
arm                   randconfig-004-20231201   gcc  
arm                        spear6xx_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231201   gcc  
arm64                 randconfig-002-20231201   gcc  
arm64                 randconfig-003-20231201   gcc  
arm64                 randconfig-004-20231201   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231201   gcc  
csky                  randconfig-002-20231201   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231201   gcc  
i386         buildonly-randconfig-002-20231201   gcc  
i386         buildonly-randconfig-003-20231201   gcc  
i386         buildonly-randconfig-004-20231201   gcc  
i386         buildonly-randconfig-005-20231201   gcc  
i386         buildonly-randconfig-006-20231201   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231201   gcc  
i386                  randconfig-002-20231201   gcc  
i386                  randconfig-003-20231201   gcc  
i386                  randconfig-004-20231201   gcc  
i386                  randconfig-005-20231201   gcc  
i386                  randconfig-006-20231201   gcc  
i386                  randconfig-011-20231201   clang
i386                  randconfig-012-20231201   clang
i386                  randconfig-013-20231201   clang
i386                  randconfig-014-20231201   clang
i386                  randconfig-015-20231201   clang
i386                  randconfig-016-20231201   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20231201   gcc  
loongarch             randconfig-002-20231201   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231201   gcc  
nios2                 randconfig-002-20231201   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20231201   gcc  
parisc                randconfig-002-20231201   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      bamboo_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc               randconfig-001-20231201   gcc  
powerpc               randconfig-002-20231201   gcc  
powerpc               randconfig-003-20231201   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     taishan_defconfig   gcc  
powerpc                     tqm8541_defconfig   gcc  
powerpc64                        alldefconfig   gcc  
powerpc64             randconfig-001-20231201   gcc  
powerpc64             randconfig-002-20231201   gcc  
powerpc64             randconfig-003-20231201   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231201   gcc  
riscv                 randconfig-002-20231201   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20231201   gcc  
sh                    randconfig-002-20231201   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231201   gcc  
sparc64               randconfig-002-20231201   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231201   gcc  
um                    randconfig-002-20231201   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231201   gcc  
x86_64       buildonly-randconfig-002-20231201   gcc  
x86_64       buildonly-randconfig-003-20231201   gcc  
x86_64       buildonly-randconfig-004-20231201   gcc  
x86_64       buildonly-randconfig-005-20231201   gcc  
x86_64       buildonly-randconfig-006-20231201   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20231201   gcc  
x86_64                randconfig-012-20231201   gcc  
x86_64                randconfig-013-20231201   gcc  
x86_64                randconfig-014-20231201   gcc  
x86_64                randconfig-015-20231201   gcc  
x86_64                randconfig-016-20231201   gcc  
x86_64                randconfig-071-20231201   gcc  
x86_64                randconfig-072-20231201   gcc  
x86_64                randconfig-073-20231201   gcc  
x86_64                randconfig-074-20231201   gcc  
x86_64                randconfig-075-20231201   gcc  
x86_64                randconfig-076-20231201   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231201   gcc  
xtensa                randconfig-002-20231201   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
