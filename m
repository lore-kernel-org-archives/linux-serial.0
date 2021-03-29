Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5185FC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 29 Mar 2021 00:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E7261948
	for <linux-serial@archiver.kernel.org>; Mon, 29 Mar 2021 00:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhC2Ajx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 28 Mar 2021 20:39:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:54632 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231450AbhC2Ajs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 28 Mar 2021 20:39:48 -0400
IronPort-SDR: tYkW3lVi9tsCnSa569MTz0q9Ct1Y0TFSKXzYhzyBZaiJ4Bn2V6qMT4XeluCZs49zdYOz56DJOS
 ir5co3xRk0TQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="190915476"
X-IronPort-AV: E=Sophos;i="5.81,285,1610438400"; 
   d="scan'208";a="190915476"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2021 17:39:48 -0700
IronPort-SDR: eufSRCQKcLeY/MgVEKnr3R8bKyuqxtWtz+6K5KqUWUk8K6h3s0n6Vosym94gooTPyFsYyrsakC
 sw0cPEzuFK3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,285,1610438400"; 
   d="scan'208";a="454333312"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 28 Mar 2021 17:39:47 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lQfwY-0004Fq-Io; Mon, 29 Mar 2021 00:39:46 +0000
Date:   Mon, 29 Mar 2021 08:39:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS WITH WARNING
 211b4d42b70f1c1660feaa968dac0efc2a96ac4d
Message-ID: <606121b6.SQdAlypo3dfEhZOF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 211b4d42b70f1c1660feaa968dac0efc2a96ac4d  tty: fix memory leak in vc_deallocate

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

elapsed time: 722m

configs tested: 113
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
riscv                            allyesconfig
sh                            titan_defconfig
powerpc                     sbc8548_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                        icon_defconfig
mips                      maltaaprp_defconfig
arm                       imx_v4_v5_defconfig
powerpc                    amigaone_defconfig
powerpc                        cell_defconfig
powerpc                     kilauea_defconfig
powerpc                      chrp32_defconfig
arm                       omap2plus_defconfig
sh                          rsk7264_defconfig
riscv                    nommu_virt_defconfig
um                            kunit_defconfig
powerpc                    socrates_defconfig
arm                         s3c6400_defconfig
powerpc                     rainier_defconfig
arc                           tb10x_defconfig
powerpc                     tqm8540_defconfig
s390                                defconfig
powerpc                      tqm8xx_defconfig
i386                             alldefconfig
sh                           se7722_defconfig
powerpc                       ppc64_defconfig
alpha                               defconfig
arm                         shannon_defconfig
mips                     loongson1b_defconfig
sh                         microdev_defconfig
parisc                generic-64bit_defconfig
powerpc                      ppc6xx_defconfig
arm                          ixp4xx_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210328
i386                 randconfig-a003-20210328
i386                 randconfig-a001-20210328
i386                 randconfig-a002-20210328
i386                 randconfig-a006-20210328
i386                 randconfig-a005-20210328
x86_64               randconfig-a015-20210328
x86_64               randconfig-a012-20210328
x86_64               randconfig-a013-20210328
x86_64               randconfig-a014-20210328
x86_64               randconfig-a016-20210328
x86_64               randconfig-a011-20210328
i386                 randconfig-a014-20210328
i386                 randconfig-a011-20210328
i386                 randconfig-a015-20210328
i386                 randconfig-a016-20210328
i386                 randconfig-a013-20210328
i386                 randconfig-a012-20210328
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210329
x86_64               randconfig-a012-20210329
x86_64               randconfig-a013-20210329
x86_64               randconfig-a014-20210329
x86_64               randconfig-a011-20210329
x86_64               randconfig-a016-20210329
x86_64               randconfig-a002-20210328
x86_64               randconfig-a003-20210328
x86_64               randconfig-a001-20210328
x86_64               randconfig-a006-20210328
x86_64               randconfig-a005-20210328
x86_64               randconfig-a004-20210328

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
