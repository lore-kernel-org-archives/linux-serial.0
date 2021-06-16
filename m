Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2F4C48BE5
	for <linux-serial@archiver.kernel.org>; Wed, 16 Jun 2021 01:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978D161209
	for <linux-serial@archiver.kernel.org>; Wed, 16 Jun 2021 01:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhFPBuG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Jun 2021 21:50:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:44970 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230454AbhFPBuF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Jun 2021 21:50:05 -0400
IronPort-SDR: y6I4+R2SqbORPQ8y9/sdsH+EicwJzM/3TnSAx29fuVB7eOFeLTTcAT6aR4jLpW6kJg44JgCCql
 c65FyhL+qdqQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="205916988"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="205916988"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 18:48:00 -0700
IronPort-SDR: Iv5I29+1F6N+ROJMqwpSkLM7RtaUU5K2FDp1K90UYD7ALFxcriQeai5O7tZ9QkXVwemp9HcI8F
 M9x2foeKNxMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="404149107"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Jun 2021 18:47:58 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ltKer-0000jk-Ue; Wed, 16 Jun 2021 01:47:57 +0000
Date:   Wed, 16 Jun 2021 09:47:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 674b5396576b636a1ff101f692935748388c7325
Message-ID: <60c9583b.7z8VXcTn76BmMZhN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 674b5396576b636a1ff101f692935748388c7325  serial_cs: Add Option International GSM-Ready 56K/ISDN modem

elapsed time: 729m

configs tested: 152
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
ia64                        generic_defconfig
arm                       versatile_defconfig
arm                         lpc32xx_defconfig
arm                         socfpga_defconfig
powerpc                     sbc8548_defconfig
arm                  colibri_pxa270_defconfig
m68k                        stmark2_defconfig
powerpc                        icon_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                     ep8248e_defconfig
arm                           omap1_defconfig
arm                       netwinder_defconfig
mips                       rbtx49xx_defconfig
xtensa                    smp_lx200_defconfig
mips                          ath79_defconfig
powerpc                  iss476-smp_defconfig
h8300                            allyesconfig
mips                  cavium_octeon_defconfig
um                           x86_64_defconfig
arm                          pcm027_defconfig
powerpc                      ppc64e_defconfig
xtensa                  audio_kc705_defconfig
xtensa                generic_kc705_defconfig
powerpc                 mpc8540_ads_defconfig
arm                        oxnas_v6_defconfig
s390                                defconfig
arm                        multi_v7_defconfig
arm                            lart_defconfig
sh                          sdk7786_defconfig
arm                          collie_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                      fuloong2e_defconfig
arm                      tct_hammer_defconfig
m68k                       m5249evb_defconfig
arm                   milbeaut_m10v_defconfig
sh                            shmin_defconfig
powerpc                   lite5200b_defconfig
arm                        neponset_defconfig
openrisc                            defconfig
sh                        sh7763rdp_defconfig
mips                      bmips_stb_defconfig
um                            kunit_defconfig
arm                            zeus_defconfig
m68k                          atari_defconfig
arm                        mvebu_v5_defconfig
ia64                            zx1_defconfig
powerpc                     ksi8560_defconfig
ia64                             alldefconfig
powerpc                      ep88xc_defconfig
arm64                            alldefconfig
arc                    vdk_hs38_smp_defconfig
m68k                         amcore_defconfig
microblaze                      mmu_defconfig
mips                     cu1000-neo_defconfig
m68k                       m5275evb_defconfig
arm                        keystone_defconfig
arm                         palmz72_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                        fsp2_defconfig
s390                             alldefconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                        warp_defconfig
powerpc                     tqm8560_defconfig
powerpc                      ppc44x_defconfig
m68k                          sun3x_defconfig
i386                                defconfig
arm                          exynos_defconfig
sh                           se7343_defconfig
arm                              alldefconfig
arm                         hackkit_defconfig
arm                       imx_v6_v7_defconfig
powerpc                      katmai_defconfig
arm                           viper_defconfig
s390                          debug_defconfig
powerpc                 mpc832x_mds_defconfig
sparc                       sparc64_defconfig
riscv                          rv32_defconfig
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
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
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
i386                 randconfig-a015-20210615
i386                 randconfig-a013-20210615
i386                 randconfig-a016-20210615
i386                 randconfig-a012-20210615
i386                 randconfig-a014-20210615
i386                 randconfig-a011-20210615
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210615
x86_64               randconfig-a015-20210615
x86_64               randconfig-a011-20210615
x86_64               randconfig-a012-20210615
x86_64               randconfig-a014-20210615
x86_64               randconfig-a016-20210615
x86_64               randconfig-a013-20210615

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
