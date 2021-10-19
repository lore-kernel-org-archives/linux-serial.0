Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C62C433FE
	for <linux-serial@archiver.kernel.org>; Tue, 19 Oct 2021 03:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFF256134F
	for <linux-serial@archiver.kernel.org>; Tue, 19 Oct 2021 03:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhJSD0C (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Oct 2021 23:26:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:35783 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229742AbhJSD0B (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Oct 2021 23:26:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="225874603"
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="225874603"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 20:23:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="661634906"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Oct 2021 20:23:48 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mcfj9-000Bza-Dn; Tue, 19 Oct 2021 03:23:47 +0000
Date:   Tue, 19 Oct 2021 11:23:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 3968ddcf05fb4b9409cd1859feb06a5b0550a1c1
Message-ID: <616e3a2f.H66p29PUFlxrwWyI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 3968ddcf05fb4b9409cd1859feb06a5b0550a1c1  tty: tty_buffer: Fix the softlockup issue in flush_to_ldisc

elapsed time: 729m

configs tested: 152
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211019
powerpc                    adder875_defconfig
powerpc                      walnut_defconfig
arc                        nsim_700_defconfig
sparc                       sparc64_defconfig
powerpc                     tqm8548_defconfig
powerpc                   bluestone_defconfig
powerpc                      acadia_defconfig
ia64                         bigsur_defconfig
arm                       multi_v4t_defconfig
arm                      jornada720_defconfig
arm                         axm55xx_defconfig
arm                            qcom_defconfig
arm64                            alldefconfig
arm                        multi_v5_defconfig
mips                          ath79_defconfig
powerpc                     powernv_defconfig
openrisc                            defconfig
sh                   secureedge5410_defconfig
powerpc                       ppc64_defconfig
arm                         palmz72_defconfig
arm                         nhk8815_defconfig
sh                          urquell_defconfig
sh                          sdk7780_defconfig
x86_64                              defconfig
openrisc                    or1ksim_defconfig
arm                        spear3xx_defconfig
riscv                               defconfig
sparc                               defconfig
powerpc                     pseries_defconfig
mips                       capcella_defconfig
arm                         assabet_defconfig
powerpc                     kilauea_defconfig
arm                         vf610m4_defconfig
m68k                        mvme147_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                            dove_defconfig
sh                     magicpanelr2_defconfig
riscv                          rv32_defconfig
powerpc                      makalu_defconfig
powerpc                 mpc85xx_cds_defconfig
s390                       zfcpdump_defconfig
arc                        vdk_hs38_defconfig
m68k                            q40_defconfig
powerpc                 linkstation_defconfig
arm                        keystone_defconfig
arc                    vdk_hs38_smp_defconfig
arm                        neponset_defconfig
powerpc                           allnoconfig
mips                           ip28_defconfig
sh                          rsk7264_defconfig
powerpc                      mgcoge_defconfig
arm                           u8500_defconfig
powerpc64                        alldefconfig
mips                           rs90_defconfig
m68k                       bvme6000_defconfig
h8300                            alldefconfig
mips                            e55_defconfig
powerpc                      pasemi_defconfig
powerpc               mpc834x_itxgp_defconfig
ia64                            zx1_defconfig
m68k                        m5307c3_defconfig
m68k                        m5407c3_defconfig
arm                           sunxi_defconfig
sh                ecovec24-romimage_defconfig
arm                       cns3420vb_defconfig
powerpc                          g5_defconfig
powerpc                       holly_defconfig
arm                      integrator_defconfig
arm                           corgi_defconfig
arm                        realview_defconfig
powerpc                  storcenter_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                  randconfig-c002-20211019
x86_64               randconfig-c001-20211019
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nios2                            allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a015-20211019
x86_64               randconfig-a012-20211019
x86_64               randconfig-a016-20211019
x86_64               randconfig-a014-20211019
x86_64               randconfig-a013-20211019
x86_64               randconfig-a011-20211019
i386                 randconfig-a014-20211019
i386                 randconfig-a016-20211019
i386                 randconfig-a011-20211019
i386                 randconfig-a015-20211019
i386                 randconfig-a012-20211019
i386                 randconfig-a013-20211019
riscv                    nommu_virt_defconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
arm                  randconfig-c002-20211019
mips                 randconfig-c004-20211019
i386                 randconfig-c001-20211019
s390                 randconfig-c005-20211019
x86_64               randconfig-c007-20211019
riscv                randconfig-c006-20211019
powerpc              randconfig-c003-20211019
x86_64               randconfig-a004-20211019
x86_64               randconfig-a006-20211019
x86_64               randconfig-a005-20211019
x86_64               randconfig-a001-20211019
x86_64               randconfig-a002-20211019
x86_64               randconfig-a003-20211019
i386                 randconfig-a001-20211019
i386                 randconfig-a003-20211019
i386                 randconfig-a004-20211019
i386                 randconfig-a005-20211019
i386                 randconfig-a002-20211019
i386                 randconfig-a006-20211019
hexagon              randconfig-r041-20211019
hexagon              randconfig-r045-20211019

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
