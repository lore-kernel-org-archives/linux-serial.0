Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB593A381D
	for <linux-serial@vger.kernel.org>; Wed,  3 Jun 2026 08:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474213; cv=none; b=Erp1DWpgNg/GDwFkPn7nyMmv1y8ax/0Y5ZGmdECBljzPeCMHOfDpqe8AzRU6qUzsZpaoxCGScDS1Ac9lTI+L+Qy6vH9kw/xTMMNLvyBDvBLChNGvwyLWiBLnQ+TWedemsF87bCEmCIk0oD4hvjwsW4Az+yV0xYKILf3FfXQh0Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474213; c=relaxed/simple;
	bh=bSWSf28WbiFOFj7OCZhHi5JIwP/IDE4GY9BnnVt5hU0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=P0dOClq1oGdDy7TAQuhMdOyaJHEM4QKhGuNDNxoXKY9vD6WEnBuPIyLjtrnldl1hmPV/NJ1LG9yCkVj7/NIDvNyujZmT4HVtZ3g0PWQev3XhDEMFwdLZePOjS0thCGfCPU6vM5WRsrYIW4TgLzphaEbE4v8+qIqFqbD/SkdUyTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJclyig/; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJclyig/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780474211; x=1812010211;
  h=date:from:to:cc:subject:message-id;
  bh=bSWSf28WbiFOFj7OCZhHi5JIwP/IDE4GY9BnnVt5hU0=;
  b=SJclyig/TbZ/Gh0a7FhWSka1gQ6ttxuxojwHZoBNpJQHrSaXyTVGEy3v
   6oPbbKjBFv7Jtiap+EBFN+HUumuf0cizspBzN9lpz4HGo9NVuaFpjgOSM
   hDRjZcOQAv/JJGdEGATcVI1+auiPFVJ1RKxTQA8XEI6iLMi7Y80nOlP0H
   y8PUbNsZ0f5XWNMlHLv5nl1N4mDACwtLBhsxnx4IJkYwTIFzJ6EZvrqW+
   3amYpF2XiECtiRzKXexQd5iFc0z02QT21LpHjz3V58RYe8ATTT8ZVJLi5
   t6q0ieliBW3Tw490mx2Y6C3mWQ5gm68a5Xz9lmglywLtaRFCWfbhXepDj
   g==;
X-CSE-ConnectionGUID: TA0EZOkSRjKO+Fx8iidtGQ==
X-CSE-MsgGUID: qEH/JJrySL++IvWPV/5AqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81455256"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81455256"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 01:10:11 -0700
X-CSE-ConnectionGUID: YANhzu4hSj67RJwyXE7MDQ==
X-CSE-MsgGUID: ytQ1ncNsT7CyiF9pZkCDiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="243302008"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 03 Jun 2026 01:10:10 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wUgfv-00000000D84-18Np;
	Wed, 03 Jun 2026 08:10:07 +0000
Date: Wed, 03 Jun 2026 16:09:06 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 b586d69177b5fc92450a5f37a3bb1ce50aa87e39
Message-ID: <202606031655.eBW2EQvS-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: b586d69177b5fc92450a5f37a3bb1ce50aa87e39  Merge tag 'v7.1-rc6' into tty-next

elapsed time: 2056m

