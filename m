Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F19CDB474
	for <linux-serial@archiver.kernel.org>; Tue, 17 Oct 2023 07:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjJQHuG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Oct 2023 03:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjJQHuF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Oct 2023 03:50:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFDA95
        for <linux-serial@vger.kernel.org>; Tue, 17 Oct 2023 00:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697529003; x=1729065003;
  h=date:from:to:cc:subject:message-id;
  bh=SMv32G7WtDQOx0JVlFCPokOMKc2qGAl0ywpdM5f/gV8=;
  b=Ale0FRkjNQj2vbxvIorkNAAS7bZG1xpIIBhO32IiEY7vvEyX6dKm8ldi
   +D8W3a44aZ8sNv/ghG0RVGQLH6nh21fJtIrIk1IliisB/Mq5HM2s6evBw
   Jy6L/WYTTdr4Fg0CZY5qN9Ae075JSI6VpoI20hWj11Hi1YsdhHNR6iXaZ
   53d2pKm4OGuLMj+o9U3gXUwWYrkFdlYBuC7AD561ysmIAz6etchIAb8L/
   1974yvjH1CG2+R/vB8w9EKe2qMKl2HlKo3QYnLUgmt/zLf+vJYcf71hLF
   lFkiwdCj8hbwV84Oil1qeLM/qnWfJJonxg2ETEXpjycAus0V+vvGLeqQa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="385561300"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="385561300"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 00:50:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="749585691"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="749585691"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 17 Oct 2023 00:50:01 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsepz-0009IB-0F;
        Tue, 17 Oct 2023 07:49:59 +0000
Date:   Tue, 17 Oct 2023 15:49:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD REGRESSION
 6271f1e8c4cb9a46273ae01ff9cb86a022063f75
Message-ID: <202310171546.juXlD3fv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 6271f1e8c4cb9a46273ae01ff9cb86a022063f75  printk: Constify name for add_preferred_console()

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202310170418.GCOnw1n1-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310170938.xHIu2lFB-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202310171049.aNxOKhUY-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/tty/serial/8250/8250_ni.c:428:41: warning: 'nic7750' defined but not used [-Wunused-const-variable=]
drivers/tty/serial/8250/8250_ni.c:433:41: warning: 'nic7772' defined but not used [-Wunused-const-variable=]
drivers/tty/serial/8250/8250_ni.c:439:41: warning: 'nic792b' defined but not used [-Wunused-const-variable=]
drivers/tty/serial/8250/8250_ni.c:446:41: warning: 'nic7a69' defined but not used [-Wunused-const-variable=]
earlycon.c:(.text+0x80): undefined reference to `screen_info'
efi.c:(.init.text+0x1ac): undefined reference to `screen_info'
loongarch64-linux-ld: earlycon.c:(.text+0x84): undefined reference to `screen_info'
loongarch64-linux-ld: efi.c:(.init.text+0x1b0): undefined reference to `screen_info'
loongarch64-linux-ld: sysfb.c:(.init.text+0x68): undefined reference to `screen_info'
sysfb.c:(.init.text+0x60): undefined reference to `screen_info'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- alpha-allyesconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- arc-allmodconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- arc-allyesconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- arm-allmodconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- arm-allyesconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- csky-allmodconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- csky-allyesconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- loongarch-randconfig-001-20231017
|   |-- efi.c:(.init.text):undefined-reference-to-screen_info
|   |-- loongarch64-linux-ld:efi.c:(.init.text):undefined-reference-to-screen_info
|   |-- loongarch64-linux-ld:sysfb.c:(.init.text):undefined-reference-to-screen_info
|   `-- sysfb.c:(.init.text):undefined-reference-to-screen_info
|-- loongarch-randconfig-002-20231017
|   |-- earlycon.c:(.text):undefined-reference-to-screen_info
|   `-- loongarch64-linux-ld:earlycon.c:(.text):undefined-reference-to-screen_info
|-- m68k-allmodconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- m68k-allyesconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- microblaze-allmodconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- microblaze-allyesconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- mips-allmodconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- mips-allyesconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- nios2-allmodconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- nios2-allyesconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- openrisc-allmodconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- openrisc-allyesconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- parisc-allmodconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- parisc-allyesconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- powerpc-allmodconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- powerpc-allyesconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- sh-allmodconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- sh-allyesconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- sparc-allmodconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- sparc-allyesconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
|-- sparc64-allmodconfig
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
|   |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
|   `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used
`-- sparc64-allyesconfig
    |-- drivers-tty-serial-8250_ni.c:warning:nic7750-defined-but-not-used
    |-- drivers-tty-serial-8250_ni.c:warning:nic7772-defined-but-not-used
    |-- drivers-tty-serial-8250_ni.c:warning:nic792b-defined-but-not-used
    `-- drivers-tty-serial-8250_ni.c:warning:nic7a69-defined-but-not-used

elapsed time: 754m

configs tested: 104
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231017   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231017   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231017   gcc  
i386                  randconfig-002-20231017   gcc  
i386                  randconfig-003-20231017   gcc  
i386                  randconfig-004-20231017   gcc  
i386                  randconfig-005-20231017   gcc  
i386                  randconfig-006-20231017   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231017   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231017   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231017   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231017   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231017   gcc  
x86_64                randconfig-002-20231017   gcc  
x86_64                randconfig-003-20231017   gcc  
x86_64                randconfig-004-20231017   gcc  
x86_64                randconfig-005-20231017   gcc  
x86_64                randconfig-006-20231017   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
