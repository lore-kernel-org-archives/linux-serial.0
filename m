Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3257FC7618D
	for <linux-serial@archiver.kernel.org>; Thu,  6 Apr 2023 17:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbjDFRxX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 Apr 2023 13:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240113AbjDFRxQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 Apr 2023 13:53:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A057A5D9
        for <linux-serial@vger.kernel.org>; Thu,  6 Apr 2023 10:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680803585; x=1712339585;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1TbMl7UPCC0uJv5CC2jYPy9kf2RjMPh+zFRlLmud1QQ=;
  b=Dq0Vktm3+MKwuqJISM5c7lNCnz4yDQz8AhCtFzFeI6KTkJ/KXGQRX51Y
   DGjv6iSMhqjZmL+D5d+j5Esg+PeogVVr7k5aMT+0s0O/5laks6QTFioez
   OXM62Y6w+NZRaX1HtzOtn+PHr+Vh57qgXH8ZU+n2qcjaqJFeXoNjchkiS
   087mx6Ux6E1vkNc/iIxJDbNoWWNGel2XlE8nTKzQbpOitu3GDUe6n/i5c
   F6vAnvnOkGC9oNmg/vowa4I0zC2EQD/ISD81oQ22OZIC3K0T9skFba6er
   wivnYRLMuNi5lce+yir2ilr/ZdGYMPBkzw++HsCKfwvMqZcYwL0G/lxDH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="341541348"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="341541348"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 10:53:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="719791247"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="719791247"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 Apr 2023 10:53:03 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkTnC-000RZw-1R;
        Thu, 06 Apr 2023 17:53:02 +0000
Date:   Fri, 07 Apr 2023 01:52:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 86c276b91c4a4faea90e8399b1aba580e9df1cb5
Message-ID: <642f06ed.c9jNSQZTCgWgl3By%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 86c276b91c4a4faea90e8399b1aba580e9df1cb5  dt-bindings: serial: fsl-lpuart: add optional power-domains property

elapsed time: 1435m

