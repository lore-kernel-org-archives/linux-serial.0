Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264ECC433F5
	for <linux-serial@archiver.kernel.org>; Sat, 26 Feb 2022 01:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiBZB5t (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Feb 2022 20:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiBZB5s (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Feb 2022 20:57:48 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FF52E0E22
        for <linux-serial@vger.kernel.org>; Fri, 25 Feb 2022 17:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645840602; x=1677376602;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7Qpgt1zwoYGq4CQPq8OGhigb7UcWc2tClPSBw6Zk36o=;
  b=FT5V7qcLun7Db3znKl2YKRg1hIHDdUcEh/sJ8x+NwvFGLex6FKsOmgt5
   fQji0wmk3faSoTb2PxY9Z8i3+VElr3ZZbnV29gz/J0G0qVvAoedyOHWZi
   fk0J+op5BT06SJAE0yKF8zpi6cDxk1ElSPZAdH5cOirgUvAkirHcvuV45
   JYtwiRdBDftq7bvOFK47Yw5GDsg0p81zrFdK5K4ZoNUoCXvoSE0rThEOz
   yKO8qmeBEyKUxH/4oiX6lkCnGCzZCX81rM44joLApklrNqTioff7IXbDo
   cRrd7LjiLDdcPkNocwAn2mStEKMjJwEyh4ereXY80GLbRdVAA0jVLd0Kf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="236126086"
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; 
   d="scan'208";a="236126086"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 17:56:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,138,1643702400"; 
   d="scan'208";a="574783078"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Feb 2022 17:56:32 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNmJz-0004vW-MD; Sat, 26 Feb 2022 01:56:31 +0000
Date:   Sat, 26 Feb 2022 09:55:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD REGRESSION
 a6d8f09319fff9e6e7a91cadb19923b8cb2573e0
Message-ID: <621988a5.qOQtYS5ysluTXji9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: a6d8f09319fff9e6e7a91cadb19923b8cb2573e0  tty: Reserve ldisc 29 for development purposes

Error/Warning reports:

https://lore.kernel.org/linux-serial/202202260105.p77piygB-lkp@intel.com
https://lore.kernel.org/llvm/202202260016.JwqeCxcs-lkp@intel.com

Error/Warning in current branch:

drivers/mmc/core/sdio_uart.c:253:16: error: implicit declaration of function 'UART_LCR_WLEN'; did you mean 'UART_LCR_WLEN5'? [-Werror=implicit-function-declaration]
drivers/mmc/core/sdio_uart.c:253:16: error: implicit declaration of function 'UART_LCR_WLEN'; did you mean 'UART_LCR_WLEN6'? [-Werror=implicit-function-declaration]
drivers/mmc/core/sdio_uart.c:253:16: error: implicit declaration of function 'UART_LCR_WLEN'; did you mean 'UART_LCR_WLEN7'? [-Werror=implicit-function-declaration]
drivers/mmc/core/sdio_uart.c:253:9: error: implicit declaration of function 'UART_LCR_WLEN' [-Werror,-Wimplicit-function-declaration]
drivers/mmc/core/sdio_uart.c:253:9: error: implicit declaration of function 'UART_LCR_WLEN'; did you mean 'UART_LCR_WLEN5'? [-Werror=implicit-function-declaration]
drivers/mmc/core/sdio_uart.c:253:9: error: implicit declaration of function 'UART_LCR_WLEN'; did you mean 'UART_LCR_WLEN6'? [-Werror=implicit-function-declaration]
drivers/mmc/core/sdio_uart.c:253:9: error: implicit declaration of function 'UART_LCR_WLEN'; did you mean 'UART_LCR_WLEN8'? [-Werror=implicit-function-declaration]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- arc-randconfig-r043-20220225
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- csky-allmodconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- h8300-allyesconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- i386-allyesconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- i386-debian-10.3-kselftests
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- i386-randconfig-a012
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- i386-randconfig-a014
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- ia64-allmodconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- ia64-allyesconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- mips-allmodconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- mips-allyesconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- powerpc-allmodconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- powerpc-allyesconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- riscv-allmodconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- riscv-allyesconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- sh-allmodconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- sparc-allyesconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- sparc-randconfig-r016-20220225
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- sparc64-allmodconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- x86_64-allyesconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- x86_64-randconfig-a006
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- x86_64-randconfig-a011
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- x86_64-randconfig-c002
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- x86_64-rhel-8.3
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- x86_64-rhel-8.3-func
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- x86_64-rhel-8.3-kselftests
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
`-- xtensa-allyesconfig
    `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN

clang_recent_errors
|-- arm-randconfig-c002-20220225
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN-Werror-Wimplicit-function-declaration
|-- arm-s3c2410_defconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN-Werror-Wimplicit-function-declaration
|-- arm64-randconfig-r011-20220225
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN-Werror-Wimplicit-function-declaration
|-- i386-randconfig-a004
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN-Werror-Wimplicit-function-declaration
|-- i386-randconfig-a006
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN-Werror-Wimplicit-function-declaration
|-- i386-randconfig-a011
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN-Werror-Wimplicit-function-declaration
|-- i386-randconfig-c001
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN-Werror-Wimplicit-function-declaration
|-- mips-randconfig-c004-20220225
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN-Werror-Wimplicit-function-declaration
|-- x86_64-randconfig-a003
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN-Werror-Wimplicit-function-declaration
|-- x86_64-randconfig-a012
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN-Werror-Wimplicit-function-declaration
|-- x86_64-randconfig-a014
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN-Werror-Wimplicit-function-declaration
`-- x86_64-randconfig-a016
    `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN-Werror-Wimplicit-function-declaration

elapsed time: 723m

configs tested: 100
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
s390                          debug_defconfig
arm                        shmobile_defconfig
sh                         microdev_defconfig
xtensa                           allyesconfig
sh                          sdk7780_defconfig
powerpc                     asp8347_defconfig
arm                          exynos_defconfig
m68k                       m5208evb_defconfig
mips                     decstation_defconfig
powerpc                     stx_gp3_defconfig
m68k                       m5475evb_defconfig
powerpc                     tqm8548_defconfig
openrisc                         alldefconfig
powerpc                     redwood_defconfig
powerpc                        warp_defconfig
arm                           sama5_defconfig
sh                        sh7785lcr_defconfig
arm                            zeus_defconfig
arc                            hsdk_defconfig
arm                        keystone_defconfig
powerpc                     tqm8555_defconfig
h8300                               defconfig
arc                          axs103_defconfig
arm                  randconfig-c002-20220225
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
powerpc              randconfig-c003-20220225
x86_64                        randconfig-c007
arm                  randconfig-c002-20220225
mips                 randconfig-c004-20220225
i386                          randconfig-c001
riscv                randconfig-c006-20220225
mips                          ath25_defconfig
powerpc                     kilauea_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220225
hexagon              randconfig-r041-20220225
riscv                randconfig-r042-20220225

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
