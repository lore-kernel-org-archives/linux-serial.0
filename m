Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DD613A244
	for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764249463; cv=none; b=HG9S+MTvrakSFnKY5m+PIP05iPx171j1tHAGoFh2dIsfZbQPjsbglgn8DMYvC9Jl6AqZlLkmvG4WXtKU+/ERNTJ1x8eVyvuK6ap4FZzgiQ3n6xr9Whg158EOuVD/ccfs6MmRgl7yl7n2URDSBsCWKRqIQbf0aO4heSKaDR1Fq1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764249463; c=relaxed/simple;
	bh=85AV+1b+QruL+I/WKNM1qWAtAd4pxNKsvr96kMi3wik=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GmUmXRNXXcvgdPJkO0WJd3nwTZMv+dYEehBAGcHZIeVBGkf/rTRrbXyCvLx77s2ytlQS3tuumNhltWtJi8inJ3xntVYSiDBpG7S6c2l5aSSwBIQGJ9af1dsRMyTsHhlQLAnPuRRXKS4zlID54mAlfNfMTB2sS5HR8awqe8Qkzzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjg3tk18; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjg3tk18"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764249462; x=1795785462;
  h=date:from:to:cc:subject:message-id;
  bh=85AV+1b+QruL+I/WKNM1qWAtAd4pxNKsvr96kMi3wik=;
  b=fjg3tk18pnoXvKGkySp4wUgDAaevyk57ZgpLG6L+SvEwuzPCjNv0NkCp
   hDw8QgEy8j1c0N+ymwhwnX0q5h5dFTkF/WYZyVASuucs7+BZBkHdfez2+
   9aiGw0FDtk4Kh1Z+Pnfi8CHsmbAYj01r1p3fmhfcK8eqfhFg1ODXuyVIQ
   H/EpFd9uD8AnqGwFqDuKgRIU1a4lzUMzYQAwqbkFJ2Z5Ca2KMOG2yYb11
   J1qeGsZE/GFLapXXKwR1KzZ59gu3pRxpL55m9+osZsY+lDtEdJv3EljTX
   lUQP9Lox9mWdSJXwsqaQpn6zvs8NdBzwF0KLA5trZb6R4H5zXswAAzuq3
   Q==;
X-CSE-ConnectionGUID: Rm89I9fkQsWsMXEFOnYBXw==
X-CSE-MsgGUID: sZ3UJZjXSVe+0DyiXAMLsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66457764"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="66457764"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 05:17:41 -0800
X-CSE-ConnectionGUID: COLUDy0MQkCENLBXmqY7Ig==
X-CSE-MsgGUID: mXUNrUzlSCK29+A0icjisQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="230500600"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 27 Nov 2025 05:17:40 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vObsP-000000004mr-2P94;
	Thu, 27 Nov 2025 13:17:37 +0000
Date: Thu, 27 Nov 2025 21:17:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 2bf95a9bcb50002ca9d47403d60aedaeb2e19abe
Message-ID: <202511272156.72zFFxTp-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 2bf95a9bcb50002ca9d47403d60aedaeb2e19abe  serial: 8250: Fix 8250_rsa symbol loop

elapsed time: 1466m

