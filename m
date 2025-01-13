Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA6A1CD1ED
	for <linux-serial@vger.kernel.org>; Mon, 13 Jan 2025 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794828; cv=none; b=V3Tnes6s8ybyoHOOs7WEJMc/go70MPnyn52qey6xhIUDRaofNf5CZidrEGNls6Z3TBFxINJ8YacTzOjq5csnJUA8GTDZGkn+EzpH4wQg5+UYmG/wNNICXzRjOIDuFnddnUQgNtgKBNRq1FSdEGC8ygMtyjGtQp4sN1yk84Naov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794828; c=relaxed/simple;
	bh=DfHzog66Y82Z2JPCYIQBVaAsGOFaqVKzuOPuX0aSpZM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TufyQtHxQySnqJyrfku6qD0FHl7l8glHNxoR0I8oMeHADPV4E8uHPDMN4DT/fZ5xyPJJIYfIh1Hcs4nDAxgXaYYVg3IjAQOV6KEM+GMcPvvAXvK4wAo1NV8NXVMd1F760B1n2JrbmQ0aWkDWcWCUYwWMAlFz8vmZUkiYaQY/gto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oISaHClF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oISaHClF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736794819; x=1768330819;
  h=date:from:to:cc:subject:message-id;
  bh=DfHzog66Y82Z2JPCYIQBVaAsGOFaqVKzuOPuX0aSpZM=;
  b=oISaHClFzi5vvtMDpDQnuCp5Bid+zosemLbxzTvCTIqGN4LsJtu4Oie9
   L5VljvF0MSIM13uWWRtskiOaII7lewl4i+i/cogZNlIdqVAekNhXf088I
   yCPTEpx8W2ukqfPWy8f0hv4igiZjMY0iCI+4fPhs1mzXy/AsO7d1j3YcM
   DBbINFCaEl6HgaTQAJU4S93olYa2EDP0mg4nLMBu+cPappx0RdixNGCI2
   SvdKgPF5h1VgcyZgRcmdImAWiT8ltJZIQec27C/N2Rp+jrqG+wWhMJaoM
   J8p4kRcW99bWoFfiekPFfY8YKb7baGIh5c4QiFL2eWbDdU8LBITPfVXYE
   w==;
X-CSE-ConnectionGUID: Yy75ADhqRhGqYYEg7+ZRwA==
X-CSE-MsgGUID: NRR7abLwSoic5sxn4GkN8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="59558488"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="59558488"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 11:00:19 -0800
X-CSE-ConnectionGUID: YK1nHPxuTOypHHMzvsTUIA==
X-CSE-MsgGUID: /VnAEmaESH+pO/9s7o1IaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="109548676"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 13 Jan 2025 11:00:18 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tXPfb-000NZ3-1J;
	Mon, 13 Jan 2025 19:00:15 +0000
Date: Tue, 14 Jan 2025 02:59:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 2f83e38a095f8bf7c6029883d894668b03b9bd93
Message-ID: <202501140237.jetrs5Wp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 2f83e38a095f8bf7c6029883d894668b03b9bd93  tty: Permit some TIOCL_SETSEL modes without CAP_SYS_ADMIN

elapsed time: 724m

configs tested: 131
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250113    gcc-13.2.0
arc                   randconfig-002-20250113    gcc-13.2.0
arm                              alldefconfig    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                     am200epdkit_defconfig    gcc-14.2.0
arm                        clps711x_defconfig    clang-19
arm                          exynos_defconfig    clang-20
arm                            hisi_defconfig    gcc-14.2.0
arm                        multi_v5_defconfig    gcc-14.2.0
arm                   randconfig-001-20250113    gcc-14.2.0
arm                   randconfig-002-20250113    gcc-14.2.0
arm                   randconfig-003-20250113    gcc-14.2.0
arm                   randconfig-004-20250113    clang-20
arm                       spear13xx_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250113    gcc-14.2.0
arm64                 randconfig-002-20250113    clang-18
arm64                 randconfig-003-20250113    clang-20
arm64                 randconfig-004-20250113    clang-20
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250113    gcc-14.2.0
csky                  randconfig-002-20250113    gcc-14.2.0
hexagon                          alldefconfig    clang-15
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250113    clang-20
hexagon               randconfig-002-20250113    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250113    clang-19
i386        buildonly-randconfig-002-20250113    gcc-12
i386        buildonly-randconfig-003-20250113    clang-19
i386        buildonly-randconfig-004-20250113    clang-19
i386        buildonly-randconfig-005-20250113    clang-19
i386        buildonly-randconfig-006-20250113    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250113    gcc-14.2.0
loongarch             randconfig-002-20250113    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          rb532_defconfig    clang-17
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250113    gcc-14.2.0
nios2                 randconfig-002-20250113    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250113    gcc-14.2.0
parisc                randconfig-002-20250113    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      cm5200_defconfig    clang-20
powerpc                 mpc8315_rdb_defconfig    clang-20
powerpc                 mpc837x_rdb_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250113    clang-18
powerpc               randconfig-002-20250113    gcc-14.2.0
powerpc               randconfig-003-20250113    clang-20
powerpc                  storcenter_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250113    clang-20
powerpc64             randconfig-002-20250113    gcc-14.2.0
powerpc64             randconfig-003-20250113    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250113    gcc-14.2.0
riscv                 randconfig-002-20250113    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250113    gcc-14.2.0
s390                  randconfig-002-20250113    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                    randconfig-001-20250113    gcc-14.2.0
sh                    randconfig-002-20250113    gcc-14.2.0
sh                          rsk7203_defconfig    gcc-14.2.0
sh                           se7206_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250113    gcc-14.2.0
sparc                 randconfig-002-20250113    gcc-14.2.0
sparc64               randconfig-001-20250113    gcc-14.2.0
sparc64               randconfig-002-20250113    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250113    gcc-12
um                    randconfig-002-20250113    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250113    gcc-12
x86_64      buildonly-randconfig-002-20250113    gcc-12
x86_64      buildonly-randconfig-003-20250113    gcc-12
x86_64      buildonly-randconfig-004-20250113    gcc-12
x86_64      buildonly-randconfig-005-20250113    clang-19
x86_64      buildonly-randconfig-006-20250113    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250113    gcc-14.2.0
xtensa                randconfig-002-20250113    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
