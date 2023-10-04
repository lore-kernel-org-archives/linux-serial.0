Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE055E8FDC3
	for <linux-serial@archiver.kernel.org>; Wed,  4 Oct 2023 02:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjJDCWV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Oct 2023 22:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjJDCWU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Oct 2023 22:22:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB464AC
        for <linux-serial@vger.kernel.org>; Tue,  3 Oct 2023 19:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696386137; x=1727922137;
  h=date:from:to:cc:subject:message-id;
  bh=EzpNjYCjvV3AKpQa1cJX3kZDHq+eYXuoK+O5eNNpiqo=;
  b=SqmrDJP5J4+fkfkWCUEnsh7D1cf1prFdJDKdhk9Dn6zvwmOlvKvf91cz
   eCVdwjY3r5qvVEU9n2ljd13BpV8Sfu3gZrJLC7DqAKAEB6dD9lAAiqsB9
   MXE3XJKWinFqwX6SQ4BSWx609B5283ll+Vr/Csr6QQAt1udHPT3C2Csg+
   WW48MYLdEZsb1WO6NKZXXkGEEtL8RNgy1dPh906LiLNPS8K4CxCDgl88I
   ADRHqENh7jIqL1em1I7JEFpM85uNFMOrNdJM1WLiCqdE7fyKdib0XHT7V
   ygtyBoa5dZzBnODEFSyoZTGSPHx75juvsorpiY3fWtkzc4m/tkbefn3p/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="373373375"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="373373375"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 19:22:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="780563525"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="780563525"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 03 Oct 2023 19:22:16 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnrWf-000ALC-3A;
        Wed, 04 Oct 2023 02:22:13 +0000
Date:   Wed, 04 Oct 2023 10:21:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 560706eff7c8e5621b0d63afe0866e0e1906e87e
Message-ID: <202310041022.GXFzd3Nx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 560706eff7c8e5621b0d63afe0866e0e1906e87e  serial: 8250_omap: Fix errors with no_console_suspend

elapsed time: 781m

configs tested: 107
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231003   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231003   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231003   gcc  
i386         buildonly-randconfig-002-20231003   gcc  
i386         buildonly-randconfig-003-20231003   gcc  
i386         buildonly-randconfig-004-20231003   gcc  
i386         buildonly-randconfig-005-20231003   gcc  
i386         buildonly-randconfig-006-20231003   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231003   gcc  
i386                  randconfig-002-20231003   gcc  
i386                  randconfig-003-20231003   gcc  
i386                  randconfig-004-20231003   gcc  
i386                  randconfig-005-20231003   gcc  
i386                  randconfig-006-20231003   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231003   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
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
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231003   gcc  
x86_64                randconfig-002-20231003   gcc  
x86_64                randconfig-003-20231003   gcc  
x86_64                randconfig-004-20231003   gcc  
x86_64                randconfig-005-20231003   gcc  
x86_64                randconfig-006-20231003   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
