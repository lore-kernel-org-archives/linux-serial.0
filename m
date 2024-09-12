Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A3919F42D
	for <linux-serial@vger.kernel.org>; Thu, 12 Sep 2024 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726142638; cv=none; b=GLtWC19x+f5JvNn9SHhqxh7bkDC3GHMxnaKFUpgC+9qb/vhAy4b3drv8Dd3PZEc73yq5u6JpF/IskLTJzBjmlWDt+0JaqhwtxX53hqhqV1wP/Dld+4KAaR9SoWhP3oWVcBfL0DGnizM075u9l2ZP+rl+xJhjiwVwW0djs/gGZTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726142638; c=relaxed/simple;
	bh=JyS3wjPl2o00hv8nwjUsGMa8F0P0ANiqD34/HXxy0QQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pGk+faMHYk88wzmEcznvPxfyi0p86Rn3+uLnS7GyG3x7t80tfV4Bf8bC5EEZVrXpDIUEPJaBYruUMqvN/5066p29DReflT75T4T3nu5n+bK/czUxKdFmyEiY1cB9Wa2lBebNwUnZmyVblAcARH9aoHBEiizL5+W6zSxsF7SotzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nc+UeT9W; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nc+UeT9W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726142636; x=1757678636;
  h=date:from:to:cc:subject:message-id;
  bh=JyS3wjPl2o00hv8nwjUsGMa8F0P0ANiqD34/HXxy0QQ=;
  b=nc+UeT9WSoEW0PTb0Kpv6IQeIHoR+M/wTQXaPNc572owc68S9NeMtNDk
   trNEqddvfqtBTSykYpyANIyGiqCfXa5ga6smAxS5l2EkBHUWpY74BczLE
   wf9x+FWHl2pDpV5lyz3LR7l9rV5Fbu2V9HAC++YzQIT8yzFJkdfbgu9zR
   Di3GwUrVVRlTWLR3NdtxKaF9/pl2udvaIcRtIVotdCbL2HnvzzSOeJqnu
   GPlauDs6IQbo4CugmpBQQJkgUmjx1aGxJhj2a0WghePEppts+CNncJifu
   2EZj1JzBY1vGy05mRjNMRrumA6H8mpMBHxbghqZXizQf/HSIz95RTi5Ov
   w==;
X-CSE-ConnectionGUID: eTWnR2xUR0iOnxsxGLI2DA==
X-CSE-MsgGUID: HExMPr/lTROr+SU2cRGeVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="36337072"
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="36337072"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 05:03:56 -0700
X-CSE-ConnectionGUID: 4A/Hs4/nQnmlUqMZ1l8fYQ==
X-CSE-MsgGUID: z0PcmHZEQXOJ3XkIeWToqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="72049614"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 12 Sep 2024 05:03:54 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soiYC-000576-0t;
	Thu, 12 Sep 2024 12:03:52 +0000
Date: Thu, 12 Sep 2024 20:03:08 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 5ed771f174726ae879945d4f148a9005ac909cb7
Message-ID: <202409122000.ZcYladbW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 5ed771f174726ae879945d4f148a9005ac909cb7  tty: serial: samsung: Fix serial rx on Apple A7-A9

elapsed time: 1285m

