Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3D515687D
	for <linux-serial@vger.kernel.org>; Thu, 23 Oct 2025 06:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199567; cv=none; b=hQBpd+RB5tMOXxff7aJmYUgkusWlEiejHFvkROgC7coR3tvoozXKCMT3OErp20dxpo4S2YEIUrzUzTHyR8UQ9QHY3ni/MZG+PH4xf7NYl7bphB6Pa+CCdlmxhjHvVtXWLTyeB634iKWm6XIEKtm1pTKqcsTpSmyaezipliwVI98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199567; c=relaxed/simple;
	bh=CvHdbCmO60l94P/4C4+3V8I4RZMyOc3XXq9IkvaRN1M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uQ0Qt2zyZl4LfcTcu/9RK+YvzaVmLxQQ42Tq8ilBg8ThLY5GCx7cnAEziW9PXtczWmKkuMxyBAT9dMYRaCTdmpeO8bBQgl5M6cLtnldkhAPckddUUtbHWDgMANZ/RMRvPW+WjUKVjcQ+3wlS2O9TQG4vQE1REYVZRzwbDqYG8PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aspBpmDe; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aspBpmDe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761199565; x=1792735565;
  h=date:from:to:cc:subject:message-id;
  bh=CvHdbCmO60l94P/4C4+3V8I4RZMyOc3XXq9IkvaRN1M=;
  b=aspBpmDeYFYFNJG/zfNzz2f0zR233QsSJTOiIH+NdMm/3u8smpFtBJur
   agNLaZ7lNn4RYubGRdSbzacq+XehzycBVKZ+s71fPEojhqNs00a3yCBft
   8edemkQms7uvXu9UkptcPjIV0X3dNvyclvwGMNj17A2MTqPJzXIrfFkHS
   yLrSNMuN9zDs7DK7fWY54nZ2QZ/AA5cWwW9r0h1WZ4EeTE3fjhhc6KEOE
   LfxCORVBc69eihpYe7mGeMc724pQ+G4hBWuhecWqeA56FilwMge8WRWis
   ZYqp8NN3YWwfG90mxmSX7sdwaVEHr0AMt7z6mYAIEphP2ZZCxPfI3blCU
   Q==;
X-CSE-ConnectionGUID: YpZ5vSoeS1inlYUgb8Qiug==
X-CSE-MsgGUID: J9gJliCIT6SlNHNbWft9dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63251983"
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="63251983"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 23:06:04 -0700
X-CSE-ConnectionGUID: gsl5eE4GSBeWnQNEK6kFtQ==
X-CSE-MsgGUID: dGDtWHIfRbCrpwiIYtBhMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="221260114"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 22 Oct 2025 23:06:03 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBoSW-000D5d-2U;
	Thu, 23 Oct 2025 06:06:00 +0000
Date: Thu, 23 Oct 2025 14:05:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 7553f5173ec3f01d7452a80ba82bef60d3ba29b7
Message-ID: <202510231410.SosoBRP9-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 7553f5173ec3f01d7452a80ba82bef60d3ba29b7  selftests/tty: add TIOCSTI test suite

elapsed time: 921m

