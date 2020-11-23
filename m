Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E712AC63777
	for <linux-serial@archiver.kernel.org>; Mon, 23 Nov 2020 19:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 944F62074B
	for <linux-serial@archiver.kernel.org>; Mon, 23 Nov 2020 19:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgKWTdm (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:33:42 -0500
Received: from mga12.intel.com ([192.55.52.136]:17311 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728553AbgKWTdl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Nov 2020 14:33:41 -0500
IronPort-SDR: n9YsiXWgRN0sXFohrKGe3KVQpLlq7LV+O+pvOIkUUOCGqOzuEHm7hJIbUXKKrGXv67230zUrkQ
 bdeW8hetZlRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="151089105"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="151089105"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 11:33:41 -0800
IronPort-SDR: rgCfX+HTNxk4USDVqxQ9s7XGsQJLsYdgWvv4DMVOZxCEt8wsTDHdkbmDLlF2hswAO7J4JvP0gj
 vhObNWX25fyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="361570030"
Received: from lkp-server01.sh.intel.com (HELO 1138cb5768e3) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Nov 2020 11:33:40 -0800
Received: from kbuild by 1138cb5768e3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1khHal-0000AH-Dc; Mon, 23 Nov 2020 19:33:39 +0000
Date:   Tue, 24 Nov 2020 03:33:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 3b3e23092449a57f4ba57cd60506ab14055b1642
Message-ID: <5fbc0e8c.lE3DcxJMlRE+VevP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: 3b3e23092449a57f4ba57cd60506ab14055b1642  Merge 5.10-rc5 into tty-next

elapsed time: 725m

configs tested: 138
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                          hp300_defconfig
arm                         bcm2835_defconfig
sh                               alldefconfig
m68k                         apollo_defconfig
sh                ecovec24-romimage_defconfig
powerpc                 mpc832x_mds_defconfig
xtensa                         virt_defconfig
sh                          r7780mp_defconfig
arm                       netwinder_defconfig
xtensa                              defconfig
arm                            u300_defconfig
arm                         nhk8815_defconfig
sh                               allmodconfig
powerpc                      cm5200_defconfig
arm                          badge4_defconfig
powerpc                     tqm8540_defconfig
microblaze                      mmu_defconfig
arm                          simpad_defconfig
x86_64                           allyesconfig
sh                        apsh4ad0a_defconfig
xtensa                          iss_defconfig
powerpc                     skiroot_defconfig
powerpc                      makalu_defconfig
powerpc                        icon_defconfig
arm                         cm_x300_defconfig
arm64                            alldefconfig
mips                         tb0226_defconfig
powerpc                  iss476-smp_defconfig
sh                           se7724_defconfig
csky                             alldefconfig
arm                            dove_defconfig
m68k                           sun3_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     akebono_defconfig
arm                         s3c6400_defconfig
sparc                            alldefconfig
mips                           ip32_defconfig
sh                           se7721_defconfig
powerpc                      ep88xc_defconfig
c6x                         dsk6455_defconfig
mips                        qi_lb60_defconfig
arc                     nsimosci_hs_defconfig
riscv                            allmodconfig
mips                           gcw0_defconfig
powerpc                   bluestone_defconfig
mips                      fuloong2e_defconfig
powerpc                   lite5200b_defconfig
mips                          ath79_defconfig
arm                         hackkit_defconfig
mips                            ar7_defconfig
arm                        realview_defconfig
arm                      footbridge_defconfig
arm                       mainstone_defconfig
sparc64                          alldefconfig
arm                         assabet_defconfig
arm                  colibri_pxa270_defconfig
powerpc                   motionpro_defconfig
powerpc                      chrp32_defconfig
sh                          rsk7269_defconfig
mips                malta_qemu_32r6_defconfig
arm                             rpc_defconfig
powerpc                     pseries_defconfig
xtensa                  audio_kc705_defconfig
mips                       rbtx49xx_defconfig
arm                            mps2_defconfig
c6x                        evmc6474_defconfig
arm                        spear3xx_defconfig
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
i386                 randconfig-a004-20201123
i386                 randconfig-a003-20201123
i386                 randconfig-a002-20201123
i386                 randconfig-a005-20201123
i386                 randconfig-a001-20201123
i386                 randconfig-a006-20201123
x86_64               randconfig-a015-20201123
x86_64               randconfig-a011-20201123
x86_64               randconfig-a014-20201123
x86_64               randconfig-a016-20201123
x86_64               randconfig-a012-20201123
x86_64               randconfig-a013-20201123
i386                 randconfig-a012-20201123
i386                 randconfig-a013-20201123
i386                 randconfig-a011-20201123
i386                 randconfig-a016-20201123
i386                 randconfig-a014-20201123
i386                 randconfig-a015-20201123
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20201123
x86_64               randconfig-a003-20201123
x86_64               randconfig-a004-20201123
x86_64               randconfig-a005-20201123
x86_64               randconfig-a002-20201123
x86_64               randconfig-a001-20201123

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
