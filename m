Return-Path: <SRS0=Gon6=DF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF7CC4346E
	for <linux-serial@archiver.kernel.org>; Mon, 28 Sep 2020 00:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A5D23A33
	for <linux-serial@archiver.kernel.org>; Mon, 28 Sep 2020 00:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgI1AUH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 27 Sep 2020 20:20:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:19479 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgI1AUH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Sep 2020 20:20:07 -0400
IronPort-SDR: DIIfFItI+RUuNT/YfKlZPUb0AanZhsqJArJ5fqfutStYZI3HQoi3geeR6/gSv3o4/rmte55Wgk
 3vGd34V0sJ5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="226067662"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="226067662"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 17:20:06 -0700
IronPort-SDR: D2QnjBVpj7eBWSBxMW9AMyn6PogWSHqq53kHVk7tFI6GNGOG9X30MAVVIUndG1O+lvFQ6aKxxd
 FfuS2r3dg/tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="311578860"
Received: from lkp-server01.sh.intel.com (HELO 0e0978ea3297) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Sep 2020 17:20:05 -0700
Received: from kbuild by 0e0978ea3297 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kMgtg-00007T-EV; Mon, 28 Sep 2020 00:20:04 +0000
Date:   Mon, 28 Sep 2020 08:19:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 988d0763361bb65690d60e2bc53a6b72777040c3
Message-ID: <5f712c18.L89IXSf3nJgezBNj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: 988d0763361bb65690d60e2bc53a6b72777040c3  vt_ioctl: make VT_RESIZEX behave like VT_RESIZE

elapsed time: 720m

configs tested: 94
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                 kfr2r09-romimage_defconfig
mips                          rm200_defconfig
c6x                         dsk6455_defconfig
powerpc                      bamboo_defconfig
nios2                         3c120_defconfig
sh                          landisk_defconfig
powerpc                 mpc8272_ads_defconfig
sparc                            alldefconfig
sh                     magicpanelr2_defconfig
sh                          lboxre2_defconfig
mips                      malta_kvm_defconfig
sparc64                          alldefconfig
ia64                            zx1_defconfig
arm                       spear13xx_defconfig
arm                          simpad_defconfig
sh                           se7750_defconfig
ia64                                defconfig
arm                  colibri_pxa300_defconfig
powerpc                       maple_defconfig
arm                        multi_v5_defconfig
openrisc                 simple_smp_defconfig
ia64                             allmodconfig
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
i386                 randconfig-a002-20200927
i386                 randconfig-a006-20200927
i386                 randconfig-a003-20200927
i386                 randconfig-a004-20200927
i386                 randconfig-a005-20200927
i386                 randconfig-a001-20200927
x86_64               randconfig-a011-20200927
x86_64               randconfig-a013-20200927
x86_64               randconfig-a014-20200927
x86_64               randconfig-a015-20200927
x86_64               randconfig-a012-20200927
x86_64               randconfig-a016-20200927
i386                 randconfig-a012-20200927
i386                 randconfig-a014-20200927
i386                 randconfig-a016-20200927
i386                 randconfig-a013-20200927
i386                 randconfig-a011-20200927
i386                 randconfig-a015-20200927
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200927
x86_64               randconfig-a003-20200927
x86_64               randconfig-a004-20200927
x86_64               randconfig-a002-20200927
x86_64               randconfig-a006-20200927
x86_64               randconfig-a001-20200927

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
