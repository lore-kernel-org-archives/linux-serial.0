Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C3F2F3C3F
	for <linux-serial@vger.kernel.org>; Sat, 24 Jan 2026 04:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769229530; cv=none; b=kLrEYoDe76OHvLz0pCTBuie5tvy3mSz8E81mXtVvRngS7PKnajmMoUGhbfDd4Khnsvoo7OWnP2KTp1FiznX6v5fYxJhTugQ5IjQuiqEbWtK1IB7MH/4K8rt6uAmkB/sGw15JyAEyidiINsB7Vp7/JKt5pOiwbbpWAWoW+0GXv28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769229530; c=relaxed/simple;
	bh=oNKkxXLrCJqmHGUbuFtp6WLRZhDOGy7ZiflaUUt6Brw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ci2YGAs7CeyvRVG5YTSjyGMW0r3zKctv+4s6uaofiSkyDwQTmCaiY7NH6TNjGtrVaQseae9nkaF0gmGdX2K+cbJoMf9BeV0IfJAJ1dMb0hoQ/hdngZIG1jlCQJHKtTM2dc1fLWIWiN0mPeJUvwCVAZw1kSCaWAztp+w5+VVxUOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nwOAbRXr; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nwOAbRXr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769229529; x=1800765529;
  h=date:from:to:cc:subject:message-id;
  bh=oNKkxXLrCJqmHGUbuFtp6WLRZhDOGy7ZiflaUUt6Brw=;
  b=nwOAbRXr8WDJr3zBo8H/iG9RUTKMWVD8T68wlqHSj90SulDFjdKGW0rj
   XvVH3v+hHoSi9xeqZ9o5ewBMwSS/SZ/C6C4xvsx6sZ8ucGcTrLRuo6H3N
   ZLyloEc+S/TtJ2oBnzKBMgBnSN6zq6KpqO/Izobi5AEwx+cntdvTuBNre
   Fjbsi9rZ9d/Ex3AGniE/Q6YLyknuOQ915VyerSxLmR98fM5ZdqM102UWu
   NFJUG9xNyiq9WDvQjS5AlGurOlDk4X/aT+cZ13/QO0opFWaOfPy5rpAaC
   SkDPicIoamySMB/ZJIBDXrdqJqOOe92iCsRUD/Og12icGYfVyhK1drHCa
   Q==;
X-CSE-ConnectionGUID: UHqvUBonTp+OhLscRaWa9A==
X-CSE-MsgGUID: HGYtc2YlSl2IXERUfIGDlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="73065839"
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="73065839"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 20:38:46 -0800
X-CSE-ConnectionGUID: 9FbvWLVATg+guMAc4fyi4g==
X-CSE-MsgGUID: IBLr5+uFSg+1nbmDZJMCfQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 23 Jan 2026 20:38:44 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjVQ2-00000000UpG-3AIW;
	Sat, 24 Jan 2026 04:38:42 +0000
Date: Sat, 24 Jan 2026 12:38:31 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 d000422a46aad32217cf1be747eb61d641baae2f
Message-ID: <202601241225.1a74X7UM-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: d000422a46aad32217cf1be747eb61d641baae2f  tty: tty_port: add workqueue to flip TTY buffer

elapsed time: 729m

