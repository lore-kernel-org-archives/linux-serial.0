Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B59A21D3CC
	for <linux-serial@vger.kernel.org>; Thu, 10 Jul 2025 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127823; cv=none; b=u/87RrDE7slGanT6SZyW9zLCXDiVXnHqjWEI7KQ3xnQqB24yIVroHAYpHc0d1elxEkfSeEIdroxP4iN7lFi0p+XChJZYfBkn8RTelmNOhoO9MyXX+NcCLAHdxoDhnnkEQCP6VxYxJrZNq3FyYhVXaVPYmnwzEoBIyN4+twIQztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127823; c=relaxed/simple;
	bh=U5D9s4cvVcEgeFyVZUbOo/YqMJmqrJyM0ZcSfyb1ZuQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kDWLqZ7xIxgeiqvKo3FS8DpzdCgmRHf30PizmMbC7SF9eYT4IKPWYx7bru759tU6Jb1p6Cd8kdHElOltG9v25ApDD4Hibtb+MgOIizBri/vIOlstz9GwHH/Aa8xocfG2JjnmrezD6W7RLB2a0GtUlXc0hO6yV1e8vLQHGivOjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eucCq9Kf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eucCq9Kf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752127821; x=1783663821;
  h=date:from:to:cc:subject:message-id;
  bh=U5D9s4cvVcEgeFyVZUbOo/YqMJmqrJyM0ZcSfyb1ZuQ=;
  b=eucCq9Kfu3m2PBfEkIOqWD/2EWh8870iAXneXfsDsuZ0RJRtMum4pSx8
   ow5X/9i5WkCvLX4HuUrhpKqAbn2i/HBhJ2cIhjJPO7Edq+ThsJzRXm4G+
   khf9rtE9xHIiQofnTUjr5D9QAO9II1Plv5wvQ4o+SD3NUZtwS1j1JJbTO
   qP0zDHog1Xci6jBLIfDmaGdrMrs2+0xDw5BsZjBHIp2e8z655W+nvNqi4
   CG8cN4Tlk6HRFiwitIqQe9Bqt7DcRuB/8jBOz4eNiahxt6OveHkp14FmS
   nudsXWtBt96GBE1C2aZpJGmLinwKYXhYcKTWx7rSKEK87H2tA6LfS9Kq6
   Q==;
X-CSE-ConnectionGUID: 5YtsdLjUTXya/np8Va+CvQ==
X-CSE-MsgGUID: eswVvIzzR6i3F9gT9w1AGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="58203730"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="58203730"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 23:10:21 -0700
X-CSE-ConnectionGUID: j8nm4Mc2Q9W3MPfv8M4rzA==
X-CSE-MsgGUID: F5TYW4iyRSy1xtGd/La2gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="161642988"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 09 Jul 2025 23:10:18 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZkU4-0004Yi-2J;
	Thu, 10 Jul 2025 06:10:16 +0000
Date: Thu, 10 Jul 2025 14:09:47 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 6c0e9f05c9d7875995b0e92ace71be947f280bbd
Message-ID: <202507101435.o4mSU45n-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 6c0e9f05c9d7875995b0e92ace71be947f280bbd  pch_uart: Fix dma_sync_sg_for_device() nents value

elapsed time: 1022m

