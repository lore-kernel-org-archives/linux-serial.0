Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48506C433F5
	for <linux-serial@archiver.kernel.org>; Sat,  1 Jan 2022 01:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiAABkX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 31 Dec 2021 20:40:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:61798 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbiAABkX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 Dec 2021 20:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641001223; x=1672537223;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eYG4wccfiHzgB/c4pPLOtXpvlWszUyTKwI+OBvNrMxM=;
  b=YwuOMHso3qvGPLYPRWZYETX4iwmJjRzuBATWOiQO6Y93ZeYK9fgQAxhA
   ZTA9sm9GANBS6DAbYdBxSS3e2RcwUBT7pxbB4RAzElecMDq83xfi7LvkC
   Ij8MlYgDGOL7PPjb3RdKhfP4QXzU4R7zAdY5JUa8cKumdWT6h0UAWgF8K
   l8/ivkfJiM5+rgHLIc6GavkWZaTNkBCAyZJEoQ5/0NV3Hx6eLYmXf3+Lj
   tnAmjhdOdwW2f2nHz65kAGsDe9unStZMCoxNwCA2N/ZFksJjqIYzVXIPM
   EiGhiDPn9LpLeAW5XBpRK2Ochu9kixKeW89BJ13/8t/F8gPyKMX67WWa7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="242068161"
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="242068161"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 17:40:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,252,1635231600"; 
   d="scan'208";a="524873772"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 31 Dec 2021 17:40:21 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3TNc-000Bs9-QL; Sat, 01 Jan 2022 01:40:20 +0000
Date:   Sat, 01 Jan 2022 09:39:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 99a507a8ea28542ec196e2dd80096708e2482735
Message-ID: <61cfb0df.mGp03/G/3ugL37St%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 99a507a8ea28542ec196e2dd80096708e2482735  Revert "serdev: BREAK/FRAME/PARITY/OVERRUN notification prototype V2"

elapsed time: 723m

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
i386                 randconfig-c001-20211231
arm                            lart_defconfig
parisc                generic-64bit_defconfig
arm                            mps2_defconfig
arm                          gemini_defconfig
i386                                defconfig
mips                      maltasmvp_defconfig
m68k                         apollo_defconfig
nios2                            allyesconfig
powerpc                      ppc6xx_defconfig
xtensa                  audio_kc705_defconfig
mips                  maltasmvp_eva_defconfig
openrisc                            defconfig
alpha                               defconfig
sh                           se7751_defconfig
m68k                          sun3x_defconfig
xtensa                          iss_defconfig
sh                           sh2007_defconfig
arm                           viper_defconfig
arm                         axm55xx_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                      makalu_defconfig
um                             i386_defconfig
m68k                       m5475evb_defconfig
xtensa                           alldefconfig
microblaze                          defconfig
arm                          pxa910_defconfig
sh                           se7705_defconfig
sh                           se7750_defconfig
nios2                            alldefconfig
alpha                            alldefconfig
mips                         db1xxx_defconfig
parisc                generic-32bit_defconfig
h8300                               defconfig
sh                             sh03_defconfig
powerpc                       eiger_defconfig
powerpc                   currituck_defconfig
m68k                          multi_defconfig
sh                         ap325rxa_defconfig
sh                         microdev_defconfig
sh                        apsh4ad0a_defconfig
sh                           se7343_defconfig
openrisc                 simple_smp_defconfig
alpha                            allyesconfig
arm                  randconfig-c002-20220101
arm                  randconfig-c002-20211231
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
csky                                defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20211231
x86_64               randconfig-a001-20211231
x86_64               randconfig-a003-20211231
x86_64               randconfig-a006-20211231
x86_64               randconfig-a004-20211231
x86_64               randconfig-a005-20211231
x86_64               randconfig-a005-20220101
x86_64               randconfig-a001-20220101
x86_64               randconfig-a004-20220101
x86_64               randconfig-a006-20220101
x86_64               randconfig-a003-20220101
x86_64               randconfig-a002-20220101
i386                 randconfig-a003-20220101
i386                 randconfig-a005-20220101
i386                 randconfig-a004-20220101
i386                 randconfig-a006-20220101
i386                 randconfig-a001-20220101
i386                 randconfig-a002-20220101
i386                 randconfig-a001-20211231
i386                 randconfig-a005-20211231
i386                 randconfig-a004-20211231
i386                 randconfig-a002-20211231
i386                 randconfig-a006-20211231
i386                 randconfig-a003-20211231
arc                  randconfig-r043-20220101
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20211231
arm                  randconfig-c002-20211231
mips                 randconfig-c004-20211231
powerpc              randconfig-c003-20211231
x86_64               randconfig-c007-20211231
i386                 randconfig-c001-20211231
powerpc                   lite5200b_defconfig
powerpc                          allmodconfig
arm                         orion5x_defconfig
x86_64                           allyesconfig
powerpc                      acadia_defconfig
arm                            dove_defconfig
arm                         socfpga_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                  colibri_pxa270_defconfig
x86_64               randconfig-a013-20211231
x86_64               randconfig-a015-20211231
x86_64               randconfig-a012-20211231
x86_64               randconfig-a011-20211231
x86_64               randconfig-a016-20211231
x86_64               randconfig-a014-20211231
x86_64               randconfig-a015-20220101
x86_64               randconfig-a012-20220101
x86_64               randconfig-a014-20220101
x86_64               randconfig-a013-20220101
x86_64               randconfig-a011-20220101
x86_64               randconfig-a016-20220101
i386                 randconfig-a011-20211231
i386                 randconfig-a013-20211231
i386                 randconfig-a012-20211231
i386                 randconfig-a014-20211231
i386                 randconfig-a015-20211231
i386                 randconfig-a016-20211231
hexagon              randconfig-r041-20211231
hexagon              randconfig-r045-20211231
riscv                randconfig-r042-20211231

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
