Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6474D1BC20
	for <linux-serial@vger.kernel.org>; Tue, 24 Dec 2024 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735050270; cv=none; b=QZVwMtou3F8LIonSye6YpBsixsqoDOvp+DpvWtx5H3obQvMvm+6mFUThaxfg6Jq58aGx6ItgXAKE4/TxPly8IyDC70aHxSCjjOB4VxAVvM/cdQaKo07ptMK7sfZvMrPVkSL1hGkJB6RzzusMLwCbBq8YVoI/NyIQvwl/y4lU0w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735050270; c=relaxed/simple;
	bh=8QsUXHI4avNiE/7V2zRrCzQZEtVzo8vNNF6lRsZM5uo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qOSkZ01j6dJanFMRcZplqN0fClPdw/EwaXj6RRWcqYTCuaUco1RRDN4E2pCAHjiz72ldAoJ+xD2P1H6dnQ89EZMw4nltnvmrlCbgIuv0mVGgOXbbBHNKmW+0xvLcwNxZ7vFqioIqZ9slgOxCI+JCNLmdD8H4A9wUz98i8T8Ygjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExztebzQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExztebzQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735050268; x=1766586268;
  h=date:from:to:cc:subject:message-id;
  bh=8QsUXHI4avNiE/7V2zRrCzQZEtVzo8vNNF6lRsZM5uo=;
  b=ExztebzQrxiC8Ln8Ux9rKTCuqsRWWLM0KzmFWz2qeRL2HRZKOs7q7Iho
   1jrtFKNAkMUgAYdTL3jEvCSNvnLQgZ+9Kp9w9LFICNaJjSr3somIl334i
   AwYI2H6ROCTFmMM372mL8iuVWwip5zejTp807ZLF4LMGqxbQFGnq03z7W
   0dtv1QZdR+Thvl2/+Msj4sgfYhehXGD1wyJuxYMjaCaIDI1TFsrcR/1Nw
   vpLomg/SkzoeD9hqmnt65VjX2knKDOzbVorqQwvjM8vc1ugjcTqL+V+7K
   439qCmi9s+bJjEWEww1Lh8ACazxDHdQR50V+RiLN6ngYFvPUpHu0mvTF0
   g==;
X-CSE-ConnectionGUID: ayNgGhH1S6S1S1cdOkHwow==
X-CSE-MsgGUID: yIc6UmmZRjKGpl4ThX1kjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="53052536"
X-IronPort-AV: E=Sophos;i="6.12,260,1728975600"; 
   d="scan'208";a="53052536"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 06:24:28 -0800
X-CSE-ConnectionGUID: 7o5T2dWLRaWSRAxzIyf6EQ==
X-CSE-MsgGUID: 89QGONz1Q3y6SrEHiGjcNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,260,1728975600"; 
   d="scan'208";a="99356265"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 24 Dec 2024 06:24:27 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tQ5pg-0001Cx-0z;
	Tue, 24 Dec 2024 14:24:24 +0000
Date: Tue, 24 Dec 2024 22:23:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 0cfc36ea51684b5932cd3951ded523777d807af2
Message-ID: <202412242236.Icekt9t6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 0cfc36ea51684b5932cd3951ded523777d807af2  serial: stm32: use port lock wrappers for break control

elapsed time: 1177m

configs tested: 187
configs skipped: 10

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
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241224    gcc-14.2.0
parisc                randconfig-002-20241224    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                     kmeter1_defconfig    gcc-14.2.0
powerpc                      ppc64e_defconfig    clang-15
powerpc               randconfig-001-20241224    clang-15
powerpc               randconfig-002-20241224    clang-20
powerpc               randconfig-003-20241224    gcc-14.2.0
powerpc64             randconfig-001-20241224    clang-20
powerpc64             randconfig-002-20241224    clang-20
powerpc64             randconfig-003-20241224    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241224    gcc-12
riscv                 randconfig-002-20241224    gcc-12
riscv                 randconfig-002-20241224    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241224    gcc-12
s390                  randconfig-001-20241224    gcc-14.2.0
s390                  randconfig-002-20241224    gcc-12
s390                  randconfig-002-20241224    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
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
sparc64                             defconfig    gcc-12
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
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241224    gcc-12
um                    randconfig-002-20241224    gcc-12
um                           x86_64_defconfig    gcc-12
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
