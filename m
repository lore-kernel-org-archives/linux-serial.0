Return-Path: <SRS0=O216=BN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407E1C433E0
	for <linux-serial@archiver.kernel.org>; Mon,  3 Aug 2020 01:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264412070A
	for <linux-serial@archiver.kernel.org>; Mon,  3 Aug 2020 01:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgHCBly (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 2 Aug 2020 21:41:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:20927 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgHCBly (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 2 Aug 2020 21:41:54 -0400
IronPort-SDR: CVTzeuUPsbsZpwsIN3TgWGVoOHipHuudLosSigxaDuGGB5ZymJja7cO4y4PIbVI8xCgts8Pvc9
 PL/9Qjk3BRHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="153238534"
X-IronPort-AV: E=Sophos;i="5.75,428,1589266800"; 
   d="scan'208";a="153238534"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 18:41:53 -0700
IronPort-SDR: m+HuBrGTMTFxJD/N0PYsEdIXAgKHi3NAlE+grd/xXtAjjcnVbs5oO1iVY3AgGuueFX/gLHsv/Z
 bzaakcYOCpiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,428,1589266800"; 
   d="scan'208";a="305647938"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2020 18:41:52 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k2PU7-0001nO-Dc; Mon, 03 Aug 2020 01:41:51 +0000
Date:   Mon, 03 Aug 2020 09:41:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 81f0f78965ebfe48c4997801050f64687cebea48
Message-ID: <5f276b5b.hldYAD9BUQUeGIfB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: 81f0f78965ebfe48c4997801050f64687cebea48  Revert "serial: 8250: Let serial core initialise spin lock"

elapsed time: 724m

configs tested: 99
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                  colibri_pxa300_defconfig
arm                          gemini_defconfig
c6x                        evmc6678_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                        multi_v5_defconfig
m68k                        m5272c3_defconfig
arm                        shmobile_defconfig
arm                            pleb_defconfig
powerpc                mpc7448_hpc2_defconfig
m68k                                defconfig
mips                         rt305x_defconfig
powerpc                 linkstation_defconfig
sh                          r7785rp_defconfig
m68k                          sun3x_defconfig
arm                        mvebu_v7_defconfig
arm                            zeus_defconfig
c6x                         dsk6455_defconfig
nds32                            alldefconfig
arc                         haps_hs_defconfig
arm                          exynos_defconfig
mips                      pistachio_defconfig
arm                           u8500_defconfig
arm                            hisi_defconfig
powerpc                     mpc83xx_defconfig
arm                  colibri_pxa270_defconfig
arm                           viper_defconfig
powerpc                    amigaone_defconfig
arm                         nhk8815_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
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
nios2                               defconfig
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
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20200802
i386                 randconfig-a005-20200802
i386                 randconfig-a001-20200802
i386                 randconfig-a002-20200802
i386                 randconfig-a003-20200802
i386                 randconfig-a006-20200802
i386                 randconfig-a004-20200803
i386                 randconfig-a005-20200803
i386                 randconfig-a001-20200803
i386                 randconfig-a002-20200803
i386                 randconfig-a003-20200803
i386                 randconfig-a006-20200803
i386                 randconfig-a011-20200802
i386                 randconfig-a012-20200802
i386                 randconfig-a015-20200802
i386                 randconfig-a014-20200802
i386                 randconfig-a013-20200802
i386                 randconfig-a016-20200802
x86_64               randconfig-a001-20200802
x86_64               randconfig-a003-20200802
x86_64               randconfig-a002-20200802
x86_64               randconfig-a006-20200802
x86_64               randconfig-a004-20200802
x86_64               randconfig-a005-20200802
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
