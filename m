Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AA21ADFFB
	for <linux-serial@vger.kernel.org>; Wed, 16 Apr 2025 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744810211; cv=none; b=ENX178kLYsEiz7KNY4cFoTrQLA6Cx5khFo8b0Aa/9i0/bKUEU/+bUrpRgZqJvVpDEifdV+GwOC1ySGbkv0RfhQWjDqX83zJl7/fr87bxbHTYXsgfYWUxW4Lo0Pna3k6LnsKabEysX/9jnLDmA5IyzY8Bth6bf5MN+eJr04sv0OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744810211; c=relaxed/simple;
	bh=45f7X97eDUg2ecxkbdjhHlWmksQL8l22LDxrojG3V4o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DFktyZ9tI62GM5SugsKAPWjRhzl+TMpvypNTc3QstSaSmEX9ZzwW4YCxtkWDUsMwg3oDJoOLe9OHpTgCp2YfP5MVXSBsw/fjXZnWKA+Z96S3zAgoADJZC3mz5UXZflCsn7IJHobk2Yh4pNmkyPthwJeWMCQG2WN9cc6Mr/RPPWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jVcLrqoL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVcLrqoL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744810210; x=1776346210;
  h=date:from:to:cc:subject:message-id;
  bh=45f7X97eDUg2ecxkbdjhHlWmksQL8l22LDxrojG3V4o=;
  b=jVcLrqoLFWs0sBudWnzALwSGhfd+I5KM0iyE9z7RixQ7P6H25EPjRXnL
   s6gE+jogIf7mQ8njVLhaArUoZSVFJQgeA/2RNMdgaYTXaGl4NsawIu9IF
   K8mzX7JNhb2G2yMD9j3sCYuIS/hxYUXbq59msisLpy1tLkkoFy9MtBHH9
   Q6F2ONXug33cU6U2WwhudBNPvkjc5znJrxUUBLGfAuhQZhT++p936X3nI
   BQj06mruBjxjtyw36sksSPFPtq6ipmm4tBgj8YKPXbcSrkYGPFqzjPxo2
   mBBIaylAgcEL5wzsB+rWIkrO5T0mTwOnNBESyH0GqlUdWMvVoxbyxcm0R
   w==;
X-CSE-ConnectionGUID: zxlU4z9xQxSUOa4JaNtqig==
X-CSE-MsgGUID: Qyst7yHrSoK6FYrPLVLzIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="57350342"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="57350342"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 06:30:01 -0700
X-CSE-ConnectionGUID: rkbv+0BtRiWj7+ZI11xX0Q==
X-CSE-MsgGUID: nPHeD5I9SqubZrU9Sy8PNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="130500015"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 Apr 2025 06:29:59 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u52pw-000JnY-3D;
	Wed, 16 Apr 2025 13:29:57 +0000
Date: Wed, 16 Apr 2025 21:29:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 926040da60642335969ff99fa2ba67e4e0bb2618
Message-ID: <202504162104.oqfXFLPj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 926040da60642335969ff99fa2ba67e4e0bb2618  serial: 8250_of: manage bus clock in suspend/resume

elapsed time: 1449m