configs tested: 240
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-21
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250709    gcc-8.5.0
arc                   randconfig-001-20250710    clang-21
arc                   randconfig-002-20250709    gcc-11.5.0
arc                   randconfig-002-20250710    clang-21
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                          exynos_defconfig    clang-21
arm                            qcom_defconfig    clang-21
arm                   randconfig-001-20250709    gcc-12.4.0
arm                   randconfig-001-20250710    clang-21
arm                   randconfig-002-20250709    gcc-10.5.0
arm                   randconfig-002-20250710    clang-21
arm                   randconfig-003-20250709    clang-21
arm                   randconfig-003-20250710    clang-21
arm                   randconfig-004-20250709    clang-21
arm                   randconfig-004-20250710    clang-21
arm                       spear13xx_defconfig    clang-21
arm                           spitz_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250709    clang-21
arm64                 randconfig-001-20250710    clang-21
arm64                 randconfig-002-20250709    gcc-15.1.0
arm64                 randconfig-002-20250710    clang-21
arm64                 randconfig-003-20250709    clang-21
arm64                 randconfig-003-20250710    clang-21
arm64                 randconfig-004-20250709    gcc-10.5.0
arm64                 randconfig-004-20250710    clang-21
csky                              allnoconfig    clang-21
csky                                defconfig    clang-19
csky                  randconfig-001-20250709    gcc-15.1.0
csky                  randconfig-001-20250710    gcc-15.1.0
csky                  randconfig-002-20250709    gcc-15.1.0
csky                  randconfig-002-20250710    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250709    clang-19
hexagon               randconfig-001-20250710    gcc-15.1.0
hexagon               randconfig-002-20250709    clang-21
hexagon               randconfig-002-20250710    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250709    gcc-12
i386        buildonly-randconfig-001-20250710    clang-20
i386        buildonly-randconfig-002-20250709    clang-20
i386        buildonly-randconfig-002-20250710    clang-20
i386        buildonly-randconfig-003-20250709    clang-20
i386        buildonly-randconfig-003-20250710    clang-20
i386        buildonly-randconfig-004-20250709    clang-20
i386        buildonly-randconfig-004-20250710    clang-20
i386        buildonly-randconfig-005-20250709    gcc-12
i386        buildonly-randconfig-005-20250710    clang-20
i386        buildonly-randconfig-006-20250709    clang-20
i386        buildonly-randconfig-006-20250710    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250710    gcc-12
i386                  randconfig-002-20250710    gcc-12
i386                  randconfig-003-20250710    gcc-12
i386                  randconfig-004-20250710    gcc-12
i386                  randconfig-005-20250710    gcc-12
i386                  randconfig-006-20250710    gcc-12
i386                  randconfig-007-20250710    gcc-12
i386                  randconfig-011-20250710    clang-20
i386                  randconfig-012-20250710    clang-20
i386                  randconfig-013-20250710    clang-20
i386                  randconfig-014-20250710    clang-20
i386                  randconfig-015-20250710    clang-20
i386                  randconfig-016-20250710    clang-20
i386                  randconfig-017-20250710    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250709    gcc-15.1.0
loongarch             randconfig-001-20250710    gcc-15.1.0
loongarch             randconfig-002-20250709    gcc-12.4.0
loongarch             randconfig-002-20250710    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                         apollo_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-15.1.0
m68k                          sun3x_defconfig    clang-21
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      bmips_stb_defconfig    gcc-15.1.0
mips                 decstation_r4k_defconfig    gcc-15.1.0
mips                           rs90_defconfig    gcc-15.1.0
mips                   sb1250_swarm_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250709    gcc-14.2.0
nios2                 randconfig-001-20250710    gcc-15.1.0
nios2                 randconfig-002-20250709    gcc-14.2.0
nios2                 randconfig-002-20250710    gcc-15.1.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    clang-21
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250709    gcc-15.1.0
parisc                randconfig-001-20250710    gcc-15.1.0
parisc                randconfig-002-20250709    gcc-14.3.0
parisc                randconfig-002-20250710    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      cm5200_defconfig    clang-21
powerpc                  iss476-smp_defconfig    clang-21
powerpc               randconfig-001-20250709    gcc-8.5.0
powerpc               randconfig-001-20250710    gcc-15.1.0
powerpc               randconfig-002-20250709    clang-21
powerpc               randconfig-002-20250710    gcc-15.1.0
powerpc               randconfig-003-20250709    clang-21
powerpc               randconfig-003-20250710    gcc-15.1.0
powerpc64             randconfig-001-20250709    gcc-10.5.0
powerpc64             randconfig-001-20250710    gcc-15.1.0
powerpc64             randconfig-002-20250709    gcc-10.5.0
powerpc64             randconfig-002-20250710    gcc-15.1.0
powerpc64             randconfig-003-20250709    clang-21
powerpc64             randconfig-003-20250710    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250709    gcc-10.5.0
riscv                 randconfig-001-20250710    gcc-12.4.0
riscv                 randconfig-002-20250709    clang-21
riscv                 randconfig-002-20250710    gcc-12.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250709    clang-17
s390                  randconfig-001-20250710    gcc-12.4.0
s390                  randconfig-002-20250709    clang-21
s390                  randconfig-002-20250710    gcc-12.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250709    gcc-10.5.0
sh                    randconfig-001-20250710    gcc-12.4.0
sh                    randconfig-002-20250709    gcc-14.3.0
sh                    randconfig-002-20250710    gcc-12.4.0
sh                           se7780_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250709    gcc-15.1.0
sparc                 randconfig-001-20250710    gcc-12.4.0
sparc                 randconfig-002-20250709    gcc-10.3.0
sparc                 randconfig-002-20250710    gcc-12.4.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250709    clang-21
sparc64               randconfig-001-20250710    gcc-12.4.0
sparc64               randconfig-002-20250709    clang-21
sparc64               randconfig-002-20250710    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250709    clang-17
um                    randconfig-001-20250710    gcc-12.4.0
um                    randconfig-002-20250709    gcc-12
um                    randconfig-002-20250710    gcc-12.4.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250709    gcc-12
x86_64      buildonly-randconfig-001-20250710    clang-20
x86_64      buildonly-randconfig-002-20250709    clang-20
x86_64      buildonly-randconfig-002-20250710    clang-20
x86_64      buildonly-randconfig-003-20250709    gcc-12
x86_64      buildonly-randconfig-003-20250710    clang-20
x86_64      buildonly-randconfig-004-20250709    gcc-12
x86_64      buildonly-randconfig-004-20250710    clang-20
x86_64      buildonly-randconfig-005-20250709    clang-20
x86_64      buildonly-randconfig-005-20250710    clang-20
x86_64      buildonly-randconfig-006-20250709    gcc-12
x86_64      buildonly-randconfig-006-20250710    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250710    gcc-12
x86_64                randconfig-002-20250710    gcc-12
x86_64                randconfig-003-20250710    gcc-12
x86_64                randconfig-004-20250710    gcc-12
x86_64                randconfig-005-20250710    gcc-12
x86_64                randconfig-006-20250710    gcc-12
x86_64                randconfig-007-20250710    gcc-12
x86_64                randconfig-008-20250710    gcc-12
x86_64                randconfig-071-20250710    gcc-11
x86_64                randconfig-072-20250710    gcc-11
x86_64                randconfig-073-20250710    gcc-11
x86_64                randconfig-074-20250710    gcc-11
x86_64                randconfig-075-20250710    gcc-11
x86_64                randconfig-076-20250710    gcc-11
x86_64                randconfig-077-20250710    gcc-11
x86_64                randconfig-078-20250710    gcc-11
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250709    gcc-8.5.0
xtensa                randconfig-001-20250710    gcc-12.4.0
xtensa                randconfig-002-20250709    gcc-11.5.0
xtensa                randconfig-002-20250710    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
