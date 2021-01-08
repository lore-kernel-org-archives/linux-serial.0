Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F57BC433E6
	for <linux-serial@archiver.kernel.org>; Fri,  8 Jan 2021 16:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B23523884
	for <linux-serial@archiver.kernel.org>; Fri,  8 Jan 2021 16:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbhAHQCf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 8 Jan 2021 11:02:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:5671 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbhAHQCe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 Jan 2021 11:02:34 -0500
IronPort-SDR: KLU1vS3Gs4/2EmX84ojOHhUWZSVW7XLebwuYFxkfom2laFocc4PGFmwI+yFxYoTbPc7V/ZcEB+
 xxf1/0HAM+gQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="177712626"
X-IronPort-AV: E=Sophos;i="5.79,331,1602572400"; 
   d="scan'208";a="177712626"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 08:01:46 -0800
IronPort-SDR: ERpU7hk0OuKz+ojBYqlXGCUfHe9nPu2CcdU7LAZtkY0hvT3D4KXRwgq9rJ728zW29eGzXw9hz2
 T93fTtiIzwnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,331,1602572400"; 
   d="scan'208";a="396343154"
Received: from lkp-server01.sh.intel.com (HELO 412602b27703) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Jan 2021 08:01:44 -0800
Received: from kbuild by 412602b27703 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kxuCt-0000Nz-Vq; Fri, 08 Jan 2021 16:01:43 +0000
Date:   Sat, 09 Jan 2021 00:01:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 c9cd57bf57fd450972a7802b9f09a680dbb4634e
Message-ID: <5ff881bc.zo+qk/O7IJG+Bdry%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: c9cd57bf57fd450972a7802b9f09a680dbb4634e  tty: Protect disc_data in n_tty_close and n_tty_flush_buffer

elapsed time: 859m

configs tested: 118
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                            alldefconfig
c6x                         dsk6455_defconfig
arm                        mini2440_defconfig
mips                          rb532_defconfig
mips                       rbtx49xx_defconfig
nios2                            allyesconfig
powerpc                    mvme5100_defconfig
mips                          ath25_defconfig
sh                             shx3_defconfig
m68k                          multi_defconfig
sh                          lboxre2_defconfig
arc                     haps_hs_smp_defconfig
um                           x86_64_defconfig
sparc64                          alldefconfig
arm                        oxnas_v6_defconfig
sh                           se7721_defconfig
arm                       aspeed_g4_defconfig
arm                         vf610m4_defconfig
arm                          badge4_defconfig
arm                        neponset_defconfig
arm                       imx_v4_v5_defconfig
sh                         ap325rxa_defconfig
m68k                         amcore_defconfig
ia64                             alldefconfig
sh                        sh7785lcr_defconfig
powerpc                      pcm030_defconfig
powerpc                 mpc832x_rdb_defconfig
m68k                          amiga_defconfig
m68k                       bvme6000_defconfig
xtensa                          iss_defconfig
powerpc                      makalu_defconfig
arm                           h3600_defconfig
m68k                          atari_defconfig
sparc                       sparc64_defconfig
c6x                        evmc6472_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                          rm200_defconfig
powerpc                        cell_defconfig
nios2                         3c120_defconfig
mips                         bigsur_defconfig
powerpc                  storcenter_defconfig
powerpc                mpc7448_hpc2_defconfig
m68k                        m5272c3_defconfig
sh                         ecovec24_defconfig
nds32                            alldefconfig
sh                           se7724_defconfig
powerpc                      cm5200_defconfig
arm                         lpc32xx_defconfig
ia64                         bigsur_defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210108
x86_64               randconfig-a006-20210108
x86_64               randconfig-a001-20210108
x86_64               randconfig-a002-20210108
x86_64               randconfig-a003-20210108
x86_64               randconfig-a005-20210108
i386                 randconfig-a005-20210108
i386                 randconfig-a002-20210108
i386                 randconfig-a001-20210108
i386                 randconfig-a003-20210108
i386                 randconfig-a006-20210108
i386                 randconfig-a004-20210108
i386                 randconfig-a016-20210108
i386                 randconfig-a011-20210108
i386                 randconfig-a014-20210108
i386                 randconfig-a015-20210108
i386                 randconfig-a013-20210108
i386                 randconfig-a012-20210108
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
