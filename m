Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5847C2E8DEB
	for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994410; cv=none; b=s47klbiVVM2JTuMQ6V31V3lgyGWUXJZQ4NPSsx7P+CXrc6YRGbGqKR5mLaBpp3rnhHER6g7jNLXvlHOv9rJVMX+dJtiHi7qQiYTPoKpYH1prRu4ZjIqY1HUkWmAzcnR5HlHIjv1PiN39E07JaJaAJWawFFOO4BblQ4+Ji/Hn/k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994410; c=relaxed/simple;
	bh=yoUorWuIrTgKKV+Oj120ZZuGjZvlJevxgXMLKQIWe2k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KjFHVO/1jYNZDrPhBbhAxUzMk7a+BM4oup53ZSYsTnr1XvBHWtRegyiNywWwfuKyzvCXmuJq5YgFHBFUJiMTSwAQMSFNufz1K5KHvN/gJMpH/uv9ndaka4OwcDf7Cmwz5G3zo61XRixNfegzaLrUxjAv8kbeWGmRxkpSWkmf7eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFAXO8Eu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFAXO8Eu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783994408; x=1815530408;
  h=date:from:to:cc:subject:message-id;
  bh=yoUorWuIrTgKKV+Oj120ZZuGjZvlJevxgXMLKQIWe2k=;
  b=XFAXO8Eun4fyOgnkQEFsLHKMkur9E2kFEbDEBASih0/6OQdqmuMPyU1i
   CNKXtlkGaROCvfRc4Jucj2SEOMexQPhkNvUPzjndl0746t++wbg8aR5kX
   Xa3h66fhFW29L6WQGuMrRTS9Q17IkzQ0ZcG9CYPeykpDEy+0c0NZMifJV
   bbqMvkJS8ZR5C9Ie5iNhaC1XQIquy64UQtYwbFkgflkE9x09W7MqyVt2z
   qo+gVXm93gP0hf4bSvvraG2jOvjI3BcpT6RmtpkmjQWDtMAo8WMSL2JRO
   n7eEWLWXlV1qqqHtLQmkf9CVR2IkuRdZhg2z/KMpP3FzHs89E90zQm6Bg
   w==;
X-CSE-ConnectionGUID: YlvqJBaYSIW9VMyk3XBzDQ==
X-CSE-MsgGUID: jDt+RriwTz+rO8hF8/2Tww==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84804319"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84804319"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 19:00:06 -0700
X-CSE-ConnectionGUID: vW75qXqvSAC0CTDjOZ+g5A==
X-CSE-MsgGUID: DuYwWlXBTPe35then4UR2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255220571"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 13 Jul 2026 19:00:05 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wjSRG-00000000MGZ-12IJ;
	Tue, 14 Jul 2026 02:00:02 +0000
Date: Tue, 14 Jul 2026 09:59:53 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 c1d4ce2d9eaeccd7e8aef7ec1109df49eaf4f503
Message-ID: <202607140943.VffrjKkG-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: c1d4ce2d9eaeccd7e8aef7ec1109df49eaf4f503  Merge 7.2-rc3 into tty-next

elapsed time: 735m

