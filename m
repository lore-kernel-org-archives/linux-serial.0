Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8995AC001C7
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 00:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6381F64EC0
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 00:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbhCDAAA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:29040 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347102AbhCCGum (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 3 Mar 2021 01:50:42 -0500
IronPort-SDR: ac7rXxLugokmUoGKc18GSaCehRG/E9lIgVfHF6IzYfY8NRLVZRmWx8ejXnN2pcL95NrbbVS4cs
 ojBF9JZsIEiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="272118579"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="272118579"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 22:49:58 -0800
IronPort-SDR: nI/Zm8sE0zJQY/bKljE3MYKW87SmDQRquHGbYDQiWk/kIOYrD1n6t+vZODxfcM4OX32bOnPCZ4
 wPCBRfWM5O2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="586251665"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 02 Mar 2021 22:49:56 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHLKV-0000xm-RO; Wed, 03 Mar 2021 06:49:55 +0000
Date:   Wed, 03 Mar 2021 14:49:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 511a9d5dc2d4d541704d25faf7f6fc2a71a2fd9d
Message-ID: <603f3170.jMHcDyYw9gUfSFiM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 511a9d5dc2d4d541704d25faf7f6fc2a71a2fd9d  Revert "serial: max310x: rework RX interrupt handling"

elapsed time: 721m

configs tested: 119
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc8272_ads_defconfig
sh                           se7751_defconfig
openrisc                            defconfig
arm                         lpc32xx_defconfig
powerpc                      ep88xc_defconfig
mips                            ar7_defconfig
sh                         microdev_defconfig
sh                           se7712_defconfig
s390                                defconfig
arm                      tct_hammer_defconfig
mips                         bigsur_defconfig
sh                   secureedge5410_defconfig
m68k                       bvme6000_defconfig
arm                          collie_defconfig
h8300                     edosk2674_defconfig
arm                       cns3420vb_defconfig
m68k                         amcore_defconfig
m68k                        m5272c3_defconfig
mips                            e55_defconfig
arm                        spear3xx_defconfig
s390                       zfcpdump_defconfig
sh                      rts7751r2d1_defconfig
sparc                               defconfig
c6x                              alldefconfig
m68k                       m5208evb_defconfig
arm                   milbeaut_m10v_defconfig
xtensa                              defconfig
sh                        sh7785lcr_defconfig
arm                         nhk8815_defconfig
nds32                            alldefconfig
h8300                    h8300h-sim_defconfig
powerpc                        cell_defconfig
mips                      maltasmvp_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210302
x86_64               randconfig-a001-20210302
x86_64               randconfig-a004-20210302
x86_64               randconfig-a002-20210302
x86_64               randconfig-a005-20210302
x86_64               randconfig-a003-20210302
i386                 randconfig-a005-20210302
i386                 randconfig-a003-20210302
i386                 randconfig-a002-20210302
i386                 randconfig-a004-20210302
i386                 randconfig-a006-20210302
i386                 randconfig-a001-20210302
i386                 randconfig-a016-20210302
i386                 randconfig-a012-20210302
i386                 randconfig-a014-20210302
i386                 randconfig-a013-20210302
i386                 randconfig-a011-20210302
i386                 randconfig-a015-20210302
i386                 randconfig-a016-20210303
i386                 randconfig-a012-20210303
i386                 randconfig-a014-20210303
i386                 randconfig-a013-20210303
i386                 randconfig-a011-20210303
i386                 randconfig-a015-20210303
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210303
x86_64               randconfig-a001-20210303
x86_64               randconfig-a004-20210303
x86_64               randconfig-a002-20210303
x86_64               randconfig-a005-20210303
x86_64               randconfig-a003-20210303
x86_64               randconfig-a013-20210302
x86_64               randconfig-a016-20210302
x86_64               randconfig-a015-20210302
x86_64               randconfig-a014-20210302
x86_64               randconfig-a012-20210302
x86_64               randconfig-a011-20210302

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
