Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58652C4338F
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 07:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BD3061054
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 07:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbhG2HDL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Jul 2021 03:03:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:59110 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234312AbhG2HDK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Jul 2021 03:03:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="199997199"
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="199997199"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 00:03:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="666272447"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jul 2021 00:03:06 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m904P-0008xS-Bn; Thu, 29 Jul 2021 07:03:05 +0000
Date:   Thu, 29 Jul 2021 15:02:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 ccd1c4d7947907b723a5d43d61383578c2f130b6
Message-ID: <6102529b.hPeUBe1rjNHLKZBX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: ccd1c4d7947907b723a5d43d61383578c2f130b6  Revert "v253_init: eliminate pointer to string"

elapsed time: 724m

configs tested: 123
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210728
arc                        vdk_hs38_defconfig
ia64                          tiger_defconfig
arc                           tb10x_defconfig
sparc                       sparc32_defconfig
h8300                            alldefconfig
arm                        multi_v7_defconfig
powerpc                         ps3_defconfig
powerpc                      chrp32_defconfig
sparc64                          alldefconfig
mips                       rbtx49xx_defconfig
m68k                            mac_defconfig
sh                     sh7710voipgw_defconfig
xtensa                generic_kc705_defconfig
parisc                           alldefconfig
sh                             espt_defconfig
powerpc                       holly_defconfig
arm                        neponset_defconfig
mips                           ip28_defconfig
arm                       aspeed_g5_defconfig
powerpc                        icon_defconfig
powerpc                       ebony_defconfig
mips                           mtx1_defconfig
arm                          simpad_defconfig
nds32                             allnoconfig
sh                          r7780mp_defconfig
mips                     cu1000-neo_defconfig
um                                  defconfig
mips                      maltasmvp_defconfig
mips                  cavium_octeon_defconfig
sh                          rsk7269_defconfig
m68k                       m5249evb_defconfig
sh                           sh2007_defconfig
sh                          urquell_defconfig
arm                            mmp2_defconfig
powerpc                      katmai_defconfig
x86_64                              defconfig
mips                     cu1830-neo_defconfig
xtensa                    xip_kc705_defconfig
m68k                       m5208evb_defconfig
xtensa                          iss_defconfig
arm                          pxa910_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210728
x86_64               randconfig-a003-20210728
x86_64               randconfig-a001-20210728
x86_64               randconfig-a004-20210728
x86_64               randconfig-a005-20210728
x86_64               randconfig-a002-20210728
i386                 randconfig-a005-20210728
i386                 randconfig-a003-20210728
i386                 randconfig-a004-20210728
i386                 randconfig-a002-20210728
i386                 randconfig-a001-20210728
i386                 randconfig-a006-20210728
x86_64               randconfig-a016-20210729
x86_64               randconfig-a011-20210729
x86_64               randconfig-a014-20210729
x86_64               randconfig-a013-20210729
x86_64               randconfig-a012-20210729
x86_64               randconfig-a015-20210729
i386                 randconfig-a016-20210728
i386                 randconfig-a012-20210728
i386                 randconfig-a013-20210728
i386                 randconfig-a014-20210728
i386                 randconfig-a011-20210728
i386                 randconfig-a015-20210728
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
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210728
x86_64               randconfig-a016-20210728
x86_64               randconfig-a011-20210728
x86_64               randconfig-a014-20210728
x86_64               randconfig-a013-20210728
x86_64               randconfig-a012-20210728
x86_64               randconfig-a015-20210728

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
