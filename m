Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4B1C433F5
	for <linux-serial@archiver.kernel.org>; Tue,  1 Mar 2022 09:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiCAJXu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiCAJXt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Mar 2022 04:23:49 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C7FE093
        for <linux-serial@vger.kernel.org>; Tue,  1 Mar 2022 01:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646126589; x=1677662589;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JQU46pUoKuyZV6aqr+C0H64uxqETEJwZMMLBWcU2f9k=;
  b=dOvMm1Rt1NBdBHmh8YGeYUYYU44KsCNms67ScjhHKAfv3nx7FBZU17Pr
   JuxsNyVOpLUwqW1uIFzXEvi3srdAlLkHffaKU0xBSOo6CenfumzjkqcKf
   Ts5I4R+08Gkur/G3Xx5oZJATmWZVfvYhwYwTS+Oxo3Msgg6RdBQKrwFoI
   +dEeN94wYZzbveF4MUNO3qlqfpoae8avP/H+u2caHHeXAKFjIqXr6trgH
   QlNlwdPoXHvfSIzmM4Cd5RpVI6TWDs/D0254ZnLQZNECFRxUcMs4WPsdA
   l9LBlqGfJv40G7eo2sFKHMVeM7fOEV8CLDf7OGfM26ai32RQ7TnMcY7AJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="252828958"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="252828958"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 01:23:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="778387768"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Mar 2022 01:23:07 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOyio-0000E0-T3; Tue, 01 Mar 2022 09:23:06 +0000
Date:   Tue, 01 Mar 2022 17:22:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-next] BUILD REGRESSION
 d4ab5487cc77a4053dc9070c5761ad94bf397825
Message-ID: <621de5dd.jutTih0Uk3mLyqXL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
branch HEAD: d4ab5487cc77a4053dc9070c5761ad94bf397825  Merge 5.17-rc6 into tty-next

Error/Warning:

drivers/tty/serial/sunplus-uart.c:574:28: error: 'sunplus_uart_console' undeclared here (not in a function); did you mean 'sunplus_uart_ops'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- mips-randconfig-c023-20220227
    `-- drivers-tty-serial-sunplus-uart.c:error:sunplus_uart_console-undeclared-here-(not-in-a-function)

elapsed time: 720m

configs tested: 130
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
arc                        vdk_hs38_defconfig
powerpc                      pasemi_defconfig
m68k                       m5249evb_defconfig
parisc                              defconfig
arc                 nsimosci_hs_smp_defconfig
mips                             allyesconfig
h8300                       h8s-sim_defconfig
nios2                         10m50_defconfig
mips                           jazz_defconfig
parisc                generic-32bit_defconfig
powerpc                      bamboo_defconfig
sh                          landisk_defconfig
sh                          r7785rp_defconfig
arc                            hsdk_defconfig
sh                          sdk7780_defconfig
microblaze                      mmu_defconfig
sh                           se7724_defconfig
arm                            pleb_defconfig
sh                          r7780mp_defconfig
arm                          pxa3xx_defconfig
m68k                        m5307c3_defconfig
m68k                          multi_defconfig
sh                               alldefconfig
powerpc                   motionpro_defconfig
powerpc                      ppc6xx_defconfig
arc                          axs103_defconfig
arm                  randconfig-c002-20220228
arm                  randconfig-c002-20220227
arm                  randconfig-c002-20220301
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a011-20220228
x86_64               randconfig-a015-20220228
x86_64               randconfig-a014-20220228
x86_64               randconfig-a013-20220228
x86_64               randconfig-a016-20220228
x86_64               randconfig-a012-20220228
i386                 randconfig-a016-20220228
i386                 randconfig-a012-20220228
i386                 randconfig-a015-20220228
i386                 randconfig-a011-20220228
i386                 randconfig-a013-20220228
i386                 randconfig-a014-20220228
arc                  randconfig-r043-20220227
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
powerpc                          allyesconfig
riscv                    nommu_virt_defconfig
powerpc                     powernv_defconfig
mips                           rs90_defconfig
mips                           mtx1_defconfig
powerpc                     pseries_defconfig
powerpc                     tqm8560_defconfig
riscv                          rv32_defconfig
arm                        mvebu_v5_defconfig
mips                           ip28_defconfig
arm                          imote2_defconfig
arm                       versatile_defconfig
powerpc                   lite5200b_defconfig
mips                           ip22_defconfig
x86_64               randconfig-a003-20220228
x86_64               randconfig-a005-20220228
x86_64               randconfig-a002-20220228
x86_64               randconfig-a006-20220228
x86_64               randconfig-a001-20220228
x86_64               randconfig-a004-20220228
i386                 randconfig-a002-20220228
i386                 randconfig-a001-20220228
i386                 randconfig-a005-20220228
i386                 randconfig-a003-20220228
i386                 randconfig-a006-20220228
i386                 randconfig-a004-20220228
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220301
hexagon              randconfig-r041-20220301
riscv                randconfig-r042-20220301
hexagon              randconfig-r045-20220227
hexagon              randconfig-r041-20220227
s390                 randconfig-r044-20220227
riscv                randconfig-r042-20220227

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
