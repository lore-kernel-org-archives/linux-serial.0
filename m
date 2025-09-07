Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907A1221554
	for <linux-serial@vger.kernel.org>; Sun,  7 Sep 2025 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757244893; cv=none; b=CC7+f62xFoZk0B/SnR0FdaFZYiKtGF49Qx8FkRg32Xdiwq/V5Cs4RxAFwHw4RblGkSkNPykAwpyLW4rpL9Y+A3qu2GsU9UzMzNDHeoRzSH4wbC/S8ANC9w9LTWmO/EQqvetf8heWYlLMhcoF1Die1UITt85TmwbCk47bclJFbZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757244893; c=relaxed/simple;
	bh=83WQP2VlLQmPtg8JgnAat9QgnDRwuprlAejRH1LqmKc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Z1eEZ0nRJLgzMLSiwz11LmKBjgWZ8fo9gW6Kct+dubkKxADMdUPRRW0is9kcDjZyBCRElD2oUIJKL/MA6jVekHZjDG7p1nRIyD9Krz8XfzhFGsAolKhWi0NdZoVDRY9TyXdEhbb9hoBCbzwUYfpM/w9Ktpcn7fHIeiYAGqkWaxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eld3vTWb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eld3vTWb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757244892; x=1788780892;
  h=date:from:to:cc:subject:message-id;
  bh=83WQP2VlLQmPtg8JgnAat9QgnDRwuprlAejRH1LqmKc=;
  b=eld3vTWb/UT9FGELXuYCgZrID3b9dE6Xl47I9UTJYkngMl8gxhXvIxJv
   fFcjOPKiMqTC4NsFSo2v6Ap+1CiFZATodL9++59NTpySFQWG1W6IoU5Em
   jvCMqxD4TpgS1tMP154L2EMc59evI8xxy2115ioYAh+PaOJV/PJvDefGJ
   4HpFK6TKecjjYf+J4wjEWIEufGA3goQnE0u0dSsUSzQkjTAESSUfsZU4F
   2G4JX1f+3/44Pj+fRcqEyaZsvF8VNxb9rj1mlc7dOtKJUdoT/KFBnjTWz
   cC3jAWhvWQkser88aiRMeqhA43WU21TDq7C4S909Py0CoGG+gOv9NkDvM
   Q==;
X-CSE-ConnectionGUID: CViLBuOPT56FNUKWHdqoSQ==
X-CSE-MsgGUID: Gs16e+xzQuadPAqLhjmtEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59475976"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59475976"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 04:34:51 -0700
X-CSE-ConnectionGUID: Z5Vwzl4PSiSgMmerBayrjg==
X-CSE-MsgGUID: LrH66NcbSsmSdMgBgNv3MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="172426312"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 07 Sep 2025 04:34:49 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvDfT-0002E9-0Z;
	Sun, 07 Sep 2025 11:34:47 +0000
Date: Sun, 07 Sep 2025 19:34:11 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 b5e3277c0f1c3439dd02b58997c06201d0ee8dbf
Message-ID: <202509071905.rljsAEnF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: b5e3277c0f1c3439dd02b58997c06201d0ee8dbf  serial: xilinx_uartps: read reg size from DTS

elapsed time: 1284m

