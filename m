Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5D02FAC0E
	for <linux-serial@vger.kernel.org>; Thu, 23 Oct 2025 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209655; cv=none; b=uUmd8gD3gjex6WSC1mik26ZbkJy37XE2yuBVkuBP3P0N/A4dj4kFIa1kUYWPOQXCj4nrfqq/d/I2Wd2dOn4IV1z/mwqKvHoQqjxR2uok0UfstzwUZhc4QLuBQ2Z6yvk4k5t8U+LvtsUaLnyXQxA+JtZ/Xbivw49QBeprpTfE1tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209655; c=relaxed/simple;
	bh=MexHNgcN3YK67HwOIju87RI0d2goNbrirjVLoZ37Cyk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LMzmx3nL8QewHtb9DwXCSp0zWD6G615xq4tBGuxY/bc2++uaE87um1r9E3mm++TW1vb1tz1qVASxOpAIFEUrLhpw8Qz0ZvR2Y8Ykne4K5/EqljkF/xF3B/WcwPTHCqmMKsjBNcuyrW9F5S0+dYt38YtEFg7BfpMtarymPrnaIKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CVYVGxYZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVYVGxYZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761209654; x=1792745654;
  h=date:from:to:cc:subject:message-id;
  bh=MexHNgcN3YK67HwOIju87RI0d2goNbrirjVLoZ37Cyk=;
  b=CVYVGxYZRt0fiIPhPEzY78PQ9sJpRqi/VFDj2iwi00Zd1XVCmmqQ+tA4
   i7vDL+s2hx7F0Z3BGCfgLNOd36oe65zr2RkANdcyBRYhXNFg0LpX7cpeh
   PmwVH1DlbC7xgYKYC2J5pFnQmlZpZzV5rUQP9Cg3PzzPKH7yMPyeUVqrn
   iH62SOWBYl1fiC/fZ1j43eIF7iaN0UmMjImcv9Xoj89diA+zCHMson7VQ
   8ZsWsZLS0GbPv8WY3uTQUAGjtJa67HgJ09L7g2+y85AgUolA8p+1ksMJp
   Y64gADajujWuL4MSqIXRcAMVK2ZnIPAmiF203rL8z3itVHWapgN8vQDxH
   Q==;
X-CSE-ConnectionGUID: XndANQJaTYW2Sd11wCjeOQ==
X-CSE-MsgGUID: U05nwp93Q6OtgX0JH5AKdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="88840143"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="88840143"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 01:54:13 -0700
X-CSE-ConnectionGUID: /EG0MdLcRVSxkZ2LjS2ppA==
X-CSE-MsgGUID: w16il7/AQZyIAAoAKaMZqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="184034529"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 23 Oct 2025 01:54:12 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBr4V-000DFd-0I;
	Thu, 23 Oct 2025 08:53:26 +0000
Date: Thu, 23 Oct 2025 16:52:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 d518314a1fa4e980a227d1b2bda1badf433cb932
Message-ID: <202510231642.JTmTYTgj-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: d518314a1fa4e980a227d1b2bda1badf433cb932  serial: 8250_mtk: Enable baud clock and manage in runtime PM

elapsed time: 1312m

