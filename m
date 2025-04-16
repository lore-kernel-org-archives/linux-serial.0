Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B9318DB2B
	for <linux-serial@vger.kernel.org>; Wed, 16 Apr 2025 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744810209; cv=none; b=aeHk56Dztgkl7o2+HCKWxiJ+MUSJALQdI5Cu4UJcjlofDbS8g3UpDY049Y9ODQa1Je4nENkkj2lXxhGv+zMlmvVjGmgh/Vy2k/yk4Vo57cDjONmYQkVV2BJEy6grCWZJvrjm9n3HNBjSV3SiFEd7u0cjUDPT0UhK9tGwKFzF39o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744810209; c=relaxed/simple;
	bh=2hGEHXOtaSRIv50ZqtKRR6wyrkam3Pc2TW7+A442Jj8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RmeCLPjhjcRCQERMuLGds7ns9Jwqm/rToJcqp90YKWcPplCDXLzNwCHdyos7xkgGBSEVvVV7rCJbb5HLNouxHR+ANguQk7foOoMHpjJyt3jQEZGOY+CVTRoPN4YNkbuxw106Pwy+4EET0kzN2zvxbUg7SIvCOz+QdchD65uQnjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ma0nqdnJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ma0nqdnJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744810207; x=1776346207;
  h=date:from:to:cc:subject:message-id;
  bh=2hGEHXOtaSRIv50ZqtKRR6wyrkam3Pc2TW7+A442Jj8=;
  b=Ma0nqdnJg8zVsrT7wAJQ32K5o0/XOKbtA8b9vPZGCYBa3En7Yxa3l7z1
   hJh9YnAvH+RMuGoG3vzwQxGkkcbjjeJhhb4xixmOogpwimJQssxHcBxv0
   42KIrKG+qV0IKbC5XczhhSBWZi7b2XV7Uk5jKQH/qZ79tO2bkegpfIBWr
   PJWXR4xmzzPzVaoqau7KimfwEBx3jIZysYXKoGZZtn2W6kUxP619yXT1O
   69tv3aRUZIcx4edGaeJmP/mRsEJqhwixrmj6w9ojqNBxx++vlAF5bdJ9X
   qDRWZxE6gfHmuVIMyeo+HKHoTSV1CeO75vX1twLWOTxHYZwoXhZKVpuEA
   w==;
X-CSE-ConnectionGUID: ErqlwLDfRj6FFzJdcVcV5A==
X-CSE-MsgGUID: 90o7XS46RieLm8arsuyM0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="57350340"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="57350340"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 06:30:00 -0700
X-CSE-ConnectionGUID: sFYs2aadRgSy7em2JwFICQ==
X-CSE-MsgGUID: PjdZHkd0Q9+mUB02jRAgBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="130500012"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 Apr 2025 06:29:59 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u52pw-000JnW-38;
	Wed, 16 Apr 2025 13:29:56 +0000
Date: Wed, 16 Apr 2025 21:29:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 e1ca3ff28ab1e2c1e70713ef3fa7943c725742c3
Message-ID: <202504162128.5vrwQGMP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: e1ca3ff28ab1e2c1e70713ef3fa7943c725742c3  serial: sifive: lock port in startup()/shutdown() callbacks

elapsed time: 1450m

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
