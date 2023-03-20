Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4682C6FD1C
	for <linux-serial@archiver.kernel.org>; Mon, 20 Mar 2023 20:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCTU6H (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Mar 2023 16:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCTU6G (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Mar 2023 16:58:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8308C5580
        for <linux-serial@vger.kernel.org>; Mon, 20 Mar 2023 13:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679345884; x=1710881884;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2goys7sPk9kebmgWvRXSO8OatnnSXSa426ACB/bOw2k=;
  b=ejss0jbXIjp6/jf2RdZngSp2rlozfAEQGMM8rIU831FnICihEKjNOXyJ
   s/50Jcn1zW7yUoh2vzU7UvHaPCw9NsJ+YXjBREOx4NtXuABtCAHbNvthO
   BgURQ/6vPWSiNQYa86UWwX0c39WrXXj7d/f8bvCxqubuszU32aiB0GQZE
   ATAdVHB2/1iAsi/W2Q/KQt02iq1j6hcScByBHNDaJT8wiyjcfJLBsP4Eo
   EtsbMmwt4xNFwJbio5WhZk/PS9dAS7u1S/P2P7nPP2/p1h0kiSK3AZEYP
   ps34649H6chtBJS+EOnJLPJYUBqdsgp8S2OB+Bu+gKk+AFDQ/39ROrcQL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="322618604"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="322618604"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 13:58:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="713693051"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="713693051"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Mar 2023 13:58:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peMZo-000BJf-2m;
        Mon, 20 Mar 2023 20:57:56 +0000
Date:   Tue, 21 Mar 2023 04:57:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 f16a70c0472ea4cda3ab53fd3b5d2fa5628fb2c7
Message-ID: <6418c8c5./Q7m5ReJ7vK44g8O%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: f16a70c0472ea4cda3ab53fd3b5d2fa5628fb2c7  Merge 6.3-rc3 into tty-next

elapsed time: 723m

configs tested: 202
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230319   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230319   gcc  
alpha                randconfig-r025-20230320   gcc  
alpha                randconfig-r036-20230319   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230319   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230320   gcc  
arc                  randconfig-r012-20230319   gcc  
arc                  randconfig-r016-20230319   gcc  
arc                  randconfig-r025-20230319   gcc  
arc                  randconfig-r043-20230319   gcc  
arc                  randconfig-r043-20230320   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r005-20230319   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r006-20230319   clang
arm                  randconfig-r032-20230319   clang
arm                  randconfig-r034-20230320   gcc  
arm                  randconfig-r046-20230319   gcc  
arm                  randconfig-r046-20230320   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230320   clang
arm64                randconfig-r011-20230320   gcc  
arm64                randconfig-r016-20230320   gcc  
arm64                randconfig-r024-20230319   clang
csky                                defconfig   gcc  
csky                 randconfig-r001-20230319   gcc  
csky                 randconfig-r006-20230320   gcc  
csky                 randconfig-r021-20230320   gcc  
hexagon      buildonly-randconfig-r001-20230319   clang
hexagon              randconfig-r001-20230319   clang
hexagon              randconfig-r003-20230320   clang
hexagon              randconfig-r004-20230320   clang
hexagon              randconfig-r006-20230320   clang
hexagon              randconfig-r025-20230320   clang
hexagon              randconfig-r032-20230319   clang
hexagon              randconfig-r036-20230320   clang
hexagon              randconfig-r041-20230319   clang
hexagon              randconfig-r041-20230320   clang
hexagon              randconfig-r045-20230319   clang
hexagon              randconfig-r045-20230320   clang
i386                             allyesconfig   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230320   clang
i386                 randconfig-a002-20230320   clang
i386                 randconfig-a003-20230320   clang
i386                 randconfig-a004-20230320   clang
i386                 randconfig-a005-20230320   clang
i386                 randconfig-a006-20230320   clang
i386                 randconfig-a011-20230320   gcc  
i386                          randconfig-a011   clang
i386                 randconfig-a012-20230320   gcc  
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230320   gcc  
i386                          randconfig-a013   clang
i386                 randconfig-a014-20230320   gcc  
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230320   gcc  
i386                          randconfig-a015   clang
i386                 randconfig-a016-20230320   gcc  
i386                          randconfig-a016   gcc  
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r003-20230319   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r011-20230320   gcc  
ia64                 randconfig-r022-20230320   gcc  
ia64                 randconfig-r033-20230319   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230319   gcc  
loongarch            randconfig-r004-20230320   gcc  
loongarch            randconfig-r034-20230319   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230319   gcc  
m68k                 randconfig-r014-20230320   gcc  
m68k                 randconfig-r023-20230320   gcc  
m68k                           virt_defconfig   gcc  
microblaze   buildonly-randconfig-r001-20230319   gcc  
microblaze           randconfig-r003-20230319   gcc  
microblaze           randconfig-r005-20230319   gcc  
microblaze           randconfig-r014-20230319   gcc  
microblaze           randconfig-r033-20230319   gcc  
microblaze           randconfig-r036-20230319   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                 randconfig-r005-20230320   gcc  
mips                 randconfig-r021-20230319   gcc  
mips                 randconfig-r033-20230320   gcc  
nios2                         3c120_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230320   gcc  
nios2                randconfig-r014-20230319   gcc  
nios2                randconfig-r022-20230319   gcc  
nios2                randconfig-r031-20230320   gcc  
nios2                randconfig-r034-20230319   gcc  
nios2                randconfig-r035-20230319   gcc  
openrisc             randconfig-r002-20230319   gcc  
openrisc             randconfig-r016-20230320   gcc  
openrisc             randconfig-r021-20230319   gcc  
openrisc             randconfig-r022-20230319   gcc  
openrisc             randconfig-r031-20230319   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230319   gcc  
parisc               randconfig-r023-20230319   gcc  
parisc               randconfig-r031-20230319   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230319   clang
powerpc                        fsp2_defconfig   clang
powerpc                 mpc85xx_cds_defconfig   gcc  
powerpc              randconfig-r006-20230319   gcc  
powerpc              randconfig-r013-20230320   gcc  
powerpc              randconfig-r015-20230320   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r023-20230319   clang
riscv                randconfig-r026-20230320   gcc  
riscv                randconfig-r032-20230320   clang
riscv                randconfig-r035-20230320   clang
riscv                randconfig-r042-20230319   clang
riscv                randconfig-r042-20230320   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230319   clang
s390                                defconfig   gcc  
s390                 randconfig-r021-20230319   clang
s390                 randconfig-r021-20230320   gcc  
s390                 randconfig-r035-20230319   gcc  
s390                 randconfig-r044-20230319   clang
s390                 randconfig-r044-20230320   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230319   gcc  
sh                   randconfig-r002-20230319   gcc  
sh                   randconfig-r005-20230320   gcc  
sh                   randconfig-r011-20230319   gcc  
sh                   randconfig-r013-20230319   gcc  
sh                   randconfig-r014-20230320   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sparc        buildonly-randconfig-r006-20230319   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230320   gcc  
sparc                randconfig-r003-20230320   gcc  
sparc                randconfig-r012-20230319   gcc  
sparc                randconfig-r015-20230320   gcc  
sparc                randconfig-r024-20230319   gcc  
sparc                randconfig-r025-20230319   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r001-20230320   gcc  
sparc64              randconfig-r006-20230319   gcc  
sparc64              randconfig-r015-20230319   gcc  
sparc64              randconfig-r024-20230320   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230320   clang
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230320   clang
x86_64                        randconfig-a002   gcc  
x86_64               randconfig-a003-20230320   clang
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230320   clang
x86_64                        randconfig-a004   gcc  
x86_64               randconfig-a005-20230320   clang
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230320   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64               randconfig-r022-20230320   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                          iss_defconfig   gcc  
xtensa               randconfig-r002-20230320   gcc  
xtensa               randconfig-r003-20230319   gcc  
xtensa               randconfig-r012-20230320   gcc  
xtensa               randconfig-r024-20230320   gcc  
xtensa               randconfig-r026-20230319   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