configs tested: 273
configs skipped: 22

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230403   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230403   gcc  
alpha                randconfig-r003-20230405   gcc  
alpha                randconfig-r005-20230403   gcc  
alpha                randconfig-r016-20230403   gcc  
alpha                randconfig-r021-20230403   gcc  
alpha                randconfig-r023-20230403   gcc  
alpha                randconfig-r034-20230403   gcc  
alpha                randconfig-r036-20230403   gcc  
alpha                randconfig-r036-20230404   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230403   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230405   gcc  
arc                  randconfig-r002-20230403   gcc  
arc                  randconfig-r004-20230403   gcc  
arc                  randconfig-r016-20230403   gcc  
arc                  randconfig-r033-20230403   gcc  
arc                  randconfig-r034-20230403   gcc  
arc                  randconfig-r043-20230403   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                             pxa_defconfig   gcc  
arm                  randconfig-r005-20230405   gcc  
arm                  randconfig-r021-20230403   clang
arm                  randconfig-r025-20230405   clang
arm                  randconfig-r031-20230403   gcc  
arm                  randconfig-r032-20230405   gcc  
arm                  randconfig-r034-20230403   gcc  
arm                  randconfig-r035-20230403   gcc  
arm                  randconfig-r046-20230403   clang
arm                           sunxi_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230403   clang
arm64                randconfig-r012-20230403   gcc  
arm64                randconfig-r015-20230403   gcc  
arm64                randconfig-r021-20230403   gcc  
arm64                randconfig-r022-20230403   gcc  
arm64                randconfig-r024-20230403   gcc  
arm64                randconfig-r026-20230405   gcc  
arm64                randconfig-r035-20230403   clang
csky         buildonly-randconfig-r001-20230403   gcc  
csky         buildonly-randconfig-r002-20230403   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230405   gcc  
csky                 randconfig-r011-20230403   gcc  
csky                 randconfig-r012-20230403   gcc  
csky                 randconfig-r013-20230403   gcc  
csky                 randconfig-r033-20230403   gcc  
csky                 randconfig-r035-20230403   gcc  
csky                 randconfig-r036-20230405   gcc  
hexagon      buildonly-randconfig-r001-20230403   clang
hexagon      buildonly-randconfig-r006-20230404   clang
hexagon              randconfig-r012-20230403   clang
hexagon              randconfig-r024-20230403   clang
hexagon              randconfig-r024-20230405   clang
hexagon              randconfig-r035-20230403   clang
hexagon              randconfig-r041-20230403   clang
hexagon              randconfig-r041-20230406   clang
hexagon              randconfig-r045-20230403   clang
hexagon              randconfig-r045-20230406   clang
i386                             allyesconfig   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230403   clang
i386                 randconfig-a002-20230403   clang
i386                 randconfig-a003-20230403   clang
i386                 randconfig-a004-20230403   clang
i386                 randconfig-a005-20230403   clang
i386                 randconfig-a006-20230403   clang
i386                 randconfig-a011-20230403   gcc  
i386                 randconfig-a012-20230403   gcc  
i386                 randconfig-a013-20230403   gcc  
i386                 randconfig-a014-20230403   gcc  
i386                 randconfig-a015-20230403   gcc  
i386                 randconfig-a016-20230403   gcc  
i386                 randconfig-r014-20230403   gcc  
i386                 randconfig-r015-20230403   gcc  
i386                 randconfig-r016-20230403   gcc  
i386                 randconfig-r022-20230403   gcc  
i386                 randconfig-r026-20230403   gcc  
i386                 randconfig-r036-20230403   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r002-20230403   gcc  
ia64         buildonly-randconfig-r004-20230403   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230403   gcc  
ia64                 randconfig-r006-20230406   gcc  
ia64                 randconfig-r024-20230403   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230405   gcc  
loongarch            randconfig-r006-20230403   gcc  
loongarch            randconfig-r013-20230403   gcc  
loongarch            randconfig-r023-20230405   gcc  
loongarch            randconfig-r026-20230403   gcc  
loongarch            randconfig-r031-20230403   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                 randconfig-r001-20230403   gcc  
m68k                 randconfig-r003-20230406   gcc  
m68k                 randconfig-r012-20230403   gcc  
m68k                 randconfig-r014-20230403   gcc  
m68k                 randconfig-r021-20230405   gcc  
m68k                 randconfig-r023-20230403   gcc  
m68k                 randconfig-r024-20230403   gcc  
m68k                 randconfig-r034-20230404   gcc  
microblaze   buildonly-randconfig-r005-20230403   gcc  
microblaze   buildonly-randconfig-r006-20230403   gcc  
microblaze           randconfig-r005-20230403   gcc  
microblaze           randconfig-r011-20230403   gcc  
microblaze           randconfig-r016-20230403   gcc  
microblaze           randconfig-r031-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips         buildonly-randconfig-r001-20230403   gcc  
mips         buildonly-randconfig-r006-20230405   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                 randconfig-r002-20230405   gcc  
mips                 randconfig-r021-20230403   clang
mips                 randconfig-r022-20230405   clang
mips                 randconfig-r024-20230403   clang
mips                 randconfig-r026-20230403   clang
nios2        buildonly-randconfig-r003-20230403   gcc  
nios2        buildonly-randconfig-r004-20230403   gcc  
nios2        buildonly-randconfig-r006-20230403   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230406   gcc  
nios2                randconfig-r014-20230403   gcc  
nios2                randconfig-r033-20230404   gcc  
openrisc     buildonly-randconfig-r002-20230405   gcc  
openrisc     buildonly-randconfig-r006-20230403   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r006-20230405   gcc  
openrisc             randconfig-r011-20230403   gcc  
openrisc             randconfig-r016-20230403   gcc  
openrisc             randconfig-r022-20230403   gcc  
openrisc             randconfig-r026-20230403   gcc  
openrisc             randconfig-r034-20230403   gcc  
openrisc                 simple_smp_defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc       buildonly-randconfig-r003-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230405   gcc  
parisc               randconfig-r011-20230403   gcc  
parisc               randconfig-r013-20230403   gcc  
parisc               randconfig-r034-20230403   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230403   gcc  
powerpc      buildonly-randconfig-r003-20230404   clang
powerpc      buildonly-randconfig-r005-20230403   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc                     pq2fads_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc              randconfig-r012-20230403   gcc  
powerpc              randconfig-r013-20230403   gcc  
powerpc              randconfig-r014-20230403   gcc  
powerpc              randconfig-r015-20230403   gcc  
powerpc              randconfig-r025-20230403   gcc  
powerpc              randconfig-r036-20230403   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230403   gcc  
riscv        buildonly-randconfig-r004-20230405   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230403   gcc  
riscv                randconfig-r013-20230403   gcc  
riscv                randconfig-r014-20230403   gcc  
riscv                randconfig-r015-20230403   gcc  
riscv                randconfig-r016-20230403   gcc  
riscv                randconfig-r042-20230403   gcc  
riscv                randconfig-r042-20230406   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230403   clang
s390                 randconfig-r005-20230406   gcc  
s390                 randconfig-r031-20230404   gcc  
s390                 randconfig-r044-20230403   gcc  
s390                 randconfig-r044-20230406   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230403   gcc  
sh           buildonly-randconfig-r003-20230403   gcc  
sh           buildonly-randconfig-r005-20230403   gcc  
sh                            migor_defconfig   gcc  
sh                   randconfig-r001-20230403   gcc  
sh                   randconfig-r002-20230406   gcc  
sh                   randconfig-r003-20230403   gcc  
sh                   randconfig-r005-20230405   gcc  
sh                   randconfig-r025-20230405   gcc  
sh                   randconfig-r026-20230403   gcc  
sh                   randconfig-r031-20230403   gcc  
sh                   randconfig-r036-20230403   gcc  
sh                          rsk7264_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc        buildonly-randconfig-r004-20230403   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230403   gcc  
sparc                randconfig-r021-20230403   gcc  
sparc                randconfig-r024-20230403   gcc  
sparc                randconfig-r025-20230403   gcc  
sparc                randconfig-r032-20230403   gcc  
sparc64      buildonly-randconfig-r002-20230403   gcc  
sparc64      buildonly-randconfig-r006-20230403   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r004-20230405   gcc  
sparc64              randconfig-r004-20230406   gcc  
sparc64              randconfig-r014-20230403   gcc  
sparc64              randconfig-r022-20230403   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230403   clang
x86_64               randconfig-a002-20230403   clang
x86_64               randconfig-a003-20230403   clang
x86_64               randconfig-a004-20230403   clang
x86_64               randconfig-a005-20230403   clang
x86_64               randconfig-a006-20230403   clang
x86_64               randconfig-a011-20230403   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230403   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230403   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-k001-20230403   gcc  
x86_64               randconfig-r001-20230403   clang
x86_64               randconfig-r012-20230403   gcc  
x86_64               randconfig-r013-20230403   gcc  
x86_64               randconfig-r023-20230403   gcc  
x86_64               randconfig-r026-20230403   gcc  
x86_64               randconfig-r032-20230403   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230403   gcc  
xtensa               randconfig-r001-20230403   gcc  
xtensa               randconfig-r012-20230403   gcc  
xtensa               randconfig-r021-20230403   gcc  
xtensa               randconfig-r022-20230403   gcc  
xtensa               randconfig-r033-20230403   gcc  
xtensa               randconfig-r035-20230404   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
