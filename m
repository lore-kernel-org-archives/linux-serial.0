Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00059C48BDF
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 23:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07EE60FEE
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 23:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbhFRXkx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 19:40:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:14355 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235132AbhFRXkx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 19:40:53 -0400
IronPort-SDR: fdCqdTQvzDhQAy457qRNMCJxV4UwPIjwT+d2OtjxoRWNXv7dZ3ZLvxSHrfFjlkkYc8rJJNBjqj
 6n3w1vdgR2rA==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="204809675"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="204809675"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 16:38:43 -0700
IronPort-SDR: crHCHQRRhxZe38HxzHZz3sXkKGSn3G/zAHaVvbraYLCrjGg+79Wpl/HjgZtvdNACPuJIN1k5ia
 v7C1aD4pVJYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="422376524"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Jun 2021 16:38:41 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1luO4O-0003CB-UI; Fri, 18 Jun 2021 23:38:40 +0000
Date:   Sat, 19 Jun 2021 07:37:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS WITH WARNING
 b61c8bf4694b5115766849378dcb8787ff54e65e
Message-ID: <60cd2e45.GEQvfTFyeF3taO6/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: b61c8bf4694b5115766849378dcb8787ff54e65e  tty: serial: Add UART driver for Cortina-Access platform

Warning in current branch:

drivers/tty/serial/serial_cortina-access.c:469:6: warning: no previous prototype for 'cortina_console_write' [-Wmissing-prototypes]
drivers/tty/serial/serial_cortina-access.c:76:27: warning: no previous prototype for 'cortina_uart_get_port' [-Wmissing-prototypes]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_console_write
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- arc-allyesconfig
|   |-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_console_write
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- arm-allmodconfig
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- arm-allyesconfig
|   |-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_console_write
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- arm64-allyesconfig
|   |-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_console_write
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- h8300-allyesconfig
|   |-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_console_write
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- i386-allyesconfig
|   |-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_console_write
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- ia64-allmodconfig
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- ia64-allyesconfig
|   |-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_console_write
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- m68k-allmodconfig
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- m68k-allyesconfig
|   |-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_console_write
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- mips-allmodconfig
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- mips-allyesconfig
|   |-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_console_write
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- nds32-allyesconfig
|   |-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_console_write
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- nios2-allyesconfig
|   |-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_console_write
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- parisc-allyesconfig
|   |-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_console_write
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- powerpc-allmodconfig
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- powerpc-allyesconfig
|   |-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_console_write
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- riscv-allmodconfig
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- riscv-allyesconfig
|   |-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_console_write
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- s390-allyesconfig
|   |-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_console_write
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- sh-allmodconfig
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- sparc-allyesconfig
|   |-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_console_write
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
|-- x86_64-allyesconfig
|   |-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_console_write
|   `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port
`-- xtensa-allyesconfig
    |-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_console_write
    `-- drivers-tty-serial-serial_cortina-access.c:warning:no-previous-prototype-for-cortina_uart_get_port

elapsed time: 724m

configs tested: 83
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc834x_itx_defconfig
sh                          polaris_defconfig
xtensa                       common_defconfig
arm                          pxa168_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
x86_64                            allnoconfig
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
i386                 randconfig-a002-20210618
i386                 randconfig-a006-20210618
i386                 randconfig-a004-20210618
i386                 randconfig-a001-20210618
i386                 randconfig-a005-20210618
i386                 randconfig-a003-20210618
x86_64               randconfig-a015-20210618
x86_64               randconfig-a011-20210618
x86_64               randconfig-a012-20210618
x86_64               randconfig-a014-20210618
x86_64               randconfig-a016-20210618
x86_64               randconfig-a013-20210618
i386                 randconfig-a015-20210618
i386                 randconfig-a016-20210618
i386                 randconfig-a013-20210618
i386                 randconfig-a014-20210618
i386                 randconfig-a012-20210618
i386                 randconfig-a011-20210618
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
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210618
x86_64               randconfig-a002-20210618
x86_64               randconfig-a001-20210618
x86_64               randconfig-a004-20210618
x86_64               randconfig-a003-20210618
x86_64               randconfig-a006-20210618
x86_64               randconfig-a005-20210618

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
