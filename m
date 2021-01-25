Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED97C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 25 Jan 2021 02:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E92A9225AC
	for <linux-serial@archiver.kernel.org>; Mon, 25 Jan 2021 02:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbhAYCqF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 24 Jan 2021 21:46:05 -0500
Received: from mga03.intel.com ([134.134.136.65]:53417 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbhAYCqA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 24 Jan 2021 21:46:00 -0500
IronPort-SDR: F2DJz+7NiaQaLOQ8ggtZDT6gpM2x3sP4zpa7VtFib7QIHApwk3YETspeUNWX8Q/pHXGjSGjQCM
 N6f09iDb0qPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="179733517"
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="179733517"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 18:45:15 -0800
IronPort-SDR: iP5U37jt7tgC8Z3liwxXlU2tAYmUXwh0Nx1T8UaxREmyerNRR+YcKGjfqkuWCEdynJ8RAvrCbO
 b/LzjJHiHyvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="361000363"
Received: from lkp-server01.sh.intel.com (HELO 27c4e0a4b6d9) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jan 2021 18:45:14 -0800
Received: from kbuild by 27c4e0a4b6d9 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l3rsP-0000c9-Ku; Mon, 25 Jan 2021 02:45:13 +0000
Date:   Mon, 25 Jan 2021 10:44:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 17749851eb9ca2298e7c3b81aae4228961b36f28
Message-ID: <600e3093.H6TQZ13t4dB1uV1W%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 17749851eb9ca2298e7c3b81aae4228961b36f28  tty: fix up hung_up_tty_write() conversion

elapsed time: 1267m

configs tested: 116
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                     davinci_all_defconfig
powerpc                    amigaone_defconfig
m68k                       bvme6000_defconfig
arm                         vf610m4_defconfig
powerpc                     ppa8548_defconfig
sh                          rsk7264_defconfig
powerpc                 linkstation_defconfig
arm                      pxa255-idp_defconfig
arm                     am200epdkit_defconfig
mips                      pistachio_defconfig
xtensa                  cadence_csp_defconfig
powerpc                      katmai_defconfig
sh                        apsh4ad0a_defconfig
m68k                           sun3_defconfig
powerpc                     ksi8560_defconfig
powerpc                      chrp32_defconfig
arm                             mxs_defconfig
mips                     cu1000-neo_defconfig
powerpc                     tqm8560_defconfig
powerpc64                        alldefconfig
sh                        sh7757lcr_defconfig
powerpc                   bluestone_defconfig
powerpc                      pasemi_defconfig
arc                     haps_hs_smp_defconfig
powerpc                    mvme5100_defconfig
mips                       capcella_defconfig
powerpc                  mpc885_ads_defconfig
s390                          debug_defconfig
arm                          iop32x_defconfig
arm                          tango4_defconfig
mips                        nlm_xlr_defconfig
sh                           se7705_defconfig
arm                       aspeed_g4_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                      pmac32_defconfig
powerpc                     skiroot_defconfig
mips                        workpad_defconfig
powerpc                      walnut_defconfig
arm                           sama5_defconfig
mips                          ath79_defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210124
i386                 randconfig-a002-20210124
i386                 randconfig-a003-20210124
i386                 randconfig-a004-20210124
i386                 randconfig-a006-20210124
i386                 randconfig-a005-20210124
x86_64               randconfig-a012-20210124
x86_64               randconfig-a016-20210124
x86_64               randconfig-a015-20210124
x86_64               randconfig-a011-20210124
x86_64               randconfig-a013-20210124
x86_64               randconfig-a014-20210124
i386                 randconfig-a013-20210124
i386                 randconfig-a012-20210124
i386                 randconfig-a014-20210124
i386                 randconfig-a016-20210124
i386                 randconfig-a011-20210124
i386                 randconfig-a015-20210124
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

clang tested configs:
x86_64               randconfig-a003-20210124
x86_64               randconfig-a002-20210124
x86_64               randconfig-a001-20210124
x86_64               randconfig-a005-20210124
x86_64               randconfig-a006-20210124
x86_64               randconfig-a004-20210124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
