Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B634DDC5
	for <linux-serial@vger.kernel.org>; Tue, 24 Dec 2024 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735042678; cv=none; b=BIyWw5amMQUi4gat86VTlf/u6J7UzCUnVdSLMnGN3BFK6NCsg7VicM9ZMHGp6O9WtJBilB6sWrgQGIfFeAPddxW9Ar2HBYiQMaxNbHOGjdw/DMRwdnR9nIwA4ks1uugJJPwrtwNbaOZ8EC143dA490PXyBTGGLAHejuZu3zHrYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735042678; c=relaxed/simple;
	bh=xlvT3IKDmVeLGSJpHWJC5iVp5YnTzQ0m4CLCSDy+9JU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UmhdOOermXUTwJivTgn37pJ/m2XhhjSkjYuZzQObmAO53QiY1qmpAxyo70mte8wGSeqvxTy+JdqxqyxYELKRHpT4GIENcbRFyKGgur1iC7jmLn2Zx3txLKK6iHfdPRIBHp1egmb1croVgpNO/ZK3irF+0jK0k7+TzdeJwzVuVZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RsDuisMM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RsDuisMM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735042677; x=1766578677;
  h=date:from:to:cc:subject:message-id;
  bh=xlvT3IKDmVeLGSJpHWJC5iVp5YnTzQ0m4CLCSDy+9JU=;
  b=RsDuisMMQauNn0pAE0Qfyj8qPwM7NgCDWFuqgFgxqkgCMAAeNsbMarts
   6wGaBvO+O7bcwQZYJnTjuzF1kdHX2eQdlE1kTbExxJDKMPiTCFiHIsky2
   wjG7QHx7sSy1IXFStWuT2GfDrpDsW4pPH3lzd62dOwFUzEvjtjHvWS3Xa
   QVBYPk4T/f4to+CZdaj68t8J8yyM3DzcMz88PXyDFMbN1wHaSujnxsnJw
   wAAXKTARRk3hr5ewdmif7gtjtTH9tzhUzq0dNIDG7+mbZITUKMr1Y+nnd
   t+HcpMgEy3cSo/q0cdWIVv+ZRB0OYHUiRYY4AMApz6/e5eG7crIc7R60C
   A==;
X-CSE-ConnectionGUID: g6ev7TvGSK2YFagH/z2Mzw==
X-CSE-MsgGUID: EGbUo2cVSIC5vs272jB19g==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35223865"
X-IronPort-AV: E=Sophos;i="6.12,260,1728975600"; 
   d="scan'208";a="35223865"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 04:17:56 -0800
X-CSE-ConnectionGUID: VXXtW9NcSjyn3CsWGfrbWw==
X-CSE-MsgGUID: gjGn21ERS+yR+2EQk0lISg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,260,1728975600"; 
   d="scan'208";a="104327937"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 24 Dec 2024 04:17:54 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tQ3rE-00016B-18;
	Tue, 24 Dec 2024 12:17:52 +0000
Date: Tue, 24 Dec 2024 20:17:13 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 2c1fd53af21b8cb13878b054894d33d3383eb1f3
Message-ID: <202412242004.qgkhz5od-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 2c1fd53af21b8cb13878b054894d33d3383eb1f3  serial: amba-pl011: Fix RTS handling in RS485 mode

elapsed time: 1050m

