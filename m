Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830E4EB64DD
	for <linux-serial@archiver.kernel.org>; Mon, 31 Jul 2023 01:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjGaB4z (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 30 Jul 2023 21:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGaB4y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 30 Jul 2023 21:56:54 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7EBE71
        for <linux-serial@vger.kernel.org>; Sun, 30 Jul 2023 18:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690768614; x=1722304614;
  h=date:from:to:cc:subject:message-id;
  bh=+JB5Eov3iGcjy5gioeVTN29w0qCeXT5Pzu2s+AhxorA=;
  b=V35KxJEnpFYn4+mcJxiaSjG27pSbMimacYdR0CfOOOoSOfJkrNqrrv+N
   GAoPVu7H54jjdNZrULgkfE4AIiodT3qiwUqn8g52xgUtsscGJmQi3Y5gt
   AYE/bHrMU6J/CZAxG0/FEjnPrZTg9UrX6WZNPAHM7sD2QH3a3qbyft6rE
   jWO9HW3M3iAx4FmgAhS7Fx0YddO5brxUbWJE65iROsXrD7nCl90HpnvdN
   86LlGS0oEUFcFL7w5MHHu8FXwQPmo7yKEsBPXinGJGjIWoTxGoqqPKl5M
   rLxIdDpxTmorpc1nJv3GBh03m4ojMisp7WOpeRgfNzP2MIPvXywCTPVkj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="435197934"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="435197934"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 18:56:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="731410571"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="731410571"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jul 2023 18:56:52 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQI9T-0004re-2F;
        Mon, 31 Jul 2023 01:56:51 +0000
Date:   Mon, 31 Jul 2023 09:56:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 16aae4c64600a6319a6f10dbff833fa198bf9599
Message-ID: <202307310958.JYuBE3QU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 16aae4c64600a6319a6f10dbff833fa198bf9599  parport_pc: add support for ASIX AX99100

elapsed time: 818m

configs tested: 107
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230730   gcc  
arc                  randconfig-r043-20230730   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r013-20230730   clang
arm                  randconfig-r024-20230730   clang
arm                  randconfig-r046-20230730   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r023-20230730   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r002-20230730   clang
hexagon              randconfig-r016-20230730   clang
hexagon              randconfig-r036-20230730   clang
hexagon              randconfig-r041-20230730   clang
hexagon              randconfig-r045-20230730   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230730   clang
i386         buildonly-randconfig-r005-20230730   clang
i386         buildonly-randconfig-r006-20230730   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230730   clang
i386                 randconfig-i002-20230730   clang
i386                 randconfig-i003-20230730   clang
i386                 randconfig-i004-20230730   clang
i386                 randconfig-i005-20230730   clang
i386                 randconfig-i006-20230730   clang
i386                 randconfig-i011-20230730   gcc  
i386                 randconfig-i012-20230730   gcc  
i386                 randconfig-i013-20230730   gcc  
i386                 randconfig-i014-20230730   gcc  
i386                 randconfig-i015-20230730   gcc  
i386                 randconfig-i016-20230730   gcc  
i386                 randconfig-r015-20230730   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r022-20230730   gcc  
loongarch            randconfig-r034-20230730   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r021-20230730   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230730   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230730   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r014-20230730   gcc  
riscv                randconfig-r042-20230730   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230730   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r003-20230730   gcc  
sh                   randconfig-r005-20230730   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r035-20230730   gcc  
sparc64              randconfig-r025-20230730   gcc  
sparc64              randconfig-r032-20230730   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r033-20230730   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230730   clang
x86_64       buildonly-randconfig-r002-20230730   clang
x86_64       buildonly-randconfig-r003-20230730   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r001-20230730   clang
x86_64               randconfig-x001-20230730   gcc  
x86_64               randconfig-x002-20230730   gcc  
x86_64               randconfig-x003-20230730   gcc  
x86_64               randconfig-x004-20230730   gcc  
x86_64               randconfig-x005-20230730   gcc  
x86_64               randconfig-x006-20230730   gcc  
x86_64               randconfig-x011-20230730   clang
x86_64               randconfig-x012-20230730   clang
x86_64               randconfig-x013-20230730   clang
x86_64               randconfig-x014-20230730   clang
x86_64               randconfig-x015-20230730   clang
x86_64               randconfig-x016-20230730   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r011-20230730   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
