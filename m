Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A8AC001B0
	for <linux-serial@archiver.kernel.org>; Sat, 12 Aug 2023 19:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjHLTdV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 12 Aug 2023 15:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjHLTdU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 12 Aug 2023 15:33:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBCEA6
        for <linux-serial@vger.kernel.org>; Sat, 12 Aug 2023 12:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691868803; x=1723404803;
  h=date:from:to:cc:subject:message-id;
  bh=RAcoRlTqjdwH0WkYVo2Tq6cr8pDzaH0Fd3zlktK/Oyo=;
  b=TGgDF1c69DDztNcKiTrt0hBgDLjHRzOG2v7iskcnFnL7zi60qmTLXRtJ
   EeJ1mQmB7Pt2CpEHMirG5m+0lAxl7Q8ksvWKKF9n+hrFUGTF1CuwJR2T2
   6bpFmOdvYrAhdp6EU81B4fBMs5i8UC+8/lrVRMeu+8KvkR+sPySWJuJCt
   o4vrlVTtepMJoCBLasS1+wu0Fzg4d7+nqPo9t5H1L6wOxwjX0UZsCC0Oy
   dRFUPwtz2pWfnpFlmxak2fnia5HRHaaTv1426fxZVLxiN7DslHYHbbCAb
   L8yjy7I5umXVM3/2/EKeunu4uiQmPy2FPwxvkwmM2Q9BSw5KkH76MHWRj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10800"; a="435740401"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="435740401"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2023 12:33:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10800"; a="856618856"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="856618856"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 12 Aug 2023 12:33:22 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUuMT-0008kU-0Y;
        Sat, 12 Aug 2023 19:33:21 +0000
Date:   Sun, 13 Aug 2023 03:33:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 04c7f60ca477ffbf7b7910320482335050f0d23a
Message-ID: <202308130313.LVpTxArX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 04c7f60ca477ffbf7b7910320482335050f0d23a  serial: core: Fix serial core port id, including multiport devices

elapsed time: 1448m

configs tested: 145
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230812   gcc  
alpha                randconfig-r005-20230812   gcc  
arc                              alldefconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                  randconfig-r006-20230812   gcc  
arc                  randconfig-r024-20230812   gcc  
arc                  randconfig-r043-20230812   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                        mvebu_v5_defconfig   gcc  
arm                       netwinder_defconfig   gcc  
arm                  randconfig-r033-20230812   clang
arm                  randconfig-r046-20230812   gcc  
arm                        shmobile_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r035-20230812   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230812   clang
hexagon              randconfig-r045-20230812   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230812   gcc  
i386         buildonly-randconfig-r005-20230812   gcc  
i386         buildonly-randconfig-r006-20230812   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230812   gcc  
i386                 randconfig-i001-20230813   clang
i386                 randconfig-i002-20230812   gcc  
i386                 randconfig-i002-20230813   clang
i386                 randconfig-i003-20230812   gcc  
i386                 randconfig-i003-20230813   clang
i386                 randconfig-i004-20230812   gcc  
i386                 randconfig-i004-20230813   clang
i386                 randconfig-i005-20230812   gcc  
i386                 randconfig-i005-20230813   clang
i386                 randconfig-i006-20230812   gcc  
i386                 randconfig-i006-20230813   clang
i386                 randconfig-i011-20230812   clang
i386                 randconfig-i011-20230813   gcc  
i386                 randconfig-i012-20230812   clang
i386                 randconfig-i012-20230813   gcc  
i386                 randconfig-i013-20230812   clang
i386                 randconfig-i013-20230813   gcc  
i386                 randconfig-i014-20230812   clang
i386                 randconfig-i014-20230813   gcc  
i386                 randconfig-i015-20230812   clang
i386                 randconfig-i015-20230813   gcc  
i386                 randconfig-i016-20230812   clang
i386                 randconfig-i016-20230813   gcc  
i386                 randconfig-r022-20230812   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230812   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze           randconfig-r001-20230812   gcc  
microblaze           randconfig-r013-20230812   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                           jazz_defconfig   gcc  
mips                 randconfig-r034-20230812   clang
nios2                               defconfig   gcc  
nios2                randconfig-r015-20230812   gcc  
nios2                randconfig-r026-20230812   gcc  
openrisc             randconfig-r011-20230812   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     skiroot_defconfig   gcc  
powerpc                  storcenter_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r014-20230812   clang
riscv                randconfig-r042-20230812   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r012-20230812   clang
s390                 randconfig-r025-20230812   clang
s390                 randconfig-r044-20230812   clang
sh                               allmodconfig   gcc  
sh                               j2_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230812   gcc  
sparc64              randconfig-r021-20230812   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r003-20230812   clang
um                   randconfig-r036-20230812   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230812   gcc  
x86_64       buildonly-randconfig-r002-20230812   gcc  
x86_64       buildonly-randconfig-r003-20230812   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r031-20230812   gcc  
x86_64               randconfig-x001-20230812   clang
x86_64               randconfig-x001-20230813   gcc  
x86_64               randconfig-x002-20230812   clang
x86_64               randconfig-x002-20230813   gcc  
x86_64               randconfig-x003-20230812   clang
x86_64               randconfig-x003-20230813   gcc  
x86_64               randconfig-x004-20230812   clang
x86_64               randconfig-x004-20230813   gcc  
x86_64               randconfig-x005-20230812   clang
x86_64               randconfig-x005-20230813   gcc  
x86_64               randconfig-x006-20230812   clang
x86_64               randconfig-x006-20230813   gcc  
x86_64               randconfig-x011-20230812   gcc  
x86_64               randconfig-x011-20230813   clang
x86_64               randconfig-x012-20230812   gcc  
x86_64               randconfig-x012-20230813   clang
x86_64               randconfig-x013-20230812   gcc  
x86_64               randconfig-x013-20230813   clang
x86_64               randconfig-x014-20230812   gcc  
x86_64               randconfig-x014-20230813   clang
x86_64               randconfig-x015-20230812   gcc  
x86_64               randconfig-x015-20230813   clang
x86_64               randconfig-x016-20230812   gcc  
x86_64               randconfig-x016-20230813   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
