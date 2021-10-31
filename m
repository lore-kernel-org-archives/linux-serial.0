Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825F0C433EF
	for <linux-serial@archiver.kernel.org>; Sun, 31 Oct 2021 16:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56C8C60F56
	for <linux-serial@archiver.kernel.org>; Sun, 31 Oct 2021 16:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhJaQpD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 31 Oct 2021 12:45:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:45945 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhJaQpC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 31 Oct 2021 12:45:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="229624903"
X-IronPort-AV: E=Sophos;i="5.87,197,1631602800"; 
   d="scan'208";a="229624903"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2021 09:42:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,197,1631602800"; 
   d="scan'208";a="666386360"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 31 Oct 2021 09:42:29 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mhDue-0002bf-Nb; Sun, 31 Oct 2021 16:42:28 +0000
Date:   Mon, 01 Nov 2021 00:41:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 cc8d7b4aea79df7cb45b74f9bc5b8a8bd2ed4c07
Message-ID: <617ec756./Vwx6CuwYKz1FQfb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: cc8d7b4aea79df7cb45b74f9bc5b8a8bd2ed4c07  tty: Fix extra "not" in TTY_DRIVER_REAL_RAW description

elapsed time: 1875m

configs tested: 167
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211028
mips                         tb0287_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                        m5407c3_defconfig
arc                        nsimosci_defconfig
sh                           se7721_defconfig
arm                           corgi_defconfig
arm                     am200epdkit_defconfig
powerpc                     mpc83xx_defconfig
xtensa                  cadence_csp_defconfig
arm                         axm55xx_defconfig
sparc                       sparc64_defconfig
sh                   sh7770_generic_defconfig
xtensa                           alldefconfig
arm                          pxa168_defconfig
mips                           ci20_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7206_defconfig
powerpc                     mpc512x_defconfig
sh                           se7780_defconfig
i386                                defconfig
riscv                          rv32_defconfig
mips                     loongson1b_defconfig
arc                        nsim_700_defconfig
mips                            e55_defconfig
powerpc                      pasemi_defconfig
powerpc                      arches_defconfig
arm                           sama7_defconfig
arc                     nsimosci_hs_defconfig
sh                           se7750_defconfig
mips                        workpad_defconfig
powerpc                      ppc64e_defconfig
arm                        keystone_defconfig
mips                        vocore2_defconfig
mips                      maltasmvp_defconfig
arm                             pxa_defconfig
powerpc                    klondike_defconfig
arm                       netwinder_defconfig
powerpc                   microwatt_defconfig
powerpc                 canyonlands_defconfig
powerpc                        cell_defconfig
h8300                     edosk2674_defconfig
powerpc                   lite5200b_defconfig
riscv                    nommu_virt_defconfig
xtensa                              defconfig
arm                         hackkit_defconfig
sh                        edosk7760_defconfig
um                             i386_defconfig
arm                           omap1_defconfig
alpha                            allyesconfig
xtensa                    xip_kc705_defconfig
mips                         bigsur_defconfig
sh                   secureedge5410_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                    socrates_defconfig
powerpc                     rainier_defconfig
sh                           se7619_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                        omega2p_defconfig
arm                          pcm027_defconfig
arm                        realview_defconfig
sh                         ecovec24_defconfig
xtensa                    smp_lx200_defconfig
powerpc                      katmai_defconfig
powerpc                        warp_defconfig
arm                        oxnas_v6_defconfig
arm                        spear6xx_defconfig
mips                       capcella_defconfig
mips                          ath25_defconfig
s390                          debug_defconfig
sh                          polaris_defconfig
arm                        magician_defconfig
h8300                            alldefconfig
mips                         tb0219_defconfig
arc                                 defconfig
arm                           sama5_defconfig
sh                        sh7763rdp_defconfig
arm                  randconfig-c002-20211031
arm                  randconfig-c002-20211028
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
h8300                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a003-20211031
i386                 randconfig-a006-20211031
i386                 randconfig-a002-20211031
i386                 randconfig-a005-20211031
i386                 randconfig-a001-20211031
i386                 randconfig-a004-20211031
x86_64               randconfig-a005-20211031
x86_64               randconfig-a004-20211031
x86_64               randconfig-a002-20211031
x86_64               randconfig-a003-20211031
x86_64               randconfig-a001-20211031
x86_64               randconfig-a006-20211031
arc                  randconfig-r043-20211031
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
powerpc              randconfig-c003-20211031
riscv                randconfig-c006-20211031
x86_64               randconfig-c007-20211031
mips                 randconfig-c004-20211031
s390                 randconfig-c005-20211031
arm                  randconfig-c002-20211031
i386                 randconfig-c001-20211031
x86_64               randconfig-a013-20211031
x86_64               randconfig-a015-20211031
x86_64               randconfig-a014-20211031
x86_64               randconfig-a011-20211031
x86_64               randconfig-a016-20211031
x86_64               randconfig-a012-20211031
x86_64               randconfig-a015-20211028
x86_64               randconfig-a013-20211028
x86_64               randconfig-a011-20211028
x86_64               randconfig-a014-20211028
x86_64               randconfig-a012-20211028
x86_64               randconfig-a016-20211028
i386                 randconfig-a013-20211031
i386                 randconfig-a012-20211031
i386                 randconfig-a014-20211031
i386                 randconfig-a015-20211031
i386                 randconfig-a011-20211031
i386                 randconfig-a016-20211031
riscv                randconfig-r042-20211031
s390                 randconfig-r044-20211031
hexagon              randconfig-r045-20211031
hexagon              randconfig-r041-20211031

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
