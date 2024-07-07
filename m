Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C9F3C0B
	for <linux-serial@vger.kernel.org>; Sun,  7 Jul 2024 05:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720331021; cv=none; b=egNBr7Kwvb46uI7y2GmKJWY2Yxf8VrGAWn1+p7pyUckwvNxuALRr2gGYLMWNRu5hTXdrzsdwQGgSa2UBmvSsL7IzNTjrHpMDTl5afvFSgr1feLRDOssQXPqi4hMM4UmGrKgmDoZ6xb4VKK8iYSYz1T6VzvdQ2Yc5nJ7uUDiHjko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720331021; c=relaxed/simple;
	bh=+GLT3N9K/9iLMmkftpAnoVlV0l583QwbW6aT2lR6jps=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JD2PqQd5FABbGGcmXKVfqOjbaFxwfe48kN1PjeWM4yFVMIqwcP9ZCeGrHrKwyAycq18635SYfEPVZ89wnlJfxC+bGf76Q5aEQrJz4gW+u0KNoRIzj162LvviX3yLlw2fzId95o9q3DnkwvnnIqQCrEdjrBxyPQNCW5JBZvlbc78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RleBSI8I; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RleBSI8I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720331019; x=1751867019;
  h=date:from:to:cc:subject:message-id;
  bh=+GLT3N9K/9iLMmkftpAnoVlV0l583QwbW6aT2lR6jps=;
  b=RleBSI8IF9BKyRgCoxoCl8pR7UIKi+1BJG9dvCDfb4kku5yhZyoCHEbW
   qafBhmuOaKQ9XamzO1F8wBl8wYFGRZT4T/RFA+fAdH1ruWJowO5CtuUMq
   i++j3uSdwCpLRKqbOSVPutS8QKkI0SELh/3TbiZKJIISg0LEfVsSu/UR4
   ApJT34b8YvTa74hCjjaum8iBSgEqOqBWFAwM2l9LaPBwslkYSIM4bNI6A
   2qQCSb2VpURsvt2vCrCMnmgS+jlgQJKehhBAjN5vNNq5XOjoj7J9PeLMb
   IXmBxgZ/TGLv/6+pQ3nls0NnHu3SFtaRollkkuOPzizRbbjmZ8jT0q83/
   A==;
X-CSE-ConnectionGUID: LUpIwhQOQ0Gc8LC3U4ZFpQ==
X-CSE-MsgGUID: ZOl2FqEmQHO98LX46TI/UQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="17699833"
X-IronPort-AV: E=Sophos;i="6.09,189,1716274800"; 
   d="scan'208";a="17699833"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 22:43:38 -0700
X-CSE-ConnectionGUID: QQjdfHfWQxmuFn1TZSwGdg==
X-CSE-MsgGUID: daDR5+aXRy6GWjl6jXmbZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,189,1716274800"; 
   d="scan'208";a="47182408"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 06 Jul 2024 22:43:37 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQKgQ-000UfI-1h;
	Sun, 07 Jul 2024 05:43:34 +0000
Date: Sun, 07 Jul 2024 13:43:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 17199dfccd4b7f7e0c059ef43bef6e0078423476
Message-ID: <202407071300.9NPe8p2A-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 17199dfccd4b7f7e0c059ef43bef6e0078423476  Documentation: kernel-parameters: Add DEVNAME:0.0 format for serial ports

elapsed time: 1221m

