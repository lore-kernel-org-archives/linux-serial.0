Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33D5C64EC4
	for <linux-serial@archiver.kernel.org>; Fri, 10 Mar 2023 04:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCJEk5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Mar 2023 23:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCJEk4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Mar 2023 23:40:56 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8659E102847
        for <linux-serial@vger.kernel.org>; Thu,  9 Mar 2023 20:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678423255; x=1709959255;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/kz7qsy/V2QesPrL2eyYaeoRFmBsKfdbDSUOtXdX2Xo=;
  b=M85U9LbVOVsytEzmAbojR4EOb63jruZvCY+e1QJmYWt/1OJ9cFhvzl3F
   QgtG99yb+SJs+O6MRXyGd5TdFirC2vXkbF7cP6nIOTwhjaXcoyQjaQdpL
   YTgC/ziNLse+4YmCrZgYLN8Dzy9WnI7tmYZdAzawVxdAtPxHpOVvrlZ8+
   5DZ4x0mgDF7Opu1onVXxDVO6Z71gGifzk2EKirtciKLoNN7RXnXmeqxmg
   ILGhwJfSBf2NONN7yBniIN343+qwUL2JrJ3mi6I+dG6dcyYEOVgcQA5ux
   fkdhHNP0EpAb92sVHUCUQ3v6xfRhFgBI03O0YSr/0EpMoEMJHeqmHmVH/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="320498867"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="320498867"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 20:40:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="801442604"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="801442604"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Mar 2023 20:40:53 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paUYn-0003V7-0m;
        Fri, 10 Mar 2023 04:40:53 +0000
Date:   Fri, 10 Mar 2023 12:40:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 571079f5ba93f08ac2563d40e46d42d56615c096
Message-ID: <640ab4c1.H+qh6YATQ6o3SNFz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 571079f5ba93f08ac2563d40e46d42d56615c096  Documentation/serial-console: Document the behavior when the last console= parameter is not used

elapsed time: 727m

configs tested: 55
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230308   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230308   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r032-20230308   clang
hexagon              randconfig-r036-20230308   clang
hexagon              randconfig-r041-20230308   clang
hexagon              randconfig-r045-20230308   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r033-20230308   clang
mips                 randconfig-r034-20230308   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r035-20230308   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230308   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r031-20230308   gcc  
s390                 randconfig-r044-20230308   clang
sh                               allmodconfig   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
