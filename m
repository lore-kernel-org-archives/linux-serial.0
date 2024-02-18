Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB486DCEA
	for <linux-serial@vger.kernel.org>; Sun, 18 Feb 2024 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708275760; cv=none; b=BFbh0oaVjBJL1B98w/DYOdKH8q1ocYSTV5Yt2pWlc/W+RdP+lG/6xpTWJen9JNL8LPskjw+RgvMDyGks7z7AAenouiHr2I360lWt9NM/NQkSvNqr9luvWpa5z3z+6LiUigUK4s7u3+ajcBhXBIaex8Z/M5fy8wqJxZPg5Q0t47U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708275760; c=relaxed/simple;
	bh=wjO6F2mGLDZAiZoX7uOKMJIgChH3iWSy9RxA0fnDnuQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jgUfbXfXkJVUcdO3sYuWMRML7oEBgl0ivKgshtvh2h3A/EWUqu1x0TPnOPxGfNalUOJmgJiYxyKMfoM2MYjB4UdwECRzmtFlImXrWdMCK5fQqA2yNjV9H5dq6NSvN8mX7OKmEpVMJ//j9IRoBqfn59UnnyI6wsRGmp8w6rjG3kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BN2pIM9D; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BN2pIM9D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708275758; x=1739811758;
  h=date:from:to:cc:subject:message-id;
  bh=wjO6F2mGLDZAiZoX7uOKMJIgChH3iWSy9RxA0fnDnuQ=;
  b=BN2pIM9DCNVFOeJzj3s8zE+ya6CAEwW8B2MEy1ddql0DjUMRnnly6wBO
   YpNvWzuZkyFHfKN8ZUv74KwpBNJQLbSez3Z4vSMBNU3n89XMuB1R66P8j
   cGbPapKnvCuRlRjIhAZCBBAPSc+6N8QBPVsHQra5RTc9146h2R7scznam
   hLRpoH4TjqmsJ6wleli4D3CKNknde6ab77KK9x3uOe23h/bhUA/rjkXPy
   pKJapA2Uf6q3jKhZNVJUqj2XBpIPyFVxTGTCr0OwCvU9Bq5gsyRrvxVK3
   VaGL14+kfxIxBcwbnza4JPP0LWgY6HHh8NkFkrnOQs1CnakiR1zcNmA7y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2218879"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2218879"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:02:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="41789636"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 18 Feb 2024 09:02:36 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbkYj-0003BA-0g;
	Sun, 18 Feb 2024 17:02:33 +0000
Date: Mon, 19 Feb 2024 01:02:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS WITH WARNING
 b8badbf3b592d3f8b70efc66be2c2c4d9698de51
Message-ID: <202402190157.iGo61bQ3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: b8badbf3b592d3f8b70efc66be2c2c4d9698de51  tty: Don't include tty_buffer.h in tty.h

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202402180801.2LNKohCO-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/tty/serial/st-asc.c:525:7: warning: variable 'manual_rts' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
drivers/tty/serial/st-asc.c:525:7: warning: variable 'manual_rts' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]

Warning ids grouped by kconfigs:

clang_recent_errors
|-- arm-defconfig
|   |-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-condition-is-false
|   `-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-if-condition-is-false
|-- arm-randconfig-002-20240218
|   |-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-condition-is-false
|   `-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-if-condition-is-false
|-- arm-randconfig-004-20240218
|   |-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-condition-is-false
|   `-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-if-condition-is-false
|-- arm64-allmodconfig
|   |-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-condition-is-false
|   `-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-if-condition-is-false
|-- arm64-allyesconfig
|   |-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-condition-is-false
|   `-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-if-condition-is-false
|-- hexagon-allmodconfig
|   |-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-condition-is-false
|   `-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-if-condition-is-false
|-- hexagon-allyesconfig
|   |-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-condition-is-false
|   `-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-if-condition-is-false
|-- i386-buildonly-randconfig-001-20240218
|   |-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-condition-is-false
|   `-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-if-condition-is-false
|-- powerpc-allyesconfig
|   |-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-condition-is-false
|   `-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-if-condition-is-false
|-- riscv-allmodconfig
|   |-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-condition-is-false
|   `-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-if-condition-is-false
|-- riscv-allyesconfig
|   |-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-condition-is-false
|   `-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-if-condition-is-false
|-- s390-allmodconfig
|   |-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-condition-is-false
|   `-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-if-condition-is-false
|-- s390-randconfig-r111-20240218
|   |-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-condition-is-false
|   `-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-if-condition-is-false
|-- x86_64-allmodconfig
|   |-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-condition-is-false
|   `-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-if-condition-is-false
`-- x86_64-allyesconfig
    |-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-condition-is-false
    `-- drivers-tty-serial-st-asc.c:warning:variable-manual_rts-is-used-uninitialized-whenever-if-condition-is-false

