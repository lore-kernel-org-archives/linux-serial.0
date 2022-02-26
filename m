Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F64C433EF
	for <linux-serial@archiver.kernel.org>; Sat, 26 Feb 2022 22:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiBZWmr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 26 Feb 2022 17:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiBZWmr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 26 Feb 2022 17:42:47 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EFE2BB583
        for <linux-serial@vger.kernel.org>; Sat, 26 Feb 2022 14:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645915332; x=1677451332;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pYtLA/x+IR2/juRL/okFXWkMG50b+lvKdkZP/wz/QTI=;
  b=PW9ffNR4uKIyofEHn0Kme3inERBJ+ExQg0E4GojK+KkSTgrfVMp4b2tp
   WJyLWIkKJIrzUhG+ql4KNJORf39dI+AJAgP/Rev7UHSkvsNY9FnxnYTSi
   1hbkpOwnzgdNrBD5VsAVC2FFzMmjGbnVNgnfE3QDMd5wlOdSwLWtKRxC6
   KZHFEQvks7I/Hv59PBpjIhYEjuzdLWj1ZJvrjRznTep5rgJrEjkhkvNFW
   dqozVGHhIYb9cuM0v0BtGHmn0Ib/jnfVJC5ceS21EBvzwU3aaNX9UrMPT
   A+X+xzRph8uFTT/pujfCm0FJBt5WT0/3m0aPTexGEpecO8O+F8Z/bPG4J
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="240094140"
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="240094140"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 14:42:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="640494235"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Feb 2022 14:42:10 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nO5lR-00060g-IM; Sat, 26 Feb 2022 22:42:09 +0000
Date:   Sun, 27 Feb 2022 06:41:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD REGRESSION
 71404f653cf7858fdbb81dd5419a8a4ac4ffa20c
Message-ID: <621aacaf.3IpEAaGLJlruT9u1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 71404f653cf7858fdbb81dd5419a8a4ac4ffa20c  mxser: make use of UART_LCR_WLEN() + tty_get_char_size()

Error/Warning reports:

https://lore.kernel.org/linux-serial/202202260105.p77piygB-lkp@intel.com
https://lore.kernel.org/linux-serial/202202262312.11J4P9pP-lkp@intel.com
https://lore.kernel.org/linux-serial/202202262328.Ss3brmL4-lkp@intel.com
https://lore.kernel.org/linux-serial/202202270135.XFr12qec-lkp@intel.com

Error/Warning in current branch:

drivers/mmc/core/sdio_uart.c:253:16: error: implicit declaration of function 'UART_LCR_WLEN'; did you mean 'UART_LCR_WLEN5'? [-Werror=implicit-function-declaration]
drivers/mmc/core/sdio_uart.c:253:16: error: implicit declaration of function 'UART_LCR_WLEN'; did you mean 'UART_LCR_WLEN6'? [-Werror=implicit-function-declaration]
drivers/mmc/core/sdio_uart.c:253:16: error: implicit declaration of function 'UART_LCR_WLEN'; did you mean 'UART_LCR_WLEN7'? [-Werror=implicit-function-declaration]
drivers/mmc/core/sdio_uart.c:253:9: error: implicit declaration of function 'UART_LCR_WLEN'; did you mean 'UART_LCR_WLEN5'? [-Werror=implicit-function-declaration]
drivers/mmc/core/sdio_uart.c:253:9: error: implicit declaration of function 'UART_LCR_WLEN'; did you mean 'UART_LCR_WLEN6'? [-Werror=implicit-function-declaration]
drivers/tty/serial/sunplus-uart.c:574:28: error: 'sunplus_uart_console' undeclared here (not in a function); did you mean 'sunplus_uart_ops'?
meson_uart.c:(.text+0x24e): undefined reference to `__clk_get_name'
meson_uart.c:(.text+0x750): undefined reference to `__clk_get_name'
meson_uart.c:(.text+0xc64): undefined reference to `__clk_get_name'
s390-linux-ld: meson_uart.c:(.text+0xc80): undefined reference to `devm_clk_hw_register_fixed_factor'
s390-linux-ld: meson_uart.c:(.text+0xd00): undefined reference to `__clk_get_name'
s390-linux-ld: meson_uart.c:(.text+0xd68): undefined reference to `__devm_clk_hw_register_divider'
s390-linux-ld: meson_uart.c:(.text+0xe80): undefined reference to `__devm_clk_hw_register_mux'
s390-linux-ld: meson_uart.c:(.text+0xe94): undefined reference to `clk_hw_get_rate'
s390-linux-ld: meson_uart.c:(.text+0xf12): undefined reference to `clk_hw_get_name'
sh4-linux-ld: meson_uart.c:(.text+0x748): undefined reference to `devm_clk_hw_register_fixed_factor'
sh4-linux-ld: meson_uart.c:(.text+0x754): undefined reference to `__devm_clk_hw_register_divider'
sh4-linux-ld: meson_uart.c:(.text+0x760): undefined reference to `__devm_clk_hw_register_mux'
sh4-linux-ld: meson_uart.c:(.text+0x764): undefined reference to `clk_hw_get_rate'
sh4-linux-ld: meson_uart.c:(.text+0x76c): undefined reference to `clk_hw_get_name'

