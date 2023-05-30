Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804A8C7EE23
	for <linux-serial@archiver.kernel.org>; Tue, 30 May 2023 12:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjE3MAe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 May 2023 08:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjE3MAd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 May 2023 08:00:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED93FE
        for <linux-serial@vger.kernel.org>; Tue, 30 May 2023 05:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685448021; x=1716984021;
  h=date:from:to:cc:subject:message-id;
  bh=2IM4uHShIoBPAYn824Ri0GRTvK3evhg09qtS9+kMtN4=;
  b=Tn7qe/wBmkETNmg85X4+XcW8nj4nHiGqCNalh47Wq/vDrcScQkO9JRII
   PbqygW3SxAqH5TiViJqJVa3vye1xkItH+eK8NBGttX8zmT06NSRcGDfyO
   BqcYx/jNtdhgLZyI658gH/EviJKAQg06Y5iaDWfP1rc2g4CKhzZ+xDl2J
   94fELnn3xYCs4/0fekILjHethSqhTg/x5WGLZ8juNiqJfJCcFp4pg4w3D
   cMDK0LCDT0ZvVMKzIK0b2APybQo6UetyTCJ79R1qLlWnvGBgVfDarBCqJ
   JLBqAmXedQvBwubrV4R6vGz4Mn2LRKRXfj/kF86I0aBhH+65xubov85tO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="357267643"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="357267643"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 05:00:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="683936921"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="683936921"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 May 2023 05:00:16 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q3y1P-0000S1-1u;
        Tue, 30 May 2023 12:00:15 +0000
Date:   Tue, 30 May 2023 20:00:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-next] BUILD SUCCESS
 0e4daea31d8312dd9f957a62717d4b5f31ef494c
Message-ID: <20230530120006.9pMmY%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
branch HEAD: 0e4daea31d8312dd9f957a62717d4b5f31ef494c  Merge 6.4-rc3 into tty-next

elapsed time: 2723m

