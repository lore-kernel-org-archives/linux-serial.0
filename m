Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB581C4338F
	for <linux-serial@archiver.kernel.org>; Thu, 19 Aug 2021 13:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED746109F
	for <linux-serial@archiver.kernel.org>; Thu, 19 Aug 2021 13:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbhHSNfJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Aug 2021 09:35:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:48202 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240010AbhHSNfI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Aug 2021 09:35:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="280288328"
X-IronPort-AV: E=Sophos;i="5.84,334,1620716400"; 
   d="scan'208";a="280288328"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 06:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,334,1620716400"; 
   d="scan'208";a="681776427"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Aug 2021 06:34:30 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mGiBi-000TzO-3K; Thu, 19 Aug 2021 13:34:30 +0000
Date:   Thu, 19 Aug 2021 21:33:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 88c1d2478ec8a420cf60a3c25503e37b34fea5aa
Message-ID: <611e5dbb.JfRXJx9EykV5sDG1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 88c1d2478ec8a420cf60a3c25503e37b34fea5aa  tty: serial: fsl_lpuart: check dma_tx_in_progress in tx dma callback

elapsed time: 1397m

configs tested: 160
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
i386                 randconfig-c001-20210818
powerpc                      ep88xc_defconfig
arm                         at91_dt_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                     loongson1c_defconfig
arm                        mvebu_v5_defconfig
mips                           ip27_defconfig
arm                         bcm2835_defconfig
m68k                        m5307c3_defconfig
arm                         mv78xx0_defconfig
sh                     magicpanelr2_defconfig
alpha                            alldefconfig
sh                     sh7710voipgw_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                             shx3_defconfig
um                                  defconfig
powerpc                 mpc834x_mds_defconfig
arm                       aspeed_g4_defconfig
nios2                         10m50_defconfig
m68k                       m5249evb_defconfig
m68k                       bvme6000_defconfig
microblaze                          defconfig
sh                          r7780mp_defconfig
x86_64                           alldefconfig
mips                        jmr3927_defconfig
powerpc                      acadia_defconfig
mips                   sb1250_swarm_defconfig
arm                  colibri_pxa300_defconfig
sh                   sh7724_generic_defconfig
sparc                            alldefconfig
x86_64                           allyesconfig
mips                          rm200_defconfig
sh                   sh7770_generic_defconfig
arm                          iop32x_defconfig
powerpc                        icon_defconfig
m68k                            mac_defconfig
powerpc                   currituck_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          lpd270_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                       imx_v4_v5_defconfig
mips                      pic32mzda_defconfig
sh                        apsh4ad0a_defconfig
xtensa                          iss_defconfig
sh                           se7780_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     mpc83xx_defconfig
ia64                      gensparse_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210818
x86_64               randconfig-a006-20210818
x86_64               randconfig-a003-20210818
x86_64               randconfig-a005-20210818
x86_64               randconfig-a002-20210818
x86_64               randconfig-a001-20210818
x86_64               randconfig-a006-20210816
x86_64               randconfig-a004-20210816
x86_64               randconfig-a003-20210816
x86_64               randconfig-a001-20210816
x86_64               randconfig-a005-20210816
x86_64               randconfig-a002-20210816
i386                 randconfig-a004-20210818
i386                 randconfig-a006-20210818
i386                 randconfig-a002-20210818
i386                 randconfig-a001-20210818
i386                 randconfig-a003-20210818
i386                 randconfig-a005-20210818
x86_64               randconfig-a013-20210819
x86_64               randconfig-a011-20210819
x86_64               randconfig-a012-20210819
x86_64               randconfig-a016-20210819
x86_64               randconfig-a014-20210819
x86_64               randconfig-a015-20210819
i386                 randconfig-a015-20210819
i386                 randconfig-a011-20210819
i386                 randconfig-a014-20210819
i386                 randconfig-a013-20210819
i386                 randconfig-a016-20210819
i386                 randconfig-a012-20210819
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
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20210818
x86_64               randconfig-a004-20210819
x86_64               randconfig-a006-20210819
x86_64               randconfig-a003-20210819
x86_64               randconfig-a002-20210819
x86_64               randconfig-a005-20210819
x86_64               randconfig-a001-20210819
i386                 randconfig-a004-20210817
i386                 randconfig-a003-20210817
i386                 randconfig-a001-20210817
i386                 randconfig-a002-20210817
i386                 randconfig-a006-20210817
i386                 randconfig-a005-20210817
i386                 randconfig-a004-20210819
i386                 randconfig-a006-20210819
i386                 randconfig-a001-20210819
i386                 randconfig-a002-20210819
i386                 randconfig-a003-20210819
i386                 randconfig-a005-20210819
x86_64               randconfig-a013-20210818
x86_64               randconfig-a011-20210818
x86_64               randconfig-a012-20210818
x86_64               randconfig-a016-20210818
x86_64               randconfig-a014-20210818
x86_64               randconfig-a015-20210818
i386                 randconfig-a015-20210818
i386                 randconfig-a011-20210818
i386                 randconfig-a013-20210818
i386                 randconfig-a014-20210818
i386                 randconfig-a016-20210818
i386                 randconfig-a012-20210818

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
