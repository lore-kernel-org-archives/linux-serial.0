Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D34C433F5
	for <linux-serial@archiver.kernel.org>; Sat, 26 Feb 2022 22:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiBZWmr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 26 Feb 2022 17:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiBZWmr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 26 Feb 2022 17:42:47 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E152BB582
        for <linux-serial@vger.kernel.org>; Sat, 26 Feb 2022 14:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645915331; x=1677451331;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=YZwo3J8oobGtYJ1E1uLeyD/jEWhlRabwA/rn1bk/6qo=;
  b=bQKGNwEYxdyjZmA1rQ2WluCMrG5kulcw5C7j0GBOahmDs0GZsrOpWdfQ
   nvCsy6Th73DG3Nw1cuUlS5M8+PWnrSueT4n3MexRhb1ouxfQT0LDZJlZA
   r6dojmwoeXZ7xYp53ZqlUEcCU1IoJNA/ZvERDPQDA0JiJLwSuIIeEhG7F
   kRFOB+xzk+ASuvRL2ZDYU7JSShkePeXjRpgevLAJna7MoVfWW+LCaYPqJ
   B7lh57sc2hEIYaRJgOD6IGHQl8AUcHou+dmjIPB0T4v5/XsH+ScMoC1j3
   D3OShvgd+eWAOZVbiEKu171P0NGZTsrVFIpT0WlkNRfrdAq5arUN3kanh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="236193300"
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="236193300"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 14:42:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="492316404"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Feb 2022 14:42:10 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nO5lR-00060j-Io; Sat, 26 Feb 2022 22:42:09 +0000
Date:   Sun, 27 Feb 2022 06:41:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-next] BUILD REGRESSION
 c2faf737abfb10f88f2d2612d573e9edc3c42c37
Message-ID: <621aacb2.Ib317c39ErQ2w3PK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
branch HEAD: c2faf737abfb10f88f2d2612d573e9edc3c42c37  tty: Reserve ldisc 29 for development purposes

Error/Warning in current branch:

drivers/tty/serial/sunplus-uart.c:574:28: error: 'sunplus_uart_console' undeclared here (not in a function); did you mean 'sunplus_uart_ops'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-randconfig-c003-20220226
|   `-- drivers-tty-serial-sunplus-uart.c:error:sunplus_uart_console-undeclared-here-(not-in-a-function)
`-- mips-randconfig-c023-20220227
    `-- drivers-tty-serial-sunplus-uart.c:error:sunplus_uart_console-undeclared-here-(not-in-a-function)

elapsed time: 722m

configs tested: 164
configs skipped: 4

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
s390                          debug_defconfig
arm                        shmobile_defconfig
sh                         microdev_defconfig
alpha                            alldefconfig
powerpc64                           defconfig
arm                       aspeed_g5_defconfig
sh                          kfr2r09_defconfig
sparc                       sparc64_defconfig
ia64                         bigsur_defconfig
mips                      loongson3_defconfig
xtensa                         virt_defconfig
arm                        multi_v7_defconfig
m68k                         apollo_defconfig
powerpc                 linkstation_defconfig
parisc                           allyesconfig
arm                          lpd270_defconfig
s390                       zfcpdump_defconfig
sh                          landisk_defconfig
powerpc                      pcm030_defconfig
arc                      axs103_smp_defconfig
csky                                defconfig
powerpc                        warp_defconfig
m68k                        mvme147_defconfig
microblaze                      mmu_defconfig
arm                         lpc18xx_defconfig
powerpc                      mgcoge_defconfig
sh                         ecovec24_defconfig
mips                         db1xxx_defconfig
powerpc                    klondike_defconfig
mips                             allyesconfig
m68k                        m5272c3_defconfig
powerpc                      tqm8xx_defconfig
mips                        vocore2_defconfig
arm                        trizeps4_defconfig
i386                             alldefconfig
powerpc                         wii_defconfig
arm                          pxa910_defconfig
arm                           sunxi_defconfig
arm                           corgi_defconfig
m68k                       m5275evb_defconfig
mips                 decstation_r4k_defconfig
powerpc                       maple_defconfig
powerpc                     ep8248e_defconfig
arm                           tegra_defconfig
sh                          lboxre2_defconfig
m68k                        m5407c3_defconfig
mips                        bcm47xx_defconfig
xtensa                       common_defconfig
mips                  decstation_64_defconfig
sh                          polaris_defconfig
arc                         haps_hs_defconfig
powerpc                       ppc64_defconfig
sh                          urquell_defconfig
powerpc                     pq2fads_defconfig
xtensa                    smp_lx200_defconfig
arm                          gemini_defconfig
mips                    maltaup_xpa_defconfig
mips                         rt305x_defconfig
powerpc                   motionpro_defconfig
arm                           viper_defconfig
sh                        sh7757lcr_defconfig
m68k                          multi_defconfig
m68k                       m5249evb_defconfig
mips                     decstation_defconfig
mips                         tb0226_defconfig
um                               alldefconfig
arm                      integrator_defconfig
m68k                       m5208evb_defconfig
arm                  randconfig-c002-20220225
arm                  randconfig-c002-20220226
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
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
parisc64                            defconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
s390                 randconfig-r044-20220226
arc                  randconfig-r043-20220226
riscv                randconfig-r042-20220226
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc              randconfig-c003-20220225
x86_64                        randconfig-c007
arm                  randconfig-c002-20220225
mips                 randconfig-c004-20220225
i386                          randconfig-c001
riscv                randconfig-c006-20220225
mips                           mtx1_defconfig
powerpc                     ppa8548_defconfig
arm                       mainstone_defconfig
powerpc                   lite5200b_defconfig
riscv                    nommu_virt_defconfig
powerpc                  mpc885_ads_defconfig
arm                       imx_v4_v5_defconfig
mips                      pic32mzda_defconfig
mips                            e55_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220226
hexagon              randconfig-r045-20220225
hexagon              randconfig-r041-20220226
hexagon              randconfig-r041-20220225
riscv                randconfig-r042-20220225
hexagon              randconfig-r045-20220227
hexagon              randconfig-r041-20220227
riscv                randconfig-r042-20220227

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
