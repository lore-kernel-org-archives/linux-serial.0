Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E8C82499
	for <linux-serial@vger.kernel.org>; Tue, 22 Oct 2024 01:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729559645; cv=none; b=e84644IfFk9CLMEEMPGYTiACmtuUSzjK+sqH0x19qC0ax5tx78/tONK7fB1zKZNgFoJkxXFAMtnGIgUq8+M1y2qlnUzbn9zJS0KmQ9ivQ9ScZZJl+/yaiMZbt710xLFgiiQ1R6CB7qSQB1sq9uxbcJ7f7z24gt0B5OHhdxYXPuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729559645; c=relaxed/simple;
	bh=AxxHCNPDNAF72PcLRGbOyzk8DhEqiW7k5I6oXPWMxis=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GumN3iFmKq952JZMKLWZUod1x1yYUCClIUaQGqxEyHs8wOVrUy6GkUqYB9IL0RJpOem4zHe2z638ucu2/BeH+q2mO6CuEA1ic2du3Ih2gGBEjYql7wiNtARUhi5BvumK3V2u06lI/KhYfbsdgfXrmEOu6OJtOz6w4WX0LxCgS3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULkiLYJV; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULkiLYJV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729559643; x=1761095643;
  h=date:from:to:cc:subject:message-id;
  bh=AxxHCNPDNAF72PcLRGbOyzk8DhEqiW7k5I6oXPWMxis=;
  b=ULkiLYJV/uogbsSjguZgMYtEcVTddSjPkkK96zabaJpB1bUgnjr6NLPy
   oqYomzkooQQR62snkFA9IKZ58RDvve1QdjS4fT4lVKKAu8b5xXWGzwzPX
   ZnStmH7oVp4HxTvSHVtSYNrzHalC2o4f2alUpc0MSUBA4TMOMLxMCaLxL
   11e0uM4Z8wxpT2AloUKiJ5Bnxp/SZqMFhKr+8ZRt9YXG4WJvx4NdEptCZ
   rSyoPNHrA6YjT/OETrJdrwy0iwdc37qD2TOTbOCF85i3hMhJaOBYXyzJx
   QcW00ZnsYE/qfCnDWoM+SoLP1Gcq1m/l0WhPvDCcEUXUXLvn5AABe9Fyf
   Q==;
X-CSE-ConnectionGUID: NRL6kmrzR4uOsy0RlLhQlQ==
X-CSE-MsgGUID: OM9L7LY/Txyz6rSA2pOtww==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="29186542"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="29186542"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 18:14:03 -0700
X-CSE-ConnectionGUID: tsvrXUJDQm2MkuSoLM/7bw==
X-CSE-MsgGUID: Chldnuu5RpKwiSkTOojh8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="84305319"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 21 Oct 2024 18:14:01 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t33TD-000Srw-0k;
	Tue, 22 Oct 2024 01:13:59 +0000
Date: Tue, 22 Oct 2024 09:13:37 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 ec8c17e5ecb4a5a74069687ccb6d2cfe1851302e
Message-ID: <202410220929.VKKf52fo-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: ec8c17e5ecb4a5a74069687ccb6d2cfe1851302e  Merge 6.12-rc4 into tty-next

elapsed time: 1027m

