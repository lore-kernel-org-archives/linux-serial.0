Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F8F21C17D
	for <linux-serial@vger.kernel.org>; Fri, 20 Jun 2025 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750423825; cv=none; b=GK2YOjWA4XnuLB8gQM+GrIhCxu6RBkJukaGouq3ij1t4QIYFfgIPo9NKw6T/lKDPRQsbHmhOvU4vhuyA+UlGhV81E/G7CQaProQSBnKw12ivTpkFFwgaLimsGkGP2aHNYtyfnR7Mp782CgXo+5qcBP4EXGRxefXuywOwiusXcCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750423825; c=relaxed/simple;
	bh=UQKkY/TpMbHwu4b/q/0e0oEvFp3ZSisAKA4mw5mEOVg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=u0ZafM1xrJwtRO6dGc/9kuL0yd0ENNADzW3DvJ+580qYD63Tfabf8tF/jHPeTdhpYEwESfvU/aQZ3TwfujffsvUhn55IugBAvt7tvRU0JQ6+xpD28bxyDtn5KU4Bvtp+TkD4RRuZNuVX6Zk6GHFdy+XgiI7s78spNM3/aCzwmPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ccrfLHhR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ccrfLHhR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750423823; x=1781959823;
  h=date:from:to:cc:subject:message-id;
  bh=UQKkY/TpMbHwu4b/q/0e0oEvFp3ZSisAKA4mw5mEOVg=;
  b=ccrfLHhR2Rh9abRrOyBwz/TyxY33v5RpM/vqFRn0huw03aPnK5yVxeuw
   WyL4g/q/QZR0O+XXQsnsR5LeL3KcIvTW658rOup9i23AxfvTxrxGDMtsb
   hiUppfibWGU1cLV9cWSTZLIK+b9Byyy8yD1WVIqq0jtuGcjt/dlXEB7FH
   JTicsXOu2HRB4V/ttLocrLoNDw6Eo2FVH2naVubUyxDUKOBlnL0kvzXg4
   cGMlr0Qwoqi61gaZd089u87ZF+TspNnxu5NiGwHY7j1SXSbioczpQ6bH3
   fK8qlNhNUuYyBWDrHUluOpsA3lasJAkz2k5f7DwtUbL3n1aeNQcfocUED
   Q==;
X-CSE-ConnectionGUID: dcCvM+FfTgCCx3pXmtPrXw==
X-CSE-MsgGUID: T35c2E9RRZm4ualfzib71A==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="70122303"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="70122303"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 05:50:23 -0700
X-CSE-ConnectionGUID: v5qc66NETxm1Kicm2MfInA==
X-CSE-MsgGUID: uTrPbz9SQyubF8L/3rMv3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="151591119"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 20 Jun 2025 05:50:17 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSbC9-000Llc-3D;
	Fri, 20 Jun 2025 12:50:13 +0000
Date: Fri, 20 Jun 2025 20:49:42 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 d36f0e9a0002f04f4d6dd9be908d58fe5bd3a279
Message-ID: <202506202032.jqsFN5fc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: d36f0e9a0002f04f4d6dd9be908d58fe5bd3a279  serial: core: restore of_node information in sysfs

elapsed time: 1455m

