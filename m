Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B32C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 31 Jan 2022 05:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiAaF5L (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 31 Jan 2022 00:57:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:20507 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232528AbiAaF5L (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 31 Jan 2022 00:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643608631; x=1675144631;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lSwt5o6nGQq7KjA5UzeBkwM7leZgiiM5rsl5nKtmTss=;
  b=iUG6RKFKFNWIGyPa+H4sG7IEXWItpa7fHV6BqmnysyOR1AIP8VimvKEj
   aYcqcJeY5DzzOvM+2X1NCAB2iXIAAJuh0qckXkNEz9P6agbgHvVKCjMrO
   B/GV9WwM2fiiH9gsFYEc7iUc8JJZY3RlnAJ6jQ7HvgrquCevWtRp2/A5D
   /L7QkaCAvtZIwMD8A0hWDfSDdcUtOlo/yiquH0cEsCVhnqj/xLHaNvXYZ
   c8t1le9k5AmKvVxQ+5DqjQ1ZErPQfZJ0/y5l4ZmHdEDmGE05jeev+6MKH
   hCoSxOFzdOiXr8mWF3H0I3wGqQ6G8c3gb+cJurpAgpmMfMkQUHB34Yxjm
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="228068236"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="228068236"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 21:57:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="478970053"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 Jan 2022 21:57:09 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEPga-000RTM-C3; Mon, 31 Jan 2022 05:57:08 +0000
Date:   Mon, 31 Jan 2022 13:56:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 4c6123873a42dc5144e4c53bb8376c14fc92336d
Message-ID: <61f77a25./mGy+rwWhXeefp72%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 4c6123873a42dc5144e4c53bb8376c14fc92336d  Merge tag 'v5.17-rc2' into tty-next

elapsed time: 727m

configs tested: 152
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
i386                 randconfig-c001-20220131
i386                          randconfig-c001
arm                           stm32_defconfig
sparc                       sparc32_defconfig
h8300                               defconfig
sh                        edosk7705_defconfig
sh                 kfr2r09-romimage_defconfig
arm                        spear6xx_defconfig
mips                       capcella_defconfig
sh                          polaris_defconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                       m5208evb_defconfig
powerpc                  storcenter_defconfig
arm                             pxa_defconfig
arm                           sama5_defconfig
arc                 nsimosci_hs_smp_defconfig
riscv                            allyesconfig
sh                        apsh4ad0a_defconfig
mips                 decstation_r4k_defconfig
arm                          pxa3xx_defconfig
nds32                               defconfig
powerpc                      mgcoge_defconfig
m68k                        m5272c3_defconfig
powerpc64                        alldefconfig
arc                      axs103_smp_defconfig
powerpc                 linkstation_defconfig
arm                            xcep_defconfig
m68k                        mvme147_defconfig
riscv                    nommu_k210_defconfig
xtensa                         virt_defconfig
arc                            hsdk_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                         cobalt_defconfig
m68k                       m5475evb_defconfig
riscv                            allmodconfig
h8300                     edosk2674_defconfig
sh                           se7206_defconfig
powerpc                      pasemi_defconfig
arc                    vdk_hs38_smp_defconfig
mips                         bigsur_defconfig
mips                            gpr_defconfig
mips                        vocore2_defconfig
powerpc                     redwood_defconfig
sh                            hp6xx_defconfig
powerpc                       ppc64_defconfig
sh                            migor_defconfig
sh                        sh7757lcr_defconfig
powerpc                      ep88xc_defconfig
arc                          axs103_defconfig
xtensa                           allyesconfig
sh                        edosk7760_defconfig
m68k                         amcore_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
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
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220130
arc                  randconfig-r043-20220130
s390                 randconfig-r044-20220130
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220130
x86_64                        randconfig-c007
arm                  randconfig-c002-20220130
powerpc              randconfig-c003-20220130
mips                 randconfig-c004-20220130
i386                          randconfig-c001
mips                     loongson2k_defconfig
powerpc               mpc834x_itxgp_defconfig
riscv                             allnoconfig
powerpc                   bluestone_defconfig
powerpc                     tqm8560_defconfig
powerpc                      ppc44x_defconfig
powerpc                    ge_imp3a_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a013-20220131
x86_64               randconfig-a015-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
i386                 randconfig-a011-20220131
i386                 randconfig-a013-20220131
i386                 randconfig-a014-20220131
i386                 randconfig-a012-20220131
i386                 randconfig-a015-20220131
i386                 randconfig-a016-20220131
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
