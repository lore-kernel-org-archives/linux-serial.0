Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F11EB64DC
	for <linux-serial@archiver.kernel.org>; Fri, 21 Jul 2023 05:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjGUFyJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 Jul 2023 01:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGUFyB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 Jul 2023 01:54:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FFD10E5
        for <linux-serial@vger.kernel.org>; Thu, 20 Jul 2023 22:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689918840; x=1721454840;
  h=date:from:to:cc:subject:message-id;
  bh=oHszbNaz3uX6ji90NUPSCVBi6hYn/ZzSPELwDnlLXpc=;
  b=U5XtKTPrUpJBDPuoUMyKHA5FeRhwOy87ia51uX6IqcRIcdqt0kmScBNM
   X9/9pBDSd8BczK+CeZ/rN8M7Vy5IDg11fHhYWmIzpbZUPaUtVbdkiufeX
   Wroy9zuLNOzozC7yI0PQvKubhSXFZ2Y7GOaLPahZ97SVZx2c/w6mto5QW
   zt5T0tIetCoPxc6zzdGGJ5jMC7w0xGql5ySVJwuDejAkWCF/+cWhYz0TW
   zwc5wZ45IwZOS+8Uv4Sxcu9JTGTNanR9+GU/U7EAPTz9c3SrtU4GbJHB5
   Bf7IPOlqyM8brk6JseXfV1zjU2F/5b0G7q73uV/OX1vGN3JhjZjTCS+1B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="370544095"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="370544095"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 22:53:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="754326022"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="754326022"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 20 Jul 2023 22:53:58 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMj5S-0006vy-0g;
        Fri, 21 Jul 2023 05:53:58 +0000
Date:   Fri, 21 Jul 2023 13:53:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 690c8b804ad2eafbd35da5d3c95ad325ca7d5061
Message-ID: <202307211320.FJl9rNwh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 690c8b804ad2eafbd35da5d3c95ad325ca7d5061  TIOCSTI: always enable for CAP_SYS_ADMIN

elapsed time: 723m

configs tested: 128
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230720   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                  randconfig-r004-20230720   gcc  
arc                  randconfig-r032-20230720   gcc  
arc                  randconfig-r043-20230720   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r035-20230720   clang
arm                  randconfig-r046-20230720   gcc  
arm                         s3c6400_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230720   gcc  
arm64                randconfig-r012-20230720   clang
arm64                randconfig-r023-20230720   clang
arm64                randconfig-r026-20230720   clang
csky                                defconfig   gcc  
hexagon              randconfig-r022-20230720   clang
hexagon              randconfig-r036-20230720   clang
hexagon              randconfig-r041-20230720   clang
hexagon              randconfig-r045-20230720   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230720   gcc  
i386         buildonly-randconfig-r005-20230720   gcc  
i386         buildonly-randconfig-r006-20230720   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230720   gcc  
i386                 randconfig-i002-20230720   gcc  
i386                 randconfig-i003-20230720   gcc  
i386                 randconfig-i004-20230720   gcc  
i386                 randconfig-i005-20230720   gcc  
i386                 randconfig-i006-20230720   gcc  
i386                 randconfig-i011-20230720   clang
i386                 randconfig-i012-20230720   clang
i386                 randconfig-i013-20230720   clang
i386                 randconfig-i014-20230720   clang
i386                 randconfig-i015-20230720   clang
i386                 randconfig-i016-20230720   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r033-20230720   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230720   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                 randconfig-r024-20230720   gcc  
mips                 randconfig-r025-20230720   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230720   gcc  
nios2                randconfig-r015-20230720   gcc  
openrisc             randconfig-r034-20230720   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230720   gcc  
parisc               randconfig-r005-20230720   gcc  
parisc               randconfig-r031-20230720   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                      ppc40x_defconfig   gcc  
powerpc              randconfig-r024-20230720   clang
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230720   gcc  
riscv                randconfig-r042-20230720   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230720   gcc  
s390                 randconfig-r013-20230720   clang
s390                 randconfig-r035-20230720   gcc  
s390                 randconfig-r044-20230720   clang
sh                               allmodconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                   randconfig-r003-20230720   gcc  
sh                   randconfig-r013-20230720   gcc  
sh                          rsk7201_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r016-20230720   gcc  
sparc64              randconfig-r036-20230720   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r021-20230720   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230720   gcc  
x86_64       buildonly-randconfig-r002-20230720   gcc  
x86_64       buildonly-randconfig-r003-20230720   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r011-20230720   clang
x86_64               randconfig-r016-20230720   clang
x86_64               randconfig-x001-20230720   clang
x86_64               randconfig-x002-20230720   clang
x86_64               randconfig-x003-20230720   clang
x86_64               randconfig-x004-20230720   clang
x86_64               randconfig-x005-20230720   clang
x86_64               randconfig-x006-20230720   clang
x86_64               randconfig-x011-20230720   gcc  
x86_64               randconfig-x012-20230720   gcc  
x86_64               randconfig-x013-20230720   gcc  
x86_64               randconfig-x014-20230720   gcc  
x86_64               randconfig-x015-20230720   gcc  
x86_64               randconfig-x016-20230720   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
