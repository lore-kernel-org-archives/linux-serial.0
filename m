Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA4AC6FA8F
	for <linux-serial@archiver.kernel.org>; Thu, 24 Aug 2023 11:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbjHXL47 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Aug 2023 07:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241232AbjHXL4b (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Aug 2023 07:56:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA954198A
        for <linux-serial@vger.kernel.org>; Thu, 24 Aug 2023 04:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692878189; x=1724414189;
  h=date:from:to:cc:subject:message-id;
  bh=6N9cSPB+GK3T+LNVGa3LkuVHdtlnrazsNObVBTXU19E=;
  b=RsN5IGtoMw86Hy50SVk6DG7U/gV4cZuqehTUPrjoyoH6RPUzRn82kCGQ
   0JXv2mQapjCGPkYAFIr3xxEFT8w2qzy1qM4yevi0dbOJ2Tw+ZvI9Sy5Eq
   2vOks+VgThel9Yhe1Kx1XUPX5qqTPFyxVUM857WMpyGS2R9/oBc7yQdec
   iQEfXXxhNE3+f4sl5GS6Qo0Vj18TOA1g6qJRzMUYcjs7pypzwU5NH/y2y
   82z30RdDvouAWn8LigPH4L1bnqIw0nLaAZIjVAHZ6SnRCFslEXM+MDlh7
   PUI4uuhCb4TpYuw7IZ2CN+Hx4bgaY9ysZaAZmQDeo93q3DAHKL/bO2lL1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="373298682"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="373298682"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 04:56:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="880774305"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2023 04:56:18 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZ8we-0002F0-25;
        Thu, 24 Aug 2023 11:56:12 +0000
Date:   Thu, 24 Aug 2023 19:55:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 4b91dcc2f601cc2098b5fead71344704ddcff8b7
Message-ID: <202308241936.KBVxULRI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 4b91dcc2f601cc2098b5fead71344704ddcff8b7  Documentation: devices.txt: Fix minors for ttyCPM*

elapsed time: 2756m

configs tested: 208
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230824   gcc  
alpha                randconfig-r026-20230824   gcc  
alpha                randconfig-r034-20230824   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230823   gcc  
arc                   randconfig-001-20230824   gcc  
arc                  randconfig-r011-20230823   gcc  
arc                  randconfig-r032-20230824   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                   randconfig-001-20230823   clang
arm                   randconfig-001-20230824   gcc  
arm                  randconfig-r001-20230823   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230823   clang
arm64                randconfig-r004-20230824   gcc  
arm64                randconfig-r011-20230824   clang
arm64                randconfig-r013-20230824   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230824   gcc  
csky                 randconfig-r025-20230824   gcc  
hexagon               randconfig-001-20230823   clang
hexagon               randconfig-001-20230824   clang
hexagon               randconfig-002-20230823   clang
hexagon               randconfig-002-20230824   clang
hexagon              randconfig-r001-20230824   clang
hexagon              randconfig-r012-20230823   clang
hexagon              randconfig-r033-20230823   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230823   clang
i386         buildonly-randconfig-002-20230823   clang
i386         buildonly-randconfig-003-20230823   clang
i386         buildonly-randconfig-004-20230823   clang
i386         buildonly-randconfig-005-20230823   clang
i386         buildonly-randconfig-006-20230823   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230823   clang
i386                  randconfig-002-20230823   clang
i386                  randconfig-003-20230823   clang
i386                  randconfig-004-20230823   clang
i386                  randconfig-005-20230823   clang
i386                  randconfig-006-20230823   clang
i386                  randconfig-011-20230823   gcc  
i386                  randconfig-012-20230823   gcc  
i386                  randconfig-013-20230823   gcc  
i386                  randconfig-014-20230823   gcc  
i386                  randconfig-015-20230823   gcc  
i386                  randconfig-016-20230823   gcc  
i386                 randconfig-r013-20230823   gcc  
i386                 randconfig-r014-20230824   clang
i386                 randconfig-r022-20230823   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230823   gcc  
loongarch             randconfig-001-20230824   gcc  
loongarch            randconfig-r013-20230824   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r004-20230823   gcc  
m68k                 randconfig-r006-20230824   gcc  
m68k                 randconfig-r021-20230824   gcc  
m68k                 randconfig-r033-20230824   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r003-20230823   gcc  
microblaze           randconfig-r012-20230824   gcc  
microblaze           randconfig-r031-20230824   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1000-neo_defconfig   clang
mips                           mtx1_defconfig   clang
mips                 randconfig-r006-20230823   gcc  
mips                 randconfig-r021-20230823   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r023-20230824   gcc  
nios2                randconfig-r032-20230823   gcc  
nios2                randconfig-r034-20230823   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r023-20230823   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230824   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                    gamecube_defconfig   clang
powerpc              randconfig-r005-20230823   clang
powerpc              randconfig-r015-20230824   clang
powerpc              randconfig-r016-20230823   gcc  
powerpc                     tqm8555_defconfig   gcc  
powerpc64            randconfig-r035-20230823   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230823   clang
riscv                 randconfig-001-20230824   gcc  
riscv                randconfig-r036-20230823   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230823   gcc  
s390                  randconfig-001-20230824   clang
s390                 randconfig-r014-20230824   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                   randconfig-r016-20230824   gcc  
sh                   randconfig-r026-20230823   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230824   gcc  
sparc                randconfig-r024-20230824   gcc  
sparc                randconfig-r025-20230823   gcc  
sparc                randconfig-r035-20230824   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r015-20230824   gcc  
sparc64              randconfig-r024-20230823   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230823   clang
x86_64       buildonly-randconfig-002-20230823   clang
x86_64       buildonly-randconfig-003-20230823   clang
x86_64       buildonly-randconfig-004-20230823   clang
x86_64       buildonly-randconfig-005-20230823   clang
x86_64       buildonly-randconfig-006-20230823   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230823   gcc  
x86_64                randconfig-002-20230823   gcc  
x86_64                randconfig-003-20230823   gcc  
x86_64                randconfig-004-20230823   gcc  
x86_64                randconfig-005-20230823   gcc  
x86_64                randconfig-006-20230823   gcc  
x86_64                randconfig-011-20230823   clang
x86_64                randconfig-012-20230823   clang
x86_64                randconfig-013-20230823   clang
x86_64                randconfig-014-20230823   clang
x86_64                randconfig-015-20230823   clang
x86_64                randconfig-016-20230823   clang
x86_64                randconfig-071-20230823   clang
x86_64                randconfig-072-20230823   clang
x86_64                randconfig-073-20230823   clang
x86_64                randconfig-074-20230823   clang
x86_64                randconfig-075-20230823   clang
x86_64                randconfig-076-20230823   clang
x86_64               randconfig-r016-20230824   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa               randconfig-r005-20230824   gcc  
xtensa               randconfig-r014-20230823   gcc  
xtensa               randconfig-r015-20230823   gcc  
xtensa               randconfig-r022-20230824   gcc  
xtensa               randconfig-r031-20230823   gcc  
xtensa               randconfig-r036-20230824   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
