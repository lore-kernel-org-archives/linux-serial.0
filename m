Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFC2C433DB
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 05:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F04164F59
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 05:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhCEF5C (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Mar 2021 00:57:02 -0500
Received: from mga06.intel.com ([134.134.136.31]:10221 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhCEF5B (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Mar 2021 00:57:01 -0500
IronPort-SDR: hi0+5n+jYzH7cT3Bo0uDehjcaoMfsLJj/LoXHvlJRwsh2Y374qCZVU+jYoc4zP743X89XHPu/z
 QdUVtdabT1lQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="248968313"
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="248968313"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 21:57:01 -0800
IronPort-SDR: imCUU02q5wwIy+4Bp4sN8ei2a9idXfb22MH4qbVFaOmYODYf2y+1xqnKh2zcVqELGWY2dK1CFH
 BlIcrmwq/z9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="597660980"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 04 Mar 2021 21:57:00 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lI3SN-0002dR-J5; Fri, 05 Mar 2021 05:56:59 +0000
Date:   Fri, 05 Mar 2021 13:56:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 4bed5190a8334958c961818e2a39dc021b142627
Message-ID: <6041c802.WFZYhsEVVRQborGX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 4bed5190a8334958c961818e2a39dc021b142627  Revert "drivers:tty:pty: Fix a race causing data loss on close"

elapsed time: 721m

configs tested: 131
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7750_defconfig
arm                          pxa3xx_defconfig
arm                           u8500_defconfig
m68k                          sun3x_defconfig
arm                        mvebu_v7_defconfig
m68k                         apollo_defconfig
arm                         s3c2410_defconfig
ia64                            zx1_defconfig
powerpc                     kmeter1_defconfig
s390                                defconfig
m68k                        m5307c3_defconfig
sh                ecovec24-romimage_defconfig
sparc64                          alldefconfig
arm                            dove_defconfig
arm                       multi_v4t_defconfig
powerpc                       maple_defconfig
mips                     cu1830-neo_defconfig
powerpc                 linkstation_defconfig
x86_64                              defconfig
arm                  colibri_pxa270_defconfig
xtensa                           alldefconfig
powerpc                     tqm8541_defconfig
powerpc                      pcm030_defconfig
um                           x86_64_defconfig
arc                            hsdk_defconfig
arc                        nsim_700_defconfig
arm                         mv78xx0_defconfig
mips                 decstation_r4k_defconfig
mips                        workpad_defconfig
arm                         hackkit_defconfig
mips                           jazz_defconfig
csky                                defconfig
powerpc                     taishan_defconfig
powerpc                         wii_defconfig
arc                      axs103_smp_defconfig
m68k                          amiga_defconfig
powerpc                     tqm8540_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     pq2fads_defconfig
arm                           h3600_defconfig
arm                        cerfcube_defconfig
sh                            shmin_defconfig
powerpc                     pseries_defconfig
h8300                               defconfig
riscv                          rv32_defconfig
powerpc                  iss476-smp_defconfig
powerpc                  mpc885_ads_defconfig
nds32                            alldefconfig
parisc                generic-32bit_defconfig
arm                            mps2_defconfig
arm                        shmobile_defconfig
m68k                          atari_defconfig
arm                            mmp2_defconfig
powerpc                 mpc836x_mds_defconfig
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
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210304
x86_64               randconfig-a001-20210304
x86_64               randconfig-a004-20210304
x86_64               randconfig-a005-20210304
x86_64               randconfig-a002-20210304
x86_64               randconfig-a003-20210304
i386                 randconfig-a005-20210304
i386                 randconfig-a003-20210304
i386                 randconfig-a002-20210304
i386                 randconfig-a004-20210304
i386                 randconfig-a006-20210304
i386                 randconfig-a001-20210304
x86_64               randconfig-a013-20210305
x86_64               randconfig-a016-20210305
x86_64               randconfig-a015-20210305
x86_64               randconfig-a014-20210305
x86_64               randconfig-a012-20210305
x86_64               randconfig-a011-20210305
i386                 randconfig-a016-20210304
i386                 randconfig-a012-20210304
i386                 randconfig-a013-20210304
i386                 randconfig-a014-20210304
i386                 randconfig-a011-20210304
i386                 randconfig-a015-20210304
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210304
x86_64               randconfig-a016-20210304
x86_64               randconfig-a015-20210304
x86_64               randconfig-a014-20210304
x86_64               randconfig-a012-20210304
x86_64               randconfig-a011-20210304

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