elapsed time: 1450m

configs tested: 179
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240218   gcc  
arc                   randconfig-002-20240218   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                   randconfig-003-20240218   gcc  
arm                           sama5_defconfig   gcc  
arm                        shmobile_defconfig   gcc  
arm                           spitz_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-004-20240218   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240218   gcc  
csky                  randconfig-002-20240218   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240218   clang
i386         buildonly-randconfig-002-20240218   clang
i386         buildonly-randconfig-003-20240218   clang
i386         buildonly-randconfig-004-20240218   clang
i386         buildonly-randconfig-005-20240218   clang
i386         buildonly-randconfig-006-20240218   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240218   clang
i386                  randconfig-002-20240218   gcc  
i386                  randconfig-003-20240218   clang
i386                  randconfig-004-20240218   clang
i386                  randconfig-005-20240218   clang
i386                  randconfig-006-20240218   gcc  
i386                  randconfig-011-20240218   gcc  
i386                  randconfig-012-20240218   gcc  
i386                  randconfig-013-20240218   clang
i386                  randconfig-014-20240218   gcc  
i386                  randconfig-015-20240218   gcc  
i386                  randconfig-016-20240218   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240218   gcc  
loongarch             randconfig-002-20240218   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                            q40_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   gcc  
mips                     cu1000-neo_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240218   gcc  
nios2                 randconfig-002-20240218   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240218   gcc  
parisc                randconfig-002-20240218   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                      ppc64e_defconfig   gcc  
powerpc               randconfig-001-20240218   gcc  
powerpc               randconfig-002-20240218   gcc  
powerpc64             randconfig-002-20240218   gcc  
powerpc64             randconfig-003-20240218   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240218   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240218   gcc  
s390                  randconfig-002-20240218   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240218   gcc  
sh                    randconfig-002-20240218   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240218   gcc  
sparc64               randconfig-002-20240218   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240218   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240218   clang
x86_64       buildonly-randconfig-002-20240218   gcc  
x86_64       buildonly-randconfig-003-20240218   gcc  
x86_64       buildonly-randconfig-004-20240218   clang
x86_64       buildonly-randconfig-005-20240218   gcc  
x86_64       buildonly-randconfig-006-20240218   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240218   clang
x86_64                randconfig-002-20240218   clang
x86_64                randconfig-003-20240218   gcc  
x86_64                randconfig-004-20240218   gcc  
x86_64                randconfig-005-20240218   gcc  
x86_64                randconfig-006-20240218   clang
x86_64                randconfig-011-20240218   clang
x86_64                randconfig-012-20240218   gcc  
x86_64                randconfig-013-20240218   clang
x86_64                randconfig-014-20240218   clang
x86_64                randconfig-015-20240218   gcc  
x86_64                randconfig-016-20240218   clang
x86_64                randconfig-071-20240218   gcc  
x86_64                randconfig-072-20240218   clang
x86_64                randconfig-073-20240218   gcc  
x86_64                randconfig-074-20240218   gcc  
x86_64                randconfig-075-20240218   clang
x86_64                randconfig-076-20240218   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240218   gcc  
xtensa                randconfig-002-20240218   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
