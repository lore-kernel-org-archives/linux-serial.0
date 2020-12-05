Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14483C4361A
	for <linux-serial@archiver.kernel.org>; Sat,  5 Dec 2020 04:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C127622B2A
	for <linux-serial@archiver.kernel.org>; Sat,  5 Dec 2020 04:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgLEEpn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Dec 2020 23:45:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:45607 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgLEEpn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Dec 2020 23:45:43 -0500
IronPort-SDR: Uz3TS/KaDq18OyOyhswITNiReGM1A91sm4G3Wc1051yOOzCiAMKgd3ZbCTxDFirHzRLeNYSFjL
 N/Rocmy2ct/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="235092479"
X-IronPort-AV: E=Sophos;i="5.78,394,1599548400"; 
   d="scan'208";a="235092479"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 20:45:00 -0800
IronPort-SDR: LQXURFvcbLtjonRgIzPBze5rcyhFWmAf5iBnTAwlu4WYzGXkII7LTbMpBDabrEMAcFJAx8kvSg
 uTZ1RYjf/fOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,394,1599548400"; 
   d="scan'208";a="366559623"
Received: from lkp-server01.sh.intel.com (HELO 47754f1311fc) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Dec 2020 20:44:59 -0800
Received: from kbuild by 47754f1311fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1klPRK-00006z-LY; Sat, 05 Dec 2020 04:44:58 +0000
Date:   Sat, 05 Dec 2020 12:44:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 c8bcd9c5be24fb9e6132e97da5a35e55a83e36b9
Message-ID: <5fcb102b.h6/maOQYIf30w7bH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-linus
branch HEAD: c8bcd9c5be24fb9e6132e97da5a35e55a83e36b9  tty: Fix ->session locking

elapsed time: 723m

configs tested: 133
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     tqm8555_defconfig
s390                                defconfig
sh                           se7721_defconfig
c6x                        evmc6457_defconfig
mips                     loongson1c_defconfig
powerpc                         wii_defconfig
mips                  decstation_64_defconfig
xtensa                  cadence_csp_defconfig
arm                        shmobile_defconfig
um                           x86_64_defconfig
ia64                          tiger_defconfig
arm                         mv78xx0_defconfig
ia64                            zx1_defconfig
arm                         lpc18xx_defconfig
powerpc                     tqm5200_defconfig
sh                            titan_defconfig
mips                         tb0226_defconfig
powerpc                      ep88xc_defconfig
arm                         bcm2835_defconfig
powerpc                      acadia_defconfig
arm                         assabet_defconfig
powerpc                     skiroot_defconfig
arc                     haps_hs_smp_defconfig
arm                       netwinder_defconfig
arm                          iop32x_defconfig
ia64                             allyesconfig
arm                          collie_defconfig
mips                         cobalt_defconfig
powerpc                   motionpro_defconfig
mips                           jazz_defconfig
powerpc                        cell_defconfig
ia64                             alldefconfig
nds32                               defconfig
nios2                            alldefconfig
powerpc                     redwood_defconfig
powerpc                          g5_defconfig
powerpc                 mpc836x_mds_defconfig
arm                      jornada720_defconfig
arm                       aspeed_g4_defconfig
arm                         hackkit_defconfig
sparc                       sparc64_defconfig
arm                       versatile_defconfig
arc                     nsimosci_hs_defconfig
arm                          pxa3xx_defconfig
openrisc                         alldefconfig
powerpc                      mgcoge_defconfig
arm                         s3c2410_defconfig
openrisc                    or1ksim_defconfig
powerpc                    amigaone_defconfig
powerpc               mpc834x_itxgp_defconfig
sparc                               defconfig
arm                        spear3xx_defconfig
powerpc                 mpc8272_ads_defconfig
sh                             espt_defconfig
arm                         vf610m4_defconfig
arm                        multi_v5_defconfig
arm                         nhk8815_defconfig
s390                          debug_defconfig
arm                      pxa255-idp_defconfig
powerpc                     tqm8548_defconfig
xtensa                              defconfig
arm                        oxnas_v6_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
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
x86_64               randconfig-a004-20201204
x86_64               randconfig-a006-20201204
x86_64               randconfig-a002-20201204
x86_64               randconfig-a001-20201204
x86_64               randconfig-a005-20201204
x86_64               randconfig-a003-20201204
i386                 randconfig-a005-20201204
i386                 randconfig-a004-20201204
i386                 randconfig-a001-20201204
i386                 randconfig-a002-20201204
i386                 randconfig-a006-20201204
i386                 randconfig-a003-20201204
i386                 randconfig-a014-20201204
i386                 randconfig-a013-20201204
i386                 randconfig-a011-20201204
i386                 randconfig-a015-20201204
i386                 randconfig-a012-20201204
i386                 randconfig-a016-20201204
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-a016-20201204
x86_64               randconfig-a012-20201204
x86_64               randconfig-a014-20201204
x86_64               randconfig-a013-20201204
x86_64               randconfig-a015-20201204
x86_64               randconfig-a011-20201204

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