configs tested: 204
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                      axs103_smp_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260124    clang-18
arc                   randconfig-002-20260124    clang-18
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                          gemini_defconfig    gcc-15.2.0
arm                       imx_v4_v5_defconfig    gcc-15.2.0
arm                       multi_v4t_defconfig    clang-16
arm                          pxa168_defconfig    clang-16
arm                   randconfig-001-20260124    clang-18
arm                   randconfig-002-20260124    clang-18
arm                   randconfig-003-20260124    clang-18
arm                   randconfig-004-20260124    clang-18
arm                           sama7_defconfig    clang-16
arm                        spear3xx_defconfig    gcc-15.2.0
arm                       versatile_defconfig    gcc-15.2.0
arm                    vt8500_v6_v7_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260124    gcc-15.2.0
arm64                 randconfig-002-20260124    gcc-15.2.0
arm64                 randconfig-003-20260124    gcc-15.2.0
arm64                 randconfig-004-20260124    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260124    gcc-15.2.0
csky                  randconfig-002-20260124    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260124    gcc-15.2.0
hexagon               randconfig-002-20260124    gcc-15.2.0
i386                             alldefconfig    clang-16
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260124    gcc-14
i386        buildonly-randconfig-002-20260124    gcc-14
i386        buildonly-randconfig-003-20260124    gcc-14
i386        buildonly-randconfig-004-20260124    gcc-14
i386        buildonly-randconfig-005-20260124    gcc-14
i386        buildonly-randconfig-006-20260124    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260124    gcc-14
i386                  randconfig-002-20260124    gcc-14
i386                  randconfig-003-20260124    gcc-14
i386                  randconfig-004-20260124    gcc-14
i386                  randconfig-005-20260124    gcc-14
i386                  randconfig-006-20260124    gcc-14
i386                  randconfig-007-20260124    gcc-14
i386                  randconfig-011-20260124    clang-20
i386                  randconfig-012-20260124    clang-20
i386                  randconfig-013-20260124    clang-20
i386                  randconfig-014-20260124    clang-20
i386                  randconfig-015-20260124    clang-20
i386                  randconfig-016-20260124    clang-20
i386                  randconfig-017-20260124    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260124    gcc-15.2.0
loongarch             randconfig-002-20260124    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                       m5475evb_defconfig    gcc-15.2.0
m68k                           virt_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                malta_qemu_32r6_defconfig    clang-16
mips                  maltasmvp_eva_defconfig    gcc-15.2.0
mips                        maltaup_defconfig    gcc-15.2.0
mips                    maltaup_xpa_defconfig    gcc-15.2.0
mips                        qi_lb60_defconfig    clang-16
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260124    gcc-15.2.0
nios2                 randconfig-002-20260124    gcc-15.2.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260124    gcc-8.5.0
parisc                randconfig-002-20260124    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                   motionpro_defconfig    gcc-15.2.0
powerpc                     ppa8548_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260124    gcc-8.5.0
powerpc               randconfig-002-20260124    gcc-8.5.0
powerpc64             randconfig-001-20260124    gcc-8.5.0
powerpc64             randconfig-002-20260124    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260124    gcc-8.5.0
riscv                 randconfig-002-20260124    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260124    gcc-8.5.0
s390                  randconfig-002-20260124    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                        edosk7705_defconfig    gcc-15.2.0
sh                          r7780mp_defconfig    clang-16
sh                    randconfig-001-20260124    gcc-8.5.0
sh                    randconfig-002-20260124    gcc-8.5.0
sh                   secureedge5410_defconfig    clang-16
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260124    gcc-13.4.0
sparc                 randconfig-002-20260124    gcc-13.4.0
sparc                       sparc64_defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260124    gcc-13.4.0
sparc64               randconfig-002-20260124    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260124    gcc-13.4.0
um                    randconfig-002-20260124    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           alldefconfig    gcc-15.2.0
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260124    clang-20
x86_64      buildonly-randconfig-002-20260124    clang-20
x86_64      buildonly-randconfig-003-20260124    clang-20
x86_64      buildonly-randconfig-004-20260124    clang-20
x86_64      buildonly-randconfig-005-20260124    clang-20
x86_64      buildonly-randconfig-006-20260124    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260124    gcc-13
x86_64                randconfig-002-20260124    gcc-13
x86_64                randconfig-003-20260124    gcc-13
x86_64                randconfig-004-20260124    gcc-13
x86_64                randconfig-005-20260124    gcc-13
x86_64                randconfig-006-20260124    gcc-13
x86_64                randconfig-011-20260124    gcc-12
x86_64                randconfig-012-20260124    gcc-12
x86_64                randconfig-013-20260124    gcc-12
x86_64                randconfig-014-20260124    gcc-12
x86_64                randconfig-015-20260124    gcc-12
x86_64                randconfig-016-20260124    gcc-12
x86_64                randconfig-071-20260124    gcc-14
x86_64                randconfig-072-20260124    gcc-14
x86_64                randconfig-073-20260124    gcc-14
x86_64                randconfig-074-20260124    gcc-14
x86_64                randconfig-075-20260124    gcc-14
x86_64                randconfig-076-20260124    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20260124    gcc-13.4.0
xtensa                randconfig-002-20260124    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
