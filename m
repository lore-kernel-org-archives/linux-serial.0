Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD488C4320A
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 03:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 992EF60ED4
	for <linux-serial@archiver.kernel.org>; Fri, 30 Jul 2021 03:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhG3DOw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Jul 2021 23:14:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:15911 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229971AbhG3DOw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Jul 2021 23:14:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="298603590"
X-IronPort-AV: E=Sophos;i="5.84,280,1620716400"; 
   d="scan'208";a="298603590"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 20:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,280,1620716400"; 
   d="scan'208";a="438849388"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jul 2021 20:14:46 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m9Iyz-0009Ya-VD; Fri, 30 Jul 2021 03:14:45 +0000
Date:   Fri, 30 Jul 2021 11:14:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 6c44eb5905f6cc731b36c4170f703f81e477f039
Message-ID: <61036e9f.Zi/Tcld59eRg9p6h%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 6c44eb5905f6cc731b36c4170f703f81e477f039  serial: omap: Only allow if 8250_omap is not selected

elapsed time: 721m

configs tested: 126
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210728
powerpc                      pcm030_defconfig
arc                 nsimosci_hs_smp_defconfig
m68k                          amiga_defconfig
arm                        cerfcube_defconfig
mips                      pistachio_defconfig
arc                          axs103_defconfig
powerpc                      ep88xc_defconfig
arm                            lart_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                        fsp2_defconfig
arm                           h5000_defconfig
mips                           ci20_defconfig
powerpc                    sam440ep_defconfig
arm                       imx_v4_v5_defconfig
mips                        nlm_xlr_defconfig
powerpc                 mpc85xx_cds_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7724_defconfig
sh                            titan_defconfig
sh                           se7343_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                   sb1250_swarm_defconfig
sh                           se7206_defconfig
arm                           omap1_defconfig
arm                         lubbock_defconfig
powerpc                     skiroot_defconfig
sh                   rts7751r2dplus_defconfig
mips                      maltasmvp_defconfig
powerpc                     powernv_defconfig
powerpc                  storcenter_defconfig
arm                         s5pv210_defconfig
xtensa                       common_defconfig
arm                           sunxi_defconfig
m68k                       m5249evb_defconfig
powerpc                       holly_defconfig
sh                           se7780_defconfig
arm                         shannon_defconfig
sh                      rts7751r2d1_defconfig
powerpc                    amigaone_defconfig
sh                           se7751_defconfig
m68k                         amcore_defconfig
arm                           tegra_defconfig
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
x86_64               randconfig-a006-20210728
x86_64               randconfig-a003-20210728
x86_64               randconfig-a001-20210728
x86_64               randconfig-a004-20210728
x86_64               randconfig-a005-20210728
x86_64               randconfig-a002-20210728
i386                 randconfig-a005-20210728
i386                 randconfig-a003-20210728
i386                 randconfig-a004-20210728
i386                 randconfig-a002-20210728
i386                 randconfig-a001-20210728
i386                 randconfig-a006-20210728
x86_64               randconfig-a016-20210729
x86_64               randconfig-a011-20210729
x86_64               randconfig-a014-20210729
x86_64               randconfig-a013-20210729
x86_64               randconfig-a012-20210729
x86_64               randconfig-a015-20210729
i386                 randconfig-a016-20210728
i386                 randconfig-a012-20210728
i386                 randconfig-a013-20210728
i386                 randconfig-a014-20210728
i386                 randconfig-a011-20210728
i386                 randconfig-a015-20210728
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
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210729
x86_64               randconfig-a016-20210728
x86_64               randconfig-a011-20210728
x86_64               randconfig-a014-20210728
x86_64               randconfig-a013-20210728
x86_64               randconfig-a012-20210728
x86_64               randconfig-a015-20210728

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
