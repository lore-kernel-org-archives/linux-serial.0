Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9924DC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 17:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726A5613CD
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 17:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhI2Rbs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Sep 2021 13:31:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:28430 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233556AbhI2Rbs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Sep 2021 13:31:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="310546534"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="310546534"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 10:30:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="708451608"
Received: from lkp-server02.sh.intel.com (HELO f7acefbbae94) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 29 Sep 2021 10:30:05 -0700
Received: from kbuild by f7acefbbae94 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mVdPA-00030N-DQ; Wed, 29 Sep 2021 17:30:04 +0000
Date:   Thu, 30 Sep 2021 01:29:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 5ecb11dd892f443d4900292edaba88a26efee8fe
Message-ID: <6154a27c.Uhm/EQLWiXTZ3olf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 5ecb11dd892f443d4900292edaba88a26efee8fe  Merge 5.15-rc3 into tty-next

elapsed time: 1081m

configs tested: 229
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210928
i386                 randconfig-c001-20210929
i386                 randconfig-c001-20210927
powerpc                    amigaone_defconfig
powerpc                     ksi8560_defconfig
powerpc                    sam440ep_defconfig
sh                          rsk7203_defconfig
powerpc                       ebony_defconfig
mips                            ar7_defconfig
xtensa                    smp_lx200_defconfig
arm                          iop32x_defconfig
powerpc                       ppc64_defconfig
ia64                      gensparse_defconfig
powerpc                      pmac32_defconfig
powerpc                 mpc8560_ads_defconfig
m68k                            mac_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                         bigsur_defconfig
arm                          collie_defconfig
sh                         ap325rxa_defconfig
powerpc                      mgcoge_defconfig
riscv                            allyesconfig
mips                       lemote2f_defconfig
sh                        sh7757lcr_defconfig
mips                      fuloong2e_defconfig
sh                        edosk7760_defconfig
mips                        maltaup_defconfig
powerpc                       holly_defconfig
arm                      footbridge_defconfig
um                                  defconfig
arc                          axs101_defconfig
xtensa                    xip_kc705_defconfig
ia64                          tiger_defconfig
arm                           spitz_defconfig
mips                        bcm47xx_defconfig
sh                          lboxre2_defconfig
mips                     decstation_defconfig
arm                         s5pv210_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                     skiroot_defconfig
ia64                                defconfig
powerpc                     tqm8555_defconfig
powerpc                   microwatt_defconfig
microblaze                          defconfig
sh                           se7722_defconfig
arm                            pleb_defconfig
arm                          ep93xx_defconfig
arm                     am200epdkit_defconfig
mips                      maltasmvp_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                       imx_v4_v5_defconfig
powerpc                     tqm8541_defconfig
powerpc                 linkstation_defconfig
sh                        sh7763rdp_defconfig
arm                           sama7_defconfig
powerpc                     tqm8560_defconfig
h8300                       h8s-sim_defconfig
arm                         hackkit_defconfig
powerpc                     asp8347_defconfig
mips                        jmr3927_defconfig
sparc                       sparc32_defconfig
nds32                               defconfig
powerpc                      ep88xc_defconfig
m68k                          atari_defconfig
mips                           ip32_defconfig
arc                        nsimosci_defconfig
arm                         bcm2835_defconfig
powerpc                     ep8248e_defconfig
m68k                       bvme6000_defconfig
sh                           se7721_defconfig
mips                     loongson1c_defconfig
mips                         mpc30x_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                          g5_defconfig
sh                            hp6xx_defconfig
arm                       spear13xx_defconfig
arc                        nsim_700_defconfig
arm                           tegra_defconfig
h8300                     edosk2674_defconfig
m68k                            q40_defconfig
arm                            mmp2_defconfig
openrisc                 simple_smp_defconfig
riscv                            alldefconfig
sparc64                             defconfig
arm                            hisi_defconfig
powerpc                     kilauea_defconfig
arm                        keystone_defconfig
arm                        mvebu_v7_defconfig
mips                            gpr_defconfig
mips                   sb1250_swarm_defconfig
sh                           se7750_defconfig
parisc                           alldefconfig
sh                          kfr2r09_defconfig
arm                          simpad_defconfig
arm                        spear6xx_defconfig
m68k                        mvme16x_defconfig
arm                         assabet_defconfig
sh                           sh2007_defconfig
arm                          ixp4xx_defconfig
sh                          urquell_defconfig
mips                           ip27_defconfig
sh                          r7780mp_defconfig
m68k                        m5272c3_defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                         amcore_defconfig
powerpc                    gamecube_defconfig
sh                             shx3_defconfig
microblaze                      mmu_defconfig
s390                          debug_defconfig
nios2                         10m50_defconfig
powerpc                     taishan_defconfig
ia64                             alldefconfig
sh                           se7751_defconfig
powerpc                     tqm5200_defconfig
sh                          sdk7780_defconfig
arm                             ezx_defconfig
x86_64               randconfig-c001-20210928
arm                  randconfig-c002-20210928
x86_64               randconfig-c001-20210929
arm                  randconfig-c002-20210929
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
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
x86_64               randconfig-a002-20210929
x86_64               randconfig-a005-20210929
x86_64               randconfig-a001-20210929
x86_64               randconfig-a006-20210929
x86_64               randconfig-a003-20210929
x86_64               randconfig-a004-20210929
i386                 randconfig-a001-20210929
i386                 randconfig-a005-20210929
i386                 randconfig-a002-20210929
i386                 randconfig-a006-20210929
i386                 randconfig-a004-20210929
i386                 randconfig-a003-20210929
x86_64               randconfig-a014-20210928
x86_64               randconfig-a011-20210928
x86_64               randconfig-a013-20210928
x86_64               randconfig-a012-20210928
x86_64               randconfig-a015-20210928
x86_64               randconfig-a016-20210928
i386                 randconfig-a014-20210928
i386                 randconfig-a013-20210928
i386                 randconfig-a016-20210928
i386                 randconfig-a011-20210928
i386                 randconfig-a015-20210928
i386                 randconfig-a012-20210928
arc                  randconfig-r043-20210928
riscv                randconfig-r042-20210928
s390                 randconfig-r044-20210928
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
powerpc              randconfig-c003-20210929
mips                 randconfig-c004-20210929
arm                  randconfig-c002-20210929
x86_64               randconfig-c007-20210929
riscv                randconfig-c006-20210929
s390                 randconfig-c005-20210929
i386                 randconfig-c001-20210929
x86_64               randconfig-a002-20210928
x86_64               randconfig-a005-20210928
x86_64               randconfig-a001-20210928
x86_64               randconfig-a006-20210928
x86_64               randconfig-a003-20210928
x86_64               randconfig-a004-20210928
i386                 randconfig-a001-20210928
i386                 randconfig-a005-20210928
i386                 randconfig-a002-20210928
i386                 randconfig-a006-20210928
i386                 randconfig-a004-20210928
i386                 randconfig-a003-20210928
x86_64               randconfig-a014-20210929
x86_64               randconfig-a011-20210929
x86_64               randconfig-a013-20210929
x86_64               randconfig-a015-20210929
x86_64               randconfig-a012-20210929
x86_64               randconfig-a016-20210929
i386                 randconfig-a014-20210929
i386                 randconfig-a013-20210929
i386                 randconfig-a016-20210929
i386                 randconfig-a011-20210929
i386                 randconfig-a015-20210929
i386                 randconfig-a012-20210929
hexagon              randconfig-r045-20210929
riscv                randconfig-r042-20210929
hexagon              randconfig-r041-20210929
s390                 randconfig-r044-20210929

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
