Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E514C433ED
	for <linux-serial@archiver.kernel.org>; Thu,  8 Apr 2021 03:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EDBF61184
	for <linux-serial@archiver.kernel.org>; Thu,  8 Apr 2021 03:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhDHDfz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Apr 2021 23:35:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:37655 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhDHDfz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Apr 2021 23:35:55 -0400
IronPort-SDR: sHQUIKWsrF/7kcwAa6SjsH9mzpLKCJ+cBABVz5JJ7vuDVSdcSoH8w88AcY/pQm22jkoFsTAYle
 vN/wVnKWi0dg==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="190243433"
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="190243433"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 20:35:45 -0700
IronPort-SDR: GeWg6/3xDy0lMmahkP8c6GA+5CinAb7FubVhBkjHjY14KsUx7av1QiI+YqW668UHU/0Bot/QLe
 /raZCPfvRsfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="380083486"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Apr 2021 20:35:43 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lULSI-000EDB-R1; Thu, 08 Apr 2021 03:35:42 +0000
Date:   Thu, 08 Apr 2021 11:34:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 88d8cb7b5f2177dfec9f12377762534dd7c64005
Message-ID: <606e79de.AxFHKca7zkhCh4/0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 88d8cb7b5f2177dfec9f12377762534dd7c64005  tty: synclink_gt: drop redundant tty-port initialisation

elapsed time: 724m

configs tested: 171
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
x86_64                           allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
i386                             allyesconfig
arm                         hackkit_defconfig
arm                           u8500_defconfig
mips                       bmips_be_defconfig
arm                           h5000_defconfig
mips                      loongson3_defconfig
ia64                             allyesconfig
powerpc                    amigaone_defconfig
arc                      axs103_smp_defconfig
mips                             allyesconfig
mips                        bcm47xx_defconfig
arc                          axs101_defconfig
powerpc                      chrp32_defconfig
arm                        keystone_defconfig
alpha                            allyesconfig
sh                            shmin_defconfig
mips                           ci20_defconfig
xtensa                         virt_defconfig
arm                         lubbock_defconfig
powerpc                     tqm8555_defconfig
s390                             alldefconfig
sh                           se7619_defconfig
powerpc                 mpc836x_mds_defconfig
arm                        oxnas_v6_defconfig
powerpc                      ppc44x_defconfig
mips                           ip28_defconfig
arm                         lpc18xx_defconfig
sh                               alldefconfig
powerpc               mpc834x_itxgp_defconfig
sh                             espt_defconfig
m68k                         amcore_defconfig
powerpc                   currituck_defconfig
sh                            hp6xx_defconfig
arc                     nsimosci_hs_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         socfpga_defconfig
mips                      malta_kvm_defconfig
i386                                defconfig
arm                     eseries_pxa_defconfig
m68k                        m5407c3_defconfig
arm                           sama5_defconfig
xtensa                           alldefconfig
powerpc                     mpc5200_defconfig
arm                       omap2plus_defconfig
csky                                defconfig
arm                        mvebu_v7_defconfig
arm                        neponset_defconfig
m68k                        stmark2_defconfig
arm                        spear3xx_defconfig
arm                  colibri_pxa300_defconfig
arm                         axm55xx_defconfig
mips                  maltasmvp_eva_defconfig
arm                      footbridge_defconfig
arm                            zeus_defconfig
openrisc                  or1klitex_defconfig
arm                         at91_dt_defconfig
sh                   rts7751r2dplus_defconfig
sh                          kfr2r09_defconfig
arm                          iop32x_defconfig
mips                      fuloong2e_defconfig
arm                            pleb_defconfig
sh                        sh7757lcr_defconfig
powerpc                       maple_defconfig
arm                        shmobile_defconfig
mips                        maltaup_defconfig
riscv             nommu_k210_sdcard_defconfig
m68k                            q40_defconfig
sparc                       sparc32_defconfig
mips                        nlm_xlr_defconfig
sh                          rsk7201_defconfig
arm                         cm_x300_defconfig
sh                          urquell_defconfig
arm                         bcm2835_defconfig
alpha                            alldefconfig
m68k                        m5307c3_defconfig
arm                      tct_hammer_defconfig
mips                           gcw0_defconfig
m68k                       m5249evb_defconfig
sh                        sh7763rdp_defconfig
h8300                               defconfig
powerpc                         ps3_defconfig
x86_64                           alldefconfig
arm                            xcep_defconfig
arm                     davinci_all_defconfig
sh                      rts7751r2d1_defconfig
powerpc                      mgcoge_defconfig
powerpc                         wii_defconfig
powerpc                     stx_gp3_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     tqm8541_defconfig
mips                            ar7_defconfig
powerpc                        fsp2_defconfig
um                               allyesconfig
nios2                         3c120_defconfig
powerpc                      ppc40x_defconfig
sh                         ap325rxa_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      bamboo_defconfig
mips                      pistachio_defconfig
arm                        trizeps4_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210407
i386                 randconfig-a003-20210407
i386                 randconfig-a001-20210407
i386                 randconfig-a004-20210407
i386                 randconfig-a002-20210407
i386                 randconfig-a005-20210407
i386                 randconfig-a006-20210408
i386                 randconfig-a003-20210408
i386                 randconfig-a001-20210408
i386                 randconfig-a004-20210408
i386                 randconfig-a005-20210408
i386                 randconfig-a002-20210408
x86_64               randconfig-a014-20210407
x86_64               randconfig-a015-20210407
x86_64               randconfig-a013-20210407
x86_64               randconfig-a011-20210407
x86_64               randconfig-a012-20210407
x86_64               randconfig-a016-20210407
i386                 randconfig-a014-20210407
i386                 randconfig-a011-20210407
i386                 randconfig-a016-20210407
i386                 randconfig-a012-20210407
i386                 randconfig-a015-20210407
i386                 randconfig-a013-20210407
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
