Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5712CC77B73
	for <linux-serial@archiver.kernel.org>; Mon,  5 Jun 2023 18:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjFESRJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 5 Jun 2023 14:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbjFESRJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Jun 2023 14:17:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5916511B
        for <linux-serial@vger.kernel.org>; Mon,  5 Jun 2023 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685989017; x=1717525017;
  h=date:from:to:cc:subject:message-id;
  bh=mqENMowIonu8kSAyqVl6GNETv4EgITkIwkTwYsVacsQ=;
  b=b87XvV0e7rW5huy9/wNmP2A5XJuQYZYl03f5E6xeKVWjQhko2kjDxolV
   3zGeuNSVy7kkuKdgajvQequ5270cn+IN4yLynhT+3JPO/IHUQE1xOqblL
   v+2K87VNKu7SvBs1OOkVfEeTIoALRf1VRRijt1Vcz5gZIKz11IoCzsBxA
   OUJvoi33CQtd6/HurqBnPaMAz+NJUrmQR8yigtB2ctHp2Xv3iozOwhM7U
   OzJWRoZFq2ingy3NR0aca1EoOWUvvNyzT3ckrwASynWjRlSt86UTkEtnm
   ugcvKcGwRm7rxa8S+sAOmRkX+YXPD+Sb0F3RrLF/1blmwXkwde5ad+gZ1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="442819316"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="442819316"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:16:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="955417586"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="955417586"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jun 2023 11:16:17 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6Eka-0004Kl-2Z;
        Mon, 05 Jun 2023 18:16:16 +0000
Date:   Tue, 06 Jun 2023 02:15:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 2076b2a4a6b7e36a33dad178ff6f7c45657b00cc
Message-ID: <20230605181557.s06qd%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 2076b2a4a6b7e36a33dad178ff6f7c45657b00cc  Merge 6.4-rc5 into tty-next

elapsed time: 726m