configs tested: 183
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241224    gcc-13.2.0
arc                   randconfig-002-20241224    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                            mps2_defconfig    clang-15
arm                        mvebu_v7_defconfig    gcc-14.2.0
arm                   randconfig-001-20241224    gcc-14.2.0
arm                   randconfig-002-20241224    gcc-14.2.0
arm                   randconfig-003-20241224    clang-19
arm                   randconfig-004-20241224    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241224    gcc-14.2.0
arm64                 randconfig-002-20241224    clang-20
arm64                 randconfig-003-20241224    gcc-14.2.0
arm64                 randconfig-004-20241224    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241224    gcc-14.2.0
csky                  randconfig-002-20241224    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241224    clang-20
hexagon               randconfig-002-20241224    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241224    clang-19
i386        buildonly-randconfig-002-20241224    gcc-12
i386        buildonly-randconfig-003-20241224    clang-19
i386        buildonly-randconfig-004-20241224    clang-19
i386        buildonly-randconfig-005-20241224    clang-19
i386        buildonly-randconfig-006-20241224    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241224    clang-19
i386                  randconfig-002-20241224    clang-19
i386                  randconfig-003-20241224    clang-19
i386                  randconfig-004-20241224    clang-19
i386                  randconfig-005-20241224    clang-19
i386                  randconfig-006-20241224    clang-19
i386                  randconfig-007-20241224    clang-19
i386                  randconfig-011-20241224    gcc-12
i386                  randconfig-012-20241224    gcc-12
i386                  randconfig-013-20241224    gcc-12
i386                  randconfig-014-20241224    gcc-12
i386                  randconfig-015-20241224    gcc-12
i386                  randconfig-016-20241224    gcc-12
i386                  randconfig-017-20241224    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241224    gcc-14.2.0
loongarch             randconfig-002-20241224    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         apollo_defconfig    gcc-14.2.0
m68k                        mvme147_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           jazz_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241224    gcc-14.2.0
nios2                 randconfig-002-20241224    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20241224    gcc-14.2.0
parisc                randconfig-002-20241224    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     kmeter1_defconfig    gcc-14.2.0
powerpc                      ppc64e_defconfig    clang-15
powerpc               randconfig-001-20241224    clang-15
powerpc               randconfig-002-20241224    clang-20
powerpc               randconfig-003-20241224    gcc-14.2.0
powerpc64             randconfig-001-20241224    clang-20
powerpc64             randconfig-002-20241224    clang-20
powerpc64             randconfig-003-20241224    clang-20
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                 randconfig-001-20241224    clang-17
riscv                 randconfig-001-20241224    gcc-12
riscv                 randconfig-002-20241224    gcc-12
riscv                 randconfig-002-20241224    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241224    gcc-12
s390                  randconfig-001-20241224    gcc-14.2.0
s390                  randconfig-002-20241224    gcc-12
s390                  randconfig-002-20241224    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                          polaris_defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    gcc-14.2.0
sh                    randconfig-001-20241224    gcc-12
sh                    randconfig-001-20241224    gcc-14.2.0
sh                    randconfig-002-20241224    gcc-12
sh                    randconfig-002-20241224    gcc-14.2.0
sh                           se7705_defconfig    clang-15
sh                        sh7785lcr_defconfig    clang-15
sh                          urquell_defconfig    clang-15
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241224    gcc-12
sparc                 randconfig-001-20241224    gcc-14.2.0
sparc                 randconfig-002-20241224    gcc-12
sparc                 randconfig-002-20241224    gcc-14.2.0
sparc64                          alldefconfig    clang-15
sparc64               randconfig-001-20241224    gcc-12
sparc64               randconfig-001-20241224    gcc-14.2.0
sparc64               randconfig-002-20241224    gcc-12
sparc64               randconfig-002-20241224    gcc-14.2.0
um                               alldefconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                    randconfig-001-20241224    gcc-12
um                    randconfig-002-20241224    clang-15
um                    randconfig-002-20241224    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241224    clang-19
x86_64      buildonly-randconfig-002-20241224    gcc-12
x86_64      buildonly-randconfig-003-20241224    gcc-12
x86_64      buildonly-randconfig-004-20241224    clang-19
x86_64      buildonly-randconfig-005-20241224    gcc-11
x86_64      buildonly-randconfig-006-20241224    gcc-11
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241224    clang-19
x86_64                randconfig-002-20241224    clang-19
x86_64                randconfig-003-20241224    clang-19
x86_64                randconfig-004-20241224    clang-19
x86_64                randconfig-005-20241224    clang-19
x86_64                randconfig-006-20241224    clang-19
x86_64                randconfig-007-20241224    clang-19
x86_64                randconfig-008-20241224    clang-19
x86_64                randconfig-071-20241224    clang-19
x86_64                randconfig-072-20241224    clang-19
x86_64                randconfig-073-20241224    clang-19
x86_64                randconfig-074-20241224    clang-19
x86_64                randconfig-075-20241224    clang-19
x86_64                randconfig-076-20241224    clang-19
x86_64                randconfig-077-20241224    clang-19
x86_64                randconfig-078-20241224    clang-19
x86_64                               rhel-9.4    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                          iss_defconfig    clang-15
xtensa                randconfig-001-20241224    gcc-12
xtensa                randconfig-001-20241224    gcc-14.2.0
xtensa                randconfig-002-20241224    gcc-12
xtensa                randconfig-002-20241224    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
