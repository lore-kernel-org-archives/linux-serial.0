Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FE5C433FE
	for <linux-serial@archiver.kernel.org>; Sat,  5 Feb 2022 04:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiBEEoO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Feb 2022 23:44:14 -0500
Received: from mga17.intel.com ([192.55.52.151]:62247 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350454AbiBEEoN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Feb 2022 23:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644036253; x=1675572253;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0PJsLhawry0UlviPLUTtU7cdlZg7LM6jfQa8leUvaBw=;
  b=AI6BZ4J1Ddgc6Vpyo4/2n/Ar+qzNbR9grRugPBPB79qN+ucQurYovWmF
   vq7bEnkkE8eOr/Vsem+KVH66ix7xB6hD7091XrFBLUGC7/yZVMAhdqHF0
   rnszFfGqrhho2s6cVEB2B8L0A2doQwF8zLzjz12L7otCt09ypPv0TAF6n
   oDzEsJb7jhqpOtgeJ219Z7NJVuG6lY04tMKINw2U2D54dWVXrJTAyAopH
   wQC064hx6uJ5O0TxxIaa5P5UGM+bXQTOLSE1GK7uQP9Cs1AFYWOiRVBuH
   LeU2+RFlR51fPCB09IyJgxWn/YpgUIzp4jGzEMEu89XwAgQJmSOji6lJt
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="229138161"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="229138161"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 20:44:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="566944131"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Feb 2022 20:44:11 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGCvi-000YZR-Qj; Sat, 05 Feb 2022 04:44:10 +0000
Date:   Sat, 05 Feb 2022 12:43:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 28cb138f559f8c1a1395f5564f86b8bbee83631b
Message-ID: <61fe0082.GUZgTB3yrBXIVFe2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 28cb138f559f8c1a1395f5564f86b8bbee83631b  vt_ioctl: add array_index_nospec to VT_ACTIVATE

elapsed time: 730m

configs tested: 190
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220131
powerpc              randconfig-c003-20220131
i386                          randconfig-c001
sh                             shx3_defconfig
sh                     sh7710voipgw_defconfig
ia64                             allmodconfig
powerpc                     rainier_defconfig
xtensa                          iss_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                        warp_defconfig
mips                         tb0226_defconfig
um                               alldefconfig
powerpc                        cell_defconfig
mips                 decstation_r4k_defconfig
sh                          r7780mp_defconfig
sh                ecovec24-romimage_defconfig
xtensa                    smp_lx200_defconfig
arm                            hisi_defconfig
arm                           tegra_defconfig
openrisc                  or1klitex_defconfig
sparc64                             defconfig
arc                           tb10x_defconfig
sh                         ap325rxa_defconfig
mips                  maltasmvp_eva_defconfig
mips                         db1xxx_defconfig
arm                       aspeed_g5_defconfig
sh                           se7206_defconfig
sh                             sh03_defconfig
powerpc                      cm5200_defconfig
arm                      footbridge_defconfig
powerpc                      ppc6xx_defconfig
arm                        clps711x_defconfig
sh                          landisk_defconfig
mips                     loongson1b_defconfig
powerpc                      chrp32_defconfig
arm                         lpc18xx_defconfig
powerpc                      ep88xc_defconfig
arm                        mini2440_defconfig
sh                           se7619_defconfig
xtensa                generic_kc705_defconfig
arc                      axs103_smp_defconfig
sh                           se7751_defconfig
openrisc                    or1ksim_defconfig
sh                      rts7751r2d1_defconfig
parisc                generic-64bit_defconfig
sparc64                          alldefconfig
microblaze                      mmu_defconfig
arm                           corgi_defconfig
xtensa                    xip_kc705_defconfig
arc                     nsimosci_hs_defconfig
mips                           gcw0_defconfig
powerpc                    klondike_defconfig
mips                      loongson3_defconfig
xtensa                  cadence_csp_defconfig
m68k                          multi_defconfig
ia64                                defconfig
arm                            zeus_defconfig
powerpc                     redwood_defconfig
sh                              ul2_defconfig
mips                            gpr_defconfig
sh                        sh7757lcr_defconfig
arm                        shmobile_defconfig
m68k                        m5407c3_defconfig
ia64                        generic_defconfig
sh                          polaris_defconfig
sh                           se7780_defconfig
powerpc                 mpc837x_rdb_defconfig
nios2                            allyesconfig
arm                         s3c6400_defconfig
sh                            hp6xx_defconfig
arc                          axs103_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
arm                  randconfig-c002-20220202
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
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
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20220131
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
i386                 randconfig-a006-20220131
i386                 randconfig-a005-20220131
i386                 randconfig-a003-20220131
i386                 randconfig-a002-20220131
i386                 randconfig-a001-20220131
i386                 randconfig-a004-20220131
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
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
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220201
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220201
mips                 randconfig-c004-20220201
i386                          randconfig-c001
arm                  randconfig-c002-20220201
riscv                randconfig-c006-20220130
arm                  randconfig-c002-20220130
powerpc              randconfig-c003-20220130
mips                 randconfig-c004-20220130
mips                         tb0287_defconfig
powerpc                     skiroot_defconfig
powerpc                        icon_defconfig
mips                        bcm63xx_defconfig
powerpc                  mpc866_ads_defconfig
mips                          rm200_defconfig
powerpc                      acadia_defconfig
mips                      maltaaprp_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a013-20220131
x86_64               randconfig-a015-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a011-20220131
i386                 randconfig-a013-20220131
i386                 randconfig-a014-20220131
i386                 randconfig-a012-20220131
i386                 randconfig-a015-20220131
i386                 randconfig-a016-20220131
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220203
hexagon              randconfig-r041-20220203
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
