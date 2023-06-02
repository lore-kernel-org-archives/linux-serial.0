Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22660C77B7A
	for <linux-serial@archiver.kernel.org>; Fri,  2 Jun 2023 06:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjFBGj2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 2 Jun 2023 02:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbjFBGj0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Jun 2023 02:39:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E1B196
        for <linux-serial@vger.kernel.org>; Thu,  1 Jun 2023 23:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685687959; x=1717223959;
  h=date:from:to:cc:subject:message-id;
  bh=J/jrRr4cSEyzkjBSd3b3bztbhm2+UulX0qM0FGG0IEA=;
  b=GMfkrc3fDBs0hJ6f49oyMiZQOtjW+4fd0O1Rh/2vYhHvtQ6lMLuKStIb
   FEusJrZi5AY+8hjpqqBFPaLmtuXvEz5Z/3CXss1rm6J7qg/3D6OlunPhS
   kyRTphI/aVz5KxLS4ijdMZ9+uw/Ol1CkxiVczEUEaPE0XdcNU5o71X2WE
   1jestzLMCvn9wIrRvPUlMxId5CfhTN0dfuTsc2r7Mr0ZLLMsvYbWAucId
   RjRfshdv589JF09URNaFSOQHu67MxMFPGSAyQqRgZ2fHDOVhRSdOErYg1
   iLUUwMkwZfbut/5P8/gtWyb3fcDKdCOqIofcEKNrCZIvLWcjeuWohrvy9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="359089858"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="359089858"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 23:39:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="797469823"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="797469823"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Jun 2023 23:39:16 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4yRQ-0000CZ-0p;
        Fri, 02 Jun 2023 06:39:16 +0000
Date:   Fri, 02 Jun 2023 14:38:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD REGRESSION
 3a3d09a9ee0ef5b417d6bdf8486a4da2bef06dc3
Message-ID: <20230602063823.-olD_%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 3a3d09a9ee0ef5b417d6bdf8486a4da2bef06dc3  serial: 8250: Apply FSL workarounds also without SERIAL_8250_CONSOLE

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202306021041.qbRZZenE-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

legacy_serial.c:(.init.text+0x46a): undefined reference to `fsl8250_handle_irq'
powerpc-linux-ld: legacy_serial.c:(.init.text+0x472): undefined reference to `fsl8250_handle_irq'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- powerpc-allmodconfig
    |-- legacy_serial.c:(.init.text):undefined-reference-to-fsl8250_handle_irq
    `-- powerpc-linux-ld:legacy_serial.c:(.init.text):undefined-reference-to-fsl8250_handle_irq

elapsed time: 728m

configs tested: 104
configs skipped: 2

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r031-20230531   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230531   gcc  
arc                  randconfig-r043-20230531   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r022-20230531   gcc  
arm                  randconfig-r046-20230531   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230602   clang
csky         buildonly-randconfig-r005-20230531   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r014-20230602   gcc  
csky                 randconfig-r035-20230531   gcc  
hexagon              randconfig-r041-20230531   clang
hexagon              randconfig-r045-20230531   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230531   gcc  
i386                 randconfig-i002-20230531   gcc  
i386                 randconfig-i003-20230531   gcc  
i386                 randconfig-i004-20230531   gcc  
i386                 randconfig-i005-20230531   gcc  
i386                 randconfig-i006-20230531   gcc  
i386                 randconfig-i051-20230602   gcc  
i386                 randconfig-i052-20230602   gcc  
i386                 randconfig-i053-20230602   gcc  
i386                 randconfig-i054-20230602   gcc  
i386                 randconfig-i055-20230602   gcc  
i386                 randconfig-i056-20230602   gcc  
i386                 randconfig-i061-20230531   gcc  
i386                 randconfig-i062-20230531   gcc  
i386                 randconfig-i063-20230531   gcc  
i386                 randconfig-i064-20230531   gcc  
i386                 randconfig-i065-20230531   gcc  
i386                 randconfig-i066-20230531   gcc  
i386                 randconfig-r006-20230531   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230531   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230531   gcc  
m68k                 randconfig-r011-20230602   gcc  
m68k                 randconfig-r021-20230531   gcc  
m68k                 randconfig-r034-20230531   gcc  
microblaze           randconfig-r015-20230602   gcc  
microblaze           randconfig-r025-20230531   gcc  
microblaze           randconfig-r032-20230531   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r003-20230531   clang
mips                 randconfig-r013-20230602   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r024-20230531   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r026-20230531   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230531   clang
riscv                               defconfig   gcc  
riscv                randconfig-r036-20230531   gcc  
riscv                randconfig-r042-20230531   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r016-20230602   clang
s390                 randconfig-r033-20230531   gcc  
s390                 randconfig-r044-20230531   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230531   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230531   gcc  
x86_64               randconfig-a002-20230531   gcc  
x86_64               randconfig-a003-20230531   gcc  
x86_64               randconfig-a004-20230531   gcc  
x86_64               randconfig-a005-20230531   gcc  
x86_64               randconfig-a006-20230531   gcc  
x86_64               randconfig-r004-20230531   gcc  
x86_64               randconfig-x061-20230601   gcc  
x86_64               randconfig-x062-20230601   gcc  
x86_64               randconfig-x063-20230601   gcc  
x86_64               randconfig-x064-20230601   gcc  
x86_64               randconfig-x065-20230601   gcc  
x86_64               randconfig-x066-20230601   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230531   gcc  
xtensa               randconfig-r001-20230531   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
