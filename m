Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912A6605A5
	for <linux-serial@vger.kernel.org>; Tue, 20 Feb 2024 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420021; cv=none; b=otU5UMMsNHtM4LXCCwAaVn6rNPwLigeFWd9E2qvKvEWD+6xE3CymsN9aZ4XT6VbpAbb7IBHLV/K7ucSZy8QQ1Qbyepb49Ds6KDSzAxXGKKYqcQrESRFxk/LjSnGWpxBjOpO4bD7ps/WXGVCBOX0aQEHhAIFmkKmqxQin3tHRxm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420021; c=relaxed/simple;
	bh=3si6bHrORPFhjfi8tCwGQwXsDoGuie5jqX1BMRDXBKQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=U+kViTQHBB2cJLS+nnfezlgxCd09Y7kxPHITH0jHdtCXO5pkFEwhYYwPsxnz5s0CC0/spcSiW9BBKm6382vdFOcRue+wzm0jAHDCLACmj+xgacUbkKdUuGANYyXyIczB4YMH0PB78d/oPDE4UgZUr72LgFSYSGiEj4qwKkoZSls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJYupyOo; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJYupyOo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708420020; x=1739956020;
  h=date:from:to:cc:subject:message-id;
  bh=3si6bHrORPFhjfi8tCwGQwXsDoGuie5jqX1BMRDXBKQ=;
  b=LJYupyOonERnyZJfZk3umPbDwnQuBDZCAAT3An6tuovqu/gbbWxeD8n2
   Qw2lqLQ/a3v0SWViGxMuI2P65SPQ42cjexLroNosWZS1Kzb26FBCVLT6b
   JYxBgOuJew3lE7Lf7pu1FCA46CECHC2CbzPDH79W8+X4zJGnlQKkBwx5r
   Vn4FCSOEPIFHd3lOABEgxSTrZuCbUkrsEsjsAmfOqGJMKlEAUO+Ydqohw
   FeI/UzY+zuvS4I7xtAevXv1p3CvSl+4Kv6SHDPU6+BtmU4Xh/JPoSZdBY
   0pXXbDe4AGawY04mZWTUZk8WirtMxF+D1V4qgTUNR7FSKNXBwsEE8KNvD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="19949857"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="19949857"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 01:07:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="9370708"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 20 Feb 2024 01:06:57 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcM5B-0004N2-2m;
	Tue, 20 Feb 2024 09:06:40 +0000
Date: Tue, 20 Feb 2024 17:04:47 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 3b69e32e151bc4a4e3c785cbdb1f918d5ee337ed
Message-ID: <202402201744.DhzjCi7v-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 3b69e32e151bc4a4e3c785cbdb1f918d5ee337ed  serial: amba-pl011: Fix DMA transmission in RS485 mode

elapsed time: 1447m

