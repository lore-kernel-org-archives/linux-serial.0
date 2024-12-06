Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC2520456E
	for <linux-serial@vger.kernel.org>; Fri,  6 Dec 2024 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515700; cv=none; b=GJHyEh7JNCHtnZISUZyNm5Ifcxuv04umfPS++JnpDmHpxrR9PZS7gq2iLXk2vWzLq7BYSbXgQz0vJzuWeSyL/lsWsd6hbjD3AluvcTzK6rB3z9+tVKMdtlCWHD3AzzJw/Vb5djM2WiAur/Ok75Bi5/y+Spa1EhcRhWmvPAKqvMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515700; c=relaxed/simple;
	bh=kATeeMPWRuw9hCWU4boxL8yWR1AVRnWkN1tQGtwjXh4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VmhckOMO7oQnwdfszJnJ0/WzLQvhwOddEcfi3zINL5W5Ii31A0UIF/4/XxNfaSq4M8qdRNm1KZ6VfOetiC9gPs89oKhh4GUqpuCHi2ZLNch/9RrRGThctCcDzX6y2aJV8OQOZNeWrDJV4hhN0aAMRUQxfTLPReu/djnaM/UP/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1RypbYR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1RypbYR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733515698; x=1765051698;
  h=date:from:to:cc:subject:message-id;
  bh=kATeeMPWRuw9hCWU4boxL8yWR1AVRnWkN1tQGtwjXh4=;
  b=N1RypbYRWrvpRGtJor8yx32NAwJNTARlaG44GjxBJjGAuxXhTFoMY1AN
   mto5CZjGnGfiaa1UrSJDXX39QZdKpQucBNLU+ovXW0dJqI4/D3fQz5KqN
   DdazNvMMUTIt5PgHl0CRK0hjjrroBU5ArWEVGcIRuzYfAvTtPBAzOUF+9
   Iw4O3qKDoOPT5onRyee+Fr/NG+n7exJofl++gxCed7tT49/vFLWAj/GHW
   PPn37x4idzs0+E1WvQEoSRZWlBNh77Nx/+6pgVUNr8wuRBwetnDhXTZVS
   4PUBry5Y+kcUgLeCoSQt/3wKbht3kSNGMcZXDkQ2lTtRxH8KJB6ObiOeL
   w==;
X-CSE-ConnectionGUID: pqQUV4DlRDWYSxNwAplYjQ==
X-CSE-MsgGUID: OkB9J3urRYqxsVcQRhh2Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="44350581"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="44350581"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 12:08:17 -0800
X-CSE-ConnectionGUID: cicGy3goTx+iNI0YFQh2ZA==
X-CSE-MsgGUID: 20CalGWMSVaDjCVAY+SZ4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="94865197"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 06 Dec 2024 12:08:15 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJecX-0002E9-07;
	Fri, 06 Dec 2024 20:08:13 +0000
Date: Sat, 07 Dec 2024 04:04:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 4e450dfd0f968b79204637bf13280892dff287b1
Message-ID: <202412070439.iGvxm9IY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 4e450dfd0f968b79204637bf13280892dff287b1  tty: serial: Work around warning backtrace in serial8250_set_defaults

elapsed time: 761m

