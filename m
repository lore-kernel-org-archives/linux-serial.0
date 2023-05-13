Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E35C77B7D
	for <linux-serial@archiver.kernel.org>; Sat, 13 May 2023 23:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjEMX1V (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 13 May 2023 19:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEMX1V (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 13 May 2023 19:27:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8341FE7
        for <linux-serial@vger.kernel.org>; Sat, 13 May 2023 16:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684020439; x=1715556439;
  h=date:from:to:cc:subject:message-id;
  bh=ikz9MHJjFS/yonVZi9ESgMTVhSWwPUzUQ/6mUOkL+t4=;
  b=WaCcTAzuJvKokSWT//d4BtfYC7gKpmIzLyI9A1bc1MVQvndukgJdVzzD
   zig6bnCdqRodROS+czC6lHybMDwnGYFoMfxgCWXjzlR40BKHbs5lqLa/z
   CXdGjTG6XXdahmGPUbJV/cvX+ZVYvx2AjflxRfiZe+r6JtQku+YhDcJp9
   FqwlpQ/J9IeDxD1dSHW5LRgtJPj/SpqH6KewDDk6K0cRovb0YVh+9f++E
   ecA3VzM+vzLn6hquVMM8tKi/tpsQpkl8zUs5tDgpSCuXH5KOsxjcRvKRO
   aLOCXlZClbBUVKfIM5Bq7x9RdUsjV813Bor1uymEyW+49mCkPi56qQTx0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="330611544"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="330611544"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 16:27:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="678040643"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="678040643"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 13 May 2023 16:27:18 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxydx-0005jM-1y;
        Sat, 13 May 2023 23:27:17 +0000
Date:   Sun, 14 May 2023 07:26:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 d5b3d02d0b107345f2a6ecb5b06f98356f5c97ab
Message-ID: <20230513232621.rQKGk%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: d5b3d02d0b107345f2a6ecb5b06f98356f5c97ab  serial: Make uart_remove_one_port() return void

elapsed time: 728m

configs tested: 182
configs skipped: 21

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r006-20230510   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230511   gcc  
alpha                randconfig-r033-20230512   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230511   gcc  
arc          buildonly-randconfig-r001-20230513   gcc  
arc          buildonly-randconfig-r002-20230510   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230509   gcc  
arc                  randconfig-r011-20230511   gcc  
arc                  randconfig-r023-20230509   gcc  
arc                  randconfig-r024-20230512   gcc  
arc                  randconfig-r024-20230513   gcc  
arc                  randconfig-r025-20230509   gcc  
arc                  randconfig-r032-20230509   gcc  
arc                  randconfig-r032-20230512   gcc  
arc                  randconfig-r043-20230509   gcc  
arc                  randconfig-r043-20230511   gcc  
arc                  randconfig-r043-20230513   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         nhk8815_defconfig   gcc  
arm                  randconfig-r002-20230513   gcc  
arm                  randconfig-r031-20230509   clang
arm                  randconfig-r036-20230509   clang
arm                  randconfig-r046-20230509   gcc  
arm                  randconfig-r046-20230511   clang
arm                  randconfig-r046-20230513   clang
arm                        shmobile_defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r031-20230512   gcc  
arm64                randconfig-r034-20230512   gcc  
arm64                randconfig-r036-20230512   gcc  
csky         buildonly-randconfig-r003-20230510   gcc  
csky         buildonly-randconfig-r006-20230511   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230511   gcc  
csky                 randconfig-r014-20230509   gcc  
hexagon      buildonly-randconfig-r003-20230511   clang
hexagon      buildonly-randconfig-r004-20230510   clang
hexagon      buildonly-randconfig-r004-20230511   clang
hexagon      buildonly-randconfig-r005-20230513   clang
hexagon              randconfig-r023-20230512   clang
hexagon              randconfig-r026-20230511   clang
hexagon              randconfig-r041-20230509   clang
hexagon              randconfig-r041-20230511   clang
hexagon              randconfig-r041-20230513   clang
hexagon              randconfig-r045-20230509   clang
hexagon              randconfig-r045-20230511   clang
hexagon              randconfig-r045-20230513   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             alldefconfig   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230509   gcc  
ia64                 randconfig-r013-20230513   gcc  
ia64                 randconfig-r014-20230513   gcc  
ia64                 randconfig-r015-20230509   gcc  
ia64                 randconfig-r015-20230511   gcc  
ia64                 randconfig-r022-20230513   gcc  
ia64                 randconfig-r025-20230513   gcc  
ia64                 randconfig-r026-20230509   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230510   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230509   gcc  
loongarch            randconfig-r006-20230513   gcc  
loongarch            randconfig-r014-20230511   gcc  
loongarch            randconfig-r021-20230509   gcc  
loongarch            randconfig-r025-20230512   gcc  
loongarch            randconfig-r034-20230513   gcc  
loongarch            randconfig-r035-20230511   gcc  
loongarch            randconfig-r035-20230512   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                 randconfig-r031-20230513   gcc  
m68k                 randconfig-r033-20230513   gcc  
microblaze           randconfig-r005-20230511   gcc  
microblaze           randconfig-r023-20230513   gcc  
microblaze           randconfig-r036-20230513   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                      malta_kvm_defconfig   clang
mips                 randconfig-r004-20230509   clang
mips                 randconfig-r022-20230509   gcc  
nios2                         3c120_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230509   gcc  
nios2                randconfig-r006-20230511   gcc  
openrisc             randconfig-r016-20230511   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230513   gcc  
parisc               randconfig-r003-20230513   gcc  
parisc               randconfig-r004-20230513   gcc  
parisc               randconfig-r035-20230509   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230511   gcc  
powerpc              randconfig-r003-20230511   clang
powerpc              randconfig-r024-20230509   clang
powerpc              randconfig-r026-20230512   clang
powerpc              randconfig-r033-20230509   gcc  
powerpc              randconfig-r035-20230513   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230509   clang
riscv                randconfig-r042-20230511   gcc  
riscv                randconfig-r042-20230513   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r021-20230511   gcc  
s390                 randconfig-r033-20230511   clang
s390                 randconfig-r044-20230509   clang
s390                 randconfig-r044-20230511   gcc  
s390                 randconfig-r044-20230513   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230511   gcc  
sh                   randconfig-r016-20230513   gcc  
sh                   randconfig-r021-20230513   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sparc        buildonly-randconfig-r006-20230513   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230509   gcc  
sparc                randconfig-r015-20230513   gcc  
sparc                randconfig-r022-20230512   gcc  
sparc                randconfig-r034-20230511   gcc  
sparc64      buildonly-randconfig-r003-20230513   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230513   gcc  
xtensa       buildonly-randconfig-r005-20230510   gcc  
xtensa               randconfig-r005-20230513   gcc  
xtensa               randconfig-r011-20230513   gcc  
xtensa               randconfig-r022-20230511   gcc  
xtensa               randconfig-r036-20230511   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
