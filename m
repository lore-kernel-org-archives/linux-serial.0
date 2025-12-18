Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABA82DC793
	for <linux-serial@vger.kernel.org>; Thu, 18 Dec 2025 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766068033; cv=none; b=kvjRc/cY2/P2ozi0cjpsxtB8KjE0dvezELxTGzdBFZsAImdO9NVm/J/CW+gXn1soJpattMOFF+dsEP+Bf281S/ycXDYo8rBTotFwBXgrH3dswM4aNdCNb9RjzDH9sM3UcPVsHv7EcBIK3EZhgCpw+bO9QDYreFVKy8/gQhIRAaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766068033; c=relaxed/simple;
	bh=R9K+8vU1Y3Qheacl+3UCr4u+7ai34MMX5y2SSuIp2Cw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FHaBJ2D4maPZo5OBEsnEl8ZBz/DbxdBe5ppz+Rg6VMSPAuPM1wKlu6I1f55kbhDOEQl/GA00R3PCNaI/N35LSboIWCdJJiAMKm/NSZeWwKDCkC5jDPCz1QnVT6J6J3IN/v2J3H+mXTblDNPNGYcaYdI1KJReoEmUxhB2gAXTA7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MtPqmCdL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MtPqmCdL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766068030; x=1797604030;
  h=date:from:to:cc:subject:message-id;
  bh=R9K+8vU1Y3Qheacl+3UCr4u+7ai34MMX5y2SSuIp2Cw=;
  b=MtPqmCdLIT41lmxm1rMs0izMTPV/5nnJxCZCksLDjeqP6ESKnR4swCvs
   Y48oull/ld+w/ByTy7Fq5J0+p1TrB8hcm82RWdgOdz1xUpy/6L/Q4Xrax
   LzPvDRvxksV1pacbivmULcb6MvpVqp+ae9aGjgjkhec3tEIOw1P9DWWsT
   ImCGWIduXs2I2JxMEKeGvBrYIh+wu7XOMgIIyMzsrT9z4QPI77rtj4oma
   4XGtTgcIakVs0FE2snCQccvtVeEFwFUYiWDIpZhct3z7DuztvxpVd2K50
   kBpcRhuYtd4s4y492L77LC109Bp6IVMVfkYelNxDXQfoL6oI7mYWLichD
   w==;
X-CSE-ConnectionGUID: QCNt7vq8Q6aXNZrPkL0d1g==
X-CSE-MsgGUID: lGtsMlsURci6AqtssosIKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="79478995"
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="79478995"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 06:27:08 -0800
X-CSE-ConnectionGUID: KU+r585hT367bqupyrJ2pw==
X-CSE-MsgGUID: fo2C+GjOT4Gk4Y+3HnlmnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="199425934"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 18 Dec 2025 06:27:07 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWEy9-000000002BF-0feF;
	Thu, 18 Dec 2025 14:27:05 +0000
Date: Thu, 18 Dec 2025 22:26:09 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 284da5de616aaebf9c2c62e5fc7cb464a064eff7
Message-ID: <202512182255.eVuU32Qh-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 284da5de616aaebf9c2c62e5fc7cb464a064eff7  platform/surface: Migrate to serdev specific shutdown function

elapsed time: 1452m

