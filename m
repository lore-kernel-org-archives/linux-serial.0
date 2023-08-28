Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A35C83F11
	for <linux-serial@archiver.kernel.org>; Mon, 28 Aug 2023 02:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjH1CrI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 27 Aug 2023 22:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjH1Cqu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Aug 2023 22:46:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814A810A
        for <linux-serial@vger.kernel.org>; Sun, 27 Aug 2023 19:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693190808; x=1724726808;
  h=date:from:to:cc:subject:message-id;
  bh=qPDHdS95qZAOqpveYnroxh/Ov8VzD9Ixsp1BtvgoxSA=;
  b=W1dlUf1ki8V1mLkl8AbayL1uaQRYTVX0Vz0iYr/VpTt1iXfa6IaHrDw3
   sdiHstq3eEABgeDE7hGmT8gNSFto/k/Szk4goiWQIVS4jGuRUhB8UGXp/
   VLsfL3CTwccJ215cYhCyHM5LQAq3gUGkE+X7jjkAzmnqnK/3zE8fxmw3h
   7A6f2W4F0T2xbz1QpBxoHut6/ATm0DvJP8p0cefaFOPaTgmJUjDy4xnZN
   uj8v03onHjcYrercojl0c5/lG5D/odsi7Mxh/gpcHMeIE/F3uw4knIpSk
   BwLkRcYC02J8qNzLT+J7s2PTLVUal07xvQ5yq4p442UBYXdi9N1U5UVbQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="372397055"
X-IronPort-AV: E=Sophos;i="6.02,206,1688454000"; 
   d="scan'208";a="372397055"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 19:46:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="1068879865"
X-IronPort-AV: E=Sophos;i="6.02,206,1688454000"; 
   d="scan'208";a="1068879865"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 27 Aug 2023 19:46:46 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qaSH7-0006QV-1t;
        Mon, 28 Aug 2023 02:46:45 +0000
Date:   Mon, 28 Aug 2023 10:45:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 ebf05c7dc92c11b0355aaa0e94064beadaa4b05c
Message-ID: <202308281057.ar2vfH0W-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: ebf05c7dc92c11b0355aaa0e94064beadaa4b05c  tty: shrink the size of struct tty_struct by 40 bytes

elapsed time: 990m

configs tested: 135
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
arc                  randconfig-r002-20230827   gcc  
arc                  randconfig-r012-20230827   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r025-20230827   clang
arm                  randconfig-r032-20230827   gcc  
arm                  randconfig-r033-20230827   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r023-20230827   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230827   gcc  
csky                 randconfig-r014-20230827   gcc  
hexagon              randconfig-r035-20230827   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
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
loongarch            randconfig-r021-20230827   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r016-20230827   gcc  
microblaze           randconfig-r022-20230827   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r026-20230827   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230827   gcc  
parisc               randconfig-r031-20230827   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r005-20230827   clang
powerpc              randconfig-r013-20230827   gcc  
powerpc              randconfig-r015-20230827   gcc  
powerpc64            randconfig-r006-20230827   clang
powerpc64            randconfig-r036-20230827   clang
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
sh                   randconfig-r001-20230827   gcc  
sh                   randconfig-r011-20230827   gcc  
sh                   randconfig-r034-20230827   gcc  
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
um                   randconfig-r024-20230827   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-003-20230827   clang
x86_64       buildonly-randconfig-004-20230827   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230827   gcc  
x86_64                randconfig-002-20230827   gcc  
x86_64                randconfig-003-20230827   gcc  
x86_64                randconfig-004-20230827   gcc  
x86_64                randconfig-005-20230827   gcc  
x86_64                randconfig-006-20230827   gcc  
x86_64                randconfig-015-20230827   clang
x86_64                randconfig-016-20230827   clang
x86_64                randconfig-071-20230827   clang
x86_64                randconfig-072-20230827   clang
x86_64                randconfig-073-20230827   clang
x86_64                randconfig-074-20230827   clang
x86_64                randconfig-075-20230827   clang
x86_64                randconfig-076-20230827   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
