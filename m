Return-Path: <SRS0=jZzm=CJ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63FFC433E6
	for <linux-serial@archiver.kernel.org>; Mon, 31 Aug 2020 18:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0693208DB
	for <linux-serial@archiver.kernel.org>; Mon, 31 Aug 2020 18:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgHaSZZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:25:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:21565 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgHaSZX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 31 Aug 2020 14:25:23 -0400
IronPort-SDR: QAzKdPSswSN46b59Ip4BrA4cMDlxBnzxVtzYWEFqF8L7dFoCBO29y+NBC3aaM3c/SqhB6GQ545
 uftGJd8HzHnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="221268867"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="221268867"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 11:25:20 -0700
IronPort-SDR: j2+Y1Fc1Y3llJXrli/UD1tIAZcczR3lqrT6RrAMS1j/9Mp/SRxkswzFqdHyW4F/hKUjdgoBrts
 XFilraawxxvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="314441385"
Received: from lkp-server02.sh.intel.com (HELO 713faec3b0e5) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 31 Aug 2020 11:25:19 -0700
Received: from kbuild by 713faec3b0e5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kCoUY-00008j-F8; Mon, 31 Aug 2020 18:25:18 +0000
Date:   Tue, 01 Sep 2020 02:24:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 8f49a2fe8e6bccbd47555048def9cd08da220c74
Message-ID: <5f4d4073.CabEUXnaXg0pH0aI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: 8f49a2fe8e6bccbd47555048def9cd08da220c74  Merge 5.9-rc3 into tty-next

elapsed time: 782m

configs tested: 111
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                           allyesconfig
arm                            mmp2_defconfig
m68k                        mvme147_defconfig
um                            kunit_defconfig
mips                 decstation_r4k_defconfig
arc                      axs103_smp_defconfig
riscv                            allyesconfig
mips                          rb532_defconfig
arm                           viper_defconfig
arm                  colibri_pxa300_defconfig
mips                        workpad_defconfig
mips                     cu1830-neo_defconfig
arm                        shmobile_defconfig
powerpc                         wii_defconfig
mips                   sb1250_swarm_defconfig
sh                           se7206_defconfig
sh                                  defconfig
c6x                        evmc6472_defconfig
mips                        nlm_xlp_defconfig
m68k                       m5208evb_defconfig
mips                          rm200_defconfig
mips                     cu1000-neo_defconfig
riscv                               defconfig
arm                             pxa_defconfig
mips                  maltasmvp_eva_defconfig
mips                        omega2p_defconfig
arc                             nps_defconfig
ia64                         bigsur_defconfig
powerpc                         ps3_defconfig
arm                         s3c6400_defconfig
sh                        sh7785lcr_defconfig
arm                         orion5x_defconfig
powerpc                     mpc5200_defconfig
sh                   sh7770_generic_defconfig
powerpc                     mpc83xx_defconfig
m68k                           sun3_defconfig
mips                        jmr3927_defconfig
arm                          ixp4xx_defconfig
ia64                             alldefconfig
m68k                        stmark2_defconfig
arm                         nhk8815_defconfig
sh                      rts7751r2d1_defconfig
arm                            qcom_defconfig
mips                     decstation_defconfig
arm                        clps711x_defconfig
nds32                             allnoconfig
parisc                generic-64bit_defconfig
xtensa                              defconfig
arm                              alldefconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
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
powerpc                             defconfig
i386                 randconfig-a001-20200831
i386                 randconfig-a002-20200831
i386                 randconfig-a004-20200831
i386                 randconfig-a006-20200831
i386                 randconfig-a005-20200831
i386                 randconfig-a003-20200831
x86_64               randconfig-a012-20200831
x86_64               randconfig-a015-20200831
x86_64               randconfig-a014-20200831
x86_64               randconfig-a011-20200831
x86_64               randconfig-a016-20200831
x86_64               randconfig-a013-20200831
i386                 randconfig-a013-20200831
i386                 randconfig-a011-20200831
i386                 randconfig-a012-20200831
i386                 randconfig-a015-20200831
i386                 randconfig-a016-20200831
i386                 randconfig-a014-20200831
riscv                             allnoconfig
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
