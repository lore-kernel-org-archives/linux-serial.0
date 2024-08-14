Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EAE22309
	for <linux-serial@vger.kernel.org>; Wed, 14 Aug 2024 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723610384; cv=none; b=CYbeq/3hnQv0EEwgsUPqrNlCJ2W7ZDMsyQ3fBu4tN5Zn5v3d41/Qx6hFu04+mIhQhHJf07Kx0+izB2XEm3lsb0cevDkPNikjofkEfDKpkLKLzpEekjwErlhYA6AqRcgNzdXL8CR799hHv21dZi0DaxaT8SIWlxgv6F0H8OWYyes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723610384; c=relaxed/simple;
	bh=ATUROiay5I/kUQ+icP6n6SXwgTwjCircYmnoJSKGLpc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kI/n9bpoGKOpV37NopRxYMm3e9CI7qT/mUEKFwmXfCWb6yM1UyOawpqeczdr5BMgrkGFwp1wbQomibI97qLMfhW4Y5tVSuOSKmd1V1H3iK1SAIfVqAsJUPn8FPS8meRvIB7xzu/KnHLG0cei+yOlYfwsgGfYErZwqB8cWxcUxSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WLl10rqS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WLl10rqS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723610383; x=1755146383;
  h=date:from:to:cc:subject:message-id;
  bh=ATUROiay5I/kUQ+icP6n6SXwgTwjCircYmnoJSKGLpc=;
  b=WLl10rqSR73xf6/trifzcP8449c854ovuNjip32nPzduEiuEKok02RgK
   vmMvqP6kCe54LXoyi5yy/hbCe+Nze8pxtRRwadwtZgB9/FMwULPOgyPgf
   ukP5oWvDQVG+htwSkOUqWNQ+K5YQpq7La5meZHfTEu/MP7t/30AjauHEW
   mwK/OOIj9oCONn8/PRBCnaAbY1YnNab83NadS269kIaQ1bCkRDzIBhDwG
   UUHgYBtd6CIUl3dJQgGtSMe2McKAdRVo9tULo/JwDcOAr9g9XkdI48LQA
   I3GFwwMmXA3IZjOaJ5KkjKjOfkzoxR7UCced02eteN3xKXGndhuA2djLc
   A==;
X-CSE-ConnectionGUID: CGeqFFrOTf2+uZDeagDizQ==
X-CSE-MsgGUID: xBrwvdLrQp+6B1YhXebhCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25604960"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="25604960"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 21:39:42 -0700
X-CSE-ConnectionGUID: lB170CJ5RNixNqOB6PtNiQ==
X-CSE-MsgGUID: 0BijLRHYQRKEEiO3ojGF2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="58579279"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 13 Aug 2024 21:39:40 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1se5nO-00018c-22;
	Wed, 14 Aug 2024 04:39:38 +0000
Date: Wed, 14 Aug 2024 12:38:43 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 b42243ffd7b68080899d9cdef63dfc691f1478b9
Message-ID: <202408141240.DyZi04Kl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: b42243ffd7b68080899d9cdef63dfc691f1478b9  serial: 8250_bcm2835aux: Switch to DEFINE_SIMPLE_DEV_PM_OPS()

elapsed time: 1152m