configs tested: 382
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230529   gcc  
alpha        buildonly-randconfig-r005-20230529   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230528   gcc  
alpha                randconfig-r021-20230528   gcc  
alpha                randconfig-r024-20230528   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230529   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230528   gcc  
arc                  randconfig-r003-20230529   gcc  
arc                  randconfig-r005-20230529   gcc  
arc                  randconfig-r022-20230528   gcc  
arc                  randconfig-r024-20230529   gcc  
arc                  randconfig-r043-20230528   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r004-20230528   gcc  
arm          buildonly-randconfig-r005-20230528   gcc  
arm                                 defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                         mv78xx0_defconfig   clang
arm                  randconfig-r011-20230528   gcc  
arm                  randconfig-r024-20230528   gcc  
arm                  randconfig-r046-20230528   gcc  
arm                  randconfig-r046-20230529   clang
arm                             rpc_defconfig   gcc  
arm                        spear3xx_defconfig   clang
arm                        spear6xx_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230528   gcc  
arm64                randconfig-r023-20230528   clang
arm64                randconfig-r034-20230528   gcc  
csky                                defconfig   gcc  
hexagon      buildonly-randconfig-r005-20230528   clang
hexagon      buildonly-randconfig-r006-20230530   clang
hexagon              randconfig-r041-20230528   clang
hexagon              randconfig-r041-20230529   clang
hexagon              randconfig-r045-20230528   clang
hexagon              randconfig-r045-20230529   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r001-20230528   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230528   gcc  
i386                 randconfig-i001-20230529   clang
i386                 randconfig-i002-20230528   gcc  
i386                 randconfig-i002-20230529   clang
i386                 randconfig-i003-20230528   gcc  
i386                 randconfig-i003-20230529   clang
i386                 randconfig-i004-20230528   gcc  
i386                 randconfig-i004-20230529   clang
i386                 randconfig-i005-20230528   gcc  
i386                 randconfig-i005-20230529   clang
i386                 randconfig-i006-20230528   gcc  
i386                 randconfig-i006-20230529   clang
i386                 randconfig-i011-20230528   clang
i386                 randconfig-i011-20230529   gcc  
i386                 randconfig-i012-20230528   clang
i386                 randconfig-i012-20230529   gcc  
i386                 randconfig-i013-20230528   clang
i386                 randconfig-i013-20230529   gcc  
i386                 randconfig-i014-20230528   clang
i386                 randconfig-i014-20230529   gcc  
i386                 randconfig-i015-20230528   clang
i386                 randconfig-i015-20230529   gcc  
i386                 randconfig-i016-20230528   clang
i386                 randconfig-i016-20230529   gcc  
i386                 randconfig-i051-20230528   gcc  
i386                 randconfig-i051-20230529   clang
i386                 randconfig-i051-20230530   clang
i386                 randconfig-i052-20230528   gcc  
i386                 randconfig-i052-20230529   clang
i386                 randconfig-i052-20230530   clang
i386                 randconfig-i053-20230528   gcc  
i386                 randconfig-i053-20230529   clang
i386                 randconfig-i053-20230530   clang
i386                 randconfig-i054-20230528   gcc  
i386                 randconfig-i054-20230529   clang
i386                 randconfig-i054-20230530   clang
i386                 randconfig-i055-20230528   gcc  
i386                 randconfig-i055-20230529   clang
i386                 randconfig-i055-20230530   clang
i386                 randconfig-i056-20230528   gcc  
i386                 randconfig-i056-20230529   clang
i386                 randconfig-i056-20230530   clang
i386                 randconfig-i061-20230528   gcc  
i386                 randconfig-i061-20230529   clang
i386                 randconfig-i061-20230530   clang
i386                 randconfig-i062-20230528   gcc  
i386                 randconfig-i062-20230529   clang
i386                 randconfig-i062-20230530   clang
i386                 randconfig-i063-20230528   gcc  
i386                 randconfig-i063-20230529   clang
i386                 randconfig-i063-20230530   clang
i386                 randconfig-i064-20230528   gcc  
i386                 randconfig-i064-20230529   clang
i386                 randconfig-i064-20230530   clang
i386                 randconfig-i065-20230528   gcc  
i386                 randconfig-i065-20230529   clang
i386                 randconfig-i065-20230530   clang
i386                 randconfig-i066-20230528   gcc  
i386                 randconfig-i066-20230529   clang
i386                 randconfig-i066-20230530   clang
i386                 randconfig-i071-20230528   clang
i386                 randconfig-i071-20230529   gcc  
i386                 randconfig-i072-20230528   clang
i386                 randconfig-i072-20230529   gcc  
i386                 randconfig-i073-20230528   clang
i386                 randconfig-i073-20230529   gcc  
i386                 randconfig-i074-20230528   clang
i386                 randconfig-i074-20230529   gcc  
i386                 randconfig-i075-20230528   clang
i386                 randconfig-i075-20230529   gcc  
i386                 randconfig-i076-20230528   clang
i386                 randconfig-i076-20230529   gcc  
i386                 randconfig-i081-20230528   clang
i386                 randconfig-i081-20230529   gcc  
i386                 randconfig-i082-20230528   clang
i386                 randconfig-i082-20230529   gcc  
i386                 randconfig-i083-20230528   clang
i386                 randconfig-i083-20230529   gcc  
i386                 randconfig-i084-20230528   clang
i386                 randconfig-i084-20230529   gcc  
i386                 randconfig-i085-20230528   clang
i386                 randconfig-i085-20230529   gcc  
i386                 randconfig-i086-20230528   clang
i386                 randconfig-i086-20230529   gcc  
i386                 randconfig-i091-20230528   gcc  
i386                 randconfig-i091-20230529   clang
i386                 randconfig-i092-20230528   gcc  
i386                 randconfig-i092-20230529   clang
i386                 randconfig-i093-20230528   gcc  
i386                 randconfig-i093-20230529   clang
i386                 randconfig-i094-20230528   gcc  
i386                 randconfig-i094-20230529   clang
i386                 randconfig-i095-20230528   gcc  
i386                 randconfig-i095-20230529   clang
i386                 randconfig-i096-20230528   gcc  
i386                 randconfig-i096-20230529   clang
i386                 randconfig-r002-20230528   gcc  
i386                 randconfig-r004-20230528   gcc  
i386                 randconfig-r013-20230528   clang
i386                 randconfig-r036-20230528   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r015-20230528   gcc  
m68k                             allmodconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k         buildonly-randconfig-r003-20230528   gcc  
m68k         buildonly-randconfig-r004-20230528   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                 randconfig-r002-20230529   gcc  
m68k                 randconfig-r013-20230529   gcc  
m68k                 randconfig-r016-20230528   gcc  
m68k                 randconfig-r022-20230528   gcc  
m68k                 randconfig-r031-20230528   gcc  
microblaze   buildonly-randconfig-r004-20230529   gcc  
microblaze                      mmu_defconfig   gcc  
microblaze           randconfig-r004-20230528   gcc  
microblaze           randconfig-r012-20230530   gcc  
microblaze           randconfig-r033-20230530   gcc  
microblaze           randconfig-r035-20230528   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips                        bcm47xx_defconfig   gcc  
mips         buildonly-randconfig-r002-20230528   clang
mips                           ip22_defconfig   clang
mips                           ip28_defconfig   clang
mips                     loongson1b_defconfig   gcc  
mips                           mtx1_defconfig   clang
mips                 randconfig-r001-20230529   gcc  
mips                 randconfig-r026-20230528   gcc  
mips                          rb532_defconfig   gcc  
mips                        vocore2_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2        buildonly-randconfig-r002-20230528   gcc  
nios2        buildonly-randconfig-r006-20230528   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230530   gcc  
nios2                randconfig-r012-20230529   gcc  
nios2                randconfig-r016-20230529   gcc  
openrisc                         alldefconfig   gcc  
openrisc     buildonly-randconfig-r003-20230528   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r021-20230529   gcc  
openrisc             randconfig-r032-20230528   gcc  
openrisc             randconfig-r033-20230528   gcc  
openrisc             randconfig-r036-20230530   gcc  
openrisc                 simple_smp_defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc               randconfig-r004-20230529   gcc  
parisc               randconfig-r006-20230528   gcc  
parisc               randconfig-r015-20230529   gcc  
parisc               randconfig-r025-20230528   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                 mpc8540_ads_defconfig   gcc  
powerpc                  mpc866_ads_defconfig   clang
powerpc              randconfig-r012-20230528   clang
powerpc              randconfig-r014-20230528   clang
powerpc              randconfig-r022-20230529   gcc  
powerpc                     sequoia_defconfig   gcc  
powerpc                  storcenter_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230528   clang
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230528   gcc  
riscv                randconfig-r014-20230528   clang
riscv                randconfig-r033-20230528   gcc  
riscv                randconfig-r042-20230528   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r013-20230530   gcc  
s390                 randconfig-r014-20230530   gcc  
s390                 randconfig-r023-20230528   clang
s390                 randconfig-r023-20230529   gcc  
s390                 randconfig-r026-20230528   clang
s390                 randconfig-r032-20230528   gcc  
s390                 randconfig-r034-20230528   gcc  
s390                 randconfig-r044-20230528   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r006-20230528   gcc  
sh                        dreamcast_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r016-20230528   gcc  
sh                   randconfig-r035-20230530   gcc  
sh                   randconfig-r036-20230528   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230528   gcc  
sparc                randconfig-r006-20230528   gcc  
sparc                randconfig-r016-20230530   gcc  
sparc                randconfig-r025-20230529   gcc  
sparc                randconfig-r026-20230529   gcc  
sparc64              randconfig-r006-20230529   gcc  
sparc64              randconfig-r014-20230529   gcc  
sparc64              randconfig-r015-20230528   gcc  
sparc64              randconfig-r032-20230530   gcc  
um                               alldefconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230530   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230528   gcc  
x86_64               randconfig-a001-20230529   clang
x86_64               randconfig-a002-20230528   gcc  
x86_64               randconfig-a002-20230529   clang
x86_64               randconfig-a003-20230528   gcc  
x86_64               randconfig-a003-20230529   clang
x86_64               randconfig-a004-20230528   gcc  
x86_64               randconfig-a004-20230529   clang
x86_64               randconfig-a005-20230528   gcc  
x86_64               randconfig-a005-20230529   clang
x86_64               randconfig-a006-20230528   gcc  
x86_64               randconfig-a006-20230529   clang
x86_64               randconfig-a011-20230528   clang
x86_64               randconfig-a011-20230529   gcc  
x86_64               randconfig-a011-20230530   gcc  
x86_64               randconfig-a012-20230528   clang
x86_64               randconfig-a012-20230529   gcc  
x86_64               randconfig-a012-20230530   gcc  
x86_64               randconfig-a013-20230528   clang
x86_64               randconfig-a013-20230529   gcc  
x86_64               randconfig-a013-20230530   gcc  
x86_64               randconfig-a014-20230528   clang
x86_64               randconfig-a014-20230529   gcc  
x86_64               randconfig-a014-20230530   gcc  
x86_64               randconfig-a015-20230528   clang
x86_64               randconfig-a015-20230529   gcc  
x86_64               randconfig-a015-20230530   gcc  
x86_64               randconfig-a016-20230528   clang
x86_64               randconfig-a016-20230529   gcc  
x86_64               randconfig-a016-20230530   gcc  
x86_64               randconfig-k001-20230528   clang
x86_64               randconfig-r012-20230528   clang
x86_64               randconfig-r035-20230528   gcc  
x86_64               randconfig-x051-20230528   clang
x86_64               randconfig-x051-20230529   gcc  
x86_64               randconfig-x052-20230528   clang
x86_64               randconfig-x052-20230529   gcc  
x86_64               randconfig-x053-20230528   clang
x86_64               randconfig-x053-20230529   gcc  
x86_64               randconfig-x054-20230528   clang
x86_64               randconfig-x054-20230529   gcc  
x86_64               randconfig-x055-20230528   clang
x86_64               randconfig-x055-20230529   gcc  
x86_64               randconfig-x056-20230528   clang
x86_64               randconfig-x056-20230529   gcc  
x86_64               randconfig-x061-20230528   clang
x86_64               randconfig-x061-20230529   gcc  
x86_64               randconfig-x061-20230530   gcc  
x86_64               randconfig-x062-20230528   clang
x86_64               randconfig-x062-20230529   gcc  
x86_64               randconfig-x062-20230530   gcc  
x86_64               randconfig-x063-20230528   clang
x86_64               randconfig-x063-20230529   gcc  
x86_64               randconfig-x063-20230530   gcc  
x86_64               randconfig-x064-20230528   clang
x86_64               randconfig-x064-20230529   gcc  
x86_64               randconfig-x064-20230530   gcc  
x86_64               randconfig-x065-20230528   clang
x86_64               randconfig-x065-20230529   gcc  
x86_64               randconfig-x065-20230530   gcc  
x86_64               randconfig-x066-20230528   clang
x86_64               randconfig-x066-20230529   gcc  
x86_64               randconfig-x066-20230530   gcc  
x86_64               randconfig-x071-20230528   gcc  
x86_64               randconfig-x071-20230529   clang
x86_64               randconfig-x072-20230528   gcc  
x86_64               randconfig-x072-20230529   clang
x86_64               randconfig-x073-20230528   gcc  
x86_64               randconfig-x073-20230529   clang
x86_64               randconfig-x074-20230528   gcc  
x86_64               randconfig-x074-20230529   clang
x86_64               randconfig-x075-20230528   gcc  
x86_64               randconfig-x075-20230529   clang
x86_64               randconfig-x076-20230528   gcc  
x86_64               randconfig-x076-20230529   clang
x86_64               randconfig-x081-20230528   gcc  
x86_64               randconfig-x081-20230529   clang
x86_64               randconfig-x082-20230528   gcc  
x86_64               randconfig-x082-20230529   clang
x86_64               randconfig-x083-20230528   gcc  
x86_64               randconfig-x083-20230529   clang
x86_64               randconfig-x084-20230528   gcc  
x86_64               randconfig-x084-20230529   clang
x86_64               randconfig-x085-20230528   gcc  
x86_64               randconfig-x085-20230529   clang
x86_64               randconfig-x086-20230528   gcc  
x86_64               randconfig-x086-20230529   clang
x86_64               randconfig-x091-20230528   clang
x86_64               randconfig-x091-20230529   gcc  
x86_64               randconfig-x092-20230528   clang
x86_64               randconfig-x092-20230529   gcc  
x86_64               randconfig-x093-20230528   clang
x86_64               randconfig-x093-20230529   gcc  
x86_64               randconfig-x094-20230528   clang
x86_64               randconfig-x094-20230529   gcc  
x86_64               randconfig-x095-20230528   clang
x86_64               randconfig-x095-20230529   gcc  
x86_64               randconfig-x096-20230528   clang
x86_64               randconfig-x096-20230529   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa       buildonly-randconfig-r006-20230529   gcc  
xtensa                          iss_defconfig   gcc  
xtensa               randconfig-r011-20230529   gcc  
xtensa               randconfig-r025-20230528   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