configs tested: 218
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20251022    gcc-13.4.0
arc                   randconfig-001-20251023    gcc-8.5.0
arc                   randconfig-002-20251022    gcc-8.5.0
arc                   randconfig-002-20251023    gcc-8.5.0
arm                              alldefconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                          gemini_defconfig    gcc-15.1.0
arm                           h3600_defconfig    clang-22
arm                           h3600_defconfig    gcc-15.1.0
arm                        multi_v7_defconfig    gcc-15.1.0
arm                   randconfig-001-20251022    gcc-11.5.0
arm                   randconfig-001-20251023    gcc-8.5.0
arm                   randconfig-002-20251022    gcc-10.5.0
arm                   randconfig-002-20251023    gcc-8.5.0
arm                   randconfig-003-20251022    gcc-10.5.0
arm                   randconfig-003-20251023    gcc-8.5.0
arm                   randconfig-004-20251022    clang-22
arm                   randconfig-004-20251023    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251022    gcc-9.5.0
arm64                 randconfig-001-20251023    gcc-8.5.0
arm64                 randconfig-002-20251022    clang-18
arm64                 randconfig-002-20251023    gcc-8.5.0
arm64                 randconfig-003-20251022    gcc-10.5.0
arm64                 randconfig-003-20251023    gcc-8.5.0
arm64                 randconfig-004-20251022    gcc-12.5.0
arm64                 randconfig-004-20251023    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20251022    gcc-15.1.0
csky                  randconfig-001-20251023    gcc-10.5.0
csky                  randconfig-002-20251022    gcc-11.5.0
csky                  randconfig-002-20251023    gcc-10.5.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251022    clang-22
hexagon               randconfig-001-20251023    gcc-10.5.0
hexagon               randconfig-002-20251022    clang-22
hexagon               randconfig-002-20251023    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251022    clang-20
i386        buildonly-randconfig-001-20251023    clang-20
i386        buildonly-randconfig-002-20251022    clang-20
i386        buildonly-randconfig-002-20251023    clang-20
i386        buildonly-randconfig-003-20251022    gcc-14
i386        buildonly-randconfig-003-20251023    clang-20
i386        buildonly-randconfig-004-20251022    clang-20
i386        buildonly-randconfig-004-20251023    clang-20
i386        buildonly-randconfig-005-20251022    gcc-12
i386        buildonly-randconfig-005-20251023    clang-20
i386        buildonly-randconfig-006-20251022    gcc-14
i386        buildonly-randconfig-006-20251023    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251023    clang-20
i386                  randconfig-002-20251023    clang-20
i386                  randconfig-003-20251023    clang-20
i386                  randconfig-004-20251023    clang-20
i386                  randconfig-005-20251023    clang-20
i386                  randconfig-006-20251023    clang-20
i386                  randconfig-007-20251023    clang-20
i386                  randconfig-011-20251023    gcc-14
i386                  randconfig-012-20251023    gcc-14
i386                  randconfig-013-20251023    gcc-14
i386                  randconfig-014-20251023    gcc-14
i386                  randconfig-015-20251023    gcc-14
i386                  randconfig-016-20251023    gcc-14
i386                  randconfig-017-20251023    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251022    gcc-12.5.0
loongarch             randconfig-001-20251023    gcc-10.5.0
loongarch             randconfig-002-20251022    gcc-15.1.0
loongarch             randconfig-002-20251023    gcc-10.5.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                         amcore_defconfig    clang-22
m68k                                defconfig    clang-19
m68k                        stmark2_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq5_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251022    gcc-8.5.0
nios2                 randconfig-001-20251023    gcc-10.5.0
nios2                 randconfig-002-20251022    gcc-10.5.0
nios2                 randconfig-002-20251023    gcc-10.5.0
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251022    gcc-13.4.0
parisc                randconfig-001-20251023    gcc-10.5.0
parisc                randconfig-002-20251022    gcc-10.5.0
parisc                randconfig-002-20251023    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     asp8347_defconfig    clang-22
powerpc                     ep8248e_defconfig    clang-22
powerpc               randconfig-001-20251022    gcc-8.5.0
powerpc               randconfig-001-20251023    gcc-10.5.0
powerpc               randconfig-002-20251022    gcc-8.5.0
powerpc               randconfig-002-20251023    gcc-10.5.0
powerpc               randconfig-003-20251022    gcc-8.5.0
powerpc               randconfig-003-20251023    gcc-10.5.0
powerpc                 xes_mpc85xx_defconfig    clang-22
powerpc64             randconfig-001-20251022    gcc-8.5.0
powerpc64             randconfig-001-20251023    gcc-10.5.0
powerpc64             randconfig-002-20251022    gcc-8.5.0
powerpc64             randconfig-002-20251023    gcc-10.5.0
powerpc64             randconfig-003-20251022    clang-22
powerpc64             randconfig-003-20251023    gcc-10.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251023    gcc-8.5.0
riscv                 randconfig-002-20251023    gcc-8.5.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251023    gcc-8.5.0
s390                  randconfig-002-20251023    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                             espt_defconfig    gcc-15.1.0
sh                     magicpanelr2_defconfig    clang-22
sh                            migor_defconfig    clang-22
sh                    randconfig-001-20251023    gcc-8.5.0
sh                    randconfig-002-20251023    gcc-8.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251023    gcc-8.5.0
sparc                 randconfig-002-20251023    gcc-8.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251023    gcc-8.5.0
sparc64               randconfig-002-20251023    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251023    gcc-8.5.0
um                    randconfig-002-20251023    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251022    clang-20
x86_64      buildonly-randconfig-001-20251023    gcc-14
x86_64      buildonly-randconfig-002-20251022    gcc-14
x86_64      buildonly-randconfig-002-20251023    gcc-14
x86_64      buildonly-randconfig-003-20251022    gcc-14
x86_64      buildonly-randconfig-003-20251023    gcc-14
x86_64      buildonly-randconfig-004-20251022    clang-20
x86_64      buildonly-randconfig-004-20251023    gcc-14
x86_64      buildonly-randconfig-005-20251022    gcc-14
x86_64      buildonly-randconfig-005-20251023    gcc-14
x86_64      buildonly-randconfig-006-20251022    gcc-14
x86_64      buildonly-randconfig-006-20251023    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251023    clang-20
x86_64                randconfig-002-20251023    clang-20
x86_64                randconfig-003-20251023    clang-20
x86_64                randconfig-004-20251023    clang-20
x86_64                randconfig-005-20251023    clang-20
x86_64                randconfig-006-20251023    clang-20
x86_64                randconfig-007-20251023    clang-20
x86_64                randconfig-008-20251023    clang-20
x86_64                randconfig-071-20251023    clang-20
x86_64                randconfig-072-20251023    clang-20
x86_64                randconfig-073-20251023    clang-20
x86_64                randconfig-074-20251023    clang-20
x86_64                randconfig-075-20251023    clang-20
x86_64                randconfig-076-20251023    clang-20
x86_64                randconfig-077-20251023    clang-20
x86_64                randconfig-078-20251023    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    clang-22
xtensa                randconfig-001-20251023    gcc-8.5.0
xtensa                randconfig-002-20251023    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