configs tested: 169
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251127    clang-22
arc                   randconfig-001-20251127    gcc-15.1.0
arc                   randconfig-002-20251127    clang-22
arc                   randconfig-002-20251127    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                         axm55xx_defconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                            mmp2_defconfig    clang-19
arm                         mv78xx0_defconfig    clang-19
arm                   randconfig-001-20251127    clang-22
arm                   randconfig-002-20251127    clang-22
arm                   randconfig-003-20251127    clang-22
arm                   randconfig-004-20251127    clang-22
arm                   randconfig-004-20251127    gcc-10.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251127    gcc-15.1.0
arm64                 randconfig-002-20251127    gcc-15.1.0
arm64                 randconfig-003-20251127    gcc-15.1.0
arm64                 randconfig-004-20251127    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251127    gcc-15.1.0
csky                  randconfig-002-20251127    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251127    clang-22
hexagon               randconfig-001-20251127    gcc-15.1.0
hexagon               randconfig-002-20251127    clang-18
hexagon               randconfig-002-20251127    gcc-15.1.0
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386        buildonly-randconfig-001-20251127    clang-20
i386        buildonly-randconfig-002-20251127    clang-20
i386        buildonly-randconfig-003-20251127    clang-20
i386        buildonly-randconfig-004-20251127    clang-20
i386        buildonly-randconfig-005-20251127    clang-20
i386        buildonly-randconfig-006-20251127    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251127    clang-20
i386                  randconfig-002-20251127    clang-20
i386                  randconfig-003-20251127    clang-20
i386                  randconfig-004-20251127    clang-20
i386                  randconfig-005-20251127    clang-20
i386                  randconfig-006-20251127    clang-20
i386                  randconfig-007-20251127    clang-20
i386                  randconfig-011-20251127    clang-20
i386                  randconfig-012-20251127    clang-20
i386                  randconfig-013-20251127    clang-20
i386                  randconfig-014-20251127    clang-20
i386                  randconfig-015-20251127    clang-20
i386                  randconfig-016-20251127    clang-20
i386                  randconfig-017-20251127    clang-20
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251127    clang-22
loongarch             randconfig-001-20251127    gcc-15.1.0
loongarch             randconfig-002-20251127    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                              allnoconfig    gcc-15.1.0
mips                          ath79_defconfig    clang-19
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251127    gcc-15.1.0
nios2                 randconfig-001-20251127    gcc-8.5.0
nios2                 randconfig-002-20251127    gcc-11.5.0
nios2                 randconfig-002-20251127    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251127    gcc-13.4.0
parisc                randconfig-001-20251127    gcc-8.5.0
parisc                randconfig-002-20251127    gcc-13.4.0
parisc                randconfig-002-20251127    gcc-15.1.0
parisc64                            defconfig    clang-19
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251127    clang-22
powerpc               randconfig-001-20251127    gcc-13.4.0
powerpc               randconfig-002-20251127    gcc-13.4.0
powerpc                      tqm8xx_defconfig    clang-19
powerpc                        warp_defconfig    clang-19
powerpc64             randconfig-001-20251127    clang-20
powerpc64             randconfig-001-20251127    gcc-13.4.0
powerpc64             randconfig-002-20251127    gcc-13.4.0
powerpc64             randconfig-002-20251127    gcc-14.3.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251127    gcc-12.5.0
riscv                 randconfig-002-20251127    clang-22
riscv                 randconfig-002-20251127    gcc-12.5.0
s390                              allnoconfig    clang-22
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251127    gcc-11.5.0
s390                  randconfig-001-20251127    gcc-12.5.0
s390                  randconfig-002-20251127    clang-22
s390                  randconfig-002-20251127    gcc-12.5.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251127    gcc-12.5.0
sh                    randconfig-001-20251127    gcc-15.1.0
sh                    randconfig-002-20251127    gcc-12.5.0
sh                   secureedge5410_defconfig    clang-19
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251127    clang-22
sparc                 randconfig-001-20251127    gcc-13.4.0
sparc                 randconfig-002-20251127    clang-22
sparc                 randconfig-002-20251127    gcc-11.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251127    clang-22
sparc64               randconfig-001-20251127    gcc-15.1.0
sparc64               randconfig-002-20251127    clang-20
sparc64               randconfig-002-20251127    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251127    clang-22
um                    randconfig-001-20251127    gcc-14
um                    randconfig-002-20251127    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64      buildonly-randconfig-001-20251127    clang-20
x86_64      buildonly-randconfig-002-20251127    clang-20
x86_64      buildonly-randconfig-003-20251127    clang-20
x86_64      buildonly-randconfig-004-20251127    clang-20
x86_64      buildonly-randconfig-005-20251127    clang-20
x86_64      buildonly-randconfig-006-20251127    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251127    gcc-14
x86_64                randconfig-002-20251127    gcc-14
x86_64                randconfig-003-20251127    gcc-14
x86_64                randconfig-004-20251127    gcc-14
x86_64                randconfig-005-20251127    gcc-14
x86_64                randconfig-006-20251127    gcc-14
x86_64                randconfig-071-20251127    gcc-14
x86_64                randconfig-072-20251127    gcc-14
x86_64                randconfig-073-20251127    gcc-14
x86_64                randconfig-074-20251127    gcc-14
x86_64                randconfig-075-20251127    gcc-14
x86_64                randconfig-076-20251127    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251127    clang-22
xtensa                randconfig-001-20251127    gcc-11.5.0
xtensa                randconfig-002-20251127    clang-22
xtensa                randconfig-002-20251127    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
