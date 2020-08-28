Return-Path: <SRS0=9Cit=CG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3A5C433E2
	for <linux-serial@archiver.kernel.org>; Fri, 28 Aug 2020 20:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA112075B
	for <linux-serial@archiver.kernel.org>; Fri, 28 Aug 2020 20:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgH1U7P (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:59:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:21327 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgH1U7O (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Aug 2020 16:59:14 -0400
IronPort-SDR: Z/DYK6qFHjwatZY+mfShS5+hioshIPIHYW9logkoF/MGoDpObCH/JBubbAzE7kjS2lWZ3l6aCb
 eltiSpRISK3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="144493518"
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; 
   d="scan'208";a="144493518"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 13:59:13 -0700
IronPort-SDR: HQT7LYWk8wjQ55Oid+qoeVYmP5i0iqworTLOYUd6O5xK+pbOvSsDsU6Tp0mKk2NEDHtRcT7JKx
 AjZmfLZArrEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; 
   d="scan'208";a="337608947"
Received: from lkp-server02.sh.intel.com (HELO 301dc1beeb51) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Aug 2020 13:59:12 -0700
Received: from kbuild by 301dc1beeb51 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kBlSq-0000Bm-48; Fri, 28 Aug 2020 20:59:12 +0000
Date:   Sat, 29 Aug 2020 04:58:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 04b6ff5f25dece9b0ee244aa768b251cfe855c85
Message-ID: <5f49700c.OyvL+2958CmtO0T6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: 04b6ff5f25dece9b0ee244aa768b251cfe855c85  serial: 8250_pci: Add WCH384_8S 8 port serial device

elapsed time: 723m

configs tested: 109
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         rt305x_defconfig
i386                             allyesconfig
powerpc                     ep8248e_defconfig
powerpc                     pseries_defconfig
arm                        keystone_defconfig
sh                           se7722_defconfig
parisc                generic-64bit_defconfig
mips                           rs90_defconfig
m68k                       bvme6000_defconfig
mips                        bcm47xx_defconfig
c6x                        evmc6474_defconfig
microblaze                    nommu_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                     pq2fads_defconfig
m68k                         apollo_defconfig
m68k                             allyesconfig
arm                            qcom_defconfig
mips                  maltasmvp_eva_defconfig
nios2                            allyesconfig
nios2                            alldefconfig
arm                           efm32_defconfig
arm                         cm_x300_defconfig
powerpc                    adder875_defconfig
m68k                       m5208evb_defconfig
arm                        mvebu_v7_defconfig
arm                         lpc18xx_defconfig
mips                        jmr3927_defconfig
arm                          exynos_defconfig
arm                          pxa910_defconfig
arm                          lpd270_defconfig
mips                malta_kvm_guest_defconfig
mips                  cavium_octeon_defconfig
arc                             nps_defconfig
arm                       spear13xx_defconfig
s390                          debug_defconfig
alpha                            alldefconfig
arm                           sama5_defconfig
arm                            mmp2_defconfig
arc                        nsim_700_defconfig
mips                          rb532_defconfig
sh                          lboxre2_defconfig
s390                       zfcpdump_defconfig
sh                             sh03_defconfig
powerpc                    gamecube_defconfig
sh                        sh7785lcr_defconfig
arm                        oxnas_v6_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200828
i386                 randconfig-a005-20200828
i386                 randconfig-a003-20200828
i386                 randconfig-a004-20200828
i386                 randconfig-a001-20200828
i386                 randconfig-a006-20200828
x86_64               randconfig-a015-20200828
x86_64               randconfig-a012-20200828
x86_64               randconfig-a016-20200828
x86_64               randconfig-a014-20200828
x86_64               randconfig-a011-20200828
x86_64               randconfig-a013-20200828
i386                 randconfig-a013-20200828
i386                 randconfig-a012-20200828
i386                 randconfig-a011-20200828
i386                 randconfig-a016-20200828
i386                 randconfig-a014-20200828
i386                 randconfig-a015-20200828
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
