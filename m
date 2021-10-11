Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5F8C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 11 Oct 2021 02:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D669E60F3A
	for <linux-serial@archiver.kernel.org>; Mon, 11 Oct 2021 02:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhJKCd7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 10 Oct 2021 22:33:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:25830 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231872AbhJKCd7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 10 Oct 2021 22:33:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="226684703"
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; 
   d="scan'208";a="226684703"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2021 19:31:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,363,1624345200"; 
   d="scan'208";a="658471309"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Oct 2021 19:31:58 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mZl6b-0001m5-II; Mon, 11 Oct 2021 02:31:57 +0000
Date:   Mon, 11 Oct 2021 10:30:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 2cb3315107b5b3312b0f434efdb3ad354274e2a5
Message-ID: <6163a1e0.ElpuCk9Tt4nlQo3V%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 2cb3315107b5b3312b0f434efdb3ad354274e2a5  serial: 8250_lpss: Enable PSE UART Auto Flow Control

elapsed time: 721m

configs tested: 151
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211010
powerpc                    ge_imp3a_defconfig
m68k                       m5249evb_defconfig
arm                           viper_defconfig
openrisc                 simple_smp_defconfig
arm                       omap2plus_defconfig
m68k                       m5475evb_defconfig
sh                               allmodconfig
powerpc                   lite5200b_defconfig
arm                          imote2_defconfig
s390                       zfcpdump_defconfig
mips                     loongson2k_defconfig
mips                        maltaup_defconfig
sh                        apsh4ad0a_defconfig
powerpc                      ppc40x_defconfig
arm                            xcep_defconfig
arm                          badge4_defconfig
mips                      maltasmvp_defconfig
mips                         cobalt_defconfig
sh                           se7780_defconfig
arm                       imx_v4_v5_defconfig
powerpc                     redwood_defconfig
sparc64                             defconfig
powerpc                         wii_defconfig
ia64                         bigsur_defconfig
mips                        bcm63xx_defconfig
arm                            pleb_defconfig
arm                        mvebu_v7_defconfig
m68k                          multi_defconfig
mips                   sb1250_swarm_defconfig
nios2                            alldefconfig
powerpc                    adder875_defconfig
sh                           se7343_defconfig
h8300                               defconfig
sh                          lboxre2_defconfig
powerpc                    sam440ep_defconfig
powerpc                    amigaone_defconfig
sh                         apsh4a3a_defconfig
sh                               j2_defconfig
powerpc                       eiger_defconfig
arm                         axm55xx_defconfig
arm                           sama7_defconfig
arm                          iop32x_defconfig
powerpc                     ksi8560_defconfig
powerpc                         ps3_defconfig
riscv                    nommu_k210_defconfig
nds32                               defconfig
mips                         tb0219_defconfig
h8300                            alldefconfig
powerpc                  iss476-smp_defconfig
arm                           h3600_defconfig
powerpc                 mpc8560_ads_defconfig
mips                          malta_defconfig
powerpc                     stx_gp3_defconfig
arm                  colibri_pxa300_defconfig
powerpc                      acadia_defconfig
mips                          rb532_defconfig
xtensa                          iss_defconfig
arm                          pxa910_defconfig
m68k                        mvme16x_defconfig
powerpc                     ep8248e_defconfig
arm                       cns3420vb_defconfig
arm                            hisi_defconfig
arc                           tb10x_defconfig
arm                         vf610m4_defconfig
arm                  randconfig-c002-20211010
x86_64               randconfig-c001-20211010
arm                  randconfig-c002-20211011
i386                 randconfig-c001-20211011
x86_64               randconfig-c001-20211011
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20211010
x86_64               randconfig-a006-20211010
x86_64               randconfig-a001-20211010
x86_64               randconfig-a005-20211010
x86_64               randconfig-a002-20211010
x86_64               randconfig-a003-20211010
i386                 randconfig-a001-20211010
i386                 randconfig-a003-20211010
i386                 randconfig-a004-20211010
i386                 randconfig-a005-20211010
i386                 randconfig-a002-20211010
i386                 randconfig-a006-20211010
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
arm                  randconfig-c002-20211010
mips                 randconfig-c004-20211010
i386                 randconfig-c001-20211010
s390                 randconfig-c005-20211010
x86_64               randconfig-c007-20211010
powerpc              randconfig-c003-20211010
riscv                randconfig-c006-20211010
x86_64               randconfig-a015-20211010
x86_64               randconfig-a012-20211010
x86_64               randconfig-a016-20211010
x86_64               randconfig-a014-20211010
x86_64               randconfig-a013-20211010
x86_64               randconfig-a011-20211010
i386                 randconfig-a016-20211010
i386                 randconfig-a014-20211010
i386                 randconfig-a011-20211010
i386                 randconfig-a015-20211010
i386                 randconfig-a012-20211010
i386                 randconfig-a013-20211010
hexagon              randconfig-r041-20211010
s390                 randconfig-r044-20211010
riscv                randconfig-r042-20211010
hexagon              randconfig-r045-20211010

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