configs tested: 244
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20240219   gcc  
arc                   randconfig-001-20240220   gcc  
arc                   randconfig-002-20240219   gcc  
arc                   randconfig-002-20240220   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20240219   gcc  
arm                   randconfig-002-20240219   gcc  
arm                   randconfig-002-20240220   gcc  
arm                   randconfig-003-20240219   gcc  
arm                   randconfig-003-20240220   gcc  
arm                   randconfig-004-20240219   gcc  
arm                   randconfig-004-20240220   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240219   gcc  
arm64                 randconfig-002-20240219   gcc  
arm64                 randconfig-003-20240219   clang
arm64                 randconfig-004-20240219   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240219   gcc  
csky                  randconfig-001-20240220   gcc  
csky                  randconfig-002-20240219   gcc  
csky                  randconfig-002-20240220   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240219   clang
hexagon               randconfig-002-20240219   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240219   gcc  
i386         buildonly-randconfig-002-20240219   gcc  
i386         buildonly-randconfig-003-20240219   clang
i386         buildonly-randconfig-003-20240220   clang
i386         buildonly-randconfig-004-20240219   gcc  
i386         buildonly-randconfig-004-20240220   clang
i386         buildonly-randconfig-005-20240219   clang
i386         buildonly-randconfig-006-20240219   clang
i386                                defconfig   clang
i386                  randconfig-001-20240219   clang
i386                  randconfig-002-20240219   clang
i386                  randconfig-003-20240219   clang
i386                  randconfig-003-20240220   clang
i386                  randconfig-004-20240219   gcc  
i386                  randconfig-004-20240220   clang
i386                  randconfig-005-20240219   clang
i386                  randconfig-006-20240219   gcc  
i386                  randconfig-006-20240220   clang
i386                  randconfig-011-20240219   gcc  
i386                  randconfig-011-20240220   clang
i386                  randconfig-012-20240219   clang
i386                  randconfig-013-20240219   gcc  
i386                  randconfig-014-20240219   clang
i386                  randconfig-014-20240220   clang
i386                  randconfig-015-20240219   gcc  
i386                  randconfig-015-20240220   clang
i386                  randconfig-016-20240219   clang
i386                  randconfig-016-20240220   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20240219   gcc  
loongarch             randconfig-001-20240220   gcc  
loongarch             randconfig-002-20240219   gcc  
loongarch             randconfig-002-20240220   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                     loongson1c_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                           rs90_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240219   gcc  
nios2                 randconfig-001-20240220   gcc  
nios2                 randconfig-002-20240219   gcc  
nios2                 randconfig-002-20240220   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240219   gcc  
parisc                randconfig-001-20240220   gcc  
parisc                randconfig-002-20240219   gcc  
parisc                randconfig-002-20240220   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240219   gcc  
powerpc               randconfig-001-20240220   gcc  
powerpc               randconfig-002-20240219   clang
powerpc               randconfig-003-20240219   clang
powerpc64             randconfig-001-20240219   clang
powerpc64             randconfig-001-20240220   gcc  
powerpc64             randconfig-002-20240219   gcc  
powerpc64             randconfig-002-20240220   gcc  
powerpc64             randconfig-003-20240219   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240219   gcc  
riscv                 randconfig-002-20240219   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240219   gcc  
s390                  randconfig-001-20240220   gcc  
s390                  randconfig-002-20240219   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240219   gcc  
sh                    randconfig-001-20240220   gcc  
sh                    randconfig-002-20240219   gcc  
sh                    randconfig-002-20240220   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240219   gcc  
sparc64               randconfig-001-20240220   gcc  
sparc64               randconfig-002-20240219   gcc  
sparc64               randconfig-002-20240220   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240219   clang
um                    randconfig-001-20240220   gcc  
um                    randconfig-002-20240219   gcc  
um                    randconfig-002-20240220   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240219   clang
x86_64       buildonly-randconfig-001-20240220   clang
x86_64       buildonly-randconfig-002-20240219   clang
x86_64       buildonly-randconfig-002-20240220   clang
x86_64       buildonly-randconfig-003-20240219   gcc  
x86_64       buildonly-randconfig-004-20240219   clang
x86_64       buildonly-randconfig-004-20240220   clang
x86_64       buildonly-randconfig-005-20240219   clang
x86_64       buildonly-randconfig-006-20240219   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240219   clang
x86_64                randconfig-002-20240219   clang
x86_64                randconfig-003-20240219   gcc  
x86_64                randconfig-004-20240219   gcc  
x86_64                randconfig-004-20240220   clang
x86_64                randconfig-005-20240219   clang
x86_64                randconfig-005-20240220   clang
x86_64                randconfig-006-20240219   clang
x86_64                randconfig-011-20240219   clang
x86_64                randconfig-012-20240219   gcc  
x86_64                randconfig-012-20240220   clang
x86_64                randconfig-013-20240219   clang
x86_64                randconfig-013-20240220   clang
x86_64                randconfig-014-20240219   gcc  
x86_64                randconfig-015-20240219   clang
x86_64                randconfig-015-20240220   clang
x86_64                randconfig-016-20240219   gcc  
x86_64                randconfig-071-20240219   gcc  
x86_64                randconfig-071-20240220   clang
x86_64                randconfig-072-20240219   clang
x86_64                randconfig-072-20240220   clang
x86_64                randconfig-073-20240219   gcc  
x86_64                randconfig-073-20240220   clang
x86_64                randconfig-074-20240219   gcc  
x86_64                randconfig-074-20240220   clang
x86_64                randconfig-075-20240219   clang
x86_64                randconfig-075-20240220   clang
x86_64                randconfig-076-20240219   clang
x86_64                randconfig-076-20240220   clang
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20240219   gcc  
xtensa                randconfig-001-20240220   gcc  
xtensa                randconfig-002-20240219   gcc  
xtensa                randconfig-002-20240220   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
