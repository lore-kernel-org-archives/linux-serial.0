Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E54C433F5
	for <linux-serial@archiver.kernel.org>; Tue,  1 Mar 2022 14:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbiCAO4a (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Mar 2022 09:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiCAO43 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Mar 2022 09:56:29 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D23A2533
        for <linux-serial@vger.kernel.org>; Tue,  1 Mar 2022 06:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646146548; x=1677682548;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uUYxtn07RM2Vn35oeakyYhNoaiITUe85Y88WybDD4Eo=;
  b=Fhzp9d+hsbAxydiTL0AAaOAgf4P80GO3dXvU2bFBo+MG2QE/ZUupMPR7
   8uN/ceqBhH1hPcxwMkubWyNON5nmcIqdSZdC59zx+GiIQZOLP6KMHyizs
   KlRc94MlkP0PdCgFSh6a796+HNvQjzc5e6tS+a0BZaCn0kRNrdRuw/gHO
   ueZNHxTrkqqSTzwG2yZVb8FT57ndRFyeINPR9xpnxPghL1Jpz0RtqKXrq
   H1AMjEZ1YikxE94dD9c1I15jcZNQxA8kMZZjHlekBrY0ZYqEWSOtgkCHG
   9LznpPRNHs7qmhP0vWlyouY8VlQyAXOa9n6Anlzr4Rbl0RFobXIB8aLXv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="252878845"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="252878845"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 06:55:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="493132006"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Mar 2022 06:55:46 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP3uk-0000af-5t; Tue, 01 Mar 2022 14:55:46 +0000
Date:   Tue, 01 Mar 2022 22:55:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD REGRESSION
 31979060cc07600b250d5837a33dae1beacfeb74
Message-ID: <621e33db.SIHY4BPovq0ylV1r%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 31979060cc07600b250d5837a33dae1beacfeb74  tty: serial: meson: Fix the compile link error reported by kernel test robot

Error/Warning reports:

https://lore.kernel.org/linux-serial/202202270135.XFr12qec-lkp@intel.com

Error/Warning:

drivers/tty/serial/sunplus-uart.c:574:28: error: 'sunplus_uart_console' undeclared here (not in a function); did you mean 'sunplus_uart_ops'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- openrisc-randconfig-r002-20220301
|   `-- drivers-tty-serial-sunplus-uart.c:error:sunplus_uart_console-undeclared-here-(not-in-a-function)
`-- sparc-randconfig-r033-20220301
    `-- drivers-tty-serial-sunplus-uart.c:error:sunplus_uart_console-undeclared-here-(not-in-a-function)

elapsed time: 819m

configs tested: 113
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
arm64                               defconfig
i386                          randconfig-c001
parisc                              defconfig
arc                 nsimosci_hs_smp_defconfig
mips                             allyesconfig
sh                           sh2007_defconfig
sh                            hp6xx_defconfig
arm                        trizeps4_defconfig
arm                        cerfcube_defconfig
arm                       omap2plus_defconfig
arm                       multi_v4t_defconfig
mips                     decstation_defconfig
arm                        realview_defconfig
h8300                    h8300h-sim_defconfig
arm                         vf610m4_defconfig
powerpc                       eiger_defconfig
sh                           se7712_defconfig
sh                     magicpanelr2_defconfig
arm                  randconfig-c002-20220228
arm                  randconfig-c002-20220227
arm                  randconfig-c002-20220301
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
sparc                               defconfig
sparc                            allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64               randconfig-a011-20220228
x86_64               randconfig-a013-20220228
x86_64               randconfig-a014-20220228
x86_64               randconfig-a012-20220228
x86_64               randconfig-a015-20220228
x86_64               randconfig-a016-20220228
i386                 randconfig-a011-20220228
i386                 randconfig-a012-20220228
i386                 randconfig-a013-20220228
i386                 randconfig-a014-20220228
i386                 randconfig-a015-20220228
i386                 randconfig-a016-20220228
arc                  randconfig-r043-20220301
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
powerpc                       ebony_defconfig
mips                          rm200_defconfig
powerpc                    ge_imp3a_defconfig
arm                        multi_v5_defconfig
arm                           spitz_defconfig
powerpc                        fsp2_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                 randconfig-a002-20220228
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220301
hexagon              randconfig-r041-20220301
s390                 randconfig-r044-20220301
riscv                randconfig-r042-20220301

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