configs tested: 183
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251218    clang-22
arc                   randconfig-002-20251218    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.1.0
arm                       imx_v6_v7_defconfig    gcc-15.1.0
arm                         lpc32xx_defconfig    clang-22
arm                         orion5x_defconfig    clang-22
arm                   randconfig-001-20251218    clang-22
arm                   randconfig-002-20251218    clang-22
arm                   randconfig-003-20251218    clang-22
arm                   randconfig-004-20251218    clang-22
arm                        spear3xx_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251218    gcc-14.3.0
arm64                 randconfig-002-20251218    gcc-14.3.0
arm64                 randconfig-003-20251218    gcc-14.3.0
arm64                 randconfig-004-20251218    gcc-14.3.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251218    gcc-14.3.0
csky                  randconfig-002-20251218    gcc-14.3.0
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251218    gcc-11.5.0
hexagon               randconfig-002-20251218    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251218    gcc-14
i386        buildonly-randconfig-002-20251218    gcc-14
i386        buildonly-randconfig-003-20251218    gcc-14
i386        buildonly-randconfig-004-20251218    gcc-14
i386        buildonly-randconfig-005-20251218    gcc-14
i386        buildonly-randconfig-006-20251218    gcc-14
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251218    gcc-12
i386                  randconfig-002-20251218    gcc-12
i386                  randconfig-003-20251218    gcc-12
i386                  randconfig-004-20251218    gcc-12
i386                  randconfig-005-20251218    gcc-12
i386                  randconfig-006-20251218    gcc-12
i386                  randconfig-007-20251218    gcc-12
i386                  randconfig-011-20251218    clang-20
i386                  randconfig-012-20251218    clang-20
i386                  randconfig-013-20251218    clang-20
i386                  randconfig-014-20251218    clang-20
i386                  randconfig-015-20251218    clang-20
i386                  randconfig-016-20251218    clang-20
i386                  randconfig-017-20251218    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251218    gcc-11.5.0
loongarch             randconfig-002-20251218    gcc-11.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                           sun3_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                          ath25_defconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251218    gcc-11.5.0
nios2                 randconfig-002-20251218    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
openrisc                  or1klitex_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251218    gcc-8.5.0
parisc                randconfig-002-20251218    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                     ppa8548_defconfig    clang-22
powerpc               randconfig-001-20251218    gcc-8.5.0
powerpc               randconfig-002-20251218    gcc-8.5.0
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251218    gcc-8.5.0
powerpc64             randconfig-002-20251218    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.1.0
riscv                    nommu_virt_defconfig    gcc-15.1.0
riscv                 randconfig-001-20251218    gcc-8.5.0
riscv                 randconfig-002-20251218    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251218    gcc-8.5.0
s390                  randconfig-002-20251218    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                        apsh4ad0a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                          r7780mp_defconfig    clang-22
sh                    randconfig-001-20251218    gcc-8.5.0
sh                    randconfig-002-20251218    gcc-8.5.0
sh                           se7750_defconfig    clang-22
sh                          urquell_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251218    gcc-15.1.0
sparc                 randconfig-002-20251218    gcc-15.1.0
sparc                       sparc32_defconfig    clang-22
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251218    gcc-15.1.0
sparc64               randconfig-002-20251218    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251218    gcc-15.1.0
um                    randconfig-002-20251218    gcc-15.1.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251218    gcc-14
x86_64      buildonly-randconfig-002-20251218    gcc-14
x86_64      buildonly-randconfig-003-20251218    gcc-14
x86_64      buildonly-randconfig-004-20251218    gcc-14
x86_64      buildonly-randconfig-005-20251218    gcc-14
x86_64      buildonly-randconfig-006-20251218    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251218    clang-20
x86_64                randconfig-002-20251218    clang-20
x86_64                randconfig-003-20251218    clang-20
x86_64                randconfig-004-20251218    clang-20
x86_64                randconfig-005-20251218    clang-20
x86_64                randconfig-006-20251218    clang-20
x86_64                randconfig-011-20251218    gcc-14
x86_64                randconfig-012-20251218    gcc-14
x86_64                randconfig-013-20251218    gcc-14
x86_64                randconfig-014-20251218    gcc-14
x86_64                randconfig-015-20251218    gcc-14
x86_64                randconfig-016-20251218    gcc-14
x86_64                randconfig-071-20251218    gcc-12
x86_64                randconfig-072-20251218    gcc-12
x86_64                randconfig-073-20251218    gcc-12
x86_64                randconfig-074-20251218    gcc-12
x86_64                randconfig-075-20251218    gcc-12
x86_64                randconfig-076-20251218    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251218    gcc-15.1.0
xtensa                randconfig-002-20251218    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
