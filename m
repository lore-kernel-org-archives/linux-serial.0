Return-Path: <SRS0=d41N=DK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE3AC4363D
	for <linux-serial@archiver.kernel.org>; Sat,  3 Oct 2020 05:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C70206F8
	for <linux-serial@archiver.kernel.org>; Sat,  3 Oct 2020 05:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725616AbgJCFRD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 3 Oct 2020 01:17:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:14340 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgJCFRD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 3 Oct 2020 01:17:03 -0400
IronPort-SDR: oZ7hbWoqctFl3PEZ0sNAs8NogRhd3i8A0YDjrhjvEwxXnMlCSj+oZGuKC2CX3j0K76HfV5Ee7m
 u+wNnYoyMl1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="160542932"
X-IronPort-AV: E=Sophos;i="5.77,330,1596524400"; 
   d="scan'208";a="160542932"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 22:16:58 -0700
IronPort-SDR: hY69JqhItw6ytwlj780aQeT6dFuNE2nF3F6rKULy1iy2CKsOxtDfIdTV2eguSbQJLadLnINOuw
 nX2XDD4a2mhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,330,1596524400"; 
   d="scan'208";a="351805101"
Received: from lkp-server02.sh.intel.com (HELO 404f47266ee4) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Oct 2020 22:16:56 -0700
Received: from kbuild by 404f47266ee4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kOZui-0000GQ-9W; Sat, 03 Oct 2020 05:16:56 +0000
Date:   Sat, 03 Oct 2020 13:16:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 bfeb28539d1f61829232883ced0986569218c4de
Message-ID: <5f78091f.jnasRRJtelnmLXEo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: bfeb28539d1f61829232883ced0986569218c4de  fbcon: remove no-op fbcon_set_origin()

elapsed time: 724m

configs tested: 153
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                          moxart_defconfig
mips                           ip32_defconfig
arm                       spear13xx_defconfig
arm                       imx_v4_v5_defconfig
powerpc                    klondike_defconfig
mips                          malta_defconfig
arc                        nsim_700_defconfig
arm                          badge4_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      ppc6xx_defconfig
arm                         s3c2410_defconfig
arm                           viper_defconfig
arm                         lpc18xx_defconfig
powerpc                      ep88xc_defconfig
powerpc                      ppc64e_defconfig
arm                   milbeaut_m10v_defconfig
arm                          ep93xx_defconfig
arm                         palmz72_defconfig
m68k                       m5475evb_defconfig
sh                   secureedge5410_defconfig
arm                           tegra_defconfig
sh                           se7619_defconfig
mips                       lemote2f_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc8540_ads_defconfig
mips                     decstation_defconfig
arm64                            alldefconfig
arm                         lpc32xx_defconfig
arm                         assabet_defconfig
arm                            zeus_defconfig
powerpc                     tqm8555_defconfig
sh                           se7343_defconfig
powerpc                        cell_defconfig
m68k                        stmark2_defconfig
arm                         axm55xx_defconfig
powerpc                     tqm5200_defconfig
mips                     loongson1b_defconfig
sh                          sdk7786_defconfig
arm                     am200epdkit_defconfig
arm                            lart_defconfig
mips                           jazz_defconfig
c6x                         dsk6455_defconfig
arm                        mini2440_defconfig
c6x                        evmc6474_defconfig
arm                          imote2_defconfig
sh                           se7750_defconfig
powerpc                      mgcoge_defconfig
powerpc                       ebony_defconfig
mips                        nlm_xlp_defconfig
arm                            xcep_defconfig
ia64                            zx1_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                       omap2plus_defconfig
sh                          rsk7264_defconfig
mips                        bcm47xx_defconfig
powerpc                 canyonlands_defconfig
arm                        multi_v7_defconfig
arm                         ebsa110_defconfig
m68k                        m5272c3_defconfig
um                            kunit_defconfig
arc                        nsimosci_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                       maple_defconfig
powerpc                         wii_defconfig
powerpc                     tqm8541_defconfig
m68k                             alldefconfig
powerpc                 mpc832x_mds_defconfig
arm                            mmp2_defconfig
mips                            gpr_defconfig
powerpc                      ppc44x_defconfig
mips                  cavium_octeon_defconfig
s390                          debug_defconfig
sh                           se7751_defconfig
arm                        mvebu_v7_defconfig
arm                        vexpress_defconfig
mips                            ar7_defconfig
arm                            dove_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     mpc512x_defconfig
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
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201002
x86_64               randconfig-a001-20201002
x86_64               randconfig-a002-20201002
x86_64               randconfig-a005-20201002
x86_64               randconfig-a003-20201002
x86_64               randconfig-a006-20201002
i386                 randconfig-a006-20201002
i386                 randconfig-a005-20201002
i386                 randconfig-a001-20201002
i386                 randconfig-a004-20201002
i386                 randconfig-a003-20201002
i386                 randconfig-a002-20201002
i386                 randconfig-a014-20201002
i386                 randconfig-a013-20201002
i386                 randconfig-a015-20201002
i386                 randconfig-a016-20201002
i386                 randconfig-a011-20201002
i386                 randconfig-a012-20201002
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20201002
x86_64               randconfig-a015-20201002
x86_64               randconfig-a014-20201002
x86_64               randconfig-a013-20201002
x86_64               randconfig-a011-20201002
x86_64               randconfig-a016-20201002

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
