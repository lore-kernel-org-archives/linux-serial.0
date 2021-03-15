Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B9EC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 23:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A6BA64F5E
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 23:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhCOXbR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Mar 2021 19:31:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:57020 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229748AbhCOXaw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Mar 2021 19:30:52 -0400
IronPort-SDR: leLkPijjIh+3bcLLJZJicmgg04n7imDXMYlHYyj8kToB53y6v8uHkzVqwg8N+HagvC7lF+dIi6
 lMJZTZwPKhGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="168442401"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="168442401"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 16:30:52 -0700
IronPort-SDR: /CYV5Fn8blSdSkltPSXiQGNhhsoPv7W7iHht54ft1ScY4QMwYolV1GjCDk2vlalo5L2ikrI59X
 RqFuQe6nUsAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="511195611"
Received: from lkp-server02.sh.intel.com (HELO 1dc5e1a854f4) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2021 16:30:51 -0700
Received: from kbuild by 1dc5e1a854f4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lLwfi-0000hA-Ld; Mon, 15 Mar 2021 23:30:50 +0000
Date:   Tue, 16 Mar 2021 07:30:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 280def1e1c17d35b21206881937d4498bcc1f503
Message-ID: <604fee18.z2S0j+tByBBPDFBg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 280def1e1c17d35b21206881937d4498bcc1f503  Merge 5.12-rc3 into tty-next

elapsed time: 900m

configs tested: 158
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
mips                      malta_kvm_defconfig
arm                          exynos_defconfig
ia64                         bigsur_defconfig
arm                            dove_defconfig
sh                                  defconfig
sh                               alldefconfig
powerpc                     taishan_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                      loongson3_defconfig
nds32                            alldefconfig
arc                      axs103_smp_defconfig
arm                           u8500_defconfig
powerpc                      ppc6xx_defconfig
powerpc                mpc7448_hpc2_defconfig
m68k                          hp300_defconfig
mips                     cu1830-neo_defconfig
mips                        jmr3927_defconfig
arm                           h5000_defconfig
m68k                       m5208evb_defconfig
arm                           h3600_defconfig
arc                 nsimosci_hs_smp_defconfig
sparc                       sparc32_defconfig
mips                   sb1250_swarm_defconfig
arm                       mainstone_defconfig
nios2                            allyesconfig
arm                           omap1_defconfig
arm                           spitz_defconfig
arm                       omap2plus_defconfig
powerpc                    socrates_defconfig
powerpc                       ebony_defconfig
sparc                       sparc64_defconfig
arm                         vf610m4_defconfig
m68k                        m5272c3_defconfig
mips                           xway_defconfig
arc                    vdk_hs38_smp_defconfig
sparc64                          alldefconfig
alpha                               defconfig
sh                           se7780_defconfig
sh                          urquell_defconfig
xtensa                           alldefconfig
sh                        sh7757lcr_defconfig
s390                                defconfig
sh                           se7206_defconfig
mips                         mpc30x_defconfig
mips                  decstation_64_defconfig
sh                            migor_defconfig
microblaze                      mmu_defconfig
xtensa                  cadence_csp_defconfig
mips                            ar7_defconfig
arc                        nsim_700_defconfig
sh                             shx3_defconfig
powerpc                     kmeter1_defconfig
mips                        nlm_xlp_defconfig
arm                         nhk8815_defconfig
xtensa                generic_kc705_defconfig
parisc                           alldefconfig
sh                            titan_defconfig
arm                         assabet_defconfig
mips                           ip32_defconfig
arm                        multi_v7_defconfig
h8300                       h8s-sim_defconfig
sh                          r7785rp_defconfig
mips                        maltaup_defconfig
sh                        apsh4ad0a_defconfig
sh                           se7721_defconfig
mips                         rt305x_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7712_defconfig
csky                                defconfig
powerpc                     mpc512x_defconfig
ia64                             alldefconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      cm5200_defconfig
sh                           se7705_defconfig
arc                              alldefconfig
arm                           viper_defconfig
mips                       lemote2f_defconfig
arc                        nsimosci_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     mpc5200_defconfig
powerpc                      chrp32_defconfig
powerpc                      ppc40x_defconfig
sh                          lboxre2_defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                          g5_defconfig
arm                         orion5x_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
alpha                            allyesconfig
nds32                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
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
i386                 randconfig-a001-20210315
i386                 randconfig-a005-20210315
i386                 randconfig-a003-20210315
i386                 randconfig-a002-20210315
i386                 randconfig-a004-20210315
i386                 randconfig-a006-20210315
i386                 randconfig-a013-20210315
i386                 randconfig-a016-20210315
i386                 randconfig-a011-20210315
i386                 randconfig-a012-20210315
i386                 randconfig-a014-20210315
i386                 randconfig-a015-20210315
x86_64               randconfig-a006-20210315
x86_64               randconfig-a001-20210315
x86_64               randconfig-a005-20210315
x86_64               randconfig-a004-20210315
x86_64               randconfig-a002-20210315
x86_64               randconfig-a003-20210315
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210315
x86_64               randconfig-a016-20210315
x86_64               randconfig-a013-20210315
x86_64               randconfig-a015-20210315
x86_64               randconfig-a014-20210315
x86_64               randconfig-a012-20210315

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