configs tested: 279
configs skipped: 26

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230605   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230605   gcc  
alpha                randconfig-r013-20230605   gcc  
alpha                randconfig-r016-20230605   gcc  
alpha                randconfig-r033-20230605   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230605   gcc  
arc          buildonly-randconfig-r004-20230605   gcc  
arc          buildonly-randconfig-r005-20230605   gcc  
arc          buildonly-randconfig-r006-20230605   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r004-20230605   gcc  
arc                  randconfig-r015-20230605   gcc  
arc                  randconfig-r016-20230605   gcc  
arc                  randconfig-r025-20230605   gcc  
arc                  randconfig-r026-20230605   gcc  
arc                  randconfig-r043-20230605   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r003-20230605   clang
arm                                 defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                          pxa168_defconfig   clang
arm                  randconfig-r005-20230605   gcc  
arm                  randconfig-r021-20230605   clang
arm                  randconfig-r031-20230605   gcc  
arm                  randconfig-r036-20230605   gcc  
arm                  randconfig-r046-20230605   clang
arm                         s5pv210_defconfig   clang
arm                           sama7_defconfig   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230605   clang
arm64        buildonly-randconfig-r006-20230605   clang
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230605   clang
arm64                randconfig-r012-20230605   gcc  
arm64                randconfig-r026-20230605   gcc  
arm64                randconfig-r034-20230605   clang
csky         buildonly-randconfig-r001-20230605   gcc  
csky         buildonly-randconfig-r005-20230605   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230605   gcc  
csky                 randconfig-r004-20230605   gcc  
csky                 randconfig-r005-20230605   gcc  
csky                 randconfig-r012-20230605   gcc  
csky                 randconfig-r014-20230605   gcc  
csky                 randconfig-r015-20230605   gcc  
csky                 randconfig-r032-20230605   gcc  
hexagon                          alldefconfig   clang
hexagon              randconfig-r003-20230605   clang
hexagon              randconfig-r004-20230605   clang
hexagon              randconfig-r005-20230605   clang
hexagon              randconfig-r026-20230605   clang
hexagon              randconfig-r031-20230605   clang
hexagon              randconfig-r035-20230605   clang
hexagon              randconfig-r036-20230605   clang
hexagon              randconfig-r041-20230605   clang
hexagon              randconfig-r045-20230605   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230605   clang
i386                 randconfig-i002-20230605   clang
i386                 randconfig-i003-20230605   clang
i386                 randconfig-i004-20230605   clang
i386                 randconfig-i005-20230605   clang
i386                 randconfig-i006-20230605   clang
i386                 randconfig-i011-20230605   gcc  
i386                 randconfig-i012-20230605   gcc  
i386                 randconfig-i013-20230605   gcc  
i386                 randconfig-i014-20230605   gcc  
i386                 randconfig-i015-20230605   gcc  
i386                 randconfig-i016-20230605   gcc  
i386                 randconfig-i051-20230605   clang
i386                 randconfig-i052-20230605   clang
i386                 randconfig-i053-20230605   clang
i386                 randconfig-i054-20230605   clang
i386                 randconfig-i055-20230605   clang
i386                 randconfig-i056-20230605   clang
i386                 randconfig-i061-20230605   clang
i386                 randconfig-i062-20230605   clang
i386                 randconfig-i063-20230605   clang
i386                 randconfig-i064-20230605   clang
i386                 randconfig-i065-20230605   clang
i386                 randconfig-i066-20230605   clang
i386                 randconfig-r002-20230605   clang
i386                 randconfig-r021-20230605   gcc  
i386                 randconfig-r022-20230605   gcc  
i386                 randconfig-r032-20230605   clang
ia64                        generic_defconfig   gcc  
ia64                      gensparse_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r004-20230605   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230605   gcc  
loongarch            randconfig-r033-20230605   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k         buildonly-randconfig-r001-20230605   gcc  
m68k         buildonly-randconfig-r006-20230605   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                 randconfig-r006-20230605   gcc  
m68k                 randconfig-r014-20230605   gcc  
m68k                 randconfig-r023-20230605   gcc  
microblaze   buildonly-randconfig-r004-20230605   gcc  
microblaze   buildonly-randconfig-r006-20230605   gcc  
microblaze           randconfig-r001-20230605   gcc  
microblaze           randconfig-r004-20230605   gcc  
microblaze           randconfig-r006-20230605   gcc  
microblaze           randconfig-r016-20230605   gcc  
microblaze           randconfig-r023-20230605   gcc  
microblaze           randconfig-r026-20230605   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips         buildonly-randconfig-r002-20230605   gcc  
mips         buildonly-randconfig-r003-20230605   gcc  
mips         buildonly-randconfig-r005-20230605   gcc  
mips                           gcw0_defconfig   gcc  
mips                           ip28_defconfig   clang
mips                      malta_kvm_defconfig   clang
mips                      pic32mzda_defconfig   clang
mips                 randconfig-r002-20230605   gcc  
mips                 randconfig-r035-20230605   gcc  
nios2        buildonly-randconfig-r005-20230605   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230605   gcc  
nios2                randconfig-r003-20230605   gcc  
nios2                randconfig-r005-20230605   gcc  
nios2                randconfig-r011-20230605   gcc  
nios2                randconfig-r014-20230605   gcc  
nios2                randconfig-r015-20230605   gcc  
nios2                randconfig-r016-20230605   gcc  
nios2                randconfig-r024-20230605   gcc  
nios2                randconfig-r032-20230605   gcc  
nios2                randconfig-r035-20230605   gcc  
openrisc     buildonly-randconfig-r001-20230605   gcc  
openrisc     buildonly-randconfig-r003-20230605   gcc  
openrisc     buildonly-randconfig-r004-20230605   gcc  
openrisc     buildonly-randconfig-r005-20230605   gcc  
openrisc             randconfig-r001-20230605   gcc  
openrisc             randconfig-r002-20230605   gcc  
openrisc             randconfig-r016-20230605   gcc  
openrisc             randconfig-r034-20230605   gcc  
openrisc             randconfig-r036-20230605   gcc  
parisc       buildonly-randconfig-r003-20230605   gcc  
parisc       buildonly-randconfig-r004-20230605   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc               randconfig-r012-20230605   gcc  
parisc               randconfig-r014-20230605   gcc  
parisc               randconfig-r015-20230605   gcc  
parisc               randconfig-r025-20230605   gcc  
parisc               randconfig-r032-20230605   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230605   gcc  
powerpc      buildonly-randconfig-r003-20230605   gcc  
powerpc                       ebony_defconfig   clang
powerpc                       eiger_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc                      makalu_defconfig   gcc  
powerpc                     mpc5200_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc              randconfig-r001-20230605   clang
powerpc              randconfig-r003-20230605   clang
powerpc              randconfig-r012-20230605   gcc  
powerpc              randconfig-r015-20230605   gcc  
powerpc              randconfig-r021-20230605   gcc  
powerpc              randconfig-r025-20230605   gcc  
powerpc              randconfig-r036-20230605   clang
powerpc                     tqm8560_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230605   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230605   clang
riscv                randconfig-r006-20230605   clang
riscv                randconfig-r022-20230605   gcc  
riscv                randconfig-r031-20230605   clang
riscv                randconfig-r042-20230605   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230605   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r015-20230605   gcc  
s390                 randconfig-r022-20230605   gcc  
s390                 randconfig-r044-20230605   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230605   gcc  
sh           buildonly-randconfig-r004-20230605   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                   randconfig-r013-20230605   gcc  
sh                   randconfig-r034-20230605   gcc  
sh                           se7206_defconfig   gcc  
sparc        buildonly-randconfig-r001-20230605   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230605   gcc  
sparc                randconfig-r003-20230605   gcc  
sparc                randconfig-r006-20230605   gcc  
sparc                randconfig-r012-20230605   gcc  
sparc                randconfig-r022-20230605   gcc  
sparc                randconfig-r023-20230605   gcc  
sparc                randconfig-r024-20230605   gcc  
sparc                randconfig-r025-20230605   gcc  
sparc                randconfig-r026-20230605   gcc  
sparc                randconfig-r033-20230605   gcc  
sparc64      buildonly-randconfig-r001-20230605   gcc  
sparc64      buildonly-randconfig-r002-20230605   gcc  
sparc64      buildonly-randconfig-r003-20230605   gcc  
sparc64      buildonly-randconfig-r006-20230605   gcc  
sparc64              randconfig-r011-20230605   gcc  
sparc64              randconfig-r023-20230605   gcc  
sparc64              randconfig-r024-20230605   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230605   clang
x86_64               randconfig-a002-20230605   clang
x86_64               randconfig-a003-20230605   clang
x86_64               randconfig-a004-20230605   clang
x86_64               randconfig-a005-20230605   clang
x86_64               randconfig-a006-20230605   clang
x86_64               randconfig-a011-20230605   gcc  
x86_64               randconfig-a012-20230605   gcc  
x86_64               randconfig-a013-20230605   gcc  
x86_64               randconfig-a014-20230605   gcc  
x86_64               randconfig-a015-20230605   gcc  
x86_64               randconfig-a016-20230605   gcc  
x86_64               randconfig-r004-20230605   clang
x86_64               randconfig-r016-20230605   gcc  
x86_64               randconfig-r021-20230605   gcc  
x86_64               randconfig-r023-20230605   gcc  
x86_64               randconfig-r024-20230605   gcc  
x86_64               randconfig-x051-20230605   gcc  
x86_64               randconfig-x052-20230605   gcc  
x86_64               randconfig-x053-20230605   gcc  
x86_64               randconfig-x054-20230605   gcc  
x86_64               randconfig-x055-20230605   gcc  
x86_64               randconfig-x056-20230605   gcc  
x86_64               randconfig-x061-20230605   gcc  
x86_64               randconfig-x062-20230605   gcc  
x86_64               randconfig-x063-20230605   gcc  
x86_64               randconfig-x064-20230605   gcc  
x86_64               randconfig-x065-20230605   gcc  
x86_64               randconfig-x066-20230605   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230605   gcc  
xtensa       buildonly-randconfig-r006-20230605   gcc  
xtensa                       common_defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa               randconfig-r002-20230605   gcc  
xtensa               randconfig-r004-20230605   gcc  
xtensa               randconfig-r006-20230605   gcc  
xtensa               randconfig-r011-20230605   gcc  
xtensa               randconfig-r012-20230605   gcc  
xtensa               randconfig-r013-20230605   gcc  
xtensa               randconfig-r015-20230605   gcc  
xtensa               randconfig-r036-20230605   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
