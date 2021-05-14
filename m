Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9737CC433B4
	for <linux-serial@archiver.kernel.org>; Fri, 14 May 2021 03:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 699736141E
	for <linux-serial@archiver.kernel.org>; Fri, 14 May 2021 03:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhENDqz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 May 2021 23:46:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:36993 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231837AbhENDqz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 May 2021 23:46:55 -0400
IronPort-SDR: VdIRDU2AvZgobObyWm88AusjibCWjRbP1QcqaFnUCGZbZH11C9szgQY7RQniu58/0ve81Y4GhH
 bFI7VvohLgfQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="199796707"
X-IronPort-AV: E=Sophos;i="5.82,298,1613462400"; 
   d="scan'208";a="199796707"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 20:45:38 -0700
IronPort-SDR: +rl2gM575VinSAeHsKeHwdcol1f1L8OdSjeSv3s2pleQEKMnZFb9y3nqldWEA8KBu2dRQdVsZe
 983nOfzemQ/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,298,1613462400"; 
   d="scan'208";a="542718256"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2021 20:45:37 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lhOlc-0000YW-C8; Fri, 14 May 2021 03:45:36 +0000
Date:   Fri, 14 May 2021 11:45:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 3c35d2a960c0077a4cb09bf4989f45d289332ea0
Message-ID: <609df24f.nzYtgZDAKKe9kNfW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 3c35d2a960c0077a4cb09bf4989f45d289332ea0  serial: 8250_dw: Add device HID for new AMD UART controller

elapsed time: 726m

configs tested: 167
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                             allmodconfig
i386                             allyesconfig
x86_64                           allyesconfig
riscv                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
riscv                            allmodconfig
s390                             allyesconfig
m68k                             allmodconfig
s390                             allmodconfig
m68k                             allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
mips                         tb0219_defconfig
ia64                          tiger_defconfig
powerpc                      acadia_defconfig
powerpc                 mpc836x_mds_defconfig
sh                                  defconfig
powerpc                 mpc8313_rdb_defconfig
m68k                        mvme16x_defconfig
m68k                       m5249evb_defconfig
arc                          axs103_defconfig
mips                        workpad_defconfig
powerpc                 linkstation_defconfig
mips                malta_qemu_32r6_defconfig
um                             i386_defconfig
arm                         lpc32xx_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     taishan_defconfig
riscv             nommu_k210_sdcard_defconfig
arc                              alldefconfig
riscv                    nommu_virt_defconfig
m68k                                defconfig
sh                        edosk7760_defconfig
mips                       capcella_defconfig
arm                   milbeaut_m10v_defconfig
arm                        multi_v5_defconfig
powerpc                     tqm8540_defconfig
mips                          ath79_defconfig
arm                       mainstone_defconfig
powerpc                      mgcoge_defconfig
arm                          exynos_defconfig
powerpc                     ppa8548_defconfig
sh                     magicpanelr2_defconfig
arc                     haps_hs_smp_defconfig
powerpc                    klondike_defconfig
openrisc                            defconfig
powerpc                      bamboo_defconfig
sh                   sh7770_generic_defconfig
arm                        mini2440_defconfig
riscv                    nommu_k210_defconfig
powerpc                   lite5200b_defconfig
powerpc                    gamecube_defconfig
arm                          simpad_defconfig
powerpc                      ppc44x_defconfig
powerpc                         ps3_defconfig
m68k                        m5307c3_defconfig
m68k                       m5275evb_defconfig
arm                          iop32x_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                          landisk_defconfig
m68k                         amcore_defconfig
sh                        apsh4ad0a_defconfig
arm                        keystone_defconfig
um                               alldefconfig
sh                        edosk7705_defconfig
sh                           se7712_defconfig
m68k                       bvme6000_defconfig
mips                      maltaaprp_defconfig
xtensa                  nommu_kc705_defconfig
xtensa                           allyesconfig
nios2                            alldefconfig
powerpc                      pcm030_defconfig
arm                        spear6xx_defconfig
arm                           h5000_defconfig
mips                         tb0287_defconfig
xtensa                generic_kc705_defconfig
arm                        cerfcube_defconfig
mips                 decstation_r4k_defconfig
arm                       imx_v4_v5_defconfig
powerpc                     tqm5200_defconfig
h8300                               defconfig
sh                        sh7785lcr_defconfig
arc                                 defconfig
m68k                           sun3_defconfig
powerpc                     mpc512x_defconfig
openrisc                 simple_smp_defconfig
mips                           ip22_defconfig
arc                          axs101_defconfig
m68k                          hp300_defconfig
powerpc                         wii_defconfig
riscv                          rv32_defconfig
arm                          moxart_defconfig
sh                          urquell_defconfig
sh                        sh7763rdp_defconfig
mips                        jmr3927_defconfig
mips                       rbtx49xx_defconfig
sh                            migor_defconfig
h8300                       h8s-sim_defconfig
riscv                            alldefconfig
powerpc                     ksi8560_defconfig
x86_64                            allnoconfig
ia64                                defconfig
ia64                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210513
i386                 randconfig-a001-20210513
i386                 randconfig-a005-20210513
i386                 randconfig-a004-20210513
i386                 randconfig-a002-20210513
i386                 randconfig-a006-20210513
i386                 randconfig-a003-20210514
i386                 randconfig-a001-20210514
i386                 randconfig-a004-20210514
i386                 randconfig-a005-20210514
i386                 randconfig-a002-20210514
i386                 randconfig-a006-20210514
x86_64               randconfig-a012-20210513
x86_64               randconfig-a015-20210513
x86_64               randconfig-a011-20210513
x86_64               randconfig-a013-20210513
x86_64               randconfig-a016-20210513
x86_64               randconfig-a014-20210513
i386                 randconfig-a016-20210513
i386                 randconfig-a014-20210513
i386                 randconfig-a011-20210513
i386                 randconfig-a015-20210513
i386                 randconfig-a012-20210513
i386                 randconfig-a013-20210513
riscv                             allnoconfig
riscv                               defconfig
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
x86_64               randconfig-a003-20210513
x86_64               randconfig-a004-20210513
x86_64               randconfig-a001-20210513
x86_64               randconfig-a005-20210513
x86_64               randconfig-a002-20210513
x86_64               randconfig-a006-20210513

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
