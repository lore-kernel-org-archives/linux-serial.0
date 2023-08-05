Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F5BC00528
	for <linux-serial@archiver.kernel.org>; Sat,  5 Aug 2023 04:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjHEESP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 5 Aug 2023 00:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHEESN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 5 Aug 2023 00:18:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C37E72
        for <linux-serial@vger.kernel.org>; Fri,  4 Aug 2023 21:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691209092; x=1722745092;
  h=date:from:to:cc:subject:message-id;
  bh=VpH6abdwWHrUHBUG7nMg7ygOt2k5VNebvIk/Z2NqUd0=;
  b=dWzZzmGbvQylfsA3v7nZttG+3+r4zjIbzr3PaJltcAUqQPSXGjlaLvFU
   EHMxUNhipak1kfgdmqdJTLxhnvQhv9/CsCvvu/z/2AZEv+0YfPcSYBgay
   qk8TWYYZCZoGaJ7WZBxQjlckBnnIBYA3I0u1a4XaXJrYxsII5mp95QM1I
   Nj4Ul7uHlNlHLIs9Pi7HvggtrEIDkMqOuYqI0OMcwJXjnDBAcX7r34CHv
   h6jAXIR1IS0dlGsf8O+Zw9XDc6baXY9bwNgpIhVlzxVMT1i4aLarCuChV
   ytMWMIECG/ftS3wY5G0zSlJx+mkCcWX13tgJTzGDai1/txNEEto4a+Af2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="401251003"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="401251003"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 21:18:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="730285994"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="730285994"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 04 Aug 2023 21:18:10 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qS8jx-0003Iy-3B;
        Sat, 05 Aug 2023 04:18:09 +0000
Date:   Sat, 05 Aug 2023 12:18:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 593135f09368dbddc0244b859a7c3befb97214e0
Message-ID: <202308051204.WHi6W0c0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 593135f09368dbddc0244b859a7c3befb97214e0  8250_men_mcb: remove unnecessary cast when reading register

elapsed time: 881m

configs tested: 133
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r014-20230731   gcc  
alpha                randconfig-r016-20230731   gcc  
alpha                randconfig-r032-20230803   gcc  
alpha                randconfig-r036-20230803   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230731   gcc  
arc                  randconfig-r043-20230731   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                  randconfig-r046-20230731   gcc  
arm                         socfpga_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230731   gcc  
arm64                randconfig-r021-20230731   clang
arm64                randconfig-r026-20230731   clang
arm64                randconfig-r033-20230731   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r012-20230731   gcc  
csky                 randconfig-r016-20230731   gcc  
hexagon              randconfig-r001-20230731   clang
hexagon              randconfig-r022-20230731   clang
hexagon              randconfig-r025-20230731   clang
hexagon              randconfig-r035-20230803   clang
hexagon              randconfig-r041-20230731   clang
hexagon              randconfig-r045-20230731   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230731   gcc  
i386         buildonly-randconfig-r005-20230731   gcc  
i386         buildonly-randconfig-r006-20230731   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230802   clang
i386                 randconfig-i002-20230802   clang
i386                 randconfig-i003-20230802   clang
i386                 randconfig-i004-20230802   clang
i386                 randconfig-i005-20230802   clang
i386                 randconfig-i006-20230802   clang
i386                 randconfig-i011-20230731   clang
i386                 randconfig-i011-20230801   clang
i386                 randconfig-i012-20230731   clang
i386                 randconfig-i012-20230801   clang
i386                 randconfig-i013-20230731   clang
i386                 randconfig-i013-20230801   clang
i386                 randconfig-i014-20230731   clang
i386                 randconfig-i014-20230801   clang
i386                 randconfig-i015-20230731   clang
i386                 randconfig-i015-20230801   clang
i386                 randconfig-i016-20230731   clang
i386                 randconfig-i016-20230801   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r031-20230803   gcc  
loongarch            randconfig-r034-20230803   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230731   gcc  
microblaze           randconfig-r002-20230731   gcc  
microblaze           randconfig-r013-20230731   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r035-20230731   gcc  
openrisc             randconfig-r024-20230731   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230731   gcc  
parisc               randconfig-r015-20230731   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230731   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230731   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r021-20230731   gcc  
sh                   randconfig-r022-20230731   gcc  
sh                          sdk7786_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r034-20230731   gcc  
sparc64              randconfig-r014-20230731   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r011-20230731   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230731   gcc  
x86_64       buildonly-randconfig-r002-20230731   gcc  
x86_64       buildonly-randconfig-r003-20230731   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r036-20230731   gcc  
x86_64               randconfig-x001-20230731   clang
x86_64               randconfig-x002-20230731   clang
x86_64               randconfig-x003-20230731   clang
x86_64               randconfig-x004-20230731   clang
x86_64               randconfig-x005-20230731   clang
x86_64               randconfig-x006-20230731   clang
x86_64               randconfig-x011-20230731   gcc  
x86_64               randconfig-x011-20230802   clang
x86_64               randconfig-x012-20230731   gcc  
x86_64               randconfig-x012-20230802   clang
x86_64               randconfig-x013-20230731   gcc  
x86_64               randconfig-x013-20230802   clang
x86_64               randconfig-x014-20230731   gcc  
x86_64               randconfig-x014-20230802   clang
x86_64               randconfig-x015-20230731   gcc  
x86_64               randconfig-x015-20230802   clang
x86_64               randconfig-x016-20230731   gcc  
x86_64               randconfig-x016-20230802   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r023-20230731   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
