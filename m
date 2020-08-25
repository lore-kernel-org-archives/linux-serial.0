Return-Path: <SRS0=bk4J=CD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA5EC433DF
	for <linux-serial@archiver.kernel.org>; Tue, 25 Aug 2020 23:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E7920706
	for <linux-serial@archiver.kernel.org>; Tue, 25 Aug 2020 23:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgHYXpt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:45:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:9064 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgHYXps (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Aug 2020 19:45:48 -0400
IronPort-SDR: KgzpMLM/e/QqEPVJBKzAA8In5O5f8FHa4Q42O/yBOrJGkiGiKKN0AQyzqZptPamCqboPOw7PJb
 cxzVQ/pCsPhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="153636143"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="153636143"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 16:45:46 -0700
IronPort-SDR: /n2yN8XTg6/jfm5yPugbTJa0Y8jUj/2D6ly6HLlfGxnzmIkgXihZOlC0uyHRWHxPtrabga8rLF
 seAJn7FFR+Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="295174417"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Aug 2020 16:45:45 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kAidM-00019K-Il; Tue, 25 Aug 2020 23:45:44 +0000
Date:   Wed, 26 Aug 2020 07:45:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 52c3c3a59234a9725b5dcfe9729ed737d7843980
Message-ID: <5f45a285.jGRNc4534RnzWtxA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: 52c3c3a59234a9725b5dcfe9729ed737d7843980  Revert "vc_screen: extract vcs_read_buf_header"

elapsed time: 721m

configs tested: 132
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        mini2440_defconfig
arm                           tegra_defconfig
arm                        oxnas_v6_defconfig
arm                         hackkit_defconfig
sh                        edosk7760_defconfig
mips                     cu1000-neo_defconfig
arm                       versatile_defconfig
m68k                          multi_defconfig
arc                        vdk_hs38_defconfig
sh                 kfr2r09-romimage_defconfig
sh                               j2_defconfig
arm                        mvebu_v5_defconfig
arm                          imote2_defconfig
arm                        realview_defconfig
mips                       capcella_defconfig
arm                          ep93xx_defconfig
arm                         assabet_defconfig
openrisc                    or1ksim_defconfig
arm                    vt8500_v6_v7_defconfig
mips                         bigsur_defconfig
arm                           omap1_defconfig
arm                           h5000_defconfig
arm                           corgi_defconfig
sh                ecovec24-romimage_defconfig
riscv                    nommu_virt_defconfig
mips                         mpc30x_defconfig
arm                             ezx_defconfig
mips                           ip28_defconfig
arm                            mmp2_defconfig
c6x                        evmc6472_defconfig
sh                     magicpanelr2_defconfig
powerpc                      ppc64e_defconfig
arc                           tb10x_defconfig
arm                        vexpress_defconfig
mips                        bcm63xx_defconfig
mips                  cavium_octeon_defconfig
arm                         lpc18xx_defconfig
arm                         s5pv210_defconfig
openrisc                 simple_smp_defconfig
um                            kunit_defconfig
arc                              alldefconfig
xtensa                          iss_defconfig
powerpc                     mpc83xx_defconfig
arm                            zeus_defconfig
riscv                    nommu_k210_defconfig
m68k                            q40_defconfig
mips                      bmips_stb_defconfig
arc                          axs103_defconfig
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
i386                 randconfig-a002-20200825
i386                 randconfig-a004-20200825
i386                 randconfig-a005-20200825
i386                 randconfig-a003-20200825
i386                 randconfig-a006-20200825
i386                 randconfig-a001-20200825
i386                 randconfig-a002-20200826
i386                 randconfig-a004-20200826
i386                 randconfig-a003-20200826
i386                 randconfig-a005-20200826
i386                 randconfig-a006-20200826
i386                 randconfig-a001-20200826
x86_64               randconfig-a015-20200826
x86_64               randconfig-a016-20200826
x86_64               randconfig-a012-20200826
x86_64               randconfig-a014-20200826
x86_64               randconfig-a011-20200826
x86_64               randconfig-a013-20200826
i386                 randconfig-a013-20200826
i386                 randconfig-a012-20200826
i386                 randconfig-a011-20200826
i386                 randconfig-a016-20200826
i386                 randconfig-a015-20200826
i386                 randconfig-a014-20200826
i386                 randconfig-a013-20200825
i386                 randconfig-a012-20200825
i386                 randconfig-a011-20200825
i386                 randconfig-a016-20200825
i386                 randconfig-a015-20200825
i386                 randconfig-a014-20200825
x86_64               randconfig-a003-20200825
x86_64               randconfig-a002-20200825
x86_64               randconfig-a001-20200825
x86_64               randconfig-a005-20200825
x86_64               randconfig-a006-20200825
x86_64               randconfig-a004-20200825
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
