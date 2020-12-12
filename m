Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EE6C433FE
	for <linux-serial@archiver.kernel.org>; Sat, 12 Dec 2020 04:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A60123158
	for <linux-serial@archiver.kernel.org>; Sat, 12 Dec 2020 04:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405371AbgLLEfx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Dec 2020 23:35:53 -0500
Received: from mga05.intel.com ([192.55.52.43]:16203 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389029AbgLLEfd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Dec 2020 23:35:33 -0500
IronPort-SDR: htOYHfM6pBiXmJH4djh7JJFipyaXDZfiaBx/1+MG973YevGF4qyzAI86HCBRtXjyMucvGMCftl
 46KXjbyEpXzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9832"; a="259248857"
X-IronPort-AV: E=Sophos;i="5.78,413,1599548400"; 
   d="scan'208";a="259248857"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 20:34:52 -0800
IronPort-SDR: Ts0MrZqjxCqoxqJkK7utQz/J8vELhdeT8HSGCYrh/oSiYpRF7uLieC1n/DUOz34RKovnJP6W+J
 pCMpMPLKTgxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,413,1599548400"; 
   d="scan'208";a="349908219"
Received: from lkp-server01.sh.intel.com (HELO ecc0cebe68d1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 11 Dec 2020 20:34:50 -0800
Received: from kbuild by ecc0cebe68d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1knwcM-0001E3-7a; Sat, 12 Dec 2020 04:34:50 +0000
Date:   Sat, 12 Dec 2020 12:34:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 c3ae3dc896fab5524f9b20f547e72e4b892d8d8e
Message-ID: <5fd44856.ZFLH0jba4uC/cyYS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: c3ae3dc896fab5524f9b20f547e72e4b892d8d8e  serial: 8250_pci: Drop bogus __refdata annotation

elapsed time: 726m

configs tested: 154
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 linkstation_defconfig
sh                         apsh4a3a_defconfig
arm                           omap1_defconfig
powerpc                     mpc512x_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
nios2                         3c120_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          r7785rp_defconfig
mips                             allmodconfig
powerpc                     tqm8548_defconfig
m68k                           sun3_defconfig
openrisc                            defconfig
arm                            pleb_defconfig
ia64                             allyesconfig
arm                          collie_defconfig
arm                           sunxi_defconfig
parisc                generic-32bit_defconfig
m68k                       m5275evb_defconfig
arm                          exynos_defconfig
sh                           se7343_defconfig
arm                      integrator_defconfig
arm                            qcom_defconfig
sh                          rsk7264_defconfig
mips                     cu1000-neo_defconfig
powerpc                        cell_defconfig
arm                      jornada720_defconfig
arm                       imx_v6_v7_defconfig
c6x                         dsk6455_defconfig
xtensa                    smp_lx200_defconfig
arm                            xcep_defconfig
arm                        multi_v5_defconfig
powerpc                     tqm8541_defconfig
sh                          landisk_defconfig
powerpc                       holly_defconfig
powerpc                 mpc832x_rdb_defconfig
parisc                              defconfig
arm                        mvebu_v7_defconfig
sh                             shx3_defconfig
arm                          gemini_defconfig
sh                          rsk7269_defconfig
sh                        apsh4ad0a_defconfig
m68k                        m5272c3_defconfig
mips                   sb1250_swarm_defconfig
arm                         socfpga_defconfig
arm                          moxart_defconfig
arm                         s3c6400_defconfig
arm                       aspeed_g4_defconfig
arc                         haps_hs_defconfig
powerpc                        warp_defconfig
nios2                         10m50_defconfig
parisc                generic-64bit_defconfig
arm                        mvebu_v5_defconfig
powerpc                      bamboo_defconfig
riscv                               defconfig
powerpc                     ppa8548_defconfig
sh                             sh03_defconfig
powerpc                      chrp32_defconfig
mips                           gcw0_defconfig
powerpc                   currituck_defconfig
mips                      loongson3_defconfig
m68k                       bvme6000_defconfig
parisc                           alldefconfig
powerpc                    klondike_defconfig
powerpc                 mpc8560_ads_defconfig
arm                         assabet_defconfig
nds32                               defconfig
ia64                                defconfig
powerpc                  mpc885_ads_defconfig
mips                           xway_defconfig
powerpc                      cm5200_defconfig
arm                      footbridge_defconfig
mips                      pistachio_defconfig
mips                      maltaaprp_defconfig
arm                        keystone_defconfig
ia64                            zx1_defconfig
m68k                          multi_defconfig
sh                          lboxre2_defconfig
xtensa                         virt_defconfig
xtensa                generic_kc705_defconfig
powerpc                          g5_defconfig
sparc                            allyesconfig
powerpc                      pasemi_defconfig
sh                           se7619_defconfig
arm                         mv78xx0_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          simpad_defconfig
xtensa                           allyesconfig
ia64                             allmodconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a004-20201209
i386                 randconfig-a005-20201209
i386                 randconfig-a001-20201209
i386                 randconfig-a002-20201209
i386                 randconfig-a006-20201209
i386                 randconfig-a003-20201209
x86_64               randconfig-a016-20201209
x86_64               randconfig-a012-20201209
x86_64               randconfig-a013-20201209
x86_64               randconfig-a014-20201209
x86_64               randconfig-a015-20201209
x86_64               randconfig-a011-20201209
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
