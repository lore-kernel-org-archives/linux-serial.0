Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1A0C83F16
	for <linux-serial@archiver.kernel.org>; Mon, 28 Aug 2023 03:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjH1Dhl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 27 Aug 2023 23:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjH1Dhl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Aug 2023 23:37:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE8B128
        for <linux-serial@vger.kernel.org>; Sun, 27 Aug 2023 20:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693193858; x=1724729858;
  h=date:from:to:cc:subject:message-id;
  bh=1a+nK9RIFe/LZeZ7gqZ5cHrgeBChH1bgMEy50z7q5vc=;
  b=csfQAY+mszY1b6HX+8D2P/z987oZNxUv3A2sWVa5uZwZSGWpCKrFyEQ7
   6hEVl63mA28oBOLmqt1c2RiHbIMnAsjeFG9rTax0JzhMrXDL727XOJN2X
   6tKAyoKucGzrQvInG4r44s9qSo2VLBUXr6uSVYFBdRsYpOZqhIgCkgyvP
   6aN9cZIyAl5jRz7Shj+4qqd44/bM+ejMlRPagxO0t4AxhotOuSfdv5jH7
   dW/OsWjpQW2+tfWtqkhVBzYwnBUyymqAadWgZcUBrPbh7owGq/12j7BCi
   E6IE0vBxwyE+DVGg6bOcRqICSP4P7kvkGqqMlmVVHd4+v0KIlk3HXIChr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="378779864"
X-IronPort-AV: E=Sophos;i="6.02,206,1688454000"; 
   d="scan'208";a="378779864"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 20:37:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="773121216"
X-IronPort-AV: E=Sophos;i="6.02,206,1688454000"; 
   d="scan'208";a="773121216"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 27 Aug 2023 20:37:37 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qaT4K-0007AI-1T;
        Mon, 28 Aug 2023 03:37:36 +0000
Date:   Mon, 28 Aug 2023 11:34:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-next] BUILD SUCCESS
 db726a2f3b4bc0cbf8e6cfd529d2d8eabb587d70
Message-ID: <202308281113.Q9AgMUo3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
branch HEAD: db726a2f3b4bc0cbf8e6cfd529d2d8eabb587d70  Revert "tty: serial: meson: Add a earlycon for the T7 SoC"

elapsed time: 1062m

configs tested: 146
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230827   gcc  
alpha                randconfig-r023-20230827   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230827   gcc  
arc                  randconfig-r004-20230827   gcc  
arc                  randconfig-r035-20230827   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230827   clang
arm                  randconfig-r002-20230827   gcc  
arm                  randconfig-r013-20230827   clang
arm                  randconfig-r026-20230827   clang
arm                  randconfig-r033-20230827   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r014-20230827   gcc  
csky                 randconfig-r022-20230827   gcc  
hexagon               randconfig-001-20230827   clang
hexagon               randconfig-002-20230827   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230827   clang
i386         buildonly-randconfig-002-20230827   clang
i386         buildonly-randconfig-003-20230827   clang
i386         buildonly-randconfig-004-20230827   clang
i386         buildonly-randconfig-005-20230827   clang
i386         buildonly-randconfig-006-20230827   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230827   clang
i386                  randconfig-011-20230827   gcc  
i386                  randconfig-012-20230827   gcc  
i386                  randconfig-013-20230827   gcc  
i386                  randconfig-014-20230827   gcc  
i386                  randconfig-015-20230827   gcc  
i386                  randconfig-016-20230827   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230827   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r024-20230827   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r034-20230827   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r021-20230827   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r036-20230827   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230827   gcc  
parisc               randconfig-r023-20230827   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r003-20230827   clang
powerpc              randconfig-r031-20230827   clang
powerpc64            randconfig-r012-20230827   gcc  
powerpc64            randconfig-r025-20230827   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230827   clang
riscv                randconfig-r024-20230827   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230827   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r016-20230827   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r005-20230827   gcc  
um                   randconfig-r015-20230827   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230827   clang
x86_64       buildonly-randconfig-002-20230827   clang
x86_64       buildonly-randconfig-003-20230827   clang
x86_64       buildonly-randconfig-004-20230827   clang
x86_64       buildonly-randconfig-005-20230827   clang
x86_64       buildonly-randconfig-006-20230827   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-006-20230827   gcc  
x86_64                randconfig-016-20230827   clang
x86_64               randconfig-r011-20230827   gcc  
x86_64               randconfig-r021-20230827   gcc  
x86_64               randconfig-r022-20230827   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r025-20230827   gcc  
xtensa               randconfig-r026-20230827   gcc  
xtensa               randconfig-r032-20230827   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