configs tested: 172
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20240912    gcc-13.2.0
arc                   randconfig-002-20240912    gcc-13.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                       aspeed_g5_defconfig    gcc-14.1.0
arm                                 defconfig    gcc-14.1.0
arm                       imx_v4_v5_defconfig    gcc-14.1.0
arm                          moxart_defconfig    gcc-14.1.0
arm                          pxa910_defconfig    gcc-14.1.0
arm                   randconfig-001-20240912    gcc-13.2.0
arm                   randconfig-002-20240912    gcc-13.2.0
arm                   randconfig-003-20240912    gcc-13.2.0
arm                   randconfig-004-20240912    gcc-13.2.0
arm                           spitz_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20240912    gcc-13.2.0
arm64                 randconfig-002-20240912    gcc-13.2.0
arm64                 randconfig-003-20240912    gcc-13.2.0
arm64                 randconfig-004-20240912    gcc-13.2.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240912    gcc-13.2.0
csky                  randconfig-002-20240912    gcc-13.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20240912    gcc-13.2.0
hexagon               randconfig-002-20240912    gcc-13.2.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20240912    gcc-12
i386        buildonly-randconfig-002-20240912    gcc-12
i386        buildonly-randconfig-003-20240912    gcc-12
i386        buildonly-randconfig-004-20240912    gcc-12
i386        buildonly-randconfig-005-20240912    gcc-12
i386        buildonly-randconfig-006-20240912    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20240912    gcc-12
i386                  randconfig-002-20240912    gcc-12
i386                  randconfig-003-20240912    gcc-12
i386                  randconfig-004-20240912    gcc-12
i386                  randconfig-005-20240912    gcc-12
i386                  randconfig-006-20240912    gcc-12
i386                  randconfig-011-20240912    gcc-12
i386                  randconfig-012-20240912    gcc-12
i386                  randconfig-013-20240912    gcc-12
i386                  randconfig-014-20240912    gcc-12
i386                  randconfig-015-20240912    gcc-12
i386                  randconfig-016-20240912    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20240912    gcc-13.2.0
loongarch             randconfig-002-20240912    gcc-13.2.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          hp300_defconfig    gcc-14.1.0
m68k                           sun3_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                       lemote2f_defconfig    gcc-14.1.0
nios2                            alldefconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20240912    gcc-13.2.0
nios2                 randconfig-002-20240912    gcc-13.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20240912    gcc-13.2.0
parisc                randconfig-002-20240912    gcc-13.2.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                       eiger_defconfig    gcc-14.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-14.1.0
powerpc               mpc834x_itxgp_defconfig    gcc-14.1.0
powerpc                         ps3_defconfig    gcc-14.1.0
powerpc               randconfig-001-20240912    gcc-13.2.0
powerpc               randconfig-002-20240912    gcc-13.2.0
powerpc               randconfig-003-20240912    gcc-13.2.0
powerpc                        warp_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20240912    gcc-13.2.0
powerpc64             randconfig-002-20240912    gcc-13.2.0
powerpc64             randconfig-003-20240912    gcc-13.2.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20240912    gcc-13.2.0
riscv                 randconfig-002-20240912    gcc-13.2.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20240912    gcc-13.2.0
s390                  randconfig-002-20240912    gcc-13.2.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20240912    gcc-13.2.0
sh                    randconfig-002-20240912    gcc-13.2.0
sh                           se7619_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20240912    gcc-13.2.0
sparc64               randconfig-002-20240912    gcc-13.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20240912    gcc-13.2.0
um                    randconfig-002-20240912    gcc-13.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240912    clang-18
x86_64      buildonly-randconfig-002-20240912    clang-18
x86_64      buildonly-randconfig-003-20240912    clang-18
x86_64      buildonly-randconfig-004-20240912    clang-18
x86_64      buildonly-randconfig-005-20240912    clang-18
x86_64      buildonly-randconfig-006-20240912    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20240912    clang-18
x86_64                randconfig-002-20240912    clang-18
x86_64                randconfig-003-20240912    clang-18
x86_64                randconfig-004-20240912    clang-18
x86_64                randconfig-005-20240912    clang-18
x86_64                randconfig-006-20240912    clang-18
x86_64                randconfig-011-20240912    clang-18
x86_64                randconfig-012-20240912    clang-18
x86_64                randconfig-013-20240912    clang-18
x86_64                randconfig-014-20240912    clang-18
x86_64                randconfig-015-20240912    clang-18
x86_64                randconfig-016-20240912    clang-18
x86_64                randconfig-071-20240912    clang-18
x86_64                randconfig-072-20240912    clang-18
x86_64                randconfig-073-20240912    clang-18
x86_64                randconfig-074-20240912    clang-18
x86_64                randconfig-075-20240912    clang-18
x86_64                randconfig-076-20240912    clang-18
x86_64                          rhel-8.3-rust    clang-18
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20240912    gcc-13.2.0
xtensa                randconfig-002-20240912    gcc-13.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