configs tested: 283
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240813   gcc-13.2.0
arc                   randconfig-002-20240813   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         assabet_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            dove_defconfig   gcc-12.4.0
arm                            hisi_defconfig   gcc-12.4.0
arm                          moxart_defconfig   gcc-12.4.0
arm                         mv78xx0_defconfig   gcc-12.4.0
arm                       omap2plus_defconfig   gcc-13.2.0
arm                   randconfig-001-20240813   gcc-13.2.0
arm                   randconfig-001-20240813   gcc-14.1.0
arm                   randconfig-002-20240813   gcc-13.2.0
arm                   randconfig-002-20240813   gcc-14.1.0
arm                   randconfig-003-20240813   gcc-13.2.0
arm                   randconfig-003-20240813   gcc-14.1.0
arm                   randconfig-004-20240813   gcc-13.2.0
arm                   randconfig-004-20240813   gcc-14.1.0
arm                           sunxi_defconfig   gcc-13.2.0
arm                         wpcm450_defconfig   gcc-12.4.0
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240813   gcc-13.2.0
arm64                 randconfig-001-20240813   gcc-14.1.0
arm64                 randconfig-002-20240813   gcc-13.2.0
arm64                 randconfig-002-20240813   gcc-14.1.0
arm64                 randconfig-003-20240813   clang-20
arm64                 randconfig-003-20240813   gcc-13.2.0
arm64                 randconfig-004-20240813   gcc-13.2.0
arm64                 randconfig-004-20240813   gcc-14.1.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240813   gcc-13.2.0
csky                  randconfig-001-20240813   gcc-14.1.0
csky                  randconfig-002-20240813   gcc-13.2.0
csky                  randconfig-002-20240813   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240813   clang-20
hexagon               randconfig-002-20240813   clang-20
i386                             alldefconfig   gcc-12.4.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240813   gcc-12
i386         buildonly-randconfig-001-20240814   clang-18
i386         buildonly-randconfig-002-20240813   gcc-12
i386         buildonly-randconfig-002-20240814   clang-18
i386         buildonly-randconfig-003-20240813   gcc-12
i386         buildonly-randconfig-003-20240814   clang-18
i386         buildonly-randconfig-004-20240813   gcc-11
i386         buildonly-randconfig-004-20240814   clang-18
i386         buildonly-randconfig-005-20240813   clang-18
i386         buildonly-randconfig-005-20240814   clang-18
i386         buildonly-randconfig-006-20240813   gcc-12
i386         buildonly-randconfig-006-20240814   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240813   gcc-12
i386                  randconfig-001-20240814   clang-18
i386                  randconfig-002-20240813   clang-18
i386                  randconfig-002-20240814   clang-18
i386                  randconfig-003-20240813   gcc-12
i386                  randconfig-003-20240814   clang-18
i386                  randconfig-004-20240813   gcc-12
i386                  randconfig-004-20240814   clang-18
i386                  randconfig-005-20240813   clang-18
i386                  randconfig-005-20240814   clang-18
i386                  randconfig-006-20240813   clang-18
i386                  randconfig-006-20240814   clang-18
i386                  randconfig-011-20240813   gcc-12
i386                  randconfig-011-20240814   clang-18
i386                  randconfig-012-20240813   gcc-12
i386                  randconfig-012-20240814   clang-18
i386                  randconfig-013-20240813   clang-18
i386                  randconfig-013-20240814   clang-18
i386                  randconfig-014-20240813   clang-18
i386                  randconfig-014-20240814   clang-18
i386                  randconfig-015-20240813   clang-18
i386                  randconfig-015-20240814   clang-18
i386                  randconfig-016-20240813   clang-18
i386                  randconfig-016-20240814   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240813   gcc-13.2.0
loongarch             randconfig-001-20240813   gcc-14.1.0
loongarch             randconfig-002-20240813   gcc-13.2.0
loongarch             randconfig-002-20240813   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         amcore_defconfig   gcc-12.4.0
m68k                                defconfig   gcc-13.2.0
m68k                        mvme16x_defconfig   gcc-12.4.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                       bmips_be_defconfig   gcc-13.2.0
mips                         rt305x_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240813   gcc-13.2.0
nios2                 randconfig-001-20240813   gcc-14.1.0
nios2                 randconfig-002-20240813   gcc-13.2.0
nios2                 randconfig-002-20240813   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
openrisc                  or1klitex_defconfig   gcc-12.4.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240813   gcc-13.2.0
parisc                randconfig-001-20240813   gcc-14.1.0
parisc                randconfig-002-20240813   gcc-13.2.0
parisc                randconfig-002-20240813   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      katmai_defconfig   gcc-12.4.0
powerpc                      katmai_defconfig   gcc-13.2.0
powerpc                 mpc837x_rdb_defconfig   gcc-13.2.0
powerpc                      ppc44x_defconfig   gcc-13.2.0
powerpc                       ppc64_defconfig   gcc-12.4.0
powerpc               randconfig-002-20240813   gcc-13.2.0
powerpc               randconfig-002-20240813   gcc-14.1.0
powerpc               randconfig-003-20240813   gcc-13.2.0
powerpc               randconfig-003-20240813   gcc-14.1.0
powerpc                 xes_mpc85xx_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240813   gcc-13.2.0
powerpc64             randconfig-001-20240813   gcc-14.1.0
powerpc64             randconfig-002-20240813   gcc-13.2.0
powerpc64             randconfig-002-20240813   gcc-14.1.0
powerpc64             randconfig-003-20240813   gcc-13.2.0
powerpc64             randconfig-003-20240813   gcc-14.1.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240813   gcc-13.2.0
riscv                 randconfig-001-20240813   gcc-14.1.0
riscv                 randconfig-002-20240813   gcc-13.2.0
riscv                 randconfig-002-20240813   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-13.2.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240813   clang-20
s390                  randconfig-001-20240813   gcc-13.2.0
s390                  randconfig-002-20240813   gcc-13.2.0
s390                  randconfig-002-20240813   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                          landisk_defconfig   gcc-13.2.0
sh                            migor_defconfig   gcc-12.4.0
sh                          polaris_defconfig   gcc-12.4.0
sh                    randconfig-001-20240813   gcc-13.2.0
sh                    randconfig-001-20240813   gcc-14.1.0
sh                    randconfig-002-20240813   gcc-13.2.0
sh                    randconfig-002-20240813   gcc-14.1.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                      rts7751r2d1_defconfig   gcc-12.4.0
sh                          sdk7780_defconfig   gcc-13.2.0
sh                           sh2007_defconfig   gcc-12.4.0
sh                     sh7710voipgw_defconfig   gcc-12.4.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc64_defconfig   gcc-12.4.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240813   gcc-13.2.0
sparc64               randconfig-001-20240813   gcc-14.1.0
sparc64               randconfig-002-20240813   gcc-13.2.0
sparc64               randconfig-002-20240813   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240813   gcc-12
um                    randconfig-001-20240813   gcc-13.2.0
um                    randconfig-002-20240813   clang-14
um                    randconfig-002-20240813   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240813   clang-18
x86_64       buildonly-randconfig-001-20240814   clang-18
x86_64       buildonly-randconfig-002-20240813   gcc-11
x86_64       buildonly-randconfig-002-20240814   clang-18
x86_64       buildonly-randconfig-003-20240813   clang-18
x86_64       buildonly-randconfig-003-20240814   clang-18
x86_64       buildonly-randconfig-004-20240813   gcc-12
x86_64       buildonly-randconfig-004-20240814   clang-18
x86_64       buildonly-randconfig-005-20240813   gcc-12
x86_64       buildonly-randconfig-005-20240814   clang-18
x86_64       buildonly-randconfig-006-20240813   gcc-12
x86_64       buildonly-randconfig-006-20240814   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240813   gcc-12
x86_64                randconfig-001-20240814   clang-18
x86_64                randconfig-002-20240813   clang-18
x86_64                randconfig-002-20240814   clang-18
x86_64                randconfig-003-20240813   gcc-12
x86_64                randconfig-003-20240814   clang-18
x86_64                randconfig-004-20240813   gcc-12
x86_64                randconfig-004-20240814   clang-18
x86_64                randconfig-005-20240813   gcc-12
x86_64                randconfig-005-20240814   clang-18
x86_64                randconfig-006-20240813   clang-18
x86_64                randconfig-006-20240814   clang-18
x86_64                randconfig-011-20240813   gcc-12
x86_64                randconfig-011-20240814   clang-18
x86_64                randconfig-012-20240813   gcc-12
x86_64                randconfig-012-20240814   clang-18
x86_64                randconfig-013-20240813   gcc-12
x86_64                randconfig-013-20240814   clang-18
x86_64                randconfig-014-20240813   gcc-11
x86_64                randconfig-014-20240814   clang-18
x86_64                randconfig-015-20240813   gcc-11
x86_64                randconfig-015-20240814   clang-18
x86_64                randconfig-016-20240813   gcc-12
x86_64                randconfig-016-20240814   clang-18
x86_64                randconfig-071-20240813   clang-18
x86_64                randconfig-071-20240814   clang-18
x86_64                randconfig-072-20240813   clang-18
x86_64                randconfig-072-20240814   clang-18
x86_64                randconfig-073-20240813   gcc-11
x86_64                randconfig-073-20240814   clang-18
x86_64                randconfig-074-20240813   gcc-12
x86_64                randconfig-074-20240814   clang-18
x86_64                randconfig-075-20240813   gcc-12
x86_64                randconfig-075-20240814   clang-18
x86_64                randconfig-076-20240813   clang-18
x86_64                randconfig-076-20240814   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240813   gcc-13.2.0
xtensa                randconfig-001-20240813   gcc-14.1.0
xtensa                randconfig-002-20240813   gcc-13.2.0
xtensa                randconfig-002-20240813   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
