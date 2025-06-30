Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C7327442
	for <linux-serial@vger.kernel.org>; Mon, 30 Jun 2025 02:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751250598; cv=none; b=V7gTCObnCboyivAN9oIyA7AjXZK0g+P4C2jUVJ0R8wLDhoR5EO7sgUC4UUhh8t5iFVWhCGqF+dDWwH4Sjl/2N47TBGpDZRQaO+TL/7ZA2/WgSxGW73swSM1629lOz2A191XjcPJ1iZiAlmHC6yhS5fZQoeFy7kAy7im1ubhwKJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751250598; c=relaxed/simple;
	bh=EVBT8pwPnoN2vg91Ks/otoaUxuFCJDu49kwm53EkSAs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IVO9gUS9iR52t/dCc40pVin57UMMVHV6rzFkOPIv8Qr5sa/Q5EfQ7eG6SQ106Qw4clBQHaZ7dWtQQj1vl1eXwTSDSZ3JtiQl64kAJFyagm52Pb1GHSS6aSbOAw8aDLLTUO2R+uALK0UhllsDQx9DFMsqgD9ztOGHd1qRV/g8XKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZXesh5J5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZXesh5J5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751250597; x=1782786597;
  h=date:from:to:cc:subject:message-id;
  bh=EVBT8pwPnoN2vg91Ks/otoaUxuFCJDu49kwm53EkSAs=;
  b=ZXesh5J5tpYtFLuxK06GcbHnFkzy3TPz2HfT/l7Sn8dUJZLZgPR+Dz5W
   N8gNo4RmvGRPnJAxk+AtPxLCB0K6kaSLTlu7zjt5hPZmTDCFlgjztwea3
   5+4rYekHaPr3g6fUIgrlHeRu/vBH1ggkJcF3EYOzxh2YIKv6DmU3eOBQO
   cHrqEainRcQ/bjbzSkLec/x4gC9Y+awhgdkPpddigorZOflUWVLVmC70M
   YQrBFHry5Qr6KnKwJPUQYrQYSkcWz8HLYlbQnZc0cTqfEO5hSvwdQxzXd
   1SErWkbQW12fSkFk2doUfXp2rzC1T7Aj3bUmIG/z4/0LfRAvQvkxPU6KE
   w==;
X-CSE-ConnectionGUID: j9PzOafORfK/OXPxyG5YRw==
X-CSE-MsgGUID: HuBuHjRpTNSfDCDcL95YvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="70903061"
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; 
   d="scan'208";a="70903061"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 19:29:56 -0700
X-CSE-ConnectionGUID: pv68PzGkR+SylTimXKxG3Q==
X-CSE-MsgGUID: H3JEa2kRS32XutQEqG/xcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; 
   d="scan'208";a="157352258"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 29 Jun 2025 19:29:55 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uW4HI-000YP8-2m;
	Mon, 30 Jun 2025 02:29:52 +0000
Date: Mon, 30 Jun 2025 10:29:14 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 acc902de05b2b8229dc27820925b7573b6d2d34e
Message-ID: <202506301004.rDVjAxzM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: acc902de05b2b8229dc27820925b7573b6d2d34e  serial: 8250: Move CE4100 quirks to a module under 8250 driver

elapsed time: 819m

configs tested: 141
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                         haps_hs_defconfig    gcc-15.1.0
arc                        nsim_700_defconfig    gcc-15.1.0
arc                   randconfig-001-20250629    gcc-8.5.0
arc                   randconfig-002-20250629    gcc-13.3.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-21
arm                           omap1_defconfig    gcc-15.1.0
arm                          pxa3xx_defconfig    clang-21
arm                   randconfig-001-20250629    clang-21
arm                   randconfig-002-20250629    gcc-12.4.0
arm                   randconfig-003-20250629    gcc-8.5.0
arm                   randconfig-004-20250629    gcc-12.4.0
arm                         s5pv210_defconfig    gcc-15.1.0
arm                        spear6xx_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250629    gcc-13.3.0
arm64                 randconfig-002-20250629    clang-19
arm64                 randconfig-003-20250629    gcc-14.3.0
arm64                 randconfig-004-20250629    gcc-11.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250629    gcc-15.1.0
csky                  randconfig-002-20250629    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250629    clang-21
hexagon               randconfig-002-20250629    clang-17
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250629    clang-20
i386        buildonly-randconfig-002-20250629    clang-20
i386        buildonly-randconfig-003-20250629    clang-20
i386        buildonly-randconfig-004-20250629    gcc-12
i386        buildonly-randconfig-005-20250629    clang-20
i386        buildonly-randconfig-006-20250629    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250629    gcc-15.1.0
loongarch             randconfig-002-20250629    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    clang-21
mips                         bigsur_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250629    gcc-9.3.0
nios2                 randconfig-002-20250629    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-32bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20250629    gcc-10.5.0
parisc                randconfig-002-20250629    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                 mpc836x_rdk_defconfig    clang-21
powerpc               randconfig-001-20250629    clang-21
powerpc               randconfig-002-20250629    gcc-13.3.0
powerpc               randconfig-003-20250629    gcc-11.5.0
powerpc                     redwood_defconfig    clang-21
powerpc64             randconfig-001-20250629    clang-21
powerpc64             randconfig-002-20250629    gcc-8.5.0
powerpc64             randconfig-003-20250629    clang-20
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250629    clang-17
riscv                 randconfig-002-20250629    gcc-13.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250629    clang-21
s390                  randconfig-002-20250629    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                             espt_defconfig    gcc-15.1.0
sh                          r7785rp_defconfig    gcc-15.1.0
sh                    randconfig-001-20250629    gcc-15.1.0
sh                    randconfig-002-20250629    gcc-15.1.0
sh                      rts7751r2d1_defconfig    gcc-15.1.0
sh                        sh7757lcr_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250629    gcc-10.3.0
sparc                 randconfig-002-20250629    gcc-8.5.0
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250629    gcc-8.5.0
sparc64               randconfig-002-20250629    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250629    gcc-11
um                    randconfig-002-20250629    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250629    gcc-12
x86_64      buildonly-randconfig-002-20250629    gcc-12
x86_64      buildonly-randconfig-003-20250629    clang-20
x86_64      buildonly-randconfig-004-20250629    gcc-12
x86_64      buildonly-randconfig-005-20250629    gcc-12
x86_64      buildonly-randconfig-006-20250629    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250629    gcc-8.5.0
xtensa                randconfig-002-20250629    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