configs tested: 257
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20251022    gcc-13.4.0
arc                   randconfig-001-20251023    gcc-8.5.0
arc                   randconfig-002-20251022    gcc-8.5.0
arc                   randconfig-002-20251023    gcc-8.5.0
arm                              alldefconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                          gemini_defconfig    gcc-15.1.0
arm                           h3600_defconfig    clang-22
arm                           h3600_defconfig    gcc-15.1.0
arm                        multi_v7_defconfig    gcc-15.1.0
arm                   randconfig-001-20251022    gcc-11.5.0
arm                   randconfig-001-20251023    gcc-8.5.0
arm                   randconfig-002-20251022    gcc-10.5.0
arm                   randconfig-002-20251023    gcc-8.5.0
arm                   randconfig-003-20251022    gcc-10.5.0
arm                   randconfig-003-20251023    gcc-8.5.0
arm                   randconfig-004-20251022    clang-22
arm                   randconfig-004-20251023    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251022    gcc-9.5.0
arm64                 randconfig-001-20251023    gcc-8.5.0
arm64                 randconfig-002-20251022    clang-18
arm64                 randconfig-002-20251023    gcc-8.5.0
arm64                 randconfig-003-20251022    gcc-10.5.0
arm64                 randconfig-003-20251023    gcc-8.5.0
arm64                 randconfig-004-20251022    gcc-12.5.0
arm64                 randconfig-004-20251023    gcc-8.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    clang-22
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251022    gcc-15.1.0
csky                  randconfig-001-20251023    gcc-10.5.0
csky                  randconfig-002-20251022    gcc-11.5.0
csky                  randconfig-002-20251023    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251022    clang-22
hexagon               randconfig-001-20251023    gcc-10.5.0
hexagon               randconfig-002-20251022    clang-22
hexagon               randconfig-002-20251023    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251022    clang-20
i386        buildonly-randconfig-001-20251023    clang-20
i386        buildonly-randconfig-002-20251022    clang-20
i386        buildonly-randconfig-002-20251023    clang-20
i386        buildonly-randconfig-003-20251022    gcc-14
i386        buildonly-randconfig-003-20251023    clang-20
i386        buildonly-randconfig-004-20251022    clang-20
i386        buildonly-randconfig-004-20251023    clang-20
i386        buildonly-randconfig-005-20251022    gcc-12
i386        buildonly-randconfig-005-20251023    clang-20
i386        buildonly-randconfig-006-20251022    gcc-14
i386        buildonly-randconfig-006-20251023    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251023    clang-20
i386                  randconfig-002-20251023    clang-20
i386                  randconfig-003-20251023    clang-20
i386                  randconfig-004-20251023    clang-20
i386                  randconfig-005-20251023    clang-20
i386                  randconfig-006-20251023    clang-20
i386                  randconfig-007-20251023    clang-20
i386                  randconfig-011-20251023    gcc-14
i386                  randconfig-012-20251023    gcc-14
i386                  randconfig-013-20251023    gcc-14
i386                  randconfig-014-20251023    gcc-14
i386                  randconfig-015-20251023    gcc-14
i386                  randconfig-016-20251023    gcc-14
i386                  randconfig-017-20251023    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251022    gcc-12.5.0
loongarch             randconfig-001-20251023    gcc-10.5.0
loongarch             randconfig-002-20251022    gcc-15.1.0
loongarch             randconfig-002-20251023    gcc-10.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                         amcore_defconfig    clang-22
m68k                                defconfig    clang-19
m68k                        stmark2_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                          eyeq5_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251022    gcc-8.5.0
nios2                 randconfig-001-20251023    gcc-10.5.0
nios2                 randconfig-002-20251022    gcc-10.5.0
nios2                 randconfig-002-20251023    gcc-10.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251022    gcc-13.4.0
parisc                randconfig-001-20251023    gcc-10.5.0
parisc                randconfig-002-20251022    gcc-10.5.0
parisc                randconfig-002-20251023    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     asp8347_defconfig    clang-22
powerpc                     ep8248e_defconfig    clang-22
powerpc               randconfig-001-20251022    gcc-8.5.0
powerpc               randconfig-001-20251023    gcc-10.5.0
powerpc               randconfig-002-20251022    gcc-8.5.0
powerpc               randconfig-002-20251023    gcc-10.5.0
powerpc               randconfig-003-20251022    gcc-8.5.0
powerpc               randconfig-003-20251023    gcc-10.5.0
powerpc                 xes_mpc85xx_defconfig    clang-22
powerpc64             randconfig-001-20251022    gcc-8.5.0
powerpc64             randconfig-001-20251023    gcc-10.5.0
powerpc64             randconfig-002-20251022    gcc-8.5.0
powerpc64             randconfig-002-20251023    gcc-10.5.0
powerpc64             randconfig-003-20251022    clang-22
powerpc64             randconfig-003-20251023    gcc-10.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251023    gcc-8.5.0
riscv                 randconfig-002-20251023    gcc-14.3.0
riscv                 randconfig-002-20251023    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251023    clang-19
s390                  randconfig-001-20251023    gcc-8.5.0
s390                  randconfig-002-20251023    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                             espt_defconfig    gcc-15.1.0
sh                     magicpanelr2_defconfig    clang-22
sh                            migor_defconfig    clang-22
sh                    randconfig-001-20251023    gcc-15.1.0
sh                    randconfig-001-20251023    gcc-8.5.0
sh                    randconfig-002-20251023    gcc-15.1.0
sh                    randconfig-002-20251023    gcc-8.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251023    gcc-12.5.0
sparc                 randconfig-001-20251023    gcc-8.5.0
sparc                 randconfig-002-20251023    gcc-8.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251023    clang-22
sparc64               randconfig-001-20251023    gcc-8.5.0
sparc64               randconfig-002-20251023    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251023    gcc-13
um                    randconfig-001-20251023    gcc-8.5.0
um                    randconfig-002-20251023    gcc-14
um                    randconfig-002-20251023    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251022    clang-20
x86_64      buildonly-randconfig-001-20251023    gcc-14
x86_64      buildonly-randconfig-002-20251022    gcc-14
x86_64      buildonly-randconfig-002-20251023    gcc-14
x86_64      buildonly-randconfig-003-20251022    gcc-14
x86_64      buildonly-randconfig-003-20251023    gcc-14
x86_64      buildonly-randconfig-004-20251022    clang-20
x86_64      buildonly-randconfig-004-20251023    gcc-14
x86_64      buildonly-randconfig-005-20251022    gcc-14
x86_64      buildonly-randconfig-005-20251023    gcc-14
x86_64      buildonly-randconfig-006-20251022    gcc-14
x86_64      buildonly-randconfig-006-20251023    gcc-14
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251023    clang-20
x86_64                randconfig-002-20251023    clang-20
x86_64                randconfig-003-20251023    clang-20
x86_64                randconfig-004-20251023    clang-20
x86_64                randconfig-005-20251023    clang-20
x86_64                randconfig-006-20251023    clang-20
x86_64                randconfig-007-20251023    clang-20
x86_64                randconfig-008-20251023    clang-20
x86_64                randconfig-071-20251023    clang-20
x86_64                randconfig-072-20251023    clang-20
x86_64                randconfig-073-20251023    clang-20
x86_64                randconfig-074-20251023    clang-20
x86_64                randconfig-075-20251023    clang-20
x86_64                randconfig-076-20251023    clang-20
x86_64                randconfig-077-20251023    clang-20
x86_64                randconfig-078-20251023    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    clang-22
xtensa                randconfig-001-20251023    gcc-8.5.0
xtensa                randconfig-002-20251023    gcc-13.4.0
xtensa                randconfig-002-20251023    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
