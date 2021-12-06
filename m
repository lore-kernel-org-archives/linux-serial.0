Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F3AC433FE
	for <linux-serial@archiver.kernel.org>; Mon,  6 Dec 2021 21:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350200AbhLFVOR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Dec 2021 16:14:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:45040 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350185AbhLFVOR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Dec 2021 16:14:17 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="217432075"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="217432075"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 13:10:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="579524016"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 06 Dec 2021 13:10:19 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muLFb-000Lkj-9d; Mon, 06 Dec 2021 21:10:19 +0000
Date:   Tue, 07 Dec 2021 05:09:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 f5bced9f34355d2b12779eebdf2634cb27c18cff
Message-ID: <61ae7c26.HDUeLVycAup0slhI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: f5bced9f34355d2b12779eebdf2634cb27c18cff  Merge 5.16-rc4 into tty-next

elapsed time: 722m

configs tested: 140
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
i386                 randconfig-c001-20211206
mips                           ip27_defconfig
powerpc                     asp8347_defconfig
arm                            xcep_defconfig
sh                          r7780mp_defconfig
powerpc                     tqm5200_defconfig
sh                           se7750_defconfig
powerpc                      chrp32_defconfig
sh                          urquell_defconfig
sh                           se7751_defconfig
um                             i386_defconfig
mips                            gpr_defconfig
arm                       cns3420vb_defconfig
sparc64                             defconfig
m68k                            mac_defconfig
arm                        multi_v5_defconfig
arm                          ixp4xx_defconfig
arm                       aspeed_g5_defconfig
x86_64                           alldefconfig
powerpc                   microwatt_defconfig
sh                           se7721_defconfig
powerpc                  storcenter_defconfig
arm                        keystone_defconfig
ia64                      gensparse_defconfig
arm                            mps2_defconfig
powerpc                         ps3_defconfig
sh                        edosk7760_defconfig
arm                       imx_v4_v5_defconfig
arm                           sama7_defconfig
arm                            zeus_defconfig
arm                         vf610m4_defconfig
arm                      integrator_defconfig
arm                        multi_v7_defconfig
sh                               alldefconfig
arm                           corgi_defconfig
sh                   sh7724_generic_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                           sama5_defconfig
h8300                    h8300h-sim_defconfig
arm                         lpc32xx_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                      rts7751r2d1_defconfig
arm                         orion5x_defconfig
i386                                defconfig
sh                   secureedge5410_defconfig
sh                           se7705_defconfig
um                           x86_64_defconfig
openrisc                  or1klitex_defconfig
powerpc                      ep88xc_defconfig
arm                         bcm2835_defconfig
powerpc                      pasemi_defconfig
powerpc                 mpc8560_ads_defconfig
mips                        qi_lb60_defconfig
arc                     haps_hs_smp_defconfig
m68k                       m5275evb_defconfig
powerpc                     mpc512x_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                  randconfig-c002-20211206
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a016-20211206
x86_64               randconfig-a011-20211206
x86_64               randconfig-a013-20211206
x86_64               randconfig-a014-20211206
x86_64               randconfig-a012-20211206
x86_64               randconfig-a015-20211206
i386                 randconfig-a016-20211206
i386                 randconfig-a013-20211206
i386                 randconfig-a011-20211206
i386                 randconfig-a014-20211206
i386                 randconfig-a012-20211206
i386                 randconfig-a015-20211206
arc                  randconfig-r043-20211206
s390                 randconfig-r044-20211206
riscv                randconfig-r042-20211206
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20211206
x86_64               randconfig-a005-20211206
x86_64               randconfig-a001-20211206
x86_64               randconfig-a002-20211206
x86_64               randconfig-a004-20211206
x86_64               randconfig-a003-20211206
i386                 randconfig-a001-20211206
i386                 randconfig-a005-20211206
i386                 randconfig-a002-20211206
i386                 randconfig-a003-20211206
i386                 randconfig-a006-20211206
i386                 randconfig-a004-20211206
hexagon              randconfig-r045-20211206
hexagon              randconfig-r041-20211206

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
