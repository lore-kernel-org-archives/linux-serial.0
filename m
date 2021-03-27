Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65810C433E0
	for <linux-serial@archiver.kernel.org>; Sat, 27 Mar 2021 02:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19ED561A28
	for <linux-serial@archiver.kernel.org>; Sat, 27 Mar 2021 02:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhC0C1L (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Mar 2021 22:27:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:45101 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230318AbhC0C0j (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Mar 2021 22:26:39 -0400
IronPort-SDR: VBCh+Kj0wep6ohQypskJ9J5aJW5S7NnjLZnOAKMA1r9gbAZoCc1d+nnMZALu/OQrGEC9IzkswM
 43Jm1EVGYRLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="190698645"
X-IronPort-AV: E=Sophos;i="5.81,282,1610438400"; 
   d="scan'208";a="190698645"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 19:26:38 -0700
IronPort-SDR: UcH1oYdyFqq3FgK6Ik2Gi/TqISxssluA2J5rzsJabGfEspNUDAIe1ktLEKUf9y4ynMuJUUuAhA
 VyiQUqg3NDlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,282,1610438400"; 
   d="scan'208";a="382851176"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 26 Mar 2021 19:26:36 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lPyeq-0003AD-4i; Sat, 27 Mar 2021 02:26:36 +0000
Date:   Sat, 27 Mar 2021 10:26:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS WITH WARNING
 41a469482de257ea8db43cf74b6311bd055de030
Message-ID: <605e97c8.3AMrm/aOtUSMsCNU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 41a469482de257ea8db43cf74b6311bd055de030  serial: 8250: Add new 8250-core based Broadcom STB driver

possible Warning in current branch:

arch/arm/boot/dts/exynos4210-i9100.dt.yaml: serial@13800000: 'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'
arch/arm/boot/dts/exynos4210-trats.dt.yaml: serial@13800000: 'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'
arch/arm/boot/dts/exynos4412-i9300.dt.yaml: serial@13800000: 'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'
arch/arm/boot/dts/exynos4412-i9305.dt.yaml: serial@13800000: 'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'
arch/arm/boot/dts/exynos4412-n710x.dt.yaml: serial@13800000: 'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'
arch/arm/boot/dts/exynos4412-p4note-n8010.dt.yaml: serial@13800000: 'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'
arch/arm/boot/dts/exynos4412-trats2.dt.yaml: serial@13800000: 'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- arm-defconfig
    |-- arch-arm-boot-dts-exynos4210-i9100.dt.yaml:serial:bluetooth-does-not-match-any-of-the-regexes:pinctrl
    |-- arch-arm-boot-dts-exynos4210-trats.dt.yaml:serial:bluetooth-does-not-match-any-of-the-regexes:pinctrl
    |-- arch-arm-boot-dts-exynos4412-i9300.dt.yaml:serial:bluetooth-does-not-match-any-of-the-regexes:pinctrl
    |-- arch-arm-boot-dts-exynos4412-i9305.dt.yaml:serial:bluetooth-does-not-match-any-of-the-regexes:pinctrl
    |-- arch-arm-boot-dts-exynos4412-n71.dt.yaml:serial:bluetooth-does-not-match-any-of-the-regexes:pinctrl
    |-- arch-arm-boot-dts-exynos4412-p4note-n8010.dt.yaml:serial:bluetooth-does-not-match-any-of-the-regexes:pinctrl
    `-- arch-arm-boot-dts-exynos4412-trats2.dt.yaml:serial:bluetooth-does-not-match-any-of-the-regexes:pinctrl

elapsed time: 723m

configs tested: 170
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
sh                ecovec24-romimage_defconfig
arc                    vdk_hs38_smp_defconfig
m68k                         amcore_defconfig
m68k                           sun3_defconfig
powerpc                      pmac32_defconfig
arm                         hackkit_defconfig
arm                         lpc18xx_defconfig
sh                          kfr2r09_defconfig
sh                           se7780_defconfig
arm                          moxart_defconfig
powerpc                     ep8248e_defconfig
openrisc                            defconfig
sh                         microdev_defconfig
powerpc                          allmodconfig
arm                          ixp4xx_defconfig
nios2                         10m50_defconfig
powerpc                       holly_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                         orion5x_defconfig
powerpc                      pasemi_defconfig
ia64                          tiger_defconfig
powerpc                         wii_defconfig
mips                      pistachio_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                       ebony_defconfig
arm                            pleb_defconfig
m68k                        mvme147_defconfig
microblaze                          defconfig
powerpc                      cm5200_defconfig
parisc                generic-64bit_defconfig
mips                             allmodconfig
arm                       spear13xx_defconfig
mips                            ar7_defconfig
powerpc                          g5_defconfig
ia64                            zx1_defconfig
arc                          axs101_defconfig
arm                       imx_v4_v5_defconfig
m68k                       m5249evb_defconfig
arm                        mini2440_defconfig
ia64                             allyesconfig
arm                          pxa3xx_defconfig
arm                       aspeed_g5_defconfig
mips                     loongson1c_defconfig
sparc                            alldefconfig
mips                           rs90_defconfig
sh                             sh03_defconfig
arm                   milbeaut_m10v_defconfig
arm                        multi_v7_defconfig
powerpc                          allyesconfig
powerpc                   bluestone_defconfig
xtensa                generic_kc705_defconfig
powerpc                      acadia_defconfig
arm                       multi_v4t_defconfig
arm                            mps2_defconfig
arm                          pxa910_defconfig
powerpc                      arches_defconfig
powerpc                       eiger_defconfig
sh                      rts7751r2d1_defconfig
alpha                            alldefconfig
arm                         s3c2410_defconfig
sh                            migor_defconfig
powerpc                    sam440ep_defconfig
sparc                       sparc64_defconfig
sh                          polaris_defconfig
powerpc                      walnut_defconfig
arm                         s3c6400_defconfig
m68k                             allmodconfig
arm                     eseries_pxa_defconfig
sh                            titan_defconfig
arm                       cns3420vb_defconfig
arm                          imote2_defconfig
mips                          rb532_defconfig
powerpc                     mpc5200_defconfig
mips                           mtx1_defconfig
sh                             shx3_defconfig
xtensa                  cadence_csp_defconfig
arm                         palmz72_defconfig
arm                         mv78xx0_defconfig
alpha                            allyesconfig
mips                            gpr_defconfig
powerpc                       maple_defconfig
powerpc                    socrates_defconfig
powerpc                      bamboo_defconfig
m68k                                defconfig
sh                           se7206_defconfig
sh                           sh2007_defconfig
powerpc                 mpc834x_mds_defconfig
sh                        sh7763rdp_defconfig
m68k                       m5275evb_defconfig
mips                           ci20_defconfig
arc                        nsimosci_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210327
x86_64               randconfig-a003-20210327
x86_64               randconfig-a006-20210327
x86_64               randconfig-a001-20210327
x86_64               randconfig-a004-20210327
x86_64               randconfig-a005-20210327
i386                 randconfig-a004-20210326
i386                 randconfig-a003-20210326
i386                 randconfig-a001-20210326
i386                 randconfig-a002-20210326
i386                 randconfig-a006-20210326
i386                 randconfig-a005-20210326
x86_64               randconfig-a012-20210326
x86_64               randconfig-a015-20210326
x86_64               randconfig-a014-20210326
x86_64               randconfig-a013-20210326
x86_64               randconfig-a016-20210326
x86_64               randconfig-a011-20210326
i386                 randconfig-a014-20210326
i386                 randconfig-a011-20210326
i386                 randconfig-a015-20210326
i386                 randconfig-a016-20210326
i386                 randconfig-a012-20210326
i386                 randconfig-a013-20210326
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210326
x86_64               randconfig-a003-20210326
x86_64               randconfig-a001-20210326
x86_64               randconfig-a006-20210326
x86_64               randconfig-a004-20210326
x86_64               randconfig-a005-20210326

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
