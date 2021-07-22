Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6C0C6377A
	for <linux-serial@archiver.kernel.org>; Thu, 22 Jul 2021 02:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84D2D61222
	for <linux-serial@archiver.kernel.org>; Thu, 22 Jul 2021 02:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhGVBzY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Jul 2021 21:55:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:30495 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230098AbhGVBzY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Jul 2021 21:55:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="233362488"
X-IronPort-AV: E=Sophos;i="5.84,259,1620716400"; 
   d="scan'208";a="233362488"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 19:36:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,259,1620716400"; 
   d="scan'208";a="470369978"
Received: from lkp-server01.sh.intel.com (HELO b8b92b2878b0) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jul 2021 19:35:59 -0700
Received: from kbuild by b8b92b2878b0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m6OZ3-0000lu-LK; Thu, 22 Jul 2021 02:35:57 +0000
Date:   Thu, 22 Jul 2021 10:35:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 e679004dec37566f658a255157d3aed9d762a2b7
Message-ID: <60f8d96e.BJqpepQ68x4QI8ME%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: e679004dec37566f658a255157d3aed9d762a2b7  tty: hvc: replace BUG_ON() with negative return value

elapsed time: 732m

configs tested: 147
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                      fuloong2e_defconfig
powerpc                       ebony_defconfig
arm                            mmp2_defconfig
powerpc                  storcenter_defconfig
mips                   sb1250_swarm_defconfig
nios2                               defconfig
csky                             alldefconfig
arm                             ezx_defconfig
sh                             shx3_defconfig
sh                          rsk7201_defconfig
arm                     davinci_all_defconfig
mips                           gcw0_defconfig
powerpc                 linkstation_defconfig
sh                   sh7770_generic_defconfig
powerpc                      pasemi_defconfig
m68k                        mvme16x_defconfig
sh                          r7785rp_defconfig
sparc64                             defconfig
arc                     nsimosci_hs_defconfig
m68k                             allyesconfig
sh                          polaris_defconfig
powerpc                      mgcoge_defconfig
powerpc                       eiger_defconfig
mips                  decstation_64_defconfig
microblaze                          defconfig
arm                        shmobile_defconfig
parisc                generic-64bit_defconfig
powerpc                     tqm8555_defconfig
arm                           h5000_defconfig
arc                              alldefconfig
mips                         tb0287_defconfig
mips                           jazz_defconfig
sh                            titan_defconfig
arc                        nsim_700_defconfig
mips                        vocore2_defconfig
riscv                          rv32_defconfig
mips                           ip28_defconfig
arm64                            alldefconfig
mips                     cu1000-neo_defconfig
riscv                    nommu_virt_defconfig
mips                 decstation_r4k_defconfig
xtensa                  nommu_kc705_defconfig
xtensa                    smp_lx200_defconfig
arm                          lpd270_defconfig
powerpc                  mpc866_ads_defconfig
arm                            pleb_defconfig
arm                           omap1_defconfig
csky                                defconfig
xtensa                       common_defconfig
h8300                               defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
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
x86_64               randconfig-a003-20210720
x86_64               randconfig-a006-20210720
x86_64               randconfig-a001-20210720
x86_64               randconfig-a005-20210720
x86_64               randconfig-a004-20210720
x86_64               randconfig-a002-20210720
i386                 randconfig-a005-20210719
i386                 randconfig-a004-20210719
i386                 randconfig-a006-20210719
i386                 randconfig-a001-20210719
i386                 randconfig-a003-20210719
i386                 randconfig-a002-20210719
i386                 randconfig-a005-20210720
i386                 randconfig-a003-20210720
i386                 randconfig-a004-20210720
i386                 randconfig-a002-20210720
i386                 randconfig-a001-20210720
i386                 randconfig-a006-20210720
i386                 randconfig-a005-20210721
i386                 randconfig-a003-20210721
i386                 randconfig-a004-20210721
i386                 randconfig-a002-20210721
i386                 randconfig-a001-20210721
i386                 randconfig-a006-20210721
x86_64               randconfig-a011-20210721
x86_64               randconfig-a016-20210721
x86_64               randconfig-a013-20210721
x86_64               randconfig-a014-20210721
x86_64               randconfig-a012-20210721
x86_64               randconfig-a015-20210721
i386                 randconfig-a016-20210720
i386                 randconfig-a013-20210720
i386                 randconfig-a012-20210720
i386                 randconfig-a014-20210720
i386                 randconfig-a011-20210720
i386                 randconfig-a015-20210720
i386                 randconfig-a016-20210721
i386                 randconfig-a013-20210721
i386                 randconfig-a012-20210721
i386                 randconfig-a014-20210721
i386                 randconfig-a011-20210721
i386                 randconfig-a015-20210721
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210720
x86_64               randconfig-a011-20210720
x86_64               randconfig-a016-20210720
x86_64               randconfig-a013-20210720
x86_64               randconfig-a014-20210720
x86_64               randconfig-a012-20210720
x86_64               randconfig-a015-20210720

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
