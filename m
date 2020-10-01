Return-Path: <SRS0=1Uan=DI=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A328C4727E
	for <linux-serial@archiver.kernel.org>; Thu,  1 Oct 2020 22:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5173820738
	for <linux-serial@archiver.kernel.org>; Thu,  1 Oct 2020 22:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgJAWJc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 1 Oct 2020 18:09:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:52110 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgJAWJb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Oct 2020 18:09:31 -0400
IronPort-SDR: 6znFRNn8/I3gGsdSAcYtEv1PzVyb32Ijql2qBdKfPflRVanh27Zxi7DclyoJ39qLEgBhjv3dpM
 EPvE0pU47Sxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="142252735"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="142252735"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 15:09:31 -0700
IronPort-SDR: N1Z0lx+IeLWmhxAclwuZoMZjr0PtOLELEfeWddYpx4lXLPrWrehPhavtH/y0KeIMty0mlUjJoU
 KyzDlr5VzuAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="295135870"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 01 Oct 2020 15:09:30 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kO6lV-0000lh-IX; Thu, 01 Oct 2020 22:09:29 +0000
Date:   Fri, 02 Oct 2020 06:09:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 fce3c5c1a2d9cd888f2987662ce17c0c651916b2
Message-ID: <5f765385.z7sDNZ0ZduI9S9o3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: fce3c5c1a2d9cd888f2987662ce17c0c651916b2  serial: max310x: rework RX interrupt handling

elapsed time: 725m

configs tested: 183
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          landisk_defconfig
sh                             sh03_defconfig
arm64                            alldefconfig
powerpc                 mpc832x_mds_defconfig
m68k                        mvme147_defconfig
powerpc                     rainier_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                 linkstation_defconfig
c6x                         dsk6455_defconfig
powerpc64                        alldefconfig
arm                          gemini_defconfig
mips                malta_qemu_32r6_defconfig
mips                          malta_defconfig
riscv                             allnoconfig
arm                              alldefconfig
mips                         tb0287_defconfig
arm                       cns3420vb_defconfig
arm                        realview_defconfig
csky                                defconfig
arm                         assabet_defconfig
mips                       rbtx49xx_defconfig
m68k                          hp300_defconfig
arc                      axs103_smp_defconfig
csky                             alldefconfig
sh                            shmin_defconfig
powerpc                        cell_defconfig
c6x                        evmc6457_defconfig
powerpc                     asp8347_defconfig
arm                         mv78xx0_defconfig
arm                           tegra_defconfig
sh                           se7619_defconfig
mips                        bcm63xx_defconfig
nds32                            alldefconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
sh                           sh2007_defconfig
powerpc                  iss476-smp_defconfig
mips                     cu1830-neo_defconfig
arm                            mmp2_defconfig
powerpc                    gamecube_defconfig
mips                          ath79_defconfig
arm                          simpad_defconfig
mips                  cavium_octeon_defconfig
arm                             mxs_defconfig
mips                             allyesconfig
microblaze                          defconfig
arm                         bcm2835_defconfig
powerpc                      mgcoge_defconfig
powerpc                  storcenter_defconfig
microblaze                      mmu_defconfig
m68k                             allyesconfig
s390                       zfcpdump_defconfig
powerpc                       ppc64_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     taishan_defconfig
arm                           spitz_defconfig
h8300                               defconfig
sh                           se7750_defconfig
m68k                            q40_defconfig
arm                        multi_v5_defconfig
arm                          lpd270_defconfig
arm                        trizeps4_defconfig
arm                           efm32_defconfig
arm                   milbeaut_m10v_defconfig
h8300                            alldefconfig
arm                           viper_defconfig
powerpc                      chrp32_defconfig
arm                           stm32_defconfig
x86_64                              defconfig
mips                      loongson3_defconfig
powerpc                      makalu_defconfig
m68k                         apollo_defconfig
sh                         apsh4a3a_defconfig
sh                             shx3_defconfig
m68k                          multi_defconfig
arm                       imx_v6_v7_defconfig
arc                    vdk_hs38_smp_defconfig
mips                        bcm47xx_defconfig
arm                             pxa_defconfig
mips                           ip28_defconfig
arm                         hackkit_defconfig
sh                          rsk7269_defconfig
sh                     magicpanelr2_defconfig
arm                              zx_defconfig
sh                           se7343_defconfig
arm                            dove_defconfig
mips                        nlm_xlr_defconfig
sh                        edosk7705_defconfig
arm                         axm55xx_defconfig
m68k                        m5307c3_defconfig
xtensa                  audio_kc705_defconfig
mips                        jmr3927_defconfig
powerpc                      katmai_defconfig
powerpc                           allnoconfig
nios2                               defconfig
riscv                            alldefconfig
arm                         palmz72_defconfig
powerpc                     ksi8560_defconfig
sh                        sh7785lcr_defconfig
sh                          rsk7203_defconfig
sh                   sh7724_generic_defconfig
sh                             espt_defconfig
arm                          iop32x_defconfig
powerpc                 mpc837x_rdb_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a003-20200930
i386                 randconfig-a002-20200930
i386                 randconfig-a006-20200930
i386                 randconfig-a005-20200930
i386                 randconfig-a004-20200930
i386                 randconfig-a001-20200930
x86_64               randconfig-a015-20200930
x86_64               randconfig-a013-20200930
x86_64               randconfig-a012-20200930
x86_64               randconfig-a016-20200930
x86_64               randconfig-a014-20200930
x86_64               randconfig-a011-20200930
x86_64               randconfig-a012-20201001
x86_64               randconfig-a015-20201001
x86_64               randconfig-a014-20201001
x86_64               randconfig-a013-20201001
x86_64               randconfig-a011-20201001
x86_64               randconfig-a016-20201001
i386                 randconfig-a011-20200930
i386                 randconfig-a015-20200930
i386                 randconfig-a012-20200930
i386                 randconfig-a014-20200930
i386                 randconfig-a016-20200930
i386                 randconfig-a013-20200930
i386                 randconfig-a014-20201001
i386                 randconfig-a015-20201001
i386                 randconfig-a013-20201001
i386                 randconfig-a016-20201001
i386                 randconfig-a011-20201001
i386                 randconfig-a012-20201001
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20200930
x86_64               randconfig-a005-20200930
x86_64               randconfig-a003-20200930
x86_64               randconfig-a004-20200930
x86_64               randconfig-a002-20200930
x86_64               randconfig-a006-20200930

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
