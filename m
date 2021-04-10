Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ED8C433ED
	for <linux-serial@archiver.kernel.org>; Sat, 10 Apr 2021 21:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751CB60FED
	for <linux-serial@archiver.kernel.org>; Sat, 10 Apr 2021 21:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbhDJVRW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 10 Apr 2021 17:17:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:60436 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232659AbhDJVRW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 10 Apr 2021 17:17:22 -0400
IronPort-SDR: F6WQG8lvC+WrNq5UV96l94GE2KI84RC4vKFBKvZfNVICe2eX04e68HciqHW25Z4btzFY/Hhz5R
 2Zf42I25012g==
X-IronPort-AV: E=McAfee;i="6000,8403,9950"; a="174054058"
X-IronPort-AV: E=Sophos;i="5.82,213,1613462400"; 
   d="scan'208";a="174054058"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2021 14:17:06 -0700
IronPort-SDR: GD+4bmlYqXWkvt3MXxyQ5lDUnbPifYAUojFAS2FZh+itNFXkutdYygDOwU7AluR9AKV9vjSqV/
 2vA57bYQSf1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,213,1613462400"; 
   d="scan'208";a="599520524"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Apr 2021 14:17:05 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lVKyW-000IcS-E3; Sat, 10 Apr 2021 21:17:04 +0000
Date:   Sun, 11 Apr 2021 05:16:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 63bbdb4ea02b17f929fa4f5c536357183eba9639
Message-ID: <607215ac.v1HcprHPIEvHylsK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 63bbdb4ea02b17f929fa4f5c536357183eba9639  tty: hvc: make symbol 'hvc_udbg_dev' static

elapsed time: 722m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
arm                          gemini_defconfig
powerpc                     ep8248e_defconfig
powerpc                 mpc836x_rdk_defconfig
m68k                       m5249evb_defconfig
ia64                            zx1_defconfig
arm                          ixp4xx_defconfig
sh                      rts7751r2d1_defconfig
h8300                     edosk2674_defconfig
powerpc                      pasemi_defconfig
xtensa                    xip_kc705_defconfig
m68k                         amcore_defconfig
powerpc                     ksi8560_defconfig
sh                               alldefconfig
mips                     loongson1b_defconfig
arm                            pleb_defconfig
arm                          collie_defconfig
powerpc                 mpc837x_rdb_defconfig
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
i386                 randconfig-a006-20210409
i386                 randconfig-a003-20210409
i386                 randconfig-a001-20210409
i386                 randconfig-a004-20210409
i386                 randconfig-a002-20210409
i386                 randconfig-a005-20210409
x86_64               randconfig-a014-20210409
x86_64               randconfig-a015-20210409
x86_64               randconfig-a012-20210409
x86_64               randconfig-a011-20210409
x86_64               randconfig-a013-20210409
x86_64               randconfig-a016-20210409
i386                 randconfig-a014-20210409
i386                 randconfig-a011-20210409
i386                 randconfig-a016-20210409
i386                 randconfig-a012-20210409
i386                 randconfig-a013-20210409
i386                 randconfig-a015-20210409
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210409
x86_64               randconfig-a005-20210409
x86_64               randconfig-a003-20210409
x86_64               randconfig-a001-20210409
x86_64               randconfig-a002-20210409
x86_64               randconfig-a006-20210409

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