configs tested: 323
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              alldefconfig    clang-20
arc                              allmodconfig    clang-18
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                         haps_hs_defconfig    gcc-13.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20241206    gcc-13.2.0
arc                   randconfig-001-20241206    gcc-14.2.0
arc                   randconfig-001-20241207    clang-19
arc                   randconfig-002-20241206    gcc-13.2.0
arc                   randconfig-002-20241206    gcc-14.2.0
arc                   randconfig-002-20241207    clang-19
arm                              allmodconfig    clang-18
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-20
arm                          collie_defconfig    gcc-14.2.0
arm                     davinci_all_defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-14.2.0
arm                          gemini_defconfig    clang-20
arm                           imxrt_defconfig    gcc-13.2.0
arm                         lpc18xx_defconfig    gcc-14.2.0
arm                            mmp2_defconfig    gcc-14.2.0
arm                            mps2_defconfig    clang-20
arm                        multi_v5_defconfig    gcc-14.2.0
arm                       netwinder_defconfig    gcc-14.2.0
arm                           omap1_defconfig    clang-20
arm                           omap1_defconfig    gcc-14.2.0
arm                         orion5x_defconfig    clang-20
arm                          pxa168_defconfig    clang-20
arm                   randconfig-001-20241206    gcc-14.2.0
arm                   randconfig-001-20241207    clang-19
arm                   randconfig-002-20241206    gcc-14.2.0
arm                   randconfig-002-20241207    clang-19
arm                   randconfig-003-20241206    gcc-14.2.0
arm                   randconfig-003-20241207    clang-19
arm                   randconfig-004-20241206    clang-20
arm                   randconfig-004-20241206    gcc-14.2.0
arm                   randconfig-004-20241207    clang-19
arm                             rpc_defconfig    gcc-14.2.0
arm                           sama7_defconfig    clang-20
arm                        shmobile_defconfig    gcc-14.2.0
arm                          sp7021_defconfig    gcc-14.2.0
arm                           tegra_defconfig    gcc-14.2.0
arm                           u8500_defconfig    gcc-13.2.0
arm64                            alldefconfig    clang-20
arm64                            allmodconfig    clang-18
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241206    clang-14
arm64                 randconfig-001-20241206    gcc-14.2.0
arm64                 randconfig-001-20241207    clang-19
arm64                 randconfig-002-20241206    gcc-14.2.0
arm64                 randconfig-002-20241207    clang-19
arm64                 randconfig-003-20241206    clang-20
arm64                 randconfig-003-20241206    gcc-14.2.0
arm64                 randconfig-003-20241207    clang-19
arm64                 randconfig-004-20241206    clang-20
arm64                 randconfig-004-20241206    gcc-14.2.0
arm64                 randconfig-004-20241207    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241206    gcc-14.2.0
csky                  randconfig-001-20241207    clang-19
csky                  randconfig-002-20241206    gcc-14.2.0
csky                  randconfig-002-20241207    clang-19
hexagon                          alldefconfig    clang-20
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241206    gcc-14.2.0
hexagon               randconfig-001-20241207    clang-19
hexagon               randconfig-002-20241206    gcc-14.2.0
hexagon               randconfig-002-20241207    clang-19
i386                 buildonly-randconfig-001    gcc-12
i386        buildonly-randconfig-001-20241206    clang-19
i386        buildonly-randconfig-001-20241207    clang-19
i386                 buildonly-randconfig-002    clang-19
i386                 buildonly-randconfig-002    gcc-12
i386        buildonly-randconfig-002-20241206    clang-19
i386        buildonly-randconfig-002-20241207    clang-19
i386                 buildonly-randconfig-003    clang-19
i386                 buildonly-randconfig-003    gcc-12
i386        buildonly-randconfig-003-20241206    clang-19
i386        buildonly-randconfig-003-20241207    clang-19
i386                 buildonly-randconfig-004    gcc-12
i386        buildonly-randconfig-004-20241206    clang-19
i386        buildonly-randconfig-004-20241207    clang-19
i386                 buildonly-randconfig-005    gcc-12
i386        buildonly-randconfig-005-20241206    clang-19
i386        buildonly-randconfig-005-20241207    clang-19
i386                 buildonly-randconfig-006    gcc-12
i386        buildonly-randconfig-006-20241206    clang-19
i386        buildonly-randconfig-006-20241207    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241206    gcc-14.2.0
loongarch             randconfig-001-20241207    clang-19
loongarch             randconfig-002-20241206    gcc-14.2.0
loongarch             randconfig-002-20241207    clang-19
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          amiga_defconfig    gcc-14.2.0
m68k                         apollo_defconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                            mac_defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-13.2.0
m68k                          multi_defconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
m68k                            q40_defconfig    clang-20
m68k                           sun3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    clang-20
mips                           ip27_defconfig    gcc-14.2.0
mips                           ip30_defconfig    gcc-14.2.0
mips                           mtx1_defconfig    clang-16
mips                        omega2p_defconfig    gcc-14.2.0
mips                        qi_lb60_defconfig    clang-20
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241206    gcc-14.2.0
nios2                 randconfig-001-20241207    clang-19
nios2                 randconfig-002-20241206    gcc-14.2.0
nios2                 randconfig-002-20241207    clang-19
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    clang-20
openrisc                 simple_smp_defconfig    gcc-13.2.0
openrisc                       virt_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                generic-64bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20241206    gcc-14.2.0
parisc                randconfig-001-20241207    clang-19
parisc                randconfig-002-20241206    gcc-14.2.0
parisc                randconfig-002-20241207    clang-19
parisc64                         alldefconfig    clang-20
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      arches_defconfig    clang-20
powerpc                      arches_defconfig    gcc-14.2.0
powerpc                     asp8347_defconfig    gcc-14.2.0
powerpc                   bluestone_defconfig    gcc-13.2.0
powerpc                      cm5200_defconfig    clang-20
powerpc                   currituck_defconfig    gcc-14.2.0
powerpc                       ebony_defconfig    clang-18
powerpc                       eiger_defconfig    gcc-14.2.0
powerpc                     ep8248e_defconfig    clang-20
powerpc                      ep88xc_defconfig    gcc-14.2.0
powerpc                    gamecube_defconfig    clang-20
powerpc                    ge_imp3a_defconfig    clang-20
powerpc                    ge_imp3a_defconfig    gcc-13.2.0
powerpc                       holly_defconfig    clang-20
powerpc                       holly_defconfig    gcc-14.2.0
powerpc                        icon_defconfig    clang-20
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc                      mgcoge_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    gcc-13.2.0
powerpc                 mpc8315_rdb_defconfig    gcc-14.2.0
powerpc                 mpc832x_rdb_defconfig    clang-20
powerpc                 mpc832x_rdb_defconfig    gcc-13.2.0
powerpc                 mpc832x_rdb_defconfig    gcc-14.2.0
powerpc                 mpc837x_rdb_defconfig    clang-20
powerpc                  mpc866_ads_defconfig    clang-20
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc                       ppc64_defconfig    clang-18
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc                         ps3_defconfig    gcc-14.2.0
powerpc                     rainier_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241206    gcc-14.2.0
powerpc               randconfig-001-20241207    clang-19
powerpc               randconfig-002-20241206    gcc-14.2.0
powerpc               randconfig-002-20241207    clang-19
powerpc               randconfig-003-20241206    gcc-14.2.0
powerpc               randconfig-003-20241207    clang-19
powerpc                     redwood_defconfig    gcc-14.2.0
powerpc                     skiroot_defconfig    gcc-14.2.0
powerpc                    socrates_defconfig    gcc-14.2.0
powerpc                     tqm8540_defconfig    clang-20
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc                     tqm8541_defconfig    clang-20
powerpc                     tqm8541_defconfig    gcc-14.2.0
powerpc                     tqm8560_defconfig    clang-20
powerpc                 xes_mpc85xx_defconfig    gcc-14.2.0
powerpc64                        alldefconfig    clang-18
powerpc64             randconfig-001-20241207    clang-19
powerpc64             randconfig-002-20241206    gcc-14.2.0
powerpc64             randconfig-002-20241207    clang-19
powerpc64             randconfig-003-20241206    gcc-14.2.0
powerpc64             randconfig-003-20241207    clang-19
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-13.2.0
riscv                    nommu_virt_defconfig    gcc-14.2.0
riscv                 randconfig-001-20241206    gcc-14.2.0
riscv                 randconfig-002-20241206    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241206    gcc-14.2.0
s390                  randconfig-002-20241206    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         apsh4a3a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    clang-18
sh                ecovec24-romimage_defconfig    gcc-13.2.0
sh                         ecovec24_defconfig    clang-20
sh                        edosk7705_defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                          polaris_defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    clang-18
sh                    randconfig-001-20241206    gcc-14.2.0
sh                    randconfig-002-20241206    gcc-14.2.0
sh                          rsk7264_defconfig    gcc-14.2.0
sh                          rsk7269_defconfig    clang-18
sh                          rsk7269_defconfig    clang-20
sh                      rts7751r2d1_defconfig    clang-20
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sh                          sdk7786_defconfig    gcc-14.2.0
sh                           se7206_defconfig    clang-20
sh                           se7343_defconfig    clang-20
sh                           se7722_defconfig    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                   secureedge5410_defconfig    clang-18
sh                   secureedge5410_defconfig    gcc-14.2.0
sh                           sh2007_defconfig    gcc-14.2.0
sh                        sh7763rdp_defconfig    clang-20
sh                        sh7763rdp_defconfig    gcc-14.2.0
sh                             shx3_defconfig    gcc-14.2.0
sh                            titan_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241206    gcc-14.2.0
sparc                 randconfig-002-20241206    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241206    gcc-14.2.0
sparc64               randconfig-002-20241206    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241206    gcc-14.2.0
um                    randconfig-002-20241206    gcc-14.2.0
um                           x86_64_defconfig    gcc-13.2.0
x86_64      buildonly-randconfig-001-20241206    clang-19
x86_64      buildonly-randconfig-001-20241206    gcc-12
x86_64      buildonly-randconfig-001-20241207    clang-19
x86_64      buildonly-randconfig-002-20241206    clang-19
x86_64      buildonly-randconfig-002-20241206    gcc-12
x86_64      buildonly-randconfig-002-20241207    clang-19
x86_64      buildonly-randconfig-003-20241206    clang-19
x86_64      buildonly-randconfig-003-20241206    gcc-12
x86_64      buildonly-randconfig-003-20241207    clang-19
x86_64      buildonly-randconfig-004-20241206    clang-19
x86_64      buildonly-randconfig-004-20241207    clang-19
x86_64      buildonly-randconfig-005-20241206    clang-19
x86_64      buildonly-randconfig-005-20241206    gcc-11
x86_64      buildonly-randconfig-005-20241207    clang-19
x86_64      buildonly-randconfig-006-20241206    clang-19
x86_64      buildonly-randconfig-006-20241207    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-13.2.0
xtensa                generic_kc705_defconfig    clang-20
xtensa                generic_kc705_defconfig    gcc-14.2.0
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20241206    gcc-14.2.0
xtensa                randconfig-002-20241206    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
