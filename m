Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0F9C77B7D
	for <linux-serial@archiver.kernel.org>; Sun, 14 May 2023 00:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjENA1W (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 13 May 2023 20:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjENA1W (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 13 May 2023 20:27:22 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE9F19BC
        for <linux-serial@vger.kernel.org>; Sat, 13 May 2023 17:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684024040; x=1715560040;
  h=date:from:to:cc:subject:message-id;
  bh=30LisDwIApibTb1ShG9rMb5IjqnXumjZUsAFhdASPEw=;
  b=hrf4q3wqOT6G8QDFxZ/fToy3P4OW99jNggyIQ6zsbiuOXYZSSFqwy6Xw
   C88cGH9PPF4Ymce5vXsDqN/WpOhv42SGMA202UPF80Y9wfozrXAJuY31I
   A11+NitXkbLDvwRpsvAbq+XvCIycWPnvm5ZM4HDX5uaQheabVziKYjTRx
   lEWfYoRCKGJ+HAOK2ptXIRLGgTREPxjefsgJ1YEgpcZw+9ZJgTLSKWfhS
   et8NT0KRubYDtw3XeFQGofgAtBl7e3Zel27ZNziAERbjyKIeZSbyztZvZ
   Y9TzWNFuEDe2Y2XGxLCI/vEo/qUw5AHCr0IxEFYtISB4+yzO1cl/k7CMP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="335522002"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="335522002"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 17:27:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="1030461107"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="1030461107"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2023 17:27:18 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxza2-0005ke-0T;
        Sun, 14 May 2023 00:27:18 +0000
Date:   Sun, 14 May 2023 08:27:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 8fb9ea65c9d1338b0d2bb0a9122dc942cdd32357
Message-ID: <20230514002712.tYiby%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 8fb9ea65c9d1338b0d2bb0a9122dc942cdd32357  vc_screen: reload load of struct vc_data pointer in vcs_write() to avoid UAF

elapsed time: 790m

configs tested: 192
configs skipped: 19

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230511   gcc  
alpha                randconfig-r006-20230511   gcc  
alpha                randconfig-r016-20230509   gcc  
alpha                randconfig-r021-20230511   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230509   gcc  
arc                  randconfig-r043-20230509   gcc  
arc                  randconfig-r043-20230511   gcc  
arc                  randconfig-r043-20230513   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                  randconfig-r013-20230512   gcc  
arm                  randconfig-r032-20230513   gcc  
arm                  randconfig-r046-20230509   gcc  
arm                  randconfig-r046-20230511   clang
arm                  randconfig-r046-20230513   clang
arm                         s3c6400_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230509   clang
arm64                randconfig-r014-20230509   clang
arm64                randconfig-r025-20230511   gcc  
arm64                randconfig-r026-20230512   clang
csky         buildonly-randconfig-r001-20230511   gcc  
csky         buildonly-randconfig-r002-20230511   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r005-20230511   gcc  
csky                 randconfig-r011-20230509   gcc  
csky                 randconfig-r022-20230512   gcc  
csky                 randconfig-r031-20230511   gcc  
csky                 randconfig-r031-20230513   gcc  
csky                 randconfig-r032-20230509   gcc  
hexagon      buildonly-randconfig-r003-20230509   clang
hexagon              randconfig-r004-20230509   clang
hexagon              randconfig-r013-20230513   clang
hexagon              randconfig-r014-20230513   clang
hexagon              randconfig-r025-20230512   clang
hexagon              randconfig-r032-20230511   clang
hexagon              randconfig-r033-20230509   clang
hexagon              randconfig-r033-20230511   clang
hexagon              randconfig-r041-20230509   clang
hexagon              randconfig-r041-20230511   clang
hexagon              randconfig-r041-20230513   clang
hexagon              randconfig-r045-20230509   clang
hexagon              randconfig-r045-20230511   clang
hexagon              randconfig-r045-20230513   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230513   gcc  
ia64                 randconfig-r005-20230513   gcc  
ia64                 randconfig-r006-20230509   gcc  
ia64                 randconfig-r011-20230512   gcc  
ia64                 randconfig-r023-20230511   gcc  
ia64                 randconfig-r032-20230512   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230513   gcc  
loongarch    buildonly-randconfig-r004-20230513   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r023-20230513   gcc  
loongarch            randconfig-r036-20230511   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230509   gcc  
m68k                 randconfig-r013-20230509   gcc  
microblaze   buildonly-randconfig-r003-20230513   gcc  
microblaze                      mmu_defconfig   gcc  
microblaze           randconfig-r024-20230512   gcc  
microblaze           randconfig-r031-20230509   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips         buildonly-randconfig-r002-20230513   gcc  
mips         buildonly-randconfig-r003-20230511   gcc  
mips                         db1xxx_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   clang
mips                 randconfig-r004-20230511   gcc  
mips                 randconfig-r004-20230513   gcc  
mips                 randconfig-r026-20230513   clang
nios2        buildonly-randconfig-r006-20230509   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r016-20230511   gcc  
nios2                randconfig-r036-20230509   gcc  
openrisc             randconfig-r001-20230513   gcc  
openrisc             randconfig-r021-20230510   gcc  
openrisc             randconfig-r023-20230512   gcc  
parisc       buildonly-randconfig-r004-20230511   gcc  
parisc       buildonly-randconfig-r005-20230511   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230513   gcc  
parisc               randconfig-r021-20230512   gcc  
parisc               randconfig-r023-20230510   gcc  
parisc               randconfig-r035-20230512   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc      buildonly-randconfig-r005-20230509   clang
powerpc                 mpc8560_ads_defconfig   clang
powerpc                    mvme5100_defconfig   clang
powerpc              randconfig-r003-20230511   clang
powerpc              randconfig-r005-20230509   gcc  
powerpc              randconfig-r014-20230511   gcc  
powerpc              randconfig-r021-20230513   gcc  
powerpc              randconfig-r025-20230510   clang
powerpc              randconfig-r034-20230511   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r022-20230511   gcc  
riscv                randconfig-r026-20230510   clang
riscv                randconfig-r026-20230511   gcc  
riscv                randconfig-r035-20230513   clang
riscv                randconfig-r036-20230512   gcc  
riscv                randconfig-r042-20230509   clang
riscv                randconfig-r042-20230511   gcc  
riscv                randconfig-r042-20230513   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230513   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r013-20230511   gcc  
s390                 randconfig-r015-20230512   clang
s390                 randconfig-r016-20230512   clang
s390                 randconfig-r022-20230513   gcc  
s390                 randconfig-r033-20230512   gcc  
s390                 randconfig-r044-20230509   clang
s390                 randconfig-r044-20230511   gcc  
s390                 randconfig-r044-20230513   gcc  
sh                               allmodconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                   randconfig-r006-20230513   gcc  
sh                   randconfig-r011-20230513   gcc  
sh                   randconfig-r015-20230509   gcc  
sh                   randconfig-r015-20230511   gcc  
sh                   randconfig-r034-20230509   gcc  
sh                           se7722_defconfig   gcc  
sparc        buildonly-randconfig-r002-20230509   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230509   gcc  
sparc                randconfig-r011-20230511   gcc  
sparc                randconfig-r012-20230511   gcc  
sparc                randconfig-r024-20230513   gcc  
sparc                randconfig-r034-20230513   gcc  
sparc64              randconfig-r012-20230513   gcc  
sparc64              randconfig-r016-20230513   gcc  
sparc64              randconfig-r033-20230513   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230509   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
