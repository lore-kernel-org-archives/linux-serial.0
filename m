Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE678C6FD1D
	for <linux-serial@archiver.kernel.org>; Fri,  7 Apr 2023 19:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjDGTVS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 7 Apr 2023 15:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjDGTVP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 7 Apr 2023 15:21:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D468C14A
        for <linux-serial@vger.kernel.org>; Fri,  7 Apr 2023 12:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680895265; x=1712431265;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gmu7sIWY1m2MSiAM0KkMcbsufa5vowWidQUM2XaImfI=;
  b=jal0aw4cKUthHd7dT4sS+moRoh7Qj87fiG/1ZtlLqJhMNV9ZvSRVDqu5
   s3PLkIOtC/OP+K624VEVil74NAMd5UstWWnj1A34iV00Kv46rhf+S1D/6
   0vxuCR2N/SYwxjZV/MsvbG91CGspbRrkexTFj71jsg9k3LbQIgD7fVGWr
   5XB2cplA/eOFrSkKJ3ccJfT8fV0ycoiuBK2lM/kSqjulf2XpDutg3Y5Nx
   f2J1sElIZ/rnw0efHLqLAnhSFJj1RJQiKdQII9wB4jWuovYtqjSUu7I6v
   mc86R0kpsigIVjBuAgE9sXgd14G6ntzmckPwhXzzjtVPFwFjiM0HZLI81
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="343059867"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="343059867"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 12:21:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="681113840"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="681113840"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 07 Apr 2023 12:21:03 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkrdu-000Sob-0a;
        Fri, 07 Apr 2023 19:21:02 +0000
Date:   Sat, 08 Apr 2023 03:20:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 b2ea273a477cd6e83daedbfa1981cd1a7468f73a
Message-ID: <64306d13.ONswMlyWlVKLGkKR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: b2ea273a477cd6e83daedbfa1981cd1a7468f73a  tty: Fix typo in LEGACY_TIOCSTI Kconfig description

Unverified Warning (likely false positive, please contact us if interested):