configs tested: 223
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250415    gcc-14.2.0
arc                   randconfig-001-20250416    gcc-7.5.0
arc                   randconfig-002-20250415    gcc-14.2.0
arc                   randconfig-002-20250416    gcc-7.5.0
arc                           tb10x_defconfig    clang-21
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                         bcm2835_defconfig    clang-21
arm                             mxs_defconfig    clang-21
arm                   randconfig-001-20250415    clang-21
arm                   randconfig-001-20250416    gcc-7.5.0
arm                   randconfig-002-20250415    clang-21
arm                   randconfig-002-20250416    gcc-7.5.0
arm                   randconfig-003-20250415    gcc-10.5.0
arm                   randconfig-003-20250416    gcc-7.5.0
arm                   randconfig-004-20250415    gcc-6.5.0
arm                   randconfig-004-20250416    gcc-7.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                            allyesconfig    gcc-14.2.0
arm64                 randconfig-001-20250415    clang-16
arm64                 randconfig-001-20250416    gcc-7.5.0
arm64                 randconfig-002-20250415    gcc-7.5.0
arm64                 randconfig-002-20250416    gcc-7.5.0
arm64                 randconfig-003-20250415    gcc-9.5.0
arm64                 randconfig-003-20250416    gcc-7.5.0
arm64                 randconfig-004-20250415    gcc-9.5.0
arm64                 randconfig-004-20250416    gcc-7.5.0
csky                             allmodconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                             allyesconfig    gcc-14.2.0
csky                  randconfig-001-20250415    gcc-13.3.0
csky                  randconfig-001-20250416    gcc-7.5.0
csky                  randconfig-002-20250415    gcc-14.2.0
csky                  randconfig-002-20250416    gcc-7.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250415    clang-20
hexagon               randconfig-001-20250416    gcc-7.5.0
hexagon               randconfig-002-20250415    clang-21
hexagon               randconfig-002-20250416    gcc-7.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250415    clang-20
i386        buildonly-randconfig-001-20250416    clang-20
i386        buildonly-randconfig-002-20250415    clang-20
i386        buildonly-randconfig-002-20250416    clang-20
i386        buildonly-randconfig-003-20250415    clang-20
i386        buildonly-randconfig-003-20250416    clang-20
i386        buildonly-randconfig-004-20250415    clang-20
i386        buildonly-randconfig-004-20250416    clang-20
i386        buildonly-randconfig-005-20250415    gcc-12
i386        buildonly-randconfig-005-20250416    clang-20
i386        buildonly-randconfig-006-20250415    gcc-12
i386        buildonly-randconfig-006-20250416    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250416    clang-20
i386                  randconfig-002-20250416    clang-20
i386                  randconfig-003-20250416    clang-20
i386                  randconfig-004-20250416    clang-20
i386                  randconfig-005-20250416    clang-20
i386                  randconfig-006-20250416    clang-20
i386                  randconfig-007-20250416    clang-20
i386                  randconfig-011-20250416    gcc-12
i386                  randconfig-012-20250416    gcc-12
i386                  randconfig-013-20250416    gcc-12
i386                  randconfig-014-20250416    gcc-12
i386                  randconfig-015-20250416    gcc-12
i386                  randconfig-016-20250416    gcc-12
i386                  randconfig-017-20250416    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                        allyesconfig    gcc-14.2.0
loongarch             randconfig-001-20250415    gcc-14.2.0
loongarch             randconfig-001-20250416    gcc-7.5.0
loongarch             randconfig-002-20250415    gcc-14.2.0
loongarch             randconfig-002-20250416    gcc-7.5.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                             allmodconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                             allyesconfig    gcc-14.2.0
mips                          eyeq5_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250415    gcc-13.3.0
nios2                 randconfig-001-20250416    gcc-7.5.0
nios2                 randconfig-002-20250415    gcc-7.5.0
nios2                 randconfig-002-20250416    gcc-7.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250415    gcc-12.4.0
parisc                randconfig-001-20250416    gcc-7.5.0
parisc                randconfig-002-20250415    gcc-10.5.0
parisc                randconfig-002-20250416    gcc-7.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc               randconfig-001-20250415    gcc-5.5.0
powerpc               randconfig-001-20250416    gcc-7.5.0
powerpc               randconfig-002-20250415    clang-17
powerpc               randconfig-002-20250416    gcc-7.5.0
powerpc               randconfig-003-20250415    gcc-7.5.0
powerpc               randconfig-003-20250416    gcc-7.5.0
powerpc64             randconfig-001-20250415    gcc-7.5.0
powerpc64             randconfig-001-20250416    gcc-7.5.0
powerpc64             randconfig-002-20250415    clang-17
powerpc64             randconfig-002-20250416    gcc-7.5.0
powerpc64             randconfig-003-20250415    gcc-10.5.0
powerpc64             randconfig-003-20250416    gcc-7.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-14.2.0
riscv                    nommu_k210_defconfig    clang-21
riscv                 randconfig-001-20250415    gcc-14.2.0
riscv                 randconfig-001-20250416    gcc-14.2.0
riscv                 randconfig-002-20250415    gcc-9.3.0
riscv                 randconfig-002-20250416    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250415    clang-21
s390                  randconfig-001-20250416    gcc-14.2.0
s390                  randconfig-002-20250415    gcc-7.5.0
s390                  randconfig-002-20250416    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250415    gcc-11.5.0
sh                    randconfig-001-20250416    gcc-14.2.0
sh                    randconfig-002-20250415    gcc-9.3.0
sh                    randconfig-002-20250416    gcc-14.2.0
sh                           se7721_defconfig    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250415    gcc-6.5.0
sparc                 randconfig-001-20250416    gcc-14.2.0
sparc                 randconfig-002-20250415    gcc-12.4.0
sparc                 randconfig-002-20250416    gcc-14.2.0
sparc                       sparc64_defconfig    clang-21
sparc64               randconfig-001-20250415    gcc-14.2.0
sparc64               randconfig-001-20250416    gcc-14.2.0
sparc64               randconfig-002-20250415    gcc-12.4.0
sparc64               randconfig-002-20250416    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                    randconfig-001-20250415    clang-21
um                    randconfig-001-20250416    gcc-14.2.0
um                    randconfig-002-20250415    clang-21
um                    randconfig-002-20250416    gcc-14.2.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250415    clang-20
x86_64      buildonly-randconfig-001-20250416    clang-20
x86_64      buildonly-randconfig-002-20250415    gcc-11
x86_64      buildonly-randconfig-002-20250416    clang-20
x86_64      buildonly-randconfig-003-20250415    gcc-12
x86_64      buildonly-randconfig-003-20250416    clang-20
x86_64      buildonly-randconfig-004-20250415    clang-20
x86_64      buildonly-randconfig-004-20250416    clang-20
x86_64      buildonly-randconfig-005-20250415    clang-20
x86_64      buildonly-randconfig-005-20250416    clang-20
x86_64      buildonly-randconfig-006-20250415    gcc-12
x86_64      buildonly-randconfig-006-20250416    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250416    gcc-12
x86_64                randconfig-002-20250416    gcc-12
x86_64                randconfig-003-20250416    gcc-12
x86_64                randconfig-004-20250416    gcc-12
x86_64                randconfig-005-20250416    gcc-12
x86_64                randconfig-006-20250416    gcc-12
x86_64                randconfig-007-20250416    gcc-12
x86_64                randconfig-008-20250416    gcc-12
x86_64                randconfig-071-20250416    gcc-12
x86_64                randconfig-072-20250416    gcc-12
x86_64                randconfig-073-20250416    gcc-12
x86_64                randconfig-074-20250416    gcc-12
x86_64                randconfig-075-20250416    gcc-12
x86_64                randconfig-076-20250416    gcc-12
x86_64                randconfig-077-20250416    gcc-12
x86_64                randconfig-078-20250416    gcc-12
x86_64                               rhel-9.4    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250415    gcc-6.5.0
xtensa                randconfig-001-20250416    gcc-14.2.0
xtensa                randconfig-002-20250415    gcc-10.5.0
xtensa                randconfig-002-20250416    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
