Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26CAC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 28 Oct 2021 15:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA3E61038
	for <linux-serial@archiver.kernel.org>; Thu, 28 Oct 2021 15:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhJ1PIO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 Oct 2021 11:08:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:51809 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230265AbhJ1PIO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Oct 2021 11:08:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="210500193"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="210500193"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 08:05:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="498436991"
Received: from lkp-server01.sh.intel.com (HELO 3b851179dbd8) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 28 Oct 2021 08:05:45 -0700
Received: from kbuild by 3b851179dbd8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mg6yO-0002FF-HT; Thu, 28 Oct 2021 15:05:44 +0000
Date:   Thu, 28 Oct 2021 23:05:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 73a3d4f41886e6bd27f8b09c6235539a586e5131
Message-ID: <617abc2b.mloTv/B/xMA8piRZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 73a3d4f41886e6bd27f8b09c6235539a586e5131  tty: rpmsg: Define tty name via constant string literal

elapsed time: 2735m

configs tested: 156
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
mips                 randconfig-c004-20211027
i386                 randconfig-c001-20211027
sh                      rts7751r2d1_defconfig
xtensa                    smp_lx200_defconfig
mips                          malta_defconfig
powerpc                     skiroot_defconfig
arm                            zeus_defconfig
powerpc                     pq2fads_defconfig
arm                        mvebu_v5_defconfig
sh                          r7785rp_defconfig
arm                           stm32_defconfig
arm                          pxa168_defconfig
mips                         cobalt_defconfig
mips                     loongson2k_defconfig
arc                 nsimosci_hs_smp_defconfig
sparc                       sparc64_defconfig
arm                        cerfcube_defconfig
powerpc                   currituck_defconfig
arm                         nhk8815_defconfig
arm                         shannon_defconfig
mips                         tb0287_defconfig
sh                                  defconfig
arc                              alldefconfig
mips                           ip32_defconfig
mips                      loongson3_defconfig
powerpc                       ebony_defconfig
mips                malta_qemu_32r6_defconfig
arm                          pcm027_defconfig
arm                         lpc32xx_defconfig
arm                          badge4_defconfig
mips                           ip27_defconfig
powerpc                 mpc8560_ads_defconfig
arm                     am200epdkit_defconfig
powerpc                        icon_defconfig
sh                           se7780_defconfig
arm                         s3c6400_defconfig
powerpc                      ppc40x_defconfig
arm                         at91_dt_defconfig
mips                  maltasmvp_eva_defconfig
m68k                          amiga_defconfig
mips                      bmips_stb_defconfig
powerpc                 mpc8315_rdb_defconfig
m68k                          multi_defconfig
arm                        clps711x_defconfig
powerpc                      ppc44x_defconfig
sh                           se7721_defconfig
powerpc                     akebono_defconfig
powerpc                      tqm8xx_defconfig
openrisc                            defconfig
arc                            hsdk_defconfig
mips                       lemote2f_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                        mvme16x_defconfig
microblaze                      mmu_defconfig
mips                     cu1830-neo_defconfig
mips                          rm200_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                  randconfig-c002-20211027
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20211028
x86_64               randconfig-a004-20211028
x86_64               randconfig-a005-20211028
x86_64               randconfig-a001-20211028
x86_64               randconfig-a006-20211028
x86_64               randconfig-a003-20211028
x86_64               randconfig-a013-20211027
x86_64               randconfig-a015-20211027
x86_64               randconfig-a011-20211027
x86_64               randconfig-a014-20211027
x86_64               randconfig-a016-20211027
x86_64               randconfig-a012-20211027
i386                 randconfig-a012-20211027
i386                 randconfig-a013-20211027
i386                 randconfig-a011-20211027
i386                 randconfig-a016-20211027
i386                 randconfig-a015-20211027
i386                 randconfig-a014-20211027
arc                  randconfig-r043-20211027
s390                 randconfig-r044-20211027
riscv                randconfig-r042-20211027
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20211027
powerpc              randconfig-c003-20211027
arm                  randconfig-c002-20211027
mips                 randconfig-c004-20211027
x86_64               randconfig-c007-20211027
i386                 randconfig-c001-20211027
s390                 randconfig-c005-20211027
x86_64               randconfig-a002-20211027
x86_64               randconfig-a004-20211027
x86_64               randconfig-a005-20211027
x86_64               randconfig-a006-20211027
x86_64               randconfig-a001-20211027
x86_64               randconfig-a003-20211027
i386                 randconfig-a003-20211027
i386                 randconfig-a004-20211027
i386                 randconfig-a002-20211027
i386                 randconfig-a005-20211027
i386                 randconfig-a001-20211027
i386                 randconfig-a006-20211027
x86_64               randconfig-a015-20211028
x86_64               randconfig-a013-20211028
x86_64               randconfig-a011-20211028
x86_64               randconfig-a014-20211028
x86_64               randconfig-a012-20211028
x86_64               randconfig-a016-20211028
hexagon              randconfig-r045-20211027
hexagon              randconfig-r041-20211027

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
