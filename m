Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1D64C90
	for <linux-serial@vger.kernel.org>; Thu, 18 Apr 2024 22:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713479891; cv=none; b=M2Wc+7F7lG5SFOdjH+ICO3PERgIEvdGF+YhAcX+Hnn7b7Puuc6SHAq1AFUm3q+oDaT0bG58XBr+nelYzutg8zSeAIJQJJrFPsM96U34wQBYB/WSLO0LLtGOlVpPsOLueIug+4W68M7Lgbz3HkR3CDUaZNIOK0AP581AekgJ/uYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713479891; c=relaxed/simple;
	bh=3YCco2eb6yZxjRa5lrvsMfHFXUqe3/PjoQxBqnBETFQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rir3r+uJ5OpRsjiEHu3G+3JciR8T1PRwZlnbVYiyrLB4W1zHGBTLO3VZgYxTh+PHlvvWciZOgVVvKx5Rk4YdxY3uiVerX5IhdRR4SpZxKIsQyg/lXrKTbXCXj0Q6d0HtygkHQXJdBJTBA1XpuhX93BvdawwzAwaRk4Bk/+tFM7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xeq+rxHZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xeq+rxHZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713479889; x=1745015889;
  h=date:from:to:cc:subject:message-id;
  bh=3YCco2eb6yZxjRa5lrvsMfHFXUqe3/PjoQxBqnBETFQ=;
  b=Xeq+rxHZCf8UYHCwDhhb4i6ZKwFWZm95nOgTyPp0DgebsUGdNO6q6X5C
   mVRSANa5okpT9c44NXQXAAZehThlUhZsnUgVWY5FkjfkHJR0eTahCV80e
   Lsj/Jq3ibQ7nahCAKdDKQagkuV+EWEhNUYlPg2bFBpQW6gZjD+DT9xa7g
   vM3vykQnlAuw7q1edmhL1eh+DZVtP4xEpWC6fvUzGP3Y51nY+52dS+/99
   EZR3Sb0PknjFN1V/AeF2F74ChCH0TkPymBoQHAxAqM50qbU0V6YwATwHE
   r7gmgGvvA4lCZiQpWSqoZJV3EqaIJh2WgDZ6MYwVV2QB6/InFSaYtFJvK
   Q==;
X-CSE-ConnectionGUID: LcJ1EB3ISrGEr7wPRcFnqQ==
X-CSE-MsgGUID: PKGohwANTcCafSwIU+k5GA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="31541134"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="31541134"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 15:38:09 -0700
X-CSE-ConnectionGUID: qRYeWP43RyOWrA+3S7C60Q==
X-CSE-MsgGUID: iuBZALr+TwilpBnlGUiC6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23750735"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 18 Apr 2024 15:38:08 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxaOL-0009Iy-1j;
	Thu, 18 Apr 2024 22:38:05 +0000
Date: Fri, 19 Apr 2024 06:37:56 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 c6795fbffc4547b40933ec368200bd4926a41b44
Message-ID: <202404190654.vm14qunU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: c6795fbffc4547b40933ec368200bd4926a41b44  serial: exar: fix checkpach warnings

elapsed time: 953m

configs tested: 180
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240418   gcc  
arc                   randconfig-002-20240418   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          ep93xx_defconfig   clang
arm                      footbridge_defconfig   clang
arm                             mxs_defconfig   clang
arm                   randconfig-001-20240418   gcc  
arm                   randconfig-002-20240418   gcc  
arm                   randconfig-003-20240418   gcc  
arm                   randconfig-004-20240418   gcc  
arm                        realview_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240418   clang
arm64                 randconfig-002-20240418   gcc  
arm64                 randconfig-003-20240418   gcc  
arm64                 randconfig-004-20240418   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240418   gcc  
csky                  randconfig-002-20240418   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240418   clang
hexagon               randconfig-002-20240418   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240418   gcc  
i386         buildonly-randconfig-001-20240419   clang
i386         buildonly-randconfig-002-20240418   gcc  
i386         buildonly-randconfig-003-20240418   clang
i386         buildonly-randconfig-004-20240418   gcc  
i386         buildonly-randconfig-005-20240418   clang
i386         buildonly-randconfig-006-20240418   clang
i386                                defconfig   clang
i386                  randconfig-001-20240418   gcc  
i386                  randconfig-001-20240419   clang
i386                  randconfig-002-20240418   gcc  
i386                  randconfig-002-20240419   clang
i386                  randconfig-003-20240418   clang
i386                  randconfig-003-20240419   clang
i386                  randconfig-004-20240418   gcc  
i386                  randconfig-005-20240418   gcc  
i386                  randconfig-005-20240419   clang
i386                  randconfig-006-20240418   gcc  
i386                  randconfig-006-20240419   clang
i386                  randconfig-011-20240418   clang
i386                  randconfig-012-20240418   clang
i386                  randconfig-012-20240419   clang
i386                  randconfig-013-20240418   gcc  
i386                  randconfig-014-20240418   gcc  
i386                  randconfig-014-20240419   clang
i386                  randconfig-015-20240418   gcc  
i386                  randconfig-016-20240418   clang
i386                  randconfig-016-20240419   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240418   gcc  
loongarch             randconfig-002-20240418   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240418   gcc  
nios2                 randconfig-002-20240418   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240418   gcc  
parisc                randconfig-002-20240418   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      cm5200_defconfig   clang
powerpc                      makalu_defconfig   clang
powerpc                     mpc512x_defconfig   clang
powerpc                      pmac32_defconfig   clang
powerpc               randconfig-001-20240418   gcc  
powerpc               randconfig-002-20240418   clang
powerpc               randconfig-003-20240418   gcc  
powerpc64             randconfig-001-20240418   gcc  
powerpc64             randconfig-002-20240418   gcc  
powerpc64             randconfig-003-20240418   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240418   gcc  
riscv                 randconfig-002-20240418   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240418   clang
s390                  randconfig-002-20240418   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240418   gcc  
sh                    randconfig-002-20240418   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240418   gcc  
sparc64               randconfig-002-20240418   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240418   gcc  
um                    randconfig-002-20240418   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240418   clang
x86_64       buildonly-randconfig-002-20240418   clang
x86_64       buildonly-randconfig-003-20240418   clang
x86_64       buildonly-randconfig-004-20240418   clang
x86_64       buildonly-randconfig-005-20240418   gcc  
x86_64       buildonly-randconfig-006-20240418   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240418   gcc  
x86_64                randconfig-002-20240418   clang
x86_64                randconfig-003-20240418   gcc  
x86_64                randconfig-004-20240418   clang
x86_64                randconfig-005-20240418   gcc  
x86_64                randconfig-006-20240418   gcc  
x86_64                randconfig-011-20240418   clang
x86_64                randconfig-012-20240418   gcc  
x86_64                randconfig-013-20240418   clang
x86_64                randconfig-014-20240418   gcc  
x86_64                randconfig-015-20240418   gcc  
x86_64                randconfig-016-20240418   gcc  
x86_64                randconfig-071-20240418   gcc  
x86_64                randconfig-072-20240418   clang
x86_64                randconfig-073-20240418   clang
x86_64                randconfig-074-20240418   gcc  
x86_64                randconfig-075-20240418   gcc  
x86_64                randconfig-076-20240418   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
