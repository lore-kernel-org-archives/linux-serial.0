Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2DC372
	for <linux-serial@vger.kernel.org>; Mon, 17 Feb 2025 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822003; cv=none; b=D5zWhEM+MGGpWdo0HljJWmjetdSs2IaTE45W5so4LLZkGrK0n27uMbgyJkxSo29mWBgaI8c/88TgKM/98nGBglq767G1UR0fla4f/zZc38uHxQ1tijawLaWccJVandXFkD6MU1wKAi6W32wNLyXQOzfq9NU3tkDr5vIKQNQsLX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822003; c=relaxed/simple;
	bh=k6nBSM2vYPLnZ64+5rtTeUlPR/d4VgigZsIS1FUvCNA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dFo7Rhtcny4MMmOjiup2dIhU4f6IP9ThKwtIhrBDBMpkdwk8TbGL5/5TjgV1H7Bh1TQJfnLk9y4/1x6CqBZgaU+HMwuu6NUBbDfC77S/1r+kc+T86gpw29HuWIOpyB1rppf5Mx3S3pe1qPPuJpFqsGNnjHfZQG0i8+jiZALDKz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FND4RLCE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FND4RLCE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739822001; x=1771358001;
  h=date:from:to:cc:subject:message-id;
  bh=k6nBSM2vYPLnZ64+5rtTeUlPR/d4VgigZsIS1FUvCNA=;
  b=FND4RLCERm3900m/w1epEGX0rnxkd4AKeLxuGGXk2I0cJv496sPhhjm5
   2Mxx1oXiv+z2+HzrPWoAlT6yla4LoPWoXxhek/JZdNHuKskVDaz5v0ShV
   JHnMv+Z2nganQtM4OQI24Hx7IC90OYc0ocIal54E3ZWl9o4LanWGjlcAn
   HAPmTCmvWuE+9OR7BJ4+sOZxJkwbKP8aXYJt1iQn7dEk03xkgFHTqN8mn
   5Y5rrqSo6AFXxN2M7tAKdCo/qV0Kar45nO4kMPjdHQun2ZnJSKMZLx8mI
   WiNEoiNVn7Ndxdxd1aapl6gNC/O9MZKk6z3iRNcv3ZAPnvcWfmSuhkEbE
   g==;
X-CSE-ConnectionGUID: iorFCBSJRwC9mUPudtZBUg==
X-CSE-MsgGUID: 6V5f7kH+RlKOptuX4xKbPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="43341912"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="43341912"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 11:53:20 -0800
X-CSE-ConnectionGUID: LaCYz7QPQBS/hZS3nfgP8w==
X-CSE-MsgGUID: esKSll9KTNCbeLV3WFc8cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="151395106"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 17 Feb 2025 11:53:19 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tk7B6-001DX1-2x;
	Mon, 17 Feb 2025 19:53:16 +0000
Date: Tue, 18 Feb 2025 03:52:42 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 e749820252c73a17da97cc18b68fec7b6299cfd3
Message-ID: <202502180336.0ch0rdSp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: e749820252c73a17da97cc18b68fec7b6299cfd3  Merge 6.14-rc3 into tty-next

elapsed time: 728m

configs tested: 115
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250217    gcc-13.2.0
arc                   randconfig-002-20250217    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250217    gcc-14.2.0
arm                   randconfig-002-20250217    gcc-14.2.0
arm                   randconfig-003-20250217    gcc-14.2.0
arm                   randconfig-004-20250217    clang-19
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250217    gcc-14.2.0
arm64                 randconfig-002-20250217    clang-21
arm64                 randconfig-003-20250217    clang-15
arm64                 randconfig-004-20250217    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250217    gcc-14.2.0
csky                  randconfig-002-20250217    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250217    clang-21
hexagon               randconfig-002-20250217    clang-14
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250217    clang-19
i386        buildonly-randconfig-002-20250217    gcc-12
i386        buildonly-randconfig-003-20250217    clang-19
i386        buildonly-randconfig-004-20250217    gcc-12
i386        buildonly-randconfig-005-20250217    gcc-12
i386        buildonly-randconfig-006-20250217    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250217    gcc-14.2.0
loongarch             randconfig-002-20250217    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250217    gcc-14.2.0
nios2                 randconfig-002-20250217    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250217    gcc-14.2.0
parisc                randconfig-002-20250217    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc               randconfig-001-20250217    clang-17
powerpc               randconfig-002-20250217    clang-15
powerpc               randconfig-003-20250217    gcc-14.2.0
powerpc64             randconfig-001-20250217    clang-19
powerpc64             randconfig-002-20250217    clang-21
powerpc64             randconfig-003-20250217    clang-15
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                               defconfig    clang-19
riscv                 randconfig-001-20250217    gcc-14.2.0
riscv                 randconfig-002-20250217    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250217    gcc-14.2.0
s390                  randconfig-002-20250217    clang-18
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250217    gcc-14.2.0
sh                    randconfig-002-20250217    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250217    gcc-14.2.0
sparc                 randconfig-002-20250217    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250217    gcc-14.2.0
sparc64               randconfig-002-20250217    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250217    clang-19
um                    randconfig-002-20250217    clang-17
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250217    gcc-12
x86_64      buildonly-randconfig-002-20250217    clang-19
x86_64      buildonly-randconfig-003-20250217    clang-19
x86_64      buildonly-randconfig-004-20250217    gcc-12
x86_64      buildonly-randconfig-005-20250217    gcc-12
x86_64      buildonly-randconfig-006-20250217    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250217    gcc-14.2.0
xtensa                randconfig-002-20250217    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
