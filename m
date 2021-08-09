Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAB5C4338F
	for <linux-serial@archiver.kernel.org>; Mon,  9 Aug 2021 19:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99EF860FE3
	for <linux-serial@archiver.kernel.org>; Mon,  9 Aug 2021 19:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbhHITZl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Aug 2021 15:25:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:20233 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231439AbhHITZk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Aug 2021 15:25:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="211655872"
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="211655872"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 12:25:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="515349438"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Aug 2021 12:25:18 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mDAti-000Jpy-5O; Mon, 09 Aug 2021 19:25:18 +0000
Date:   Tue, 10 Aug 2021 03:24:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 15e580283f2654b3455970c404ae363197aa176d
Message-ID: <611180ed.Dwuj9zVrV+eGsJ3q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 15e580283f2654b3455970c404ae363197aa176d  Merge 5.14-rc5 into tty-next

elapsed time: 729m

configs tested: 144
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
sh                           se7750_defconfig
arm                         at91_dt_defconfig
arm                          iop32x_defconfig
nds32                             allnoconfig
m68k                       m5208evb_defconfig
arc                         haps_hs_defconfig
riscv                            alldefconfig
arm                       netwinder_defconfig
powerpc                     ksi8560_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                      obs600_defconfig
m68k                         amcore_defconfig
powerpc                      ppc64e_defconfig
powerpc                   microwatt_defconfig
arm                       aspeed_g5_defconfig
h8300                     edosk2674_defconfig
sh                          r7785rp_defconfig
sh                        edosk7705_defconfig
arm                         lpc18xx_defconfig
powerpc                     taishan_defconfig
arm                        keystone_defconfig
x86_64                            allnoconfig
sh                     sh7710voipgw_defconfig
arc                              allyesconfig
powerpc                    klondike_defconfig
i386                                defconfig
sh                           se7343_defconfig
powerpc                     tqm8541_defconfig
sh                         apsh4a3a_defconfig
mips                       capcella_defconfig
arm                      pxa255-idp_defconfig
sh                          rsk7201_defconfig
xtensa                         virt_defconfig
arm                         bcm2835_defconfig
sparc64                             defconfig
powerpc                      ppc40x_defconfig
mips                        nlm_xlp_defconfig
mips                     cu1830-neo_defconfig
sh                          sdk7780_defconfig
mips                       bmips_be_defconfig
mips                  decstation_64_defconfig
powerpc                     stx_gp3_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                         tb0287_defconfig
powerpc                      ep88xc_defconfig
powerpc64                           defconfig
m68k                        stmark2_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                          urquell_defconfig
mips                     loongson1b_defconfig
mips                     loongson1c_defconfig
powerpc                       holly_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                               defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210809
i386                 randconfig-a005-20210809
i386                 randconfig-a006-20210809
i386                 randconfig-a002-20210809
i386                 randconfig-a001-20210809
i386                 randconfig-a003-20210809
i386                 randconfig-a004-20210808
i386                 randconfig-a005-20210808
i386                 randconfig-a006-20210808
i386                 randconfig-a002-20210808
i386                 randconfig-a001-20210808
i386                 randconfig-a003-20210808
x86_64               randconfig-a016-20210808
x86_64               randconfig-a012-20210808
x86_64               randconfig-a013-20210808
x86_64               randconfig-a011-20210808
x86_64               randconfig-a014-20210808
x86_64               randconfig-a015-20210808
i386                 randconfig-a012-20210808
i386                 randconfig-a015-20210808
i386                 randconfig-a011-20210808
i386                 randconfig-a013-20210808
i386                 randconfig-a014-20210808
i386                 randconfig-a016-20210808
x86_64               randconfig-a002-20210809
x86_64               randconfig-a004-20210809
x86_64               randconfig-a006-20210809
x86_64               randconfig-a003-20210809
x86_64               randconfig-a001-20210809
x86_64               randconfig-a005-20210809
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210809
x86_64               randconfig-c001-20210810
x86_64               randconfig-a002-20210808
x86_64               randconfig-a004-20210808
x86_64               randconfig-a006-20210808
x86_64               randconfig-a003-20210808
x86_64               randconfig-a001-20210808
x86_64               randconfig-a005-20210808
x86_64               randconfig-a016-20210809
x86_64               randconfig-a012-20210809
x86_64               randconfig-a013-20210809
x86_64               randconfig-a011-20210809
x86_64               randconfig-a014-20210809
x86_64               randconfig-a015-20210809

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
