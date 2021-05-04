Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094F2C433B4
	for <linux-serial@archiver.kernel.org>; Tue,  4 May 2021 06:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5122613B3
	for <linux-serial@archiver.kernel.org>; Tue,  4 May 2021 06:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhEDGXB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 May 2021 02:23:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:18462 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229773AbhEDGXA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 May 2021 02:23:00 -0400
IronPort-SDR: 4wHpX4ZkFqUjfjI0Xi1lOH+XBokMQ+I7UtYK5YWI3hXX7qSy5KJepJ6JT3W54W61rsjxsbStyJ
 kmZp7QpxNliQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="194772972"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="194772972"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 23:22:06 -0700
IronPort-SDR: mOEY3exh7RAT/T0esw9y1JmYB5r3bbrVNKzINMsTHa9MbqCwkV/0n+RjIuxRy8HQ9d8rc0r1oq
 +Bgg24ufHKNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="468380636"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 May 2021 23:22:04 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ldoRX-0009Uh-V4; Tue, 04 May 2021 06:22:03 +0000
Date:   Tue, 04 May 2021 14:21:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty_msg_cleanup] BUILD SUCCESS
 efbe2a641f47d13a3ab58bb0487cf5af3d9eb978
Message-ID: <6090e7d0./OUTedk4htAzE1fO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty_msg_cleanup
branch HEAD: efbe2a641f47d13a3ab58bb0487cf5af3d9eb978  tty: remove tty_driver_name()

elapsed time: 724m

configs tested: 93
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                           stm32_defconfig
sh                           se7343_defconfig
powerpc                 canyonlands_defconfig
sh                        edosk7705_defconfig
sh                          sdk7786_defconfig
mips                        bcm47xx_defconfig
mips                         tb0226_defconfig
mips                            e55_defconfig
mips                        vocore2_defconfig
m68k                       m5475evb_defconfig
sh                              ul2_defconfig
arm                  colibri_pxa300_defconfig
sh                     sh7710voipgw_defconfig
sh                        sh7785lcr_defconfig
mips                      maltaaprp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20210503
x86_64               randconfig-a005-20210503
x86_64               randconfig-a003-20210503
x86_64               randconfig-a002-20210503
x86_64               randconfig-a006-20210503
x86_64               randconfig-a004-20210503
i386                 randconfig-a003-20210503
i386                 randconfig-a006-20210503
i386                 randconfig-a001-20210503
i386                 randconfig-a005-20210503
i386                 randconfig-a004-20210503
i386                 randconfig-a002-20210503
i386                 randconfig-a013-20210503
i386                 randconfig-a015-20210503
i386                 randconfig-a016-20210503
i386                 randconfig-a014-20210503
i386                 randconfig-a011-20210503
i386                 randconfig-a012-20210503
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210503
x86_64               randconfig-a015-20210503
x86_64               randconfig-a012-20210503
x86_64               randconfig-a011-20210503
x86_64               randconfig-a013-20210503
x86_64               randconfig-a016-20210503

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
