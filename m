Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D986C5519F
	for <linux-serial@archiver.kernel.org>; Thu, 19 Nov 2020 00:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EAA6246E7
	for <linux-serial@archiver.kernel.org>; Thu, 19 Nov 2020 00:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgKSAfp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Nov 2020 19:35:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:13520 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgKSAfp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Nov 2020 19:35:45 -0500
IronPort-SDR: nZ56PBN+5qZGIH9S8VjazBMKgXaPMt8ZO9DdC86LR6JQgsgoxHr/iwu2Mksk5Zkz8tRl4v0sxX
 IaKvdYZmHDaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="171378660"
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="171378660"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 16:35:45 -0800
IronPort-SDR: F79+Eh8IxjE198TrwrEbBB90G1N7Lbe27lrB2dBNaiKOq65WW/uXDabqzxqv1Pq7G8F7TV2e/Y
 b/l4oRPvds4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="532956465"
Received: from lkp-server01.sh.intel.com (HELO cf7a658f8e69) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 18 Nov 2020 16:35:43 -0800
Received: from kbuild by cf7a658f8e69 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kfXvK-00000o-Ft; Thu, 19 Nov 2020 00:35:42 +0000
Date:   Thu, 19 Nov 2020 08:35:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 660beb0ffdc9fc0695321dde5e115cd8cc384c94
Message-ID: <5fb5bdd5.as/2VQcGR9CWplqx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: 660beb0ffdc9fc0695321dde5e115cd8cc384c94  serial: imx: Remove unused .id_table support

elapsed time: 727m

configs tested: 147
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
sh                          rsk7269_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                        edosk7760_defconfig
sh                         microdev_defconfig
sh                            shmin_defconfig
sh                            migor_defconfig
sh                         ap325rxa_defconfig
mips                  maltasmvp_eva_defconfig
mips                      pic32mzda_defconfig
powerpc                      bamboo_defconfig
powerpc                     tqm8560_defconfig
m68k                          sun3x_defconfig
arc                        nsim_700_defconfig
mips                      loongson3_defconfig
arm                           sunxi_defconfig
nios2                            alldefconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     taishan_defconfig
powerpc                     skiroot_defconfig
powerpc                    adder875_defconfig
sh                ecovec24-romimage_defconfig
m68k                            mac_defconfig
sh                           sh2007_defconfig
sh                          polaris_defconfig
arm                       aspeed_g5_defconfig
arm                           stm32_defconfig
powerpc                     sbc8548_defconfig
arm                   milbeaut_m10v_defconfig
sh                   sh7724_generic_defconfig
arm                         s3c6400_defconfig
m68k                        mvme16x_defconfig
mips                        omega2p_defconfig
mips                    maltaup_xpa_defconfig
mips                       bmips_be_defconfig
mips                  cavium_octeon_defconfig
ia64                        generic_defconfig
mips                        nlm_xlr_defconfig
powerpc                     tqm8540_defconfig
mips                        bcm63xx_defconfig
sh                          urquell_defconfig
powerpc                      obs600_defconfig
arm                             mxs_defconfig
sh                   sh7770_generic_defconfig
arm                         socfpga_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                               j2_defconfig
arm                          exynos_defconfig
xtensa                  cadence_csp_defconfig
mips                         rt305x_defconfig
sh                               alldefconfig
arm                      tct_hammer_defconfig
sh                             sh03_defconfig
nios2                         10m50_defconfig
um                           x86_64_defconfig
arm                       netwinder_defconfig
arm                         s3c2410_defconfig
arc                                 defconfig
riscv                    nommu_virt_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                           ip32_defconfig
arm                       spear13xx_defconfig
sh                           se7705_defconfig
arm                         cm_x300_defconfig
sh                          r7780mp_defconfig
arc                              alldefconfig
powerpc                     mpc83xx_defconfig
mips                         tb0219_defconfig
microblaze                          defconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
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
x86_64               randconfig-a005-20201118
x86_64               randconfig-a003-20201118
x86_64               randconfig-a004-20201118
x86_64               randconfig-a002-20201118
x86_64               randconfig-a006-20201118
x86_64               randconfig-a001-20201118
i386                 randconfig-a006-20201118
i386                 randconfig-a005-20201118
i386                 randconfig-a002-20201118
i386                 randconfig-a001-20201118
i386                 randconfig-a003-20201118
i386                 randconfig-a004-20201118
i386                 randconfig-a006-20201119
i386                 randconfig-a005-20201119
i386                 randconfig-a002-20201119
i386                 randconfig-a001-20201119
i386                 randconfig-a003-20201119
i386                 randconfig-a004-20201119
i386                 randconfig-a012-20201118
i386                 randconfig-a014-20201118
i386                 randconfig-a016-20201118
i386                 randconfig-a011-20201118
i386                 randconfig-a013-20201118
i386                 randconfig-a015-20201118
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a015-20201118
x86_64               randconfig-a014-20201118
x86_64               randconfig-a011-20201118
x86_64               randconfig-a013-20201118
x86_64               randconfig-a016-20201118
x86_64               randconfig-a012-20201118

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