configs tested: 208
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260602    gcc-11.5.0
arc                   randconfig-002-20260602    gcc-14.3.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260602    gcc-11.5.0
arm                   randconfig-002-20260602    gcc-8.5.0
arm                   randconfig-003-20260602    gcc-10.5.0
arm                   randconfig-004-20260602    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    gcc-8.5.0
arm64                 randconfig-001-20260602    gcc-14.3.0
arm64                          randconfig-002    gcc-14.3.0
arm64                 randconfig-002-20260602    gcc-15.2.0
arm64                          randconfig-003    clang-23
arm64                 randconfig-003-20260602    clang-23
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260602    clang-23
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    gcc-10.5.0
csky                  randconfig-001-20260602    gcc-12.5.0
csky                           randconfig-002    gcc-10.5.0
csky                  randconfig-002-20260602    gcc-14.3.0
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon                        randconfig-001    clang-17
hexagon               randconfig-001-20260602    clang-23
hexagon                        randconfig-002    clang-23
hexagon               randconfig-002-20260602    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20260602    clang-20
i386                 buildonly-randconfig-002    clang-20
i386        buildonly-randconfig-002-20260602    gcc-13
i386                 buildonly-randconfig-003    clang-20
i386        buildonly-randconfig-003-20260602    clang-20
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20260602    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20260602    clang-20
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20260602    clang-20
i386                                defconfig    clang-20
i386                           randconfig-001    clang-20
i386                  randconfig-001-20260602    clang-20
i386                  randconfig-001-20260603    gcc-14
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260602    clang-20
i386                  randconfig-002-20260603    gcc-14
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260603    gcc-14
i386                           randconfig-004    clang-20
i386                  randconfig-004-20260602    clang-20
i386                  randconfig-004-20260603    gcc-14
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260602    clang-20
i386                  randconfig-005-20260603    clang-20
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260602    clang-20
i386                  randconfig-006-20260603    gcc-12
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260602    gcc-14
i386                  randconfig-007-20260603    clang-20
i386                  randconfig-011-20260602    gcc-14
i386                  randconfig-012-20260602    clang-20
i386                  randconfig-013-20260602    clang-20
i386                  randconfig-014-20260602    gcc-14
i386                  randconfig-015-20260602    gcc-14
i386                  randconfig-016-20260602    clang-20
i386                  randconfig-017-20260602    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    clang-18
loongarch             randconfig-001-20260602    clang-23
loongarch                      randconfig-002    gcc-13.4.0
loongarch             randconfig-002-20260602    gcc-16.1.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260602    gcc-8.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260602    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260602    gcc-12.5.0
parisc                         randconfig-002    gcc-8.5.0
parisc                randconfig-002-20260602    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      arches_defconfig    gcc-15.2.0
powerpc                        randconfig-001    gcc-13.4.0
powerpc               randconfig-001-20260602    clang-23
powerpc                        randconfig-002    gcc-10.5.0
powerpc               randconfig-002-20260602    gcc-8.5.0
powerpc64                      randconfig-001    clang-17
powerpc64             randconfig-001-20260602    clang-23
powerpc64                      randconfig-002    clang-23
powerpc64             randconfig-002-20260602    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260602    gcc-13.4.0
riscv                 randconfig-002-20260602    clang-23
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260602    gcc-10.5.0
s390                  randconfig-002-20260602    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260602    gcc-11.5.0
sh                    randconfig-002-20260602    gcc-16.1.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260602    gcc-12.5.0
sparc                 randconfig-001-20260603    gcc-8.5.0
sparc                 randconfig-002-20260602    gcc-12.5.0
sparc                 randconfig-002-20260603    gcc-16.1.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260602    gcc-8.5.0
sparc64               randconfig-001-20260603    clang-23
sparc64               randconfig-002-20260602    clang-20
sparc64               randconfig-002-20260603    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260602    gcc-14
um                    randconfig-001-20260603    gcc-14
um                    randconfig-002-20260602    clang-23
um                    randconfig-002-20260603    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260602    gcc-14
x86_64      buildonly-randconfig-002-20260602    clang-20
x86_64      buildonly-randconfig-003-20260602    gcc-14
x86_64      buildonly-randconfig-004-20260602    clang-20
x86_64      buildonly-randconfig-005-20260602    gcc-14
x86_64      buildonly-randconfig-006-20260602    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260602    clang-20
x86_64                randconfig-002-20260602    clang-20
x86_64                randconfig-003-20260602    gcc-12
x86_64                randconfig-004-20260602    gcc-14
x86_64                randconfig-005-20260602    clang-20
x86_64                randconfig-006-20260602    clang-20
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260602    clang-20
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260602    clang-20
x86_64                         randconfig-013    clang-20
x86_64                randconfig-013-20260602    clang-20
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260602    gcc-13
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260602    clang-20
x86_64                         randconfig-016    clang-20
x86_64                randconfig-016-20260602    clang-20
x86_64                randconfig-071-20260602    clang-20
x86_64                randconfig-072-20260602    clang-20
x86_64                randconfig-073-20260602    gcc-14
x86_64                randconfig-074-20260602    gcc-14
x86_64                randconfig-075-20260602    clang-20
x86_64                randconfig-076-20260602    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260603    gcc-9.5.0
xtensa                randconfig-002-20260602    gcc-14.3.0
xtensa                randconfig-002-20260603    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
