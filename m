Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F9EC4338F
	for <linux-serial@archiver.kernel.org>; Wed, 28 Jul 2021 00:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 229D860551
	for <linux-serial@archiver.kernel.org>; Wed, 28 Jul 2021 00:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhG1AVj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 27 Jul 2021 20:21:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:46247 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232778AbhG1AVi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 27 Jul 2021 20:21:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="234429046"
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="234429046"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 17:21:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="580433778"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jul 2021 17:21:35 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m8XKJ-0007QW-9V; Wed, 28 Jul 2021 00:21:35 +0000
Date:   Wed, 28 Jul 2021 08:20:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 6a3e3c7ac7587232eb52c1b1b78bc8fb71d1b949
Message-ID: <6100a2d4.Ffy8f6Ceu9kytMyU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 6a3e3c7ac7587232eb52c1b1b78bc8fb71d1b949  vt: keyboard.c: make console an unsigned int

elapsed time: 722m

configs tested: 87
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210727
i386                 randconfig-c001-20210726
sh                          urquell_defconfig
sh                           se7712_defconfig
arm                      integrator_defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                 canyonlands_defconfig
microblaze                      mmu_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210727
i386                 randconfig-a003-20210727
i386                 randconfig-a004-20210727
i386                 randconfig-a002-20210727
i386                 randconfig-a001-20210727
i386                 randconfig-a006-20210727
x86_64               randconfig-a011-20210727
x86_64               randconfig-a016-20210727
x86_64               randconfig-a013-20210727
x86_64               randconfig-a014-20210727
x86_64               randconfig-a012-20210727
x86_64               randconfig-a015-20210727
i386                 randconfig-a016-20210727
i386                 randconfig-a013-20210727
i386                 randconfig-a012-20210727
i386                 randconfig-a011-20210727
i386                 randconfig-a014-20210727
i386                 randconfig-a015-20210727
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210727
x86_64               randconfig-a003-20210727
x86_64               randconfig-a006-20210727
x86_64               randconfig-a001-20210727
x86_64               randconfig-a005-20210727
x86_64               randconfig-a004-20210727
x86_64               randconfig-a002-20210727

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
