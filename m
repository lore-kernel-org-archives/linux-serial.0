Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29402C433F5
	for <linux-serial@archiver.kernel.org>; Tue,  5 Apr 2022 02:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiDECqq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Apr 2022 22:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiDECq0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Apr 2022 22:46:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3002119269
        for <linux-serial@vger.kernel.org>; Mon,  4 Apr 2022 18:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649123544; x=1680659544;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ilz00yKWxabAQcr8wtuzj4wMPvn1sT2Cl6JT6wHGd5A=;
  b=iLXcVo4CHL+nxq6aHmIrSI0SIPTxmKo90bXrzLhF71SjxW5cVAJPp3Gf
   Jbjhgue5k74AdkSysK4ODGPode7lOK8ecpb22YZOkQsILvmS205P9yDGM
   JvTIxQnGFkQrcEOwMbbfxX6pvKGRoQoX6x53cDdKX5h18mrIW3HQlmJ4V
   A8Fpy2pdKJNcQMgcdpDgsJ+6A1Cq1ycJ5CAlXsm4O9NEoRzz7obfgamD1
   yFlaIYpA2ezYVslUm80kCLVw1K3fttiWHrQe/9fHtpsAggP+/IYODOFoa
   E471P03e5zAZdfPo4D5iDaMsaTCuwhZRWBhk5tHRy89x3N4ZmcAladWHY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="248148019"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="248148019"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 16:58:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="721841002"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Apr 2022 16:58:39 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbWak-0002Si-EV;
        Mon, 04 Apr 2022 23:58:38 +0000
Date:   Tue, 05 Apr 2022 07:58:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 dbf3f09322141b6f04a33949453b7626f62d9e0b
Message-ID: <624b860d.qFJiK5PHKAMHf5RQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: dbf3f09322141b6f04a33949453b7626f62d9e0b  tty: serial: mpc52xx_uart: make rx/tx hooks return unsigned, part II.

elapsed time: 743m

configs tested: 118
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220404
riscv                            allmodconfig
mips                             allyesconfig
mips                             allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
riscv                            allyesconfig
m68k                             allyesconfig
s390                             allmodconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
m68k                             allmodconfig
s390                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
nios2                            allyesconfig
powerpc                      ppc40x_defconfig
sh                           se7722_defconfig
xtensa                  nommu_kc705_defconfig
openrisc                 simple_smp_defconfig
parisc64                         alldefconfig
arc                        nsimosci_defconfig
m68k                          sun3x_defconfig
sh                                  defconfig
xtensa                              defconfig
alpha                            alldefconfig
powerpc                        cell_defconfig
sh                          rsk7203_defconfig
sh                            shmin_defconfig
sh                          rsk7264_defconfig
m68k                          hp300_defconfig
powerpc                      ep88xc_defconfig
sh                               j2_defconfig
arc                      axs103_smp_defconfig
sh                           se7206_defconfig
ia64                      gensparse_defconfig
sh                            hp6xx_defconfig
sh                        sh7785lcr_defconfig
x86_64               randconfig-c001-20220404
arm                  randconfig-c002-20220404
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                                defconfig
csky                                defconfig
alpha                               defconfig
nios2                               defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                           allnoconfig
x86_64               randconfig-a015-20220404
x86_64               randconfig-a011-20220404
x86_64               randconfig-a014-20220404
x86_64               randconfig-a016-20220404
x86_64               randconfig-a012-20220404
x86_64               randconfig-a013-20220404
i386                 randconfig-a014-20220404
i386                 randconfig-a013-20220404
i386                 randconfig-a016-20220404
i386                 randconfig-a015-20220404
i386                 randconfig-a011-20220404
i386                 randconfig-a012-20220404
arc                  randconfig-r043-20220404
s390                 randconfig-r044-20220404
riscv                randconfig-r042-20220404
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
i386                 randconfig-c001-20220404
x86_64               randconfig-c007-20220404
powerpc              randconfig-c003-20220404
riscv                randconfig-c006-20220404
mips                 randconfig-c004-20220404
arm                  randconfig-c002-20220404
mips                      pic32mzda_defconfig
powerpc                      katmai_defconfig
mips                     loongson1c_defconfig
mips                  cavium_octeon_defconfig
arm                        multi_v5_defconfig
powerpc                        icon_defconfig
arm                             mxs_defconfig
powerpc                   microwatt_defconfig
x86_64               randconfig-a006-20220404
x86_64               randconfig-a002-20220404
x86_64               randconfig-a001-20220404
x86_64               randconfig-a005-20220404
x86_64               randconfig-a003-20220404
x86_64               randconfig-a004-20220404
i386                 randconfig-a006-20220404
i386                 randconfig-a002-20220404
i386                 randconfig-a001-20220404
i386                 randconfig-a004-20220404
i386                 randconfig-a003-20220404
i386                 randconfig-a005-20220404

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