possible Error/Warning in current branch (please contact us if interested):

(.text+0x3dc): undefined reference to `__clk_get_name'
drivers/mmc/core/sdio_uart.c:253:9: error: implicit declaration of function 'UART_LCR_WLEN' [-Werror,-Wimplicit-function-declaration]
drivers/tty/serial/meson_uart.c:832 meson_uart_probe() warn: 'pclk' not released on lines: 779,785,790,794,799.
hppa-linux-ld: (.text+0x400): undefined reference to `devm_clk_hw_register_fixed_factor'
hppa-linux-ld: (.text+0x448): undefined reference to `__clk_get_name'
hppa-linux-ld: (.text+0x4a0): undefined reference to `__devm_clk_hw_register_divider'
hppa-linux-ld: (.text+0x54c): undefined reference to `__devm_clk_hw_register_mux'
hppa-linux-ld: (.text+0x564): undefined reference to `clk_hw_get_rate'
hppa-linux-ld: (.text+0x5a0): undefined reference to `clk_hw_get_name'
m68k-linux-ld: meson_uart.c:(.text+0x26c): undefined reference to `devm_clk_hw_register_fixed_factor'
m68k-linux-ld: meson_uart.c:(.text+0x2e4): undefined reference to `__devm_clk_hw_register_divider'
m68k-linux-ld: meson_uart.c:(.text+0x368): undefined reference to `__devm_clk_hw_register_mux'
m68k-linux-ld: meson_uart.c:(.text+0x37e): undefined reference to `clk_hw_get_rate'
m68k-linux-ld: meson_uart.c:(.text+0x3bc): undefined reference to `clk_hw_get_name'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-randconfig-m031-20220226
|   `-- drivers-tty-serial-meson_uart.c-meson_uart_probe()-warn:pclk-not-released-on-lines:.
|-- arm-randconfig-c002-20220225
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- m68k-randconfig-r013-20220225
|   |-- m68k-linux-ld:meson_uart.c:(.text):undefined-reference-to-__devm_clk_hw_register_divider
|   |-- m68k-linux-ld:meson_uart.c:(.text):undefined-reference-to-__devm_clk_hw_register_mux
|   |-- m68k-linux-ld:meson_uart.c:(.text):undefined-reference-to-clk_hw_get_name
|   |-- m68k-linux-ld:meson_uart.c:(.text):undefined-reference-to-clk_hw_get_rate
|   |-- m68k-linux-ld:meson_uart.c:(.text):undefined-reference-to-devm_clk_hw_register_fixed_factor
|   `-- meson_uart.c:(.text):undefined-reference-to-__clk_get_name
|-- mips-randconfig-c023-20220227
|   `-- drivers-tty-serial-sunplus-uart.c:error:sunplus_uart_console-undeclared-here-(not-in-a-function)
|-- nds32-randconfig-r013-20220226
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- parisc-buildonly-randconfig-r002-20220227
|   `-- drivers-tty-serial-sunplus-uart.c:error:sunplus_uart_console-undeclared-here-(not-in-a-function)
|-- parisc-randconfig-r011-20220226
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- parisc-randconfig-r015-20220226
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- parisc-randconfig-r031-20220225
|   |-- (.text):undefined-reference-to-__clk_get_name
|   |-- hppa-linux-ld:(.text):undefined-reference-to-__clk_get_name
|   |-- hppa-linux-ld:(.text):undefined-reference-to-__devm_clk_hw_register_divider
|   |-- hppa-linux-ld:(.text):undefined-reference-to-__devm_clk_hw_register_mux
|   |-- hppa-linux-ld:(.text):undefined-reference-to-clk_hw_get_name
|   |-- hppa-linux-ld:(.text):undefined-reference-to-clk_hw_get_rate
|   `-- hppa-linux-ld:(.text):undefined-reference-to-devm_clk_hw_register_fixed_factor
|-- parisc64-allmodconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- riscv-allmodconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- s390-allyesconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- s390-randconfig-p002-20220226
|   |-- meson_uart.c:(.text):undefined-reference-to-__clk_get_name
|   |-- s390-linux-ld:meson_uart.c:(.text):undefined-reference-to-__clk_get_name
|   |-- s390-linux-ld:meson_uart.c:(.text):undefined-reference-to-__devm_clk_hw_register_divider
|   |-- s390-linux-ld:meson_uart.c:(.text):undefined-reference-to-__devm_clk_hw_register_mux
|   |-- s390-linux-ld:meson_uart.c:(.text):undefined-reference-to-clk_hw_get_name
|   |-- s390-linux-ld:meson_uart.c:(.text):undefined-reference-to-clk_hw_get_rate
|   `-- s390-linux-ld:meson_uart.c:(.text):undefined-reference-to-devm_clk_hw_register_fixed_factor
|-- sh-allmodconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- sh-randconfig-r011-20220225
|   |-- meson_uart.c:(.text):undefined-reference-to-__clk_get_name
|   |-- sh4-linux-ld:meson_uart.c:(.text):undefined-reference-to-__devm_clk_hw_register_divider
|   |-- sh4-linux-ld:meson_uart.c:(.text):undefined-reference-to-__devm_clk_hw_register_mux
|   |-- sh4-linux-ld:meson_uart.c:(.text):undefined-reference-to-clk_hw_get_name
|   |-- sh4-linux-ld:meson_uart.c:(.text):undefined-reference-to-clk_hw_get_rate
|   `-- sh4-linux-ld:meson_uart.c:(.text):undefined-reference-to-devm_clk_hw_register_fixed_factor
|-- x86_64-allmodconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- x86_64-allyesconfig
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
|-- x86_64-randconfig-a011
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN
`-- xtensa-allyesconfig
    `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN

clang_recent_errors
|-- x86_64-randconfig-a012
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN-Werror-Wimplicit-function-declaration
|-- x86_64-randconfig-a014
|   `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN-Werror-Wimplicit-function-declaration
`-- x86_64-randconfig-a016
    `-- drivers-mmc-core-sdio_uart.c:error:implicit-declaration-of-function-UART_LCR_WLEN-Werror-Wimplicit-function-declaration