drivers/tty/n_gsm.c:3751 gsmld_ioctl() warn: potential spectre issue 'gsm->dlci' [r] (local cap)
drivers/tty/n_gsm.c:3752 gsmld_ioctl() warn: possible spectre second half.  'dlci'

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-m001-20230403
    |-- drivers-tty-n_gsm.c-gsmld_ioctl()-warn:possible-spectre-second-half.-dlci
    `-- drivers-tty-n_gsm.c-gsmld_ioctl()-warn:potential-spectre-issue-gsm-dlci-r-(local-cap)

elapsed time: 727m

configs tested: 230
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230405   gcc  
alpha        buildonly-randconfig-r004-20230405   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230405   gcc  
alpha                randconfig-r005-20230403   gcc  
alpha                randconfig-r015-20230403   gcc  
alpha                randconfig-r023-20230403   gcc  
alpha                randconfig-r026-20230405   gcc  
alpha                randconfig-r036-20230403   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r001-20230405   gcc  
arc                  randconfig-r002-20230403   gcc  
arc                  randconfig-r016-20230403   gcc  
arc                  randconfig-r031-20230404   gcc  
arc                  randconfig-r033-20230403   gcc  
arc                  randconfig-r036-20230404   gcc  
arc                  randconfig-r043-20230403   gcc  
arc                  randconfig-r043-20230404   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                             mxs_defconfig   clang
arm                        neponset_defconfig   clang
arm                  randconfig-r005-20230405   gcc  
arm                  randconfig-r011-20230407   clang
arm                  randconfig-r015-20230403   clang
arm                  randconfig-r015-20230407   clang
arm                  randconfig-r021-20230403   clang
arm                  randconfig-r034-20230403   gcc  
arm                  randconfig-r046-20230403   clang
arm                  randconfig-r046-20230404   gcc  
arm                  randconfig-r046-20230407   clang
arm                        vexpress_defconfig   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230407   clang
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230403   gcc  
arm64                randconfig-r015-20230403   gcc  
arm64                randconfig-r021-20230403   gcc  
arm64                randconfig-r025-20230403   gcc  
arm64                randconfig-r032-20230403   clang
arm64                randconfig-r035-20230403   clang
csky         buildonly-randconfig-r001-20230403   gcc  
csky         buildonly-randconfig-r002-20230403   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230403   gcc  
csky                 randconfig-r002-20230405   gcc  
csky                 randconfig-r004-20230403   gcc  
csky                 randconfig-r012-20230403   gcc  
hexagon      buildonly-randconfig-r001-20230403   clang
hexagon              randconfig-r003-20230403   clang
hexagon              randconfig-r025-20230405   clang
hexagon              randconfig-r041-20230403   clang
hexagon              randconfig-r041-20230404   clang
hexagon              randconfig-r041-20230407   clang
hexagon              randconfig-r045-20230403   clang
hexagon              randconfig-r045-20230404   clang
hexagon              randconfig-r045-20230407   clang
i386                             allyesconfig   gcc  
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
i386                 randconfig-r022-20230403   gcc  
i386                 randconfig-r031-20230403   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r002-20230403   gcc  
ia64                                defconfig   gcc  
ia64                        generic_defconfig   gcc  
ia64                 randconfig-r002-20230403   gcc  
ia64                 randconfig-r006-20230406   gcc  
ia64                 randconfig-r011-20230403   gcc  
ia64                 randconfig-r024-20230405   gcc  
ia64                 randconfig-r033-20230404   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230405   gcc  
loongarch            randconfig-r006-20230403   gcc  
loongarch            randconfig-r013-20230403   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r001-20230403   gcc  
m68k                 randconfig-r003-20230406   gcc  
m68k                 randconfig-r005-20230403   gcc  
m68k                 randconfig-r012-20230403   gcc  
m68k                 randconfig-r016-20230403   gcc  
m68k                 randconfig-r024-20230403   gcc  
m68k                 randconfig-r033-20230403   gcc  
microblaze   buildonly-randconfig-r001-20230407   gcc  
microblaze   buildonly-randconfig-r006-20230403   gcc  
microblaze           randconfig-r031-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip28_defconfig   clang
mips                  maltasmvp_eva_defconfig   gcc  
mips                 randconfig-r002-20230405   gcc  
mips                 randconfig-r005-20230403   gcc  
mips                 randconfig-r024-20230403   clang
mips                 randconfig-r026-20230403   clang
mips                          rb532_defconfig   gcc  
nios2        buildonly-randconfig-r006-20230407   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230406   gcc  
nios2                randconfig-r014-20230403   gcc  
nios2                randconfig-r034-20230403   gcc  
openrisc     buildonly-randconfig-r001-20230403   gcc  
openrisc     buildonly-randconfig-r003-20230407   gcc  
openrisc     buildonly-randconfig-r006-20230403   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r006-20230403   gcc  
openrisc             randconfig-r006-20230405   gcc  
openrisc             randconfig-r011-20230403   gcc  
openrisc             randconfig-r014-20230407   gcc  
openrisc             randconfig-r026-20230403   gcc  
openrisc             randconfig-r035-20230403   gcc  
parisc       buildonly-randconfig-r003-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230403   gcc  
parisc               randconfig-r003-20230405   gcc  
parisc               randconfig-r011-20230403   gcc  
parisc               randconfig-r035-20230403   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                          allmodconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230403   gcc  
powerpc      buildonly-randconfig-r005-20230403   gcc  
powerpc                          g5_defconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                 mpc832x_rdb_defconfig   clang
powerpc              randconfig-r012-20230407   gcc  
powerpc              randconfig-r013-20230403   gcc  
powerpc              randconfig-r014-20230403   gcc  
powerpc              randconfig-r021-20230405   gcc  
powerpc              randconfig-r025-20230403   gcc  
powerpc              randconfig-r034-20230403   clang
powerpc              randconfig-r036-20230403   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_virt_defconfig   clang
riscv                randconfig-r023-20230405   gcc  
riscv                randconfig-r042-20230403   gcc  
riscv                randconfig-r042-20230404   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r006-20230405   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230406   gcc  
s390                 randconfig-r022-20230405   gcc  
s390                 randconfig-r034-20230404   gcc  
s390                 randconfig-r044-20230403   gcc  
s390                 randconfig-r044-20230404   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230403   gcc  
sh           buildonly-randconfig-r003-20230403   gcc  
sh           buildonly-randconfig-r005-20230403   gcc  
sh           buildonly-randconfig-r005-20230407   gcc  
sh                        edosk7760_defconfig   gcc  
sh                         microdev_defconfig   gcc  
sh                   randconfig-r002-20230406   gcc  
sh                   randconfig-r005-20230405   gcc  
sparc        buildonly-randconfig-r002-20230403   gcc  
sparc        buildonly-randconfig-r004-20230403   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230403   gcc  
sparc                randconfig-r032-20230403   gcc  
sparc64      buildonly-randconfig-r006-20230403   gcc  
sparc64              randconfig-r003-20230403   gcc  
sparc64              randconfig-r004-20230405   gcc  
sparc64              randconfig-r004-20230406   gcc  
sparc64              randconfig-r014-20230403   gcc  
sparc64              randconfig-r022-20230403   gcc  
sparc64              randconfig-r023-20230403   gcc  
sparc64              randconfig-r035-20230404   gcc  
sparc64              randconfig-r036-20230403   gcc  
um                                  defconfig   gcc  
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
x86_64                        randconfig-a011   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230403   gcc  
x86_64                        randconfig-a013   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230403   gcc  
x86_64                        randconfig-a015   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-k001-20230403   gcc  
x86_64               randconfig-r013-20230403   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230403   gcc  
xtensa       buildonly-randconfig-r005-20230403   gcc  
xtensa               randconfig-r006-20230403   gcc  
xtensa               randconfig-r013-20230407   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
