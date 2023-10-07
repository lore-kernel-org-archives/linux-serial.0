Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91553E95A6A
	for <linux-serial@archiver.kernel.org>; Sat,  7 Oct 2023 22:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344204AbjJGWDj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 7 Oct 2023 18:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344151AbjJGWDj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 7 Oct 2023 18:03:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93279F
        for <linux-serial@vger.kernel.org>; Sat,  7 Oct 2023 15:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696716216; x=1728252216;
  h=date:from:to:cc:subject:message-id;
  bh=ev/9yEi37uFdxVkxUNXksX0JWCllN1YEP9JLGNnq2Q8=;
  b=NcrYxr3H/SJuJEpqQt1clpq3Fy9CSYyRO5Flw4Ltf+aDtL3jq70US+ap
   zLNJiAa+SnP1gNLwSaws66eL2WNPL77p5061AHAGBWZe20+U102y1UoWJ
   Q0Ak88ORo1SO8jfYjj22xtRF7H2EPQD8CqCX1+8bv/1S/JzCYRyFOsg1q
   xgrdozCggA0Zk08L+d5WiBmidC87dXY68q7C5MIEtkdQOrwOONHOEIyZP
   tyWq1r9PeiMv2Nm5isYXfye62cgw+WNnnoQPwqngdH2qXzoCUEDKlXXkm
   4d6GZ5vD+oEUPbdQEnoVAmEqBe8dVWBEfX/2gwR2cMwYirl8db/nMOTFb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="2562286"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="2562286"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 15:03:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="868779024"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="868779024"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 Oct 2023 15:03:33 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpFOV-0004q7-1J;
        Sat, 07 Oct 2023 22:03:31 +0000
Date:   Sun, 08 Oct 2023 06:02:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 81a61051e0ce5fd7e09225c0d5985da08c7954a7
Message-ID: <202310080646.40KOhHCJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 81a61051e0ce5fd7e09225c0d5985da08c7954a7  serial: core: Fix checks for tx runtime PM state

elapsed time: 755m

configs tested: 126
configs skipped: 2

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
arc                   randconfig-001-20231007   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231007   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231007   gcc  
i386         buildonly-randconfig-002-20231007   gcc  
i386         buildonly-randconfig-003-20231007   gcc  
i386         buildonly-randconfig-004-20231007   gcc  
i386         buildonly-randconfig-005-20231007   gcc  
i386         buildonly-randconfig-006-20231007   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231007   gcc  
i386                  randconfig-002-20231007   gcc  
i386                  randconfig-003-20231007   gcc  
i386                  randconfig-004-20231007   gcc  
i386                  randconfig-005-20231007   gcc  
i386                  randconfig-006-20231007   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20231007   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          rb532_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231008   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231008   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231008   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231008   gcc  
x86_64       buildonly-randconfig-002-20231008   gcc  
x86_64       buildonly-randconfig-003-20231008   gcc  
x86_64       buildonly-randconfig-004-20231008   gcc  
x86_64       buildonly-randconfig-005-20231008   gcc  
x86_64       buildonly-randconfig-006-20231008   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231007   gcc  
x86_64                randconfig-002-20231007   gcc  
x86_64                randconfig-003-20231007   gcc  
x86_64                randconfig-004-20231007   gcc  
x86_64                randconfig-005-20231007   gcc  
x86_64                randconfig-006-20231007   gcc  
x86_64                randconfig-011-20231008   gcc  
x86_64                randconfig-012-20231008   gcc  
x86_64                randconfig-013-20231008   gcc  
x86_64                randconfig-014-20231008   gcc  
x86_64                randconfig-015-20231008   gcc  
x86_64                randconfig-016-20231008   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                       common_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