configs tested: 219
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              alldefconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260713    gcc-8.5.0
arc                   randconfig-001-20260714    clang-23
arc                   randconfig-002-20260713    gcc-8.5.0
arc                   randconfig-002-20260714    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                          ixp4xx_defconfig    gcc-16.1.0
arm                   randconfig-001-20260713    gcc-8.5.0
arm                   randconfig-001-20260714    clang-23
arm                   randconfig-002-20260713    gcc-8.5.0
arm                   randconfig-002-20260714    clang-23
arm                   randconfig-003-20260713    gcc-8.5.0
arm                   randconfig-003-20260714    clang-23
arm                   randconfig-004-20260713    gcc-8.5.0
arm                   randconfig-004-20260714    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260713    gcc-13.4.0
arm64                 randconfig-001-20260714    gcc-16.1.0
arm64                 randconfig-002-20260713    gcc-13.4.0
arm64                 randconfig-002-20260714    gcc-16.1.0
arm64                 randconfig-003-20260713    gcc-13.4.0
arm64                 randconfig-003-20260714    gcc-16.1.0
arm64                 randconfig-004-20260713    gcc-13.4.0
arm64                 randconfig-004-20260714    gcc-16.1.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260713    gcc-13.4.0
csky                  randconfig-001-20260714    gcc-16.1.0
csky                  randconfig-002-20260713    gcc-13.4.0
csky                  randconfig-002-20260714    gcc-16.1.0
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260714    gcc-16.1.0
hexagon               randconfig-002-20260714    gcc-16.1.0
i386                             allmodconfig    clang-22
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386        buildonly-randconfig-001-20260713    gcc-14
i386        buildonly-randconfig-001-20260714    clang-22
i386        buildonly-randconfig-002-20260713    clang-22
i386        buildonly-randconfig-002-20260713    gcc-14
i386        buildonly-randconfig-002-20260714    clang-22
i386        buildonly-randconfig-003-20260713    gcc-14
i386        buildonly-randconfig-003-20260714    clang-22
i386        buildonly-randconfig-004-20260713    clang-22
i386        buildonly-randconfig-004-20260713    gcc-14
i386        buildonly-randconfig-004-20260714    clang-22
i386        buildonly-randconfig-005-20260713    gcc-14
i386        buildonly-randconfig-005-20260714    clang-22
i386        buildonly-randconfig-006-20260713    gcc-14
i386        buildonly-randconfig-006-20260714    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260713    gcc-14
i386                  randconfig-001-20260714    gcc-13
i386                  randconfig-002-20260714    gcc-13
i386                  randconfig-003-20260713    gcc-14
i386                  randconfig-003-20260714    gcc-13
i386                  randconfig-004-20260713    gcc-14
i386                  randconfig-004-20260714    gcc-13
i386                  randconfig-005-20260713    gcc-14
i386                  randconfig-005-20260714    gcc-13
i386                  randconfig-006-20260713    gcc-14
i386                  randconfig-006-20260714    gcc-13
i386                  randconfig-007-20260713    gcc-14
i386                  randconfig-007-20260714    gcc-13
i386                  randconfig-011-20260714    clang-22
i386                  randconfig-012-20260714    clang-22
i386                  randconfig-013-20260714    clang-22
i386                  randconfig-014-20260714    clang-22
i386                  randconfig-015-20260714    clang-22
i386                  randconfig-016-20260714    clang-22
i386                  randconfig-017-20260714    clang-22
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260714    gcc-16.1.0
loongarch             randconfig-002-20260714    gcc-16.1.0
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                                defconfig    clang-23
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260714    gcc-16.1.0
nios2                 randconfig-002-20260714    gcc-16.1.0
openrisc                         allmodconfig    clang-20
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-17
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260713    clang-23
parisc                randconfig-001-20260714    clang-17
parisc                randconfig-002-20260713    clang-23
parisc                randconfig-002-20260714    clang-17
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                       holly_defconfig    clang-23
powerpc               randconfig-001-20260713    clang-23
powerpc               randconfig-001-20260714    clang-17
powerpc               randconfig-002-20260713    clang-23
powerpc               randconfig-002-20260714    clang-17
powerpc64             randconfig-001-20260713    clang-23
powerpc64             randconfig-001-20260714    clang-17
powerpc64             randconfig-002-20260713    clang-23
powerpc64             randconfig-002-20260714    clang-17
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv             nommu_k210_sdcard_defconfig    gcc-16.1.0
riscv                 randconfig-001-20260713    gcc-16.1.0
riscv                 randconfig-001-20260714    gcc-10.5.0
riscv                 randconfig-002-20260714    gcc-10.5.0
s390                             allmodconfig    clang-17
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                  randconfig-001-20260713    gcc-16.1.0
s390                  randconfig-001-20260714    gcc-10.5.0
s390                  randconfig-002-20260713    gcc-16.1.0
s390                  randconfig-002-20260714    gcc-10.5.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-17
sh                                  defconfig    gcc-14
sh                             espt_defconfig    gcc-16.1.0
sh                    randconfig-001-20260713    gcc-16.1.0
sh                    randconfig-001-20260714    gcc-10.5.0
sh                    randconfig-002-20260713    gcc-16.1.0
sh                    randconfig-002-20260714    gcc-10.5.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260714    gcc-8.5.0
sparc                 randconfig-002-20260714    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260714    gcc-8.5.0
sparc64               randconfig-002-20260714    gcc-8.5.0
um                               allmodconfig    clang-17
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260714    gcc-8.5.0
um                    randconfig-002-20260714    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64      buildonly-randconfig-001-20260714    gcc-14
x86_64      buildonly-randconfig-002-20260714    gcc-14
x86_64      buildonly-randconfig-003-20260714    gcc-14
x86_64      buildonly-randconfig-004-20260714    gcc-14
x86_64      buildonly-randconfig-005-20260714    gcc-14
x86_64      buildonly-randconfig-006-20260714    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                randconfig-001-20260714    clang-22
x86_64                randconfig-002-20260714    clang-22
x86_64                randconfig-003-20260714    clang-22
x86_64                randconfig-004-20260714    clang-22
x86_64                randconfig-005-20260714    clang-22
x86_64                randconfig-006-20260714    clang-22
x86_64                randconfig-011-20260713    gcc-14
x86_64                randconfig-011-20260714    clang-22
x86_64                randconfig-012-20260713    gcc-14
x86_64                randconfig-012-20260714    clang-22
x86_64                randconfig-013-20260713    gcc-14
x86_64                randconfig-013-20260714    clang-22
x86_64                randconfig-014-20260713    gcc-14
x86_64                randconfig-014-20260714    clang-22
x86_64                randconfig-015-20260713    gcc-14
x86_64                randconfig-015-20260714    clang-22
x86_64                randconfig-016-20260713    gcc-14
x86_64                randconfig-016-20260714    clang-22
x86_64                randconfig-071-20260714    gcc-14
x86_64                randconfig-072-20260714    gcc-14
x86_64                randconfig-073-20260713    gcc-14
x86_64                randconfig-073-20260714    gcc-14
x86_64                randconfig-074-20260713    gcc-14
x86_64                randconfig-074-20260714    gcc-14
x86_64                randconfig-075-20260713    gcc-14
x86_64                randconfig-075-20260714    gcc-14
x86_64                randconfig-076-20260713    gcc-14
x86_64                randconfig-076-20260714    gcc-14
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260714    gcc-8.5.0
xtensa                randconfig-002-20260714    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