configs tested: 293
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     haps_hs_smp_defconfig   gcc-13.2.0
arc                   randconfig-001-20240706   gcc-13.2.0
arc                   randconfig-001-20240707   gcc-13.2.0
arc                   randconfig-002-20240706   gcc-13.2.0
arc                   randconfig-002-20240707   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-13.2.0
arm                            hisi_defconfig   gcc-13.2.0
arm                       multi_v4t_defconfig   gcc-13.2.0
arm                        mvebu_v7_defconfig   gcc-13.2.0
arm                       netwinder_defconfig   gcc-13.2.0
arm                   randconfig-001-20240706   gcc-13.2.0
arm                   randconfig-001-20240707   gcc-13.2.0
arm                   randconfig-002-20240706   gcc-13.2.0
arm                   randconfig-002-20240707   gcc-13.2.0
arm                   randconfig-003-20240706   gcc-13.2.0
arm                   randconfig-003-20240707   gcc-13.2.0
arm                   randconfig-004-20240706   gcc-13.2.0
arm                   randconfig-004-20240707   gcc-13.2.0
arm                           tegra_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240706   gcc-13.2.0
arm64                 randconfig-001-20240707   gcc-13.2.0
arm64                 randconfig-002-20240706   gcc-13.2.0
arm64                 randconfig-002-20240707   gcc-13.2.0
arm64                 randconfig-003-20240706   gcc-13.2.0
arm64                 randconfig-003-20240707   gcc-13.2.0
arm64                 randconfig-004-20240706   gcc-13.2.0
arm64                 randconfig-004-20240707   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240706   gcc-13.2.0
csky                  randconfig-001-20240707   gcc-13.2.0
csky                  randconfig-002-20240706   gcc-13.2.0
csky                  randconfig-002-20240707   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240706   clang-18
i386         buildonly-randconfig-001-20240707   gcc-13
i386         buildonly-randconfig-002-20240706   clang-18
i386         buildonly-randconfig-002-20240706   gcc-13
i386         buildonly-randconfig-002-20240707   gcc-13
i386         buildonly-randconfig-003-20240706   clang-18
i386         buildonly-randconfig-003-20240707   gcc-13
i386         buildonly-randconfig-004-20240706   clang-18
i386         buildonly-randconfig-004-20240706   gcc-13
i386         buildonly-randconfig-004-20240707   gcc-13
i386         buildonly-randconfig-005-20240706   clang-18
i386         buildonly-randconfig-005-20240706   gcc-10
i386         buildonly-randconfig-005-20240707   gcc-13
i386         buildonly-randconfig-006-20240706   clang-18
i386         buildonly-randconfig-006-20240707   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240706   clang-18
i386                  randconfig-001-20240706   gcc-13
i386                  randconfig-001-20240707   gcc-13
i386                  randconfig-002-20240706   clang-18
i386                  randconfig-002-20240707   gcc-13
i386                  randconfig-003-20240706   clang-18
i386                  randconfig-003-20240706   gcc-13
i386                  randconfig-003-20240707   gcc-13
i386                  randconfig-004-20240706   clang-18
i386                  randconfig-004-20240707   gcc-13
i386                  randconfig-005-20240706   clang-18
i386                  randconfig-005-20240707   gcc-13
i386                  randconfig-006-20240706   clang-18
i386                  randconfig-006-20240706   gcc-12
i386                  randconfig-006-20240707   gcc-13
i386                  randconfig-011-20240706   clang-18
i386                  randconfig-011-20240706   gcc-11
i386                  randconfig-011-20240707   gcc-13
i386                  randconfig-012-20240706   clang-18
i386                  randconfig-012-20240707   gcc-13
i386                  randconfig-013-20240706   clang-18
i386                  randconfig-013-20240707   gcc-13
i386                  randconfig-014-20240706   clang-18
i386                  randconfig-014-20240707   gcc-13
i386                  randconfig-015-20240706   clang-18
i386                  randconfig-015-20240706   gcc-7
i386                  randconfig-015-20240707   gcc-13
i386                  randconfig-016-20240706   clang-18
i386                  randconfig-016-20240706   gcc-13
i386                  randconfig-016-20240707   gcc-13
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240706   gcc-13.2.0
loongarch             randconfig-001-20240707   gcc-13.2.0
loongarch             randconfig-002-20240706   gcc-13.2.0
loongarch             randconfig-002-20240707   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5275evb_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                          ath25_defconfig   gcc-13.2.0
mips                     cu1830-neo_defconfig   gcc-13.2.0
mips                      fuloong2e_defconfig   gcc-13.2.0
mips                            gpr_defconfig   gcc-13.2.0
mips                           ip27_defconfig   gcc-13.2.0
mips                           ip28_defconfig   gcc-13.2.0
mips                           jazz_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240706   gcc-13.2.0
nios2                 randconfig-001-20240707   gcc-13.2.0
nios2                 randconfig-002-20240706   gcc-13.2.0
nios2                 randconfig-002-20240707   gcc-13.2.0
openrisc                         alldefconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                         allyesconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                           allmodconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                           allyesconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc                generic-64bit_defconfig   gcc-13.2.0
parisc                randconfig-001-20240706   gcc-13.2.0
parisc                randconfig-001-20240707   gcc-13.2.0
parisc                randconfig-002-20240706   gcc-13.2.0
parisc                randconfig-002-20240707   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-13.2.0
powerpc                    ge_imp3a_defconfig   gcc-13.2.0
powerpc                     mpc512x_defconfig   gcc-13.2.0
powerpc                 mpc8315_rdb_defconfig   gcc-13.2.0
powerpc                    mvme5100_defconfig   gcc-13.2.0
powerpc                      pasemi_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240706   gcc-13.2.0
powerpc               randconfig-001-20240707   gcc-13.2.0
powerpc               randconfig-002-20240706   gcc-13.2.0
powerpc               randconfig-002-20240707   gcc-13.2.0
powerpc               randconfig-003-20240706   gcc-13.2.0
powerpc               randconfig-003-20240707   gcc-13.2.0
powerpc                     tqm8541_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240706   gcc-13.2.0
powerpc64             randconfig-001-20240707   gcc-13.2.0
powerpc64             randconfig-002-20240706   gcc-13.2.0
powerpc64             randconfig-002-20240707   gcc-13.2.0
powerpc64             randconfig-003-20240706   gcc-13.2.0
powerpc64             randconfig-003-20240707   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-13.2.0
riscv                               defconfig   gcc-13.2.0
riscv                 randconfig-001-20240706   gcc-13.2.0
riscv                 randconfig-001-20240707   gcc-13.2.0
riscv                 randconfig-002-20240706   gcc-13.2.0
riscv                 randconfig-002-20240707   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-13.2.0
s390                                defconfig   gcc-13.2.0
s390                  randconfig-001-20240706   gcc-13.2.0
s390                  randconfig-001-20240707   gcc-13.2.0
s390                  randconfig-002-20240706   gcc-13.2.0
s390                  randconfig-002-20240707   gcc-13.2.0
sh                               alldefconfig   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sh                        edosk7705_defconfig   gcc-13.2.0
sh                     magicpanelr2_defconfig   gcc-13.2.0
sh                    randconfig-001-20240706   gcc-13.2.0
sh                    randconfig-001-20240707   gcc-13.2.0
sh                    randconfig-002-20240706   gcc-13.2.0
sh                    randconfig-002-20240707   gcc-13.2.0
sh                           se7705_defconfig   gcc-13.2.0
sh                           sh2007_defconfig   gcc-13.2.0
sh                     sh7710voipgw_defconfig   gcc-13.2.0
sh                        sh7757lcr_defconfig   gcc-13.2.0
sh                        sh7785lcr_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
sparc64               randconfig-001-20240706   gcc-13.2.0
sparc64               randconfig-001-20240707   gcc-13.2.0
sparc64               randconfig-002-20240706   gcc-13.2.0
sparc64               randconfig-002-20240707   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.2.0
um                                  defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-13.2.0
um                    randconfig-001-20240706   gcc-13.2.0
um                    randconfig-001-20240707   gcc-13.2.0
um                    randconfig-002-20240706   gcc-13.2.0
um                    randconfig-002-20240707   gcc-13.2.0
um                           x86_64_defconfig   gcc-13.2.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240706   clang-18
x86_64       buildonly-randconfig-001-20240707   gcc-13
x86_64       buildonly-randconfig-002-20240706   clang-18
x86_64       buildonly-randconfig-002-20240707   gcc-13
x86_64       buildonly-randconfig-003-20240706   clang-18
x86_64       buildonly-randconfig-003-20240707   gcc-13
x86_64       buildonly-randconfig-004-20240706   clang-18
x86_64       buildonly-randconfig-004-20240707   gcc-13
x86_64       buildonly-randconfig-005-20240706   clang-18
x86_64       buildonly-randconfig-005-20240706   gcc-13
x86_64       buildonly-randconfig-005-20240707   gcc-13
x86_64       buildonly-randconfig-006-20240706   clang-18
x86_64       buildonly-randconfig-006-20240707   gcc-13
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240706   clang-18
x86_64                randconfig-001-20240706   gcc-9
x86_64                randconfig-001-20240707   gcc-13
x86_64                randconfig-002-20240706   clang-18
x86_64                randconfig-002-20240707   gcc-13
x86_64                randconfig-003-20240706   clang-18
x86_64                randconfig-003-20240707   gcc-13
x86_64                randconfig-004-20240706   clang-18
x86_64                randconfig-004-20240707   gcc-13
x86_64                randconfig-005-20240706   clang-18
x86_64                randconfig-005-20240707   gcc-13
x86_64                randconfig-006-20240706   clang-18
x86_64                randconfig-006-20240707   gcc-13
x86_64                randconfig-011-20240706   clang-18
x86_64                randconfig-011-20240706   gcc-12
x86_64                randconfig-011-20240707   gcc-13
x86_64                randconfig-012-20240706   clang-18
x86_64                randconfig-012-20240706   gcc-12
x86_64                randconfig-012-20240707   gcc-13
x86_64                randconfig-013-20240706   clang-18
x86_64                randconfig-013-20240707   gcc-13
x86_64                randconfig-014-20240706   clang-18
x86_64                randconfig-014-20240706   gcc-13
x86_64                randconfig-014-20240707   gcc-13
x86_64                randconfig-015-20240706   clang-18
x86_64                randconfig-015-20240706   gcc-13
x86_64                randconfig-015-20240707   gcc-13
x86_64                randconfig-016-20240706   clang-18
x86_64                randconfig-016-20240706   gcc-13
x86_64                randconfig-016-20240707   gcc-13
x86_64                randconfig-071-20240706   clang-18
x86_64                randconfig-071-20240706   gcc-12
x86_64                randconfig-071-20240707   gcc-13
x86_64                randconfig-072-20240706   clang-18
x86_64                randconfig-072-20240706   gcc-13
x86_64                randconfig-072-20240707   gcc-13
x86_64                randconfig-073-20240706   clang-18
x86_64                randconfig-073-20240706   gcc-12
x86_64                randconfig-073-20240707   gcc-13
x86_64                randconfig-074-20240706   clang-18
x86_64                randconfig-074-20240706   gcc-13
x86_64                randconfig-074-20240707   gcc-13
x86_64                randconfig-075-20240706   clang-18
x86_64                randconfig-075-20240707   gcc-13
x86_64                randconfig-076-20240706   clang-18
x86_64                randconfig-076-20240706   gcc-13
x86_64                randconfig-076-20240707   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240706   gcc-13.2.0
xtensa                randconfig-001-20240707   gcc-13.2.0
xtensa                randconfig-002-20240706   gcc-13.2.0
xtensa                randconfig-002-20240707   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
