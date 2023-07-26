Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87320C0015E
	for <linux-serial@archiver.kernel.org>; Wed, 26 Jul 2023 06:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjGZG4C (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Jul 2023 02:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGZGz5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jul 2023 02:55:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B584E2704
        for <linux-serial@vger.kernel.org>; Tue, 25 Jul 2023 23:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690354555; x=1721890555;
  h=date:from:to:cc:subject:message-id;
  bh=UifXyHIyHW5clo5A4yV/MohebiGvrhEStSMyTipXYRg=;
  b=CB373+mkDCzKWyTzGi9dRjJfFNpHpg4TgXeiMxkDi2aEYu1vynYgHjoP
   7qfE62Mz0szdBs3LVd8AgTuGJ3hLzMAETL2vrK45RZEI24l7k1YSnx4Lv
   5c9C8/+Li0rGEQUXS3tAhYVt29+5+Nw+Gh5lrLh3iT5CDaP0rC7BUo/ND
   jZNHyisr/mszjGXY9gwNT5esxI9poleYLn7AByn/YpepZure6qNp0Qcpa
   pf7Yr+NS68iKxSTWsAUwU9RV1FPNpK/0ssMKeUDmRxghsRBR0bBawO2dQ
   OZynyBESCcHZ0Rkf7RCSmXgz4nkxeCTYWMxItewwEtiS8TLuQRwI1ncxm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="366820812"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="366820812"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 23:55:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="840150105"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="840150105"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jul 2023 23:55:54 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOYR7-0000kZ-0w;
        Wed, 26 Jul 2023 06:55:53 +0000
Date:   Wed, 26 Jul 2023 14:54:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 9b4e18f032db160a70d73d3cdf3a0bff229686b4
Message-ID: <202307261451.b2Shkcaj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 9b4e18f032db160a70d73d3cdf3a0bff229686b4  serial: st-asc: Use devm_platform_get_and_ioremap_resource()

elapsed time: 727m

configs tested: 180
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230725   gcc  
alpha                randconfig-r002-20230725   gcc  
alpha                randconfig-r006-20230725   gcc  
alpha                randconfig-r006-20230726   gcc  
alpha                randconfig-r012-20230725   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230726   gcc  
arc                  randconfig-r013-20230725   gcc  
arc                  randconfig-r014-20230725   gcc  
arc                  randconfig-r043-20230725   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230725   gcc  
arm                  randconfig-r046-20230725   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230725   clang
arm64                randconfig-r024-20230725   gcc  
arm64                randconfig-r032-20230725   clang
arm64                randconfig-r035-20230725   clang
csky                                defconfig   gcc  
csky                 randconfig-r016-20230725   gcc  
csky                 randconfig-r023-20230725   gcc  
hexagon              randconfig-r004-20230725   clang
hexagon              randconfig-r005-20230725   clang
hexagon              randconfig-r023-20230725   clang
hexagon              randconfig-r041-20230725   clang
hexagon              randconfig-r041-20230726   clang
hexagon              randconfig-r045-20230725   clang
hexagon              randconfig-r045-20230726   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230725   clang
i386         buildonly-randconfig-r005-20230725   clang
i386         buildonly-randconfig-r006-20230725   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230725   clang
i386                 randconfig-i001-20230726   gcc  
i386                 randconfig-i002-20230725   clang
i386                 randconfig-i002-20230726   gcc  
i386                 randconfig-i003-20230725   clang
i386                 randconfig-i003-20230726   gcc  
i386                 randconfig-i004-20230725   clang
i386                 randconfig-i004-20230726   gcc  
i386                 randconfig-i005-20230725   clang
i386                 randconfig-i005-20230726   gcc  
i386                 randconfig-i006-20230725   clang
i386                 randconfig-i006-20230726   gcc  
i386                 randconfig-i011-20230725   gcc  
i386                 randconfig-i012-20230725   gcc  
i386                 randconfig-i013-20230725   gcc  
i386                 randconfig-i014-20230725   gcc  
i386                 randconfig-i015-20230725   gcc  
i386                 randconfig-i016-20230725   gcc  
i386                 randconfig-r001-20230725   clang
i386                 randconfig-r003-20230725   clang
i386                 randconfig-r036-20230725   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230725   gcc  
loongarch            randconfig-r015-20230725   gcc  
loongarch            randconfig-r016-20230725   gcc  
loongarch            randconfig-r021-20230725   gcc  
loongarch            randconfig-r032-20230725   gcc  
loongarch            randconfig-r034-20230725   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230725   gcc  
m68k                 randconfig-r001-20230726   gcc  
m68k                 randconfig-r026-20230725   gcc  
microblaze           randconfig-r002-20230725   gcc  
microblaze           randconfig-r012-20230725   gcc  
microblaze           randconfig-r035-20230725   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r033-20230725   gcc  
nios2                         10m50_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r021-20230725   gcc  
nios2                randconfig-r026-20230725   gcc  
openrisc             randconfig-r031-20230725   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r013-20230725   gcc  
parisc               randconfig-r016-20230725   gcc  
parisc               randconfig-r025-20230725   gcc  
parisc               randconfig-r036-20230725   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      ppc40x_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc              randconfig-r003-20230726   gcc  
powerpc              randconfig-r006-20230725   clang
powerpc              randconfig-r012-20230725   gcc  
powerpc              randconfig-r032-20230725   clang
powerpc              randconfig-r035-20230725   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230725   clang
riscv                randconfig-r034-20230725   clang
riscv                randconfig-r042-20230725   gcc  
riscv                randconfig-r042-20230726   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r014-20230725   gcc  
s390                 randconfig-r031-20230725   clang
s390                 randconfig-r033-20230725   clang
s390                 randconfig-r036-20230725   clang
s390                 randconfig-r044-20230725   gcc  
s390                 randconfig-r044-20230726   clang
sh                               allmodconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                   randconfig-r014-20230725   gcc  
sh                   randconfig-r016-20230725   gcc  
sh                          rsk7201_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230725   gcc  
sparc                randconfig-r015-20230725   gcc  
sparc64              randconfig-r005-20230725   gcc  
sparc64              randconfig-r014-20230725   gcc  
sparc64              randconfig-r022-20230725   gcc  
sparc64              randconfig-r025-20230725   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r016-20230725   clang
um                   randconfig-r026-20230725   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230725   clang
x86_64       buildonly-randconfig-r002-20230725   clang
x86_64       buildonly-randconfig-r003-20230725   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r011-20230725   gcc  
x86_64               randconfig-r015-20230725   gcc  
x86_64               randconfig-r024-20230725   gcc  
x86_64               randconfig-x001-20230725   gcc  
x86_64               randconfig-x001-20230726   clang
x86_64               randconfig-x002-20230725   gcc  
x86_64               randconfig-x002-20230726   clang
x86_64               randconfig-x003-20230725   gcc  
x86_64               randconfig-x003-20230726   clang
x86_64               randconfig-x004-20230725   gcc  
x86_64               randconfig-x004-20230726   clang
x86_64               randconfig-x005-20230725   gcc  
x86_64               randconfig-x005-20230726   clang
x86_64               randconfig-x006-20230725   gcc  
x86_64               randconfig-x006-20230726   clang
x86_64               randconfig-x011-20230725   clang
x86_64               randconfig-x011-20230726   gcc  
x86_64               randconfig-x012-20230725   clang
x86_64               randconfig-x012-20230726   gcc  
x86_64               randconfig-x013-20230725   clang
x86_64               randconfig-x013-20230726   gcc  
x86_64               randconfig-x014-20230725   clang
x86_64               randconfig-x014-20230726   gcc  
x86_64               randconfig-x015-20230725   clang
x86_64               randconfig-x015-20230726   gcc  
x86_64               randconfig-x016-20230725   clang
x86_64               randconfig-x016-20230726   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r013-20230725   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