elapsed time: 722m

configs tested: 118
configs skipped: 4

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
powerpc                     tqm8548_defconfig
arc                          axs101_defconfig
powerpc                      ppc40x_defconfig
sh                           se7712_defconfig
xtensa                         virt_defconfig
arm                        multi_v7_defconfig
sh                          landisk_defconfig
powerpc                      pcm030_defconfig
mips                         db1xxx_defconfig
powerpc                    klondike_defconfig
mips                             allyesconfig
m68k                        m5272c3_defconfig
s390                       zfcpdump_defconfig
powerpc                      tqm8xx_defconfig
mips                        vocore2_defconfig
arm                        trizeps4_defconfig
arm                           corgi_defconfig
m68k                       m5275evb_defconfig
mips                 decstation_r4k_defconfig
powerpc                     ep8248e_defconfig
arm                           tegra_defconfig
sh                          lboxre2_defconfig
sh                          polaris_defconfig
arc                         haps_hs_defconfig
powerpc                       ppc64_defconfig
arm                          gemini_defconfig
mips                    maltaup_xpa_defconfig
mips                      loongson3_defconfig
mips                         rt305x_defconfig
powerpc                   motionpro_defconfig
arm                           viper_defconfig
sh                        sh7757lcr_defconfig
m68k                          multi_defconfig
m68k                       m5249evb_defconfig
arm                  randconfig-c002-20220225
arm                  randconfig-c002-20220226
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
xtensa                           allyesconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
mips                           mtx1_defconfig
powerpc                     ppa8548_defconfig
arm                       mainstone_defconfig
powerpc                   lite5200b_defconfig
riscv                    nommu_virt_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220226
hexagon              randconfig-r045-20220225
hexagon              randconfig-r041-20220226
hexagon              randconfig-r041-20220225
riscv                randconfig-r042-20220225
hexagon              randconfig-r045-20220227
hexagon              randconfig-r041-20220227
riscv                randconfig-r042-20220227

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
