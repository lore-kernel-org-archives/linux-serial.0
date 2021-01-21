Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB771C433DB
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 23:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9185206B7
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 23:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbhAUXoe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Jan 2021 18:44:34 -0500
Received: from mga18.intel.com ([134.134.136.126]:42990 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbhAUXod (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Jan 2021 18:44:33 -0500
IronPort-SDR: /VnISIVH79d9OTVZDans7wtOWK9CuJeRkZvtPTYqFBS+qFGE2qFy5lbQZO9ee/XQ0IitQ1srOT
 sJY0OwkIENrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="167040863"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="167040863"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 15:43:50 -0800
IronPort-SDR: Qo4j2viYUUB8KqSNmjONKx6wp++M1j82CXdx1g5tMp3G5AAWInef/w6FB6TSqg4/m3BC1Ascyn
 s0fTeLzYfFzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="351640958"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Jan 2021 15:43:49 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l2jcC-0006mG-Jr; Thu, 21 Jan 2021 23:43:48 +0000
Date:   Fri, 22 Jan 2021 07:43:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 494e63ee9c9f322c1051acc537ac5b99688f7e58
Message-ID: <600a11a2.UJmOXcA7JzW9S+Ys%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 494e63ee9c9f322c1051acc537ac5b99688f7e58  Merge 9bb48c82aced ("tty: implement write_iter") into tty-linus

elapsed time: 727m

configs tested: 107
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
openrisc                         alldefconfig
arm                            lart_defconfig
arm                            pleb_defconfig
arm                         assabet_defconfig
sh                           se7619_defconfig
arm                        trizeps4_defconfig
s390                       zfcpdump_defconfig
arm                        mvebu_v5_defconfig
sh                            hp6xx_defconfig
mips                        vocore2_defconfig
sh                           se7780_defconfig
arc                          axs101_defconfig
arc                        vdk_hs38_defconfig
x86_64                           alldefconfig
mips                          ath79_defconfig
sh                          lboxre2_defconfig
xtensa                generic_kc705_defconfig
powerpc                    socrates_defconfig
m68k                          atari_defconfig
arm                             mxs_defconfig
powerpc                   currituck_defconfig
arm                         cm_x300_defconfig
mips                           ip27_defconfig
m68k                         amcore_defconfig
powerpc                     sequoia_defconfig
mips                          ath25_defconfig
arm                         orion5x_defconfig
arm                         s3c6400_defconfig
arm                           u8500_defconfig
powerpc                  storcenter_defconfig
powerpc                         wii_defconfig
xtensa                              defconfig
sh                   rts7751r2dplus_defconfig
arm                       aspeed_g4_defconfig
mips                          malta_defconfig
csky                             alldefconfig
powerpc                     ppa8548_defconfig
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
x86_64               randconfig-a002-20210121
x86_64               randconfig-a003-20210121
x86_64               randconfig-a001-20210121
x86_64               randconfig-a005-20210121
x86_64               randconfig-a006-20210121
x86_64               randconfig-a004-20210121
i386                 randconfig-a001-20210121
i386                 randconfig-a002-20210121
i386                 randconfig-a004-20210121
i386                 randconfig-a006-20210121
i386                 randconfig-a005-20210121
i386                 randconfig-a003-20210121
i386                 randconfig-a013-20210121
i386                 randconfig-a011-20210121
i386                 randconfig-a012-20210121
i386                 randconfig-a014-20210121
i386                 randconfig-a015-20210121
i386                 randconfig-a016-20210121
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
