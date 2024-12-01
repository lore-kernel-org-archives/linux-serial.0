Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CEB320F
	for <linux-serial@vger.kernel.org>; Sun,  1 Dec 2024 04:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733025963; cv=none; b=X+SXRmITsTMGOdSEw8g8Ly/M4WF8EFB6HDmeiTR85aHFn4TmxHQ5fR1xC4zpU8kf0JzXKpPlZQIDKgpMgx16/Zq5Ml4E/GM+D4yqAeRs39bAnSdbM/v/wp48/0CxGXC5qZAHK7GPfYMcCxNU74jWHbakF/aYclJqotiIHPK94w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733025963; c=relaxed/simple;
	bh=Kv+JbSr3aNlPrfM4ERsQxyXSiK8g1XFugwD2ItmYENM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=r4QiA9PX7nny1vxg+1vcHjRV/r2+xnbfcl03aWv3ljEOrHhlxbDNeWYkhqfUjaRi07tMC/A6XwGRnAUemeBkJgSg8UOYfLX6C8mL/MhcJJOsME19YIxFwRAgbJHhpHx0SxhpgoeLzuF5XukWfLjPi0MoGN+GTvBofuG6rdwdSoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfJf/OTp; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfJf/OTp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733025962; x=1764561962;
  h=date:from:to:cc:subject:message-id;
  bh=Kv+JbSr3aNlPrfM4ERsQxyXSiK8g1XFugwD2ItmYENM=;
  b=cfJf/OTpqBEc9QodT0TYfKruVaNwCgVSy04SRx+Qo0d0u8Dub7MwrFfH
   6G5NqV7x4D3gG8aQ4QEV/e8XVCqeSrhsG5WHH64myVK21CL+9YZz16991
   zHC8oz4ON3FC1BJOgqDJy65pKgtIsbYndDfjr3G/ysufSREFGtYojai1d
   oJJUf7oR9utwftORRNTRblNOUm/5SwwLTiOQ4tYF7COsH9epfVjo3oKIf
   3seVHosf4TKMhkhprvdTF2KWqi1qpaPR9AL1rz17isesaG5YoGW/YztN7
   ZNwnMnWKeLOl3xO7kBw2kvRgrA/hszwX901D2O4i/Uvb9p+9jU+1jLal+
   g==;
X-CSE-ConnectionGUID: Ewbc1aSHTjGbZcCEL7Vrwg==
X-CSE-MsgGUID: 3UjrMOruRJiMq663bQ6IPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11272"; a="33138076"
X-IronPort-AV: E=Sophos;i="6.12,199,1728975600"; 
   d="scan'208";a="33138076"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 20:06:01 -0800
X-CSE-ConnectionGUID: jYAdqA/6ShyFkgnBHN3/Vg==
X-CSE-MsgGUID: b7wWgyeSSGeVjU+TguM/Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,199,1728975600"; 
   d="scan'208";a="123648443"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 30 Nov 2024 20:06:01 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHbDZ-0001Dp-2F;
	Sun, 01 Dec 2024 04:05:57 +0000
Date: Sun, 01 Dec 2024 12:03:03 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 718632467d88e98816fa01ab12681ef1c2aa56f8
Message-ID: <202412011253.5jnCafmu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 718632467d88e98816fa01ab12681ef1c2aa56f8  Revert "serial: sh-sci: Clean sci_ports[0] after at earlycon exit"

elapsed time: 721m

configs tested: 144
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                          axs101_defconfig    gcc-13.2.0
arc                          axs103_defconfig    gcc-13.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20241201    gcc-13.2.0
arc                   randconfig-002-20241201    gcc-13.2.0
arc                           tb10x_defconfig    gcc-13.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                        clps711x_defconfig    clang-20
arm                      footbridge_defconfig    clang-20
arm                       imx_v4_v5_defconfig    clang-20
arm                          ixp4xx_defconfig    gcc-14.2.0
arm                            mmp2_defconfig    gcc-14.2.0
arm                            mps2_defconfig    clang-20
arm                        multi_v7_defconfig    clang-20
arm                           omap1_defconfig    gcc-14.2.0
arm                   randconfig-001-20241201    clang-20
arm                   randconfig-002-20241201    gcc-14.2.0
arm                   randconfig-003-20241201    clang-20
arm                   randconfig-004-20241201    clang-20
arm                           sama7_defconfig    clang-20
arm                        shmobile_defconfig    gcc-14.2.0
arm                           stm32_defconfig    clang-20
arm                           sunxi_defconfig    clang-20
arm                         wpcm450_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241201    clang-15
arm64                 randconfig-002-20241201    clang-20
arm64                 randconfig-003-20241201    gcc-14.2.0
arm64                 randconfig-004-20241201    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
i386        buildonly-randconfig-001-20241201    gcc-12
i386        buildonly-randconfig-002-20241201    clang-19
i386        buildonly-randconfig-003-20241201    clang-19
i386        buildonly-randconfig-004-20241201    gcc-12
i386        buildonly-randconfig-005-20241201    clang-19
i386        buildonly-randconfig-006-20241201    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    clang-20
m68k                       m5249evb_defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    clang-20
m68k                          multi_defconfig    gcc-14.2.0
m68k                           sun3_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         db1xxx_defconfig    clang-20
mips                          eyeq6_defconfig    clang-14
mips                           ip27_defconfig    gcc-14.2.0
mips                           ip32_defconfig    clang-20
mips                     loongson1b_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     asp8347_defconfig    clang-17
powerpc                   currituck_defconfig    clang-20
powerpc                    gamecube_defconfig    clang-20
powerpc                    ge_imp3a_defconfig    clang-20
powerpc                    ge_imp3a_defconfig    gcc-14.2.0
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                   lite5200b_defconfig    clang-20
powerpc                 mpc837x_rdb_defconfig    gcc-14.2.0
powerpc                  mpc866_ads_defconfig    clang-20
powerpc                      pasemi_defconfig    clang-20
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc                      ppc64e_defconfig    clang-20
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc                         ps3_defconfig    gcc-14.2.0
powerpc64                        alldefconfig    clang-20
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
s390                             alldefconfig    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                       zfcpdump_defconfig    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         apsh4a3a_defconfig    clang-20
sh                         ecovec24_defconfig    clang-20
sh                        edosk7705_defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    clang-20
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                          r7785rp_defconfig    gcc-14.2.0
sh                           se7619_defconfig    gcc-14.2.0
sh                   sh7724_generic_defconfig    gcc-14.2.0
sh                             shx3_defconfig    gcc-14.2.0
sparc                            alldefconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
x86_64      buildonly-randconfig-001-20241201    clang-19
x86_64      buildonly-randconfig-002-20241201    gcc-12
x86_64      buildonly-randconfig-003-20241201    gcc-12
x86_64      buildonly-randconfig-004-20241201    clang-19
x86_64      buildonly-randconfig-005-20241201    clang-19
x86_64      buildonly-randconfig-006-20241201    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    gcc-14.2.0
xtensa                       common_defconfig    clang-20
xtensa                  nommu_kc705_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