configs tested: 227
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                      axs103_smp_defconfig    gcc-14.1.0
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241021    gcc-14.1.0
arc                   randconfig-001-20241022    gcc-14.1.0
arc                   randconfig-002-20241021    gcc-14.1.0
arc                   randconfig-002-20241022    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                        clps711x_defconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                             mxs_defconfig    gcc-14.1.0
arm                       omap2plus_defconfig    gcc-14.1.0
arm                   randconfig-001-20241021    gcc-14.1.0
arm                   randconfig-001-20241022    gcc-14.1.0
arm                   randconfig-002-20241021    gcc-14.1.0
arm                   randconfig-002-20241022    gcc-14.1.0
arm                   randconfig-003-20241021    gcc-14.1.0
arm                   randconfig-003-20241022    gcc-14.1.0
arm                   randconfig-004-20241021    gcc-14.1.0
arm                   randconfig-004-20241022    gcc-14.1.0
arm                             rpc_defconfig    gcc-14.1.0
arm                         socfpga_defconfig    gcc-14.1.0
arm                       versatile_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241021    gcc-14.1.0
arm64                 randconfig-001-20241022    gcc-14.1.0
arm64                 randconfig-002-20241021    gcc-14.1.0
arm64                 randconfig-002-20241022    gcc-14.1.0
arm64                 randconfig-003-20241021    gcc-14.1.0
arm64                 randconfig-003-20241022    gcc-14.1.0
arm64                 randconfig-004-20241021    gcc-14.1.0
arm64                 randconfig-004-20241022    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241021    gcc-14.1.0
csky                  randconfig-001-20241022    gcc-14.1.0
csky                  randconfig-002-20241021    gcc-14.1.0
csky                  randconfig-002-20241022    gcc-14.1.0
hexagon                          alldefconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241021    gcc-14.1.0
hexagon               randconfig-001-20241022    gcc-14.1.0
hexagon               randconfig-002-20241021    gcc-14.1.0
hexagon               randconfig-002-20241022    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241021    clang-18
i386        buildonly-randconfig-002-20241021    clang-18
i386        buildonly-randconfig-003-20241021    clang-18
i386        buildonly-randconfig-004-20241021    clang-18
i386        buildonly-randconfig-005-20241021    clang-18
i386        buildonly-randconfig-006-20241021    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241021    clang-18
i386                  randconfig-002-20241021    clang-18
i386                  randconfig-003-20241021    clang-18
i386                  randconfig-004-20241021    clang-18
i386                  randconfig-005-20241021    clang-18
i386                  randconfig-006-20241021    clang-18
i386                  randconfig-011-20241021    clang-18
i386                  randconfig-012-20241021    clang-18
i386                  randconfig-013-20241021    clang-18
i386                  randconfig-014-20241021    clang-18
i386                  randconfig-015-20241021    clang-18
i386                  randconfig-016-20241021    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241021    gcc-14.1.0
loongarch             randconfig-001-20241022    gcc-14.1.0
loongarch             randconfig-002-20241021    gcc-14.1.0
loongarch             randconfig-002-20241022    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                        m5307c3_defconfig    gcc-14.1.0
m68k                       m5475evb_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                        bcm47xx_defconfig    gcc-14.1.0
mips                        bcm63xx_defconfig    gcc-14.1.0
mips                          eyeq6_defconfig    gcc-14.1.0
mips                     loongson1b_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241021    gcc-14.1.0
nios2                 randconfig-001-20241022    gcc-14.1.0
nios2                 randconfig-002-20241021    gcc-14.1.0
nios2                 randconfig-002-20241022    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241021    gcc-14.1.0
parisc                randconfig-001-20241022    gcc-14.1.0
parisc                randconfig-002-20241021    gcc-14.1.0
parisc                randconfig-002-20241022    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                       maple_defconfig    gcc-14.1.0
powerpc                     mpc512x_defconfig    gcc-14.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-14.1.0
powerpc                       ppc64_defconfig    gcc-14.1.0
powerpc                      ppc64e_defconfig    gcc-14.1.0
powerpc                         ps3_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241021    gcc-14.1.0
powerpc               randconfig-001-20241022    gcc-14.1.0
powerpc               randconfig-002-20241021    gcc-14.1.0
powerpc               randconfig-002-20241022    gcc-14.1.0
powerpc               randconfig-003-20241021    gcc-14.1.0
powerpc               randconfig-003-20241022    gcc-14.1.0
powerpc                     tqm5200_defconfig    gcc-14.1.0
powerpc                     tqm8548_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20241021    gcc-14.1.0
powerpc64             randconfig-001-20241022    gcc-14.1.0
powerpc64             randconfig-002-20241021    gcc-14.1.0
powerpc64             randconfig-002-20241022    gcc-14.1.0
powerpc64             randconfig-003-20241021    gcc-14.1.0
powerpc64             randconfig-003-20241022    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241021    gcc-14.1.0
riscv                 randconfig-001-20241022    gcc-14.1.0
riscv                 randconfig-002-20241021    gcc-14.1.0
riscv                 randconfig-002-20241022    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241021    gcc-14.1.0
s390                  randconfig-001-20241022    gcc-14.1.0
s390                  randconfig-002-20241021    gcc-14.1.0
s390                  randconfig-002-20241022    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                        apsh4ad0a_defconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                        edosk7705_defconfig    gcc-14.1.0
sh                          landisk_defconfig    gcc-14.1.0
sh                    randconfig-001-20241021    gcc-14.1.0
sh                    randconfig-001-20241022    gcc-14.1.0
sh                    randconfig-002-20241021    gcc-14.1.0
sh                    randconfig-002-20241022    gcc-14.1.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.1.0
sh                             shx3_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241021    gcc-14.1.0
sparc64               randconfig-001-20241022    gcc-14.1.0
sparc64               randconfig-002-20241021    gcc-14.1.0
sparc64               randconfig-002-20241022    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241021    gcc-14.1.0
um                    randconfig-001-20241022    gcc-14.1.0
um                    randconfig-002-20241021    gcc-14.1.0
um                    randconfig-002-20241022    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241022    clang-18
x86_64      buildonly-randconfig-002-20241022    clang-18
x86_64      buildonly-randconfig-003-20241022    clang-18
x86_64      buildonly-randconfig-004-20241022    clang-18
x86_64      buildonly-randconfig-005-20241022    clang-18
x86_64      buildonly-randconfig-006-20241022    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241022    clang-18
x86_64                randconfig-002-20241022    clang-18
x86_64                randconfig-003-20241022    clang-18
x86_64                randconfig-004-20241022    clang-18
x86_64                randconfig-005-20241022    clang-18
x86_64                randconfig-006-20241022    clang-18
x86_64                randconfig-011-20241022    clang-18
x86_64                randconfig-012-20241022    clang-18
x86_64                randconfig-013-20241022    clang-18
x86_64                randconfig-014-20241022    clang-18
x86_64                randconfig-015-20241022    clang-18
x86_64                randconfig-016-20241022    clang-18
x86_64                randconfig-071-20241022    clang-18
x86_64                randconfig-072-20241022    clang-18
x86_64                randconfig-073-20241022    clang-18
x86_64                randconfig-074-20241022    clang-18
x86_64                randconfig-075-20241022    clang-18
x86_64                randconfig-076-20241022    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-18
x86_64                    rhel-8.3-kselftests    gcc-12
x86_64                         rhel-8.3-kunit    clang-18
x86_64                           rhel-8.3-ltp    clang-18
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241021    gcc-14.1.0
xtensa                randconfig-001-20241022    gcc-14.1.0
xtensa                randconfig-002-20241021    gcc-14.1.0
xtensa                randconfig-002-20241022    gcc-14.1.0
xtensa                    smp_lx200_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