configs tested: 237
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                        nsim_700_defconfig    gcc-15.1.0
arc                   randconfig-001-20250906    gcc-14.3.0
arc                   randconfig-001-20250907    clang-22
arc                   randconfig-002-20250906    gcc-10.5.0
arc                   randconfig-002-20250907    clang-22
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   randconfig-001-20250906    clang-22
arm                   randconfig-001-20250907    clang-22
arm                   randconfig-002-20250906    clang-22
arm                   randconfig-002-20250907    clang-22
arm                   randconfig-003-20250906    gcc-13.4.0
arm                   randconfig-003-20250907    clang-22
arm                   randconfig-004-20250906    gcc-10.5.0
arm                   randconfig-004-20250907    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250906    gcc-8.5.0
arm64                 randconfig-001-20250907    clang-22
arm64                 randconfig-002-20250906    gcc-12.5.0
arm64                 randconfig-002-20250907    clang-22
arm64                 randconfig-003-20250906    clang-22
arm64                 randconfig-003-20250907    clang-22
arm64                 randconfig-004-20250906    gcc-9.5.0
arm64                 randconfig-004-20250907    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250907    gcc-11.5.0
csky                  randconfig-001-20250907    gcc-15.1.0
csky                  randconfig-002-20250907    gcc-11.5.0
csky                  randconfig-002-20250907    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250907    clang-17
hexagon               randconfig-001-20250907    gcc-11.5.0
hexagon               randconfig-002-20250907    clang-22
hexagon               randconfig-002-20250907    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250906    clang-20
i386        buildonly-randconfig-001-20250907    clang-20
i386        buildonly-randconfig-002-20250906    gcc-11
i386        buildonly-randconfig-002-20250907    clang-20
i386        buildonly-randconfig-003-20250906    gcc-13
i386        buildonly-randconfig-003-20250907    clang-20
i386        buildonly-randconfig-004-20250906    gcc-13
i386        buildonly-randconfig-004-20250907    clang-20
i386        buildonly-randconfig-005-20250906    clang-20
i386        buildonly-randconfig-005-20250907    clang-20
i386        buildonly-randconfig-006-20250906    clang-20
i386        buildonly-randconfig-006-20250907    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250907    gcc-13
i386                  randconfig-002-20250907    gcc-13
i386                  randconfig-003-20250907    gcc-13
i386                  randconfig-004-20250907    gcc-13
i386                  randconfig-005-20250907    gcc-13
i386                  randconfig-006-20250907    gcc-13
i386                  randconfig-007-20250907    gcc-13
i386                  randconfig-011-20250907    gcc-13
i386                  randconfig-012-20250907    gcc-13
i386                  randconfig-013-20250907    gcc-13
i386                  randconfig-014-20250907    gcc-13
i386                  randconfig-015-20250907    gcc-13
i386                  randconfig-016-20250907    gcc-13
i386                  randconfig-017-20250907    gcc-13
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250907    clang-22
loongarch             randconfig-001-20250907    gcc-11.5.0
loongarch             randconfig-002-20250907    clang-22
loongarch             randconfig-002-20250907    gcc-11.5.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    gcc-15.1.0
mips                        omega2p_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250907    gcc-11.5.0
nios2                 randconfig-002-20250907    gcc-11.5.0
openrisc                         alldefconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-13
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250907    gcc-11.5.0
parisc                randconfig-001-20250907    gcc-9.5.0
parisc                randconfig-002-20250907    gcc-11.5.0
parisc                randconfig-002-20250907    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250907    gcc-11.5.0
powerpc               randconfig-001-20250907    gcc-9.5.0
powerpc               randconfig-002-20250907    clang-22
powerpc               randconfig-002-20250907    gcc-11.5.0
powerpc               randconfig-003-20250907    gcc-11.5.0
powerpc               randconfig-003-20250907    gcc-15.1.0
powerpc                  storcenter_defconfig    gcc-15.1.0
powerpc                     tqm8555_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250907    gcc-11.5.0
powerpc64             randconfig-001-20250907    gcc-13.4.0
powerpc64             randconfig-002-20250907    clang-22
powerpc64             randconfig-002-20250907    gcc-11.5.0
powerpc64             randconfig-003-20250907    clang-22
powerpc64             randconfig-003-20250907    gcc-11.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-13
riscv                 randconfig-001-20250906    gcc-13.4.0
riscv                 randconfig-001-20250907    gcc-12.5.0
riscv                 randconfig-002-20250906    gcc-8.5.0
riscv                 randconfig-002-20250907    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-13
s390                  randconfig-001-20250906    gcc-10.5.0
s390                  randconfig-001-20250907    gcc-12.5.0
s390                  randconfig-002-20250906    clang-22
s390                  randconfig-002-20250907    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-13
sh                          polaris_defconfig    gcc-15.1.0
sh                    randconfig-001-20250906    gcc-15.1.0
sh                    randconfig-001-20250907    gcc-12.5.0
sh                    randconfig-002-20250906    gcc-12.5.0
sh                    randconfig-002-20250907    gcc-12.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250906    gcc-8.5.0
sparc                 randconfig-001-20250907    gcc-12.5.0
sparc                 randconfig-002-20250906    gcc-13.4.0
sparc                 randconfig-002-20250907    gcc-12.5.0
sparc                       sparc64_defconfig    gcc-15.1.0
sparc64                             defconfig    gcc-13
sparc64               randconfig-001-20250906    clang-22
sparc64               randconfig-001-20250907    gcc-12.5.0
sparc64               randconfig-002-20250906    gcc-14.3.0
sparc64               randconfig-002-20250907    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-13
um                                  defconfig    gcc-13
um                             i386_defconfig    gcc-13
um                    randconfig-001-20250906    gcc-12
um                    randconfig-001-20250907    gcc-12.5.0
um                    randconfig-002-20250906    clang-22
um                    randconfig-002-20250907    gcc-12.5.0
um                           x86_64_defconfig    gcc-13
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250906    clang-20
x86_64      buildonly-randconfig-001-20250907    gcc-13
x86_64      buildonly-randconfig-002-20250906    gcc-13
x86_64      buildonly-randconfig-002-20250907    gcc-13
x86_64      buildonly-randconfig-003-20250906    gcc-13
x86_64      buildonly-randconfig-003-20250907    gcc-13
x86_64      buildonly-randconfig-004-20250906    clang-20
x86_64      buildonly-randconfig-004-20250907    gcc-13
x86_64      buildonly-randconfig-005-20250906    gcc-13
x86_64      buildonly-randconfig-005-20250907    gcc-13
x86_64      buildonly-randconfig-006-20250906    gcc-13
x86_64      buildonly-randconfig-006-20250907    gcc-13
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250907    clang-20
x86_64                randconfig-002-20250907    clang-20
x86_64                randconfig-003-20250907    clang-20
x86_64                randconfig-004-20250907    clang-20
x86_64                randconfig-005-20250907    clang-20
x86_64                randconfig-006-20250907    clang-20
x86_64                randconfig-007-20250907    clang-20
x86_64                randconfig-008-20250907    clang-20
x86_64                randconfig-071-20250907    gcc-13
x86_64                randconfig-072-20250907    gcc-13
x86_64                randconfig-073-20250907    gcc-13
x86_64                randconfig-074-20250907    gcc-13
x86_64                randconfig-075-20250907    gcc-13
x86_64                randconfig-076-20250907    gcc-13
x86_64                randconfig-077-20250907    gcc-13
x86_64                randconfig-078-20250907    gcc-13
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-13
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-13
x86_64                           rhel-9.4-ltp    gcc-13
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250906    gcc-12.5.0
xtensa                randconfig-001-20250907    gcc-12.5.0
xtensa                randconfig-002-20250906    gcc-10.5.0
xtensa                randconfig-002-20250907    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
