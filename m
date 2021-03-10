Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7BAC433DB
	for <linux-serial@archiver.kernel.org>; Wed, 10 Mar 2021 22:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80AC664E27
	for <linux-serial@archiver.kernel.org>; Wed, 10 Mar 2021 22:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhCJWG6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Mar 2021 17:06:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:22631 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234102AbhCJWGi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Mar 2021 17:06:38 -0500
IronPort-SDR: I8GbNiCJhd5wq1ZMa0LZLxRIPCrqF8GnP971knO3WpijXGmHDANUXkGGE6MyyfRtcMUM0rQWEw
 sXP98yRRJRCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="185217429"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="185217429"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 14:06:38 -0800
IronPort-SDR: WqIK60/lZGPkVhGOxz07mktxiWu5c/93cKIYwGp7xs6I5fgEiRu2n/Y9cf+f4Uu0mn0kQyBZf9
 bfX1LGwvR4YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="409262067"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 10 Mar 2021 14:06:36 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lK6yS-0000PQ-3R; Wed, 10 Mar 2021 22:06:36 +0000
Date:   Thu, 11 Mar 2021 06:05:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 3d82be8be6fdf38543fa3ae9c35beda4a8a8d067
Message-ID: <604942b7.1ltyyPDksONrw8zo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 3d82be8be6fdf38543fa3ae9c35beda4a8a8d067  serial: stm32: add support for "flush_buffer" ops

elapsed time: 727m

configs tested: 111
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sparc                            allyesconfig
mips                         db1xxx_defconfig
powerpc                     tqm8540_defconfig
powerpc                      ppc44x_defconfig
m68k                          hp300_defconfig
powerpc                    adder875_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                      ppc40x_defconfig
mips                      pistachio_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                             mxs_defconfig
sh                         microdev_defconfig
mips                       capcella_defconfig
arm                        mvebu_v7_defconfig
xtensa                  cadence_csp_defconfig
mips                  maltasmvp_eva_defconfig
h8300                    h8300h-sim_defconfig
mips                            gpr_defconfig
powerpc64                        alldefconfig
powerpc                     tqm8541_defconfig
sh                          urquell_defconfig
arc                    vdk_hs38_smp_defconfig
m68k                       bvme6000_defconfig
x86_64                              defconfig
arm                        spear3xx_defconfig
arm                       omap2plus_defconfig
arm                      tct_hammer_defconfig
arm                         lubbock_defconfig
arm                            hisi_defconfig
mips                           ip32_defconfig
sh                          lboxre2_defconfig
powerpc                 mpc832x_mds_defconfig
riscv                               defconfig
arm                         s3c2410_defconfig
mips                          ath79_defconfig
sh                         ap325rxa_defconfig
mips                           jazz_defconfig
arm                        multi_v5_defconfig
m68k                        m5272c3_defconfig
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
parisc                           allyesconfig
s390                                defconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210308
x86_64               randconfig-a001-20210308
x86_64               randconfig-a004-20210308
x86_64               randconfig-a002-20210308
x86_64               randconfig-a005-20210308
x86_64               randconfig-a003-20210308
i386                 randconfig-a005-20210309
i386                 randconfig-a003-20210309
i386                 randconfig-a002-20210309
i386                 randconfig-a006-20210309
i386                 randconfig-a004-20210309
i386                 randconfig-a001-20210309
x86_64               randconfig-a011-20210310
x86_64               randconfig-a016-20210310
x86_64               randconfig-a013-20210310
x86_64               randconfig-a015-20210310
x86_64               randconfig-a014-20210310
x86_64               randconfig-a012-20210310
i386                 randconfig-a016-20210309
i386                 randconfig-a012-20210309
i386                 randconfig-a014-20210309
i386                 randconfig-a013-20210309
i386                 randconfig-a011-20210309
i386                 randconfig-a015-20210309
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
