Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC3EC48BE6
	for <linux-serial@archiver.kernel.org>; Wed, 16 Jun 2021 19:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 323D461351
	for <linux-serial@archiver.kernel.org>; Wed, 16 Jun 2021 19:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFPT7L (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Jun 2021 15:59:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:11711 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230118AbhFPT7K (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Jun 2021 15:59:10 -0400
IronPort-SDR: 6F0eLSV8f0x1baagfbV9ThFdFslcyckWVH7mvqWS0ziRW7nU3PLAqLXcCeLKoegzWvIppo97yD
 DAux1FT79dhg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="267396475"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="267396475"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 12:57:03 -0700
IronPort-SDR: 3WZL5UeWg9bH+xUGsdNM1XuAhFuNy76N33H4IsHgIjwH1dACIPSv/V8VZjQq9nOC/52x+OFtAs
 ViJ3gw6Mc04g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="479218820"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2021 12:57:02 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ltben-0001UJ-OJ; Wed, 16 Jun 2021 19:57:01 +0000
Date:   Thu, 17 Jun 2021 03:56:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 d495dd743d5ecd47288156e25c4d9163294a0992
Message-ID: <60ca576a.p8R5P4FRThcr32MD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: d495dd743d5ecd47288156e25c4d9163294a0992  serial_cs: Add Option International GSM-Ready 56K/ISDN modem

elapsed time: 733m

configs tested: 206
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      chrp32_defconfig
powerpc                  mpc866_ads_defconfig
mips                     cu1000-neo_defconfig
ia64                        generic_defconfig
arm                       versatile_defconfig
arm                         lpc32xx_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                   bluestone_defconfig
sh                          r7785rp_defconfig
sh                        sh7785lcr_defconfig
arm                        clps711x_defconfig
sparc                       sparc64_defconfig
ia64                            zx1_defconfig
mips                        vocore2_defconfig
m68k                          multi_defconfig
xtensa                    smp_lx200_defconfig
mips                          ath79_defconfig
powerpc                  iss476-smp_defconfig
xtensa                         virt_defconfig
arm                            lart_defconfig
sh                           se7619_defconfig
ia64                      gensparse_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                   motionpro_defconfig
sh                           se7206_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                          rsk7201_defconfig
nios2                               defconfig
sh                 kfr2r09-romimage_defconfig
mips                        omega2p_defconfig
powerpc                   currituck_defconfig
um                               alldefconfig
sh                          sdk7786_defconfig
arm                          collie_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                      ep88xc_defconfig
mips                           rs90_defconfig
powerpc                       ppc64_defconfig
sh                             shx3_defconfig
sh                           se7721_defconfig
arm                         socfpga_defconfig
nios2                         10m50_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                     tqm8555_defconfig
powerpc                     pq2fads_defconfig
powerpc                     taishan_defconfig
mips                    maltaup_xpa_defconfig
m68k                            mac_defconfig
m68k                        mvme16x_defconfig
powerpc                      cm5200_defconfig
arm                       netwinder_defconfig
arm                         assabet_defconfig
mips                       rbtx49xx_defconfig
i386                                defconfig
sparc                       sparc32_defconfig
powerpc64                        alldefconfig
mips                 decstation_r4k_defconfig
powerpc                   lite5200b_defconfig
arm                        neponset_defconfig
m68k                             alldefconfig
powerpc                  storcenter_defconfig
powerpc                        warp_defconfig
mips                            gpr_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     tqm5200_defconfig
arm                         vf610m4_defconfig
arm                        multi_v5_defconfig
powerpc                     kmeter1_defconfig
powerpc                     ppa8548_defconfig
h8300                       h8s-sim_defconfig
arm                           u8500_defconfig
powerpc                       holly_defconfig
um                           x86_64_defconfig
arm64                            alldefconfig
arc                    vdk_hs38_smp_defconfig
m68k                         amcore_defconfig
microblaze                      mmu_defconfig
xtensa                generic_kc705_defconfig
powerpc                    socrates_defconfig
arc                        nsim_700_defconfig
arm                            hisi_defconfig
sh                            migor_defconfig
sh                            hp6xx_defconfig
powerpc                     mpc5200_defconfig
riscv                    nommu_k210_defconfig
mips                      pic32mzda_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     pseries_defconfig
arm                          ixp4xx_defconfig
arm                        multi_v7_defconfig
powerpc                     tqm8560_defconfig
powerpc                      ppc44x_defconfig
mips                        workpad_defconfig
mips                        jmr3927_defconfig
arm                           spitz_defconfig
mips                   sb1250_swarm_defconfig
arm                            zeus_defconfig
m68k                          sun3x_defconfig
arm                          exynos_defconfig
sh                           se7343_defconfig
arm                              alldefconfig
powerpc                    gamecube_defconfig
xtensa                  cadence_csp_defconfig
arm                         hackkit_defconfig
arm                       imx_v6_v7_defconfig
powerpc                      katmai_defconfig
arm                           viper_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     rainier_defconfig
s390                          debug_defconfig
powerpc                 mpc832x_mds_defconfig
arm                        mvebu_v5_defconfig
riscv                          rv32_defconfig
powerpc                     powernv_defconfig
sh                           se7751_defconfig
x86_64                           alldefconfig
alpha                               defconfig
mips                       bmips_be_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20210615
x86_64               randconfig-a004-20210615
x86_64               randconfig-a002-20210615
x86_64               randconfig-a003-20210615
x86_64               randconfig-a006-20210615
x86_64               randconfig-a005-20210615
i386                 randconfig-a002-20210615
i386                 randconfig-a006-20210615
i386                 randconfig-a004-20210615
i386                 randconfig-a001-20210615
i386                 randconfig-a005-20210615
i386                 randconfig-a003-20210615
i386                 randconfig-a015-20210616
i386                 randconfig-a013-20210616
i386                 randconfig-a016-20210616
i386                 randconfig-a012-20210616
i386                 randconfig-a014-20210616
i386                 randconfig-a011-20210616
i386                 randconfig-a015-20210615
i386                 randconfig-a013-20210615
i386                 randconfig-a016-20210615
i386                 randconfig-a012-20210615
i386                 randconfig-a014-20210615
i386                 randconfig-a011-20210615
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210615
x86_64               randconfig-b001-20210616
x86_64               randconfig-a004-20210616
x86_64               randconfig-a001-20210616
x86_64               randconfig-a002-20210616
x86_64               randconfig-a003-20210616
x86_64               randconfig-a006-20210616
x86_64               randconfig-a005-20210616
x86_64               randconfig-a015-20210615
x86_64               randconfig-a011-20210615
x86_64               randconfig-a012-20210615
x86_64               randconfig-a014-20210615
x86_64               randconfig-a016-20210615
x86_64               randconfig-a013-20210615

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