configs tested: 248
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                          axs103_defconfig    clang-21
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250619    gcc-15.1.0
arc                   randconfig-001-20250620    clang-21
arc                   randconfig-002-20250619    gcc-15.1.0
arc                   randconfig-002-20250620    clang-21
arm                              allmodconfig    clang-19
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         axm55xx_defconfig    clang-21
arm                                 defconfig    gcc-15.1.0
arm                          ixp4xx_defconfig    clang-21
arm                            mps2_defconfig    clang-21
arm                   randconfig-001-20250619    clang-21
arm                   randconfig-001-20250620    clang-21
arm                   randconfig-002-20250619    gcc-8.5.0
arm                   randconfig-002-20250620    clang-21
arm                   randconfig-003-20250619    gcc-8.5.0
arm                   randconfig-003-20250620    clang-21
arm                   randconfig-004-20250619    gcc-10.5.0
arm                   randconfig-004-20250620    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250619    gcc-8.5.0
arm64                 randconfig-001-20250620    clang-21
arm64                 randconfig-002-20250619    gcc-9.5.0
arm64                 randconfig-002-20250620    clang-21
arm64                 randconfig-003-20250619    gcc-10.5.0
arm64                 randconfig-003-20250620    clang-21
arm64                 randconfig-004-20250619    gcc-10.5.0
arm64                 randconfig-004-20250620    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250619    gcc-11.5.0
csky                  randconfig-001-20250620    clang-21
csky                  randconfig-002-20250619    gcc-9.3.0
csky                  randconfig-002-20250620    clang-21
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250619    clang-21
hexagon               randconfig-001-20250620    clang-21
hexagon               randconfig-002-20250619    clang-21
hexagon               randconfig-002-20250620    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250619    gcc-12
i386        buildonly-randconfig-001-20250620    clang-20
i386        buildonly-randconfig-002-20250619    gcc-12
i386        buildonly-randconfig-002-20250620    clang-20
i386        buildonly-randconfig-003-20250619    clang-20
i386        buildonly-randconfig-003-20250620    clang-20
i386        buildonly-randconfig-004-20250619    clang-20
i386        buildonly-randconfig-004-20250620    clang-20
i386        buildonly-randconfig-005-20250619    clang-20
i386        buildonly-randconfig-005-20250620    clang-20
i386        buildonly-randconfig-006-20250619    clang-20
i386        buildonly-randconfig-006-20250620    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250620    gcc-12
i386                  randconfig-002-20250620    gcc-12
i386                  randconfig-003-20250620    gcc-12
i386                  randconfig-004-20250620    gcc-12
i386                  randconfig-005-20250620    gcc-12
i386                  randconfig-006-20250620    gcc-12
i386                  randconfig-007-20250620    gcc-12
i386                  randconfig-011-20250620    gcc-12
i386                  randconfig-012-20250620    gcc-12
i386                  randconfig-013-20250620    gcc-12
i386                  randconfig-014-20250620    gcc-12
i386                  randconfig-015-20250620    gcc-12
i386                  randconfig-016-20250620    gcc-12
i386                  randconfig-017-20250620    gcc-12
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250619    gcc-15.1.0
loongarch             randconfig-001-20250620    clang-21
loongarch             randconfig-002-20250619    gcc-15.1.0
loongarch             randconfig-002-20250620    clang-21
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          atari_defconfig    clang-21
m68k                                defconfig    gcc-15.1.0
m68k                           virt_defconfig    clang-21
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      bmips_stb_defconfig    clang-21
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250619    gcc-8.5.0
nios2                 randconfig-001-20250620    clang-21
nios2                 randconfig-002-20250619    gcc-8.5.0
nios2                 randconfig-002-20250620    clang-21
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250619    gcc-11.5.0
parisc                randconfig-001-20250620    clang-21
parisc                randconfig-002-20250619    gcc-8.5.0
parisc                randconfig-002-20250620    clang-21
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      cm5200_defconfig    clang-21
powerpc                     mpc5200_defconfig    clang-21
powerpc               mpc834x_itxgp_defconfig    clang-21
powerpc                     ppa8548_defconfig    clang-21
powerpc               randconfig-001-20250619    gcc-9.3.0
powerpc               randconfig-001-20250620    clang-21
powerpc               randconfig-002-20250619    clang-21
powerpc               randconfig-002-20250620    clang-21
powerpc               randconfig-003-20250619    gcc-10.5.0
powerpc               randconfig-003-20250620    clang-21
powerpc                     stx_gp3_defconfig    clang-21
powerpc64             randconfig-001-20250619    gcc-11.5.0
powerpc64             randconfig-001-20250620    clang-21
powerpc64             randconfig-002-20250619    clang-21
powerpc64             randconfig-002-20250620    clang-21
powerpc64             randconfig-003-20250619    gcc-10.5.0
powerpc64             randconfig-003-20250620    clang-21
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250619    gcc-11.5.0
riscv                 randconfig-001-20250620    gcc-13.3.0
riscv                 randconfig-002-20250619    clang-16
riscv                 randconfig-002-20250620    gcc-13.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250619    clang-19
s390                  randconfig-001-20250620    gcc-13.3.0
s390                  randconfig-002-20250619    gcc-13.2.0
s390                  randconfig-002-20250620    gcc-13.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                         ecovec24_defconfig    clang-21
sh                            hp6xx_defconfig    clang-21
sh                    randconfig-001-20250619    gcc-9.3.0
sh                    randconfig-001-20250620    gcc-13.3.0
sh                    randconfig-002-20250619    gcc-9.3.0
sh                    randconfig-002-20250620    gcc-13.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250619    gcc-14.3.0
sparc                 randconfig-001-20250620    gcc-13.3.0
sparc                 randconfig-002-20250619    gcc-10.3.0
sparc                 randconfig-002-20250620    gcc-13.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250619    gcc-13.3.0
sparc64               randconfig-001-20250620    gcc-13.3.0
sparc64               randconfig-002-20250619    gcc-8.5.0
sparc64               randconfig-002-20250620    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250619    clang-19
um                    randconfig-001-20250620    gcc-13.3.0
um                    randconfig-002-20250619    clang-21
um                    randconfig-002-20250620    gcc-13.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250619    clang-20
x86_64      buildonly-randconfig-001-20250620    gcc-12
x86_64      buildonly-randconfig-002-20250619    gcc-12
x86_64      buildonly-randconfig-002-20250620    gcc-12
x86_64      buildonly-randconfig-003-20250619    clang-20
x86_64      buildonly-randconfig-003-20250620    gcc-12
x86_64      buildonly-randconfig-004-20250619    gcc-12
x86_64      buildonly-randconfig-004-20250620    gcc-12
x86_64      buildonly-randconfig-005-20250619    clang-20
x86_64      buildonly-randconfig-005-20250620    gcc-12
x86_64      buildonly-randconfig-006-20250619    gcc-12
x86_64      buildonly-randconfig-006-20250620    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250620    clang-20
x86_64                randconfig-002-20250620    clang-20
x86_64                randconfig-003-20250620    clang-20
x86_64                randconfig-004-20250620    clang-20
x86_64                randconfig-005-20250620    clang-20
x86_64                randconfig-006-20250620    clang-20
x86_64                randconfig-007-20250620    clang-20
x86_64                randconfig-008-20250620    clang-20
x86_64                randconfig-071-20250620    clang-20
x86_64                randconfig-072-20250620    clang-20
x86_64                randconfig-073-20250620    clang-20
x86_64                randconfig-074-20250620    clang-20
x86_64                randconfig-075-20250620    clang-20
x86_64                randconfig-076-20250620    clang-20
x86_64                randconfig-077-20250620    clang-20
x86_64                randconfig-078-20250620    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250619    gcc-9.3.0
xtensa                randconfig-001-20250620    gcc-13.3.0
xtensa                randconfig-002-20250619    gcc-8.5.0
xtensa                randconfig-002-20250620    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
