Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A92C433DB
	for <linux-serial@archiver.kernel.org>; Wed, 10 Feb 2021 02:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9693B64E02
	for <linux-serial@archiver.kernel.org>; Wed, 10 Feb 2021 02:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbhBJClj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 9 Feb 2021 21:41:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:23572 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235391AbhBJCjg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 9 Feb 2021 21:39:36 -0500
IronPort-SDR: fyAZDeUA3rbKa1j6p3sCK/FSyGav42LoPmap2LNPb9owcxNhW+C4q9OsotQ6XLhNPP+xkfCxDy
 pFdAb+0vcXog==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="243493811"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="243493811"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 18:38:50 -0800
IronPort-SDR: xaQ2U8jK8Ij7mlfRoScXOiqbP2QjA7+0eeOaNlqOikrCYLbM/Vg4oBa4ysYkGc+wnNZszynPKZ
 jcT01L/A8Rcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="362022204"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Feb 2021 18:38:46 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l9fOw-0002ZY-3T; Wed, 10 Feb 2021 02:38:46 +0000
Date:   Wed, 10 Feb 2021 10:38:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 a157270fbf37f822e1fa9e9faa8ed8c81da1eb28
Message-ID: <60234714.b5OK/ELrIVqXsE4i%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: a157270fbf37f822e1fa9e9faa8ed8c81da1eb28  serial: core: Remove BUG_ON(in_interrupt()) check

i386-tinyconfig vmlinux size:

+-------+-------------------------+------------------------------------------+
| DELTA |         SYMBOL          |                  COMMIT                  |
+-------+-------------------------+------------------------------------------+
|  +471 | TOTAL                   | 5c8fe583cce5..a157270fbf37 (ALL COMMITS) |
|  +465 | TEXT                    | 5c8fe583cce5..a157270fbf37 (ALL COMMITS) |
|  +101 | kernel_fpu_begin_mask() | 5c8fe583cce5..a157270fbf37 (ALL COMMITS) |
|   +91 | shrink_page_list()      | 5c8fe583cce5..a157270fbf37 (ALL COMMITS) |
|   -87 | kernel_fpu_begin()      | 5c8fe583cce5..a157270fbf37 (ALL COMMITS) |
+-------+-------------------------+------------------------------------------+

elapsed time: 728m

configs tested: 109
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                         virt_defconfig
microblaze                          defconfig
powerpc                     ksi8560_defconfig
mips                         cobalt_defconfig
powerpc                     pseries_defconfig
arm                       spear13xx_defconfig
powerpc                     kmeter1_defconfig
mips                       lemote2f_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 mpc8560_ads_defconfig
mips                           rs90_defconfig
arm                         s5pv210_defconfig
arm                           sama5_defconfig
sh                        sh7763rdp_defconfig
mips                        bcm47xx_defconfig
openrisc                    or1ksim_defconfig
arc                        vdk_hs38_defconfig
powerpc                     sequoia_defconfig
powerpc                     taishan_defconfig
alpha                               defconfig
mips                      maltaaprp_defconfig
arm                       cns3420vb_defconfig
sh                             shx3_defconfig
arm                          ixp4xx_defconfig
xtensa                  nommu_kc705_defconfig
arm                         hackkit_defconfig
m68k                       m5475evb_defconfig
arm                           stm32_defconfig
sh                          rsk7201_defconfig
arm                         socfpga_defconfig
um                           x86_64_defconfig
arm                            lart_defconfig
riscv                            allyesconfig
arm                        keystone_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210209
x86_64               randconfig-a001-20210209
x86_64               randconfig-a005-20210209
x86_64               randconfig-a004-20210209
x86_64               randconfig-a002-20210209
x86_64               randconfig-a003-20210209
i386                 randconfig-a001-20210209
i386                 randconfig-a005-20210209
i386                 randconfig-a003-20210209
i386                 randconfig-a002-20210209
i386                 randconfig-a006-20210209
i386                 randconfig-a004-20210209
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210209
x86_64               randconfig-a014-20210209
x86_64               randconfig-a015-20210209
x86_64               randconfig-a012-20210209
x86_64               randconfig-a016-20210209
x86_64               randconfig-a011-20210209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
