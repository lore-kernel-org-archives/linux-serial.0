Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08C2C43460
	for <linux-serial@archiver.kernel.org>; Mon, 10 May 2021 21:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE406146E
	for <linux-serial@archiver.kernel.org>; Mon, 10 May 2021 21:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhEJVks (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 May 2021 17:40:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:11876 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232257AbhEJVkr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 May 2021 17:40:47 -0400
IronPort-SDR: /PMUj6N9lB1wnu0BIhU3Rug2DY3j+2Mq9cevXN74XkkLON3ZnIdcMY7m56OD7VNyQDd53KtT/t
 vZr2G5fjMoXQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="263224989"
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="263224989"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 14:39:42 -0700
IronPort-SDR: BlfdCZ+HRtSnZC+MDmYcy+bHmQt8kt/0dF1+ty15D3VCAbzFWA78zZJ5WrK9kque0dWn6zrWD7
 xLXJK83B3CSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="609245620"
Received: from lkp-server01.sh.intel.com (HELO f375d57c4ed4) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 May 2021 14:39:39 -0700
Received: from kbuild by f375d57c4ed4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lgDcp-0000Ng-4W; Mon, 10 May 2021 21:39:39 +0000
Date:   Tue, 11 May 2021 05:39:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty_msg_cleanup] BUILD SUCCESS
 77ac8996db278f549ca8dc8e36e900de6bd9688a
Message-ID: <6099a80d.cODn2KoqK9YYYwG/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty_msg_cleanup
branch HEAD: 77ac8996db278f549ca8dc8e36e900de6bd9688a  tty: remove tty_driver_name()

elapsed time: 721m

configs tested: 211
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

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
h8300                     edosk2674_defconfig
sh                          landisk_defconfig
powerpc                    mvme5100_defconfig
powerpc                     sbc8548_defconfig
mips                             allmodconfig
mips                       rbtx49xx_defconfig
arm                           spitz_defconfig
h8300                            alldefconfig
sh                          lboxre2_defconfig
nds32                               defconfig
m68k                                defconfig
sh                          urquell_defconfig
arm                         at91_dt_defconfig
arc                         haps_hs_defconfig
mips                       capcella_defconfig
powerpc                 mpc8272_ads_defconfig
mips                malta_qemu_32r6_defconfig
sh                     sh7710voipgw_defconfig
arm                          simpad_defconfig
powerpc                 mpc836x_mds_defconfig
arm                         s3c6400_defconfig
m68k                          atari_defconfig
powerpc                      ppc40x_defconfig
powerpc                      obs600_defconfig
arm64                            alldefconfig
powerpc                mpc7448_hpc2_defconfig
arm                           tegra_defconfig
arm                            mps2_defconfig
openrisc                  or1klitex_defconfig
ia64                          tiger_defconfig
s390                             alldefconfig
sh                           se7619_defconfig
arm                         nhk8815_defconfig
arm                       aspeed_g4_defconfig
mips                        workpad_defconfig
arm                       aspeed_g5_defconfig
arm                           u8500_defconfig
arm                          iop32x_defconfig
mips                          ath25_defconfig
m68k                        mvme16x_defconfig
mips                           xway_defconfig
powerpc                  storcenter_defconfig
mips                           ip32_defconfig
sh                           se7343_defconfig
openrisc                    or1ksim_defconfig
xtensa                  nommu_kc705_defconfig
riscv                    nommu_k210_defconfig
mips                     cu1830-neo_defconfig
ia64                        generic_defconfig
sh                   sh7770_generic_defconfig
mips                       lemote2f_defconfig
sh                               alldefconfig
arm                            lart_defconfig
openrisc                            defconfig
arm                            pleb_defconfig
powerpc                 mpc837x_mds_defconfig
nios2                            alldefconfig
powerpc64                           defconfig
mips                        omega2p_defconfig
arm                         lpc32xx_defconfig
sparc                       sparc32_defconfig
arm                          pxa3xx_defconfig
sh                           se7751_defconfig
mips                            ar7_defconfig
mips                          rm200_defconfig
powerpc                     tqm8555_defconfig
arm                             ezx_defconfig
powerpc                 mpc834x_mds_defconfig
mips                        bcm63xx_defconfig
mips                      maltaaprp_defconfig
powerpc                      chrp32_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                    gamecube_defconfig
arm                            dove_defconfig
arm                        trizeps4_defconfig
x86_64                           alldefconfig
mips                        bcm47xx_defconfig
mips                         tb0226_defconfig
sh                                  defconfig
m68k                          amiga_defconfig
powerpc                      ppc64e_defconfig
sh                           sh2007_defconfig
powerpc                  iss476-smp_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                     decstation_defconfig
arm                         mv78xx0_defconfig
ia64                             alldefconfig
arc                          axs101_defconfig
sh                      rts7751r2d1_defconfig
sh                   secureedge5410_defconfig
ia64                             allyesconfig
sh                          r7780mp_defconfig
arm                      tct_hammer_defconfig
arm                          pxa168_defconfig
arc                        vdk_hs38_defconfig
csky                                defconfig
mips                          ath79_defconfig
mips                  cavium_octeon_defconfig
powerpc                    klondike_defconfig
sh                              ul2_defconfig
powerpc                      pmac32_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                         cm_x300_defconfig
arm                       imx_v6_v7_defconfig
mips                         tb0287_defconfig
sh                          sdk7786_defconfig
arm                        mvebu_v5_defconfig
mips                        qi_lb60_defconfig
sh                          rsk7269_defconfig
powerpc                     skiroot_defconfig
mips                         cobalt_defconfig
arc                          axs103_defconfig
h8300                            allyesconfig
sh                           se7724_defconfig
mips                        maltaup_defconfig
powerpc                        icon_defconfig
arm                        multi_v7_defconfig
sh                         microdev_defconfig
powerpc                          g5_defconfig
arm                        multi_v5_defconfig
mips                           ci20_defconfig
sh                               j2_defconfig
powerpc                   currituck_defconfig
mips                            gpr_defconfig
arm                          ixp4xx_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                 linkstation_defconfig
mips                      bmips_stb_defconfig
arm                            mmp2_defconfig
m68k                         amcore_defconfig
powerpc                 canyonlands_defconfig
mips                 decstation_r4k_defconfig
sh                          rsk7201_defconfig
powerpc                   motionpro_defconfig
x86_64                              defconfig
h8300                    h8300h-sim_defconfig
riscv                            alldefconfig
powerpc                     rainier_defconfig
xtensa                       common_defconfig
m68k                        stmark2_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210510
x86_64               randconfig-a004-20210510
x86_64               randconfig-a001-20210510
x86_64               randconfig-a005-20210510
x86_64               randconfig-a002-20210510
x86_64               randconfig-a006-20210510
i386                 randconfig-a003-20210510
i386                 randconfig-a001-20210510
i386                 randconfig-a005-20210510
i386                 randconfig-a004-20210510
i386                 randconfig-a002-20210510
i386                 randconfig-a006-20210510
i386                 randconfig-a016-20210510
i386                 randconfig-a014-20210510
i386                 randconfig-a011-20210510
i386                 randconfig-a015-20210510
i386                 randconfig-a012-20210510
i386                 randconfig-a013-20210510
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210510
x86_64               randconfig-a012-20210510
x86_64               randconfig-a011-20210510
x86_64               randconfig-a013-20210510
x86_64               randconfig-a016-20210510
x86_64               randconfig-a014-20210510

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
