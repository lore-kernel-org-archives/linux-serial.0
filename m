Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E04C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 20 Dec 2021 22:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhLTWV1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Dec 2021 17:21:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:2844 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230391AbhLTWV1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Dec 2021 17:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640038887; x=1671574887;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OO1CIGv2vCQpr7qbodB94VI0aaR0M5+35o3BtyGLTGY=;
  b=QCvwRI09EnMWJ5EEVQ3IFjUWKPnzgZbHQhuTCCJ/qKw2OADd8RI5DEPe
   q1JgpIFBw1YVSdHDLCpW9oB3Futi9FgA8SwtA7Ypc9aqwaqslvXTauNU0
   g24AbD5j83FMWf8ricO7Y5batuu0aEK62tTe6PQ3lDTBsi0pmjdgRRTZm
   E42de5ukXtUJ1nyi489Js7X7aM4AKW/bBefTuNTAcrAbtl4DLN+hA9JuM
   71xouP6Q7FKNkfZSdFG9dhs0vN+JikpxPq9hcnbGO60wo0ry5MPvM6tsb
   tqn18OEV7Axq73POOZPlfFBnt+lD0WbrQ2MhkawdV+VdyU3LJD/X1k3Bq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="227133480"
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="227133480"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 14:21:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="507848681"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 20 Dec 2021 14:21:25 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzR24-0008Jl-Oa; Mon, 20 Dec 2021 22:21:24 +0000
Date:   Tue, 21 Dec 2021 06:20:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-next] BUILD SUCCESS
 35eaa42c4a1017c08d0572008db375becb621744
Message-ID: <61c101c3.j3vjWMZjJCY9PKh5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
branch HEAD: 35eaa42c4a1017c08d0572008db375becb621744  Merge 5.16-rc6 into tty-next

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
powerpc                       maple_defconfig
arm                       imx_v4_v5_defconfig
sh                           se7712_defconfig
arm                        vexpress_defconfig
mips                       bmips_be_defconfig
mips                             allmodconfig
mips                     cu1830-neo_defconfig
sparc                       sparc32_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                     sequoia_defconfig
arm                        cerfcube_defconfig
h8300                    h8300h-sim_defconfig
xtensa                              defconfig
arm                       spear13xx_defconfig
powerpc                      ep88xc_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                          iop32x_defconfig
arm                         s3c2410_defconfig
powerpc                      chrp32_defconfig
csky                                defconfig
parisc                           allyesconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                       ebony_defconfig
sh                          sdk7780_defconfig
m68k                        mvme16x_defconfig
powerpc                     kilauea_defconfig
powerpc                 mpc832x_mds_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                 canyonlands_defconfig
powerpc                      ppc44x_defconfig
powerpc                           allnoconfig
powerpc                     tqm8541_defconfig
m68k                             alldefconfig
sh                          urquell_defconfig
sh                             shx3_defconfig
openrisc                  or1klitex_defconfig
powerpc                     tqm5200_defconfig
arm                           omap1_defconfig
arm                     davinci_all_defconfig
sh                          rsk7269_defconfig
arm                            mmp2_defconfig
h8300                            alldefconfig
arm                         hackkit_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                             sh03_defconfig
parisc                generic-64bit_defconfig
powerpc                       eiger_defconfig
sh                            hp6xx_defconfig
sh                           se7750_defconfig
arm                         lubbock_defconfig
alpha                               defconfig
powerpc                   currituck_defconfig
arm                          exynos_defconfig
sh                     magicpanelr2_defconfig
arm                        clps711x_defconfig
arm                             rpc_defconfig
m68k                        m5272c3_defconfig
mips                            e55_defconfig
mips                           ci20_defconfig
sh                           se7705_defconfig
mips                      pic32mzda_defconfig
arm                       versatile_defconfig
arm                        neponset_defconfig
nios2                         3c120_defconfig
powerpc                 mpc834x_itx_defconfig
um                             i386_defconfig
powerpc                      pmac32_defconfig
arm                  randconfig-c002-20211220
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a001-20211220
x86_64               randconfig-a003-20211220
x86_64               randconfig-a006-20211220
x86_64               randconfig-a004-20211220
x86_64               randconfig-a002-20211220
x86_64               randconfig-a005-20211220
i386                 randconfig-a004-20211220
i386                 randconfig-a002-20211220
i386                 randconfig-a003-20211220
i386                 randconfig-a005-20211220
i386                 randconfig-a006-20211220
i386                 randconfig-a001-20211220
i386                 randconfig-a013-20211219
i386                 randconfig-a011-20211219
i386                 randconfig-a016-20211219
i386                 randconfig-a015-20211219
i386                 randconfig-a014-20211219
i386                 randconfig-a012-20211219
arc                  randconfig-r043-20211220
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig

clang tested configs:
x86_64               randconfig-a015-20211220
x86_64               randconfig-a014-20211220
x86_64               randconfig-a012-20211220
x86_64               randconfig-a011-20211220
x86_64               randconfig-a016-20211220
x86_64               randconfig-a013-20211220
i386                 randconfig-a012-20211220
i386                 randconfig-a011-20211220
i386                 randconfig-a014-20211220
i386                 randconfig-a013-20211220
i386                 randconfig-a015-20211220
i386                 randconfig-a016-20211220
s390                 randconfig-r044-20211220
hexagon              randconfig-r041-20211220
hexagon              randconfig-r045-20211220
riscv                randconfig-r042-20211220

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
