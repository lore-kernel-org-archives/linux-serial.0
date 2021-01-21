Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7D1C433E0
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 06:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7EB238D6
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 06:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbhAUGDm (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Jan 2021 01:03:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:36135 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbhAUGCZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Jan 2021 01:02:25 -0500
IronPort-SDR: KP9Dq+2yExvEwWGzVaIYyOsGXC4HSV2Nv8ZB2EoEXup30SRqyW0/tBB0lyCQau6YHAA9M96c0C
 9M+xoxrNK2Ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="166320371"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="166320371"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 22:01:43 -0800
IronPort-SDR: MGGDMO8X8f+5L04bztv3DZtpep4AzGUPdh8QVWTeMMRFYsyYEJCZJaoKAyel+3bfuDN8xZdRol
 RHYVFmnxly3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="570622431"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Jan 2021 22:01:42 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l2T2L-0006KR-IM; Thu, 21 Jan 2021 06:01:41 +0000
Date:   Thu, 21 Jan 2021 14:01:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 4776a4a0a29c64b954a445ff65848bd376a50fcc
Message-ID: <600918b5.2Bzxkq31ElwH71nE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 4776a4a0a29c64b954a445ff65848bd376a50fcc  serial: remove sirf prima/atlas driver

elapsed time: 727m

configs tested: 196
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
alpha                            alldefconfig
arm                           stm32_defconfig
sparc64                             defconfig
arm                   milbeaut_m10v_defconfig
powerpc                     kilauea_defconfig
sh                     magicpanelr2_defconfig
arc                          axs101_defconfig
sh                   sh7770_generic_defconfig
c6x                              alldefconfig
s390                          debug_defconfig
mips                     cu1830-neo_defconfig
arm                          moxart_defconfig
xtensa                    smp_lx200_defconfig
mips                          malta_defconfig
powerpc                     stx_gp3_defconfig
arm                             pxa_defconfig
mips                        maltaup_defconfig
powerpc                  storcenter_defconfig
powerpc                 mpc836x_mds_defconfig
arm                              alldefconfig
powerpc                         ps3_defconfig
arm                         hackkit_defconfig
powerpc64                           defconfig
m68k                          sun3x_defconfig
ia64                      gensparse_defconfig
sh                            titan_defconfig
arm                        mini2440_defconfig
mips                        nlm_xlr_defconfig
powerpc                 mpc834x_mds_defconfig
xtensa                  cadence_csp_defconfig
arm                         cm_x300_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     mpc83xx_defconfig
mips                  decstation_64_defconfig
mips                        vocore2_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                    amigaone_defconfig
openrisc                            defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      pcm030_defconfig
powerpc                     redwood_defconfig
mips                      pic32mzda_defconfig
ia64                          tiger_defconfig
openrisc                 simple_smp_defconfig
arm                          pcm027_defconfig
arc                        nsim_700_defconfig
m68k                           sun3_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                       lemote2f_defconfig
mips                   sb1250_swarm_defconfig
sh                           se7724_defconfig
mips                     decstation_defconfig
mips                         bigsur_defconfig
xtensa                              defconfig
powerpc                    klondike_defconfig
powerpc                     rainier_defconfig
powerpc                 mpc834x_itx_defconfig
mips                            ar7_defconfig
ia64                        generic_defconfig
mips                        jmr3927_defconfig
riscv                             allnoconfig
xtensa                         virt_defconfig
i386                             alldefconfig
arm                           sunxi_defconfig
arc                     haps_hs_smp_defconfig
sh                        edosk7760_defconfig
sparc64                          alldefconfig
arm                             ezx_defconfig
arm                         nhk8815_defconfig
h8300                       h8s-sim_defconfig
sh                           se7712_defconfig
powerpc                      ppc6xx_defconfig
mips                           ip22_defconfig
openrisc                    or1ksim_defconfig
m68k                         apollo_defconfig
arm                     am200epdkit_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                       spear13xx_defconfig
xtensa                generic_kc705_defconfig
m68k                             alldefconfig
arm                           spitz_defconfig
arm                         axm55xx_defconfig
arm                           h3600_defconfig
c6x                                 defconfig
xtensa                       common_defconfig
m68k                          multi_defconfig
arm                         bcm2835_defconfig
sh                          sdk7786_defconfig
sparc                       sparc32_defconfig
mips                        nlm_xlp_defconfig
sparc                            alldefconfig
powerpc                        cell_defconfig
csky                             alldefconfig
arm                         mv78xx0_defconfig
mips                           ip32_defconfig
mips                      maltasmvp_defconfig
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
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210119
i386                 randconfig-a005-20210119
i386                 randconfig-a006-20210119
i386                 randconfig-a001-20210119
i386                 randconfig-a003-20210119
i386                 randconfig-a004-20210119
i386                 randconfig-a001-20210120
i386                 randconfig-a002-20210120
i386                 randconfig-a004-20210120
i386                 randconfig-a005-20210120
i386                 randconfig-a003-20210120
i386                 randconfig-a006-20210120
i386                 randconfig-a001-20210121
i386                 randconfig-a002-20210121
i386                 randconfig-a004-20210121
i386                 randconfig-a006-20210121
i386                 randconfig-a005-20210121
i386                 randconfig-a003-20210121
x86_64               randconfig-a012-20210120
x86_64               randconfig-a015-20210120
x86_64               randconfig-a016-20210120
x86_64               randconfig-a011-20210120
x86_64               randconfig-a013-20210120
x86_64               randconfig-a014-20210120
x86_64               randconfig-a002-20210121
x86_64               randconfig-a003-20210121
x86_64               randconfig-a001-20210121
x86_64               randconfig-a005-20210121
x86_64               randconfig-a006-20210121
x86_64               randconfig-a004-20210121
i386                 randconfig-a013-20210120
i386                 randconfig-a011-20210120
i386                 randconfig-a012-20210120
i386                 randconfig-a014-20210120
i386                 randconfig-a015-20210120
i386                 randconfig-a016-20210120
i386                 randconfig-a013-20210121
i386                 randconfig-a011-20210121
i386                 randconfig-a012-20210121
i386                 randconfig-a014-20210121
i386                 randconfig-a015-20210121
i386                 randconfig-a016-20210121
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210120
x86_64               randconfig-a003-20210120
x86_64               randconfig-a001-20210120
x86_64               randconfig-a005-20210120
x86_64               randconfig-a006-20210120
x86_64               randconfig-a004-20210120

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
