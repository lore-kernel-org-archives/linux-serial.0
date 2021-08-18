Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A210C4338F
	for <linux-serial@archiver.kernel.org>; Wed, 18 Aug 2021 03:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E61E60F38
	for <linux-serial@archiver.kernel.org>; Wed, 18 Aug 2021 03:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbhHRDTD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Aug 2021 23:19:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:60374 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236113AbhHRDSy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Aug 2021 23:18:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="277269694"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="277269694"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 20:18:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="680588714"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2021 20:18:18 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mGC5p-000SUi-GQ; Wed, 18 Aug 2021 03:18:17 +0000
Date:   Wed, 18 Aug 2021 11:17:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 1143637f00cd8205c43bad702b2aff57c01913f8
Message-ID: <611c7bc3.vkNt1l8/oFSzqsJi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 1143637f00cd8205c43bad702b2aff57c01913f8  tty: replace in_irq() with in_hardirq()

elapsed time: 2009m

configs tested: 108
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210816
powerpc                   motionpro_defconfig
sh                          rsk7203_defconfig
nds32                               defconfig
powerpc                         wii_defconfig
powerpc                     skiroot_defconfig
powerpc64                        alldefconfig
powerpc                         ps3_defconfig
powerpc                  mpc866_ads_defconfig
arm                         lpc18xx_defconfig
arm                         lubbock_defconfig
powerpc                   bluestone_defconfig
powerpc                     ep8248e_defconfig
parisc                generic-32bit_defconfig
arm                        neponset_defconfig
arm                          simpad_defconfig
mips                        workpad_defconfig
powerpc                    mvme5100_defconfig
powerpc                     rainier_defconfig
mips                        nlm_xlr_defconfig
sh                             shx3_defconfig
m68k                             alldefconfig
arc                        vdk_hs38_defconfig
powerpc                       ebony_defconfig
arm                         s3c6400_defconfig
sh                         ecovec24_defconfig
arm                         orion5x_defconfig
alpha                            alldefconfig
m68k                        mvme16x_defconfig
arm                      pxa255-idp_defconfig
sh                           se7750_defconfig
m68k                       m5208evb_defconfig
arm                         s5pv210_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210816
x86_64               randconfig-a004-20210816
x86_64               randconfig-a003-20210816
x86_64               randconfig-a001-20210816
x86_64               randconfig-a005-20210816
x86_64               randconfig-a002-20210816
i386                 randconfig-a004-20210816
i386                 randconfig-a003-20210816
i386                 randconfig-a002-20210816
i386                 randconfig-a001-20210816
i386                 randconfig-a006-20210816
i386                 randconfig-a005-20210816
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20210816
x86_64               randconfig-a011-20210816
x86_64               randconfig-a013-20210816
x86_64               randconfig-a016-20210816
x86_64               randconfig-a012-20210816
x86_64               randconfig-a015-20210816
x86_64               randconfig-a014-20210816
i386                 randconfig-a011-20210816
i386                 randconfig-a015-20210816
i386                 randconfig-a013-20210816
i386                 randconfig-a014-20210816
i386                 randconfig-a016-20210816
i386                 randconfig-a012-20210816

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
