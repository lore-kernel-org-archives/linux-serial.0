Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C8AC433E0
	for <linux-serial@archiver.kernel.org>; Tue, 29 Dec 2020 03:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EE78207C5
	for <linux-serial@archiver.kernel.org>; Tue, 29 Dec 2020 03:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgL2DQ5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Dec 2020 22:16:57 -0500
Received: from mga03.intel.com ([134.134.136.65]:20740 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgL2DQ4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Dec 2020 22:16:56 -0500
IronPort-SDR: unCTaq/b3GlFbziJiZj+k+eQD3qcrQbXYcFBbz08VD5Fv8Kt4WisAPI6if7nT5xN7gFLOCfcr0
 k2wgq2q8Q+Xw==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="176548250"
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="176548250"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 19:16:15 -0800
IronPort-SDR: 1Uy1N5Zc4+ql05MoAmfOwu+UkoyH5EbuJGIwaxRxH/px42/OX8aOZNl7iIdhs2B0LbDauzr6k6
 OuBoq4xx74Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="400148516"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Dec 2020 19:16:14 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ku5Ub-0003IA-G7; Tue, 29 Dec 2020 03:16:13 +0000
Date:   Tue, 29 Dec 2020 11:15:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 01493ccb4436aadcaf8f33cd5d524a5d68f22836
Message-ID: <5fea9f54.dCz9QTQZRbJAmEUY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: 01493ccb4436aadcaf8f33cd5d524a5d68f22836  tty: serial: icom: Use DEFINE_SPINLOCK() for spinlock

elapsed time: 721m

configs tested: 147
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                    nommu_k210_defconfig
powerpc                     rainier_defconfig
powerpc                        warp_defconfig
ia64                            zx1_defconfig
arm                            mps2_defconfig
powerpc                     tqm8541_defconfig
sh                           se7722_defconfig
sh                 kfr2r09-romimage_defconfig
sh                         ap325rxa_defconfig
arm                       imx_v6_v7_defconfig
powerpc                     powernv_defconfig
arm                     am200epdkit_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
sh                           se7705_defconfig
sh                      rts7751r2d1_defconfig
arm                         axm55xx_defconfig
arm                         socfpga_defconfig
sparc                               defconfig
mips                        workpad_defconfig
nios2                            alldefconfig
um                           x86_64_defconfig
sh                           se7724_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                         tb0226_defconfig
h8300                       h8s-sim_defconfig
sh                               j2_defconfig
csky                                defconfig
sparc                       sparc32_defconfig
powerpc                      pmac32_defconfig
arm                         at91_dt_defconfig
sh                           se7751_defconfig
arm                      footbridge_defconfig
sh                     magicpanelr2_defconfig
powerpc                    adder875_defconfig
arm                           tegra_defconfig
mips                            gpr_defconfig
arm                           sunxi_defconfig
sh                          kfr2r09_defconfig
powerpc                    socrates_defconfig
sh                     sh7710voipgw_defconfig
powerpc                     mpc5200_defconfig
mips                           xway_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                            e55_defconfig
arm                           h5000_defconfig
sh                        dreamcast_defconfig
powerpc                      makalu_defconfig
powerpc                       ebony_defconfig
mips                        jmr3927_defconfig
arm                   milbeaut_m10v_defconfig
mips                           ci20_defconfig
powerpc                     kilauea_defconfig
mips                malta_kvm_guest_defconfig
arc                     haps_hs_smp_defconfig
mips                      fuloong2e_defconfig
mips                  maltasmvp_eva_defconfig
arm                      jornada720_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20201228
i386                 randconfig-a002-20201228
i386                 randconfig-a004-20201228
i386                 randconfig-a006-20201228
i386                 randconfig-a003-20201228
i386                 randconfig-a001-20201228
i386                 randconfig-a002-20201227
i386                 randconfig-a005-20201227
i386                 randconfig-a006-20201227
i386                 randconfig-a004-20201227
i386                 randconfig-a003-20201227
i386                 randconfig-a001-20201227
x86_64               randconfig-a014-20201228
x86_64               randconfig-a015-20201228
x86_64               randconfig-a016-20201228
x86_64               randconfig-a012-20201228
x86_64               randconfig-a011-20201228
x86_64               randconfig-a013-20201228
i386                 randconfig-a011-20201227
i386                 randconfig-a016-20201227
i386                 randconfig-a012-20201227
i386                 randconfig-a014-20201227
i386                 randconfig-a015-20201227
i386                 randconfig-a013-20201227
i386                 randconfig-a014-20201228
i386                 randconfig-a012-20201228
i386                 randconfig-a016-20201228
i386                 randconfig-a011-20201228
i386                 randconfig-a015-20201228
i386                 randconfig-a013-20201228
x86_64               randconfig-a001-20201227
x86_64               randconfig-a006-20201227
x86_64               randconfig-a004-20201227
x86_64               randconfig-a002-20201227
x86_64               randconfig-a003-20201227
x86_64               randconfig-a005-20201227
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20201228
x86_64               randconfig-a006-20201228
x86_64               randconfig-a002-20201228
x86_64               randconfig-a004-20201228
x86_64               randconfig-a003-20201228
x86_64               randconfig-a005-20201228

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
