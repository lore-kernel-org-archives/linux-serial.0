Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F85EC2B9F4
	for <linux-serial@archiver.kernel.org>; Sat, 26 Jun 2021 00:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8FD61963
	for <linux-serial@archiver.kernel.org>; Sat, 26 Jun 2021 00:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFZALm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 20:11:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:35554 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhFZALm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 20:11:42 -0400
IronPort-SDR: m9kXRcWjhD9Q6KG8bLq4BhJgs1cC++3B0lpXyjMr1u0059etYGtpZ71lm1EA7PH96QfC2EOPoL
 G9o6fGETjjLA==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="271614868"
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="271614868"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 17:09:18 -0700
IronPort-SDR: xdFbM+xBxp6DpRlWuDw2Kpzddlh88DF4+9URHzhmSkHtpYT9NEUEtpk3N2zCyZD/rQoYBnqFen
 OaCxykJ97sNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="491739720"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jun 2021 17:09:17 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lwvsq-0007Sb-G8; Sat, 26 Jun 2021 00:09:16 +0000
Date:   Sat, 26 Jun 2021 08:08:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-next] BUILD SUCCESS
 15279ebe99d7c6142d9f1a6ae4ded66c0f168678
Message-ID: <60d67001.5qXI5WiuTALjdj9L%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
branch HEAD: 15279ebe99d7c6142d9f1a6ae4ded66c0f168678  serial: mvebu-uart: remove unused member nb from struct mvebu_uart

elapsed time: 720m

configs tested: 161
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         hackkit_defconfig
csky                             alldefconfig
arc                           tb10x_defconfig
sh                          rsk7201_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     akebono_defconfig
mips                        workpad_defconfig
xtensa                generic_kc705_defconfig
sh                          urquell_defconfig
mips                        omega2p_defconfig
sh                         ecovec24_defconfig
powerpc                         ps3_defconfig
powerpc                      mgcoge_defconfig
sh                        sh7785lcr_defconfig
sh                           se7721_defconfig
sh                        edosk7705_defconfig
mips                         rt305x_defconfig
sh                           se7206_defconfig
nios2                            alldefconfig
powerpc                 mpc8540_ads_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                       m5249evb_defconfig
arm                        keystone_defconfig
arm                       multi_v4t_defconfig
h8300                            alldefconfig
arm                         axm55xx_defconfig
powerpc                 mpc834x_itx_defconfig
sh                             espt_defconfig
microblaze                      mmu_defconfig
arm                          pxa3xx_defconfig
arm                          moxart_defconfig
arm                           u8500_defconfig
arm                         palmz72_defconfig
powerpc                 mpc834x_mds_defconfig
xtensa                    xip_kc705_defconfig
sh                           se7751_defconfig
mips                       capcella_defconfig
arm                      footbridge_defconfig
mips                             allmodconfig
powerpc                 mpc8315_rdb_defconfig
arm                            zeus_defconfig
arc                          axs101_defconfig
sh                          landisk_defconfig
ia64                          tiger_defconfig
sh                        dreamcast_defconfig
mips                          malta_defconfig
arc                            hsdk_defconfig
powerpc                      ppc40x_defconfig
arm                            dove_defconfig
arm                        mini2440_defconfig
arm                       versatile_defconfig
powerpc                 canyonlands_defconfig
arc                          axs103_defconfig
arm                        cerfcube_defconfig
sh                             shx3_defconfig
riscv                          rv32_defconfig
powerpc                    socrates_defconfig
powerpc                          g5_defconfig
powerpc                        fsp2_defconfig
sparc64                             defconfig
sparc                       sparc32_defconfig
s390                          debug_defconfig
powerpc                       ebony_defconfig
powerpc                       holly_defconfig
x86_64                            allnoconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210625
x86_64               randconfig-a001-20210625
x86_64               randconfig-a005-20210625
x86_64               randconfig-a003-20210625
x86_64               randconfig-a004-20210625
x86_64               randconfig-a006-20210625
i386                 randconfig-a002-20210625
i386                 randconfig-a001-20210625
i386                 randconfig-a003-20210625
i386                 randconfig-a006-20210625
i386                 randconfig-a005-20210625
i386                 randconfig-a004-20210625
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
i386                 randconfig-a011-20210625
i386                 randconfig-a014-20210625
i386                 randconfig-a013-20210625
i386                 randconfig-a015-20210625
i386                 randconfig-a012-20210625
i386                 randconfig-a016-20210625
i386                 randconfig-a011-20210622
i386                 randconfig-a014-20210622
i386                 randconfig-a013-20210622
i386                 randconfig-a015-20210622
i386                 randconfig-a012-20210622
i386                 randconfig-a016-20210622
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210622
x86_64               randconfig-b001-20210625
x86_64               randconfig-a012-20210625
x86_64               randconfig-a016-20210625
x86_64               randconfig-a015-20210625
x86_64               randconfig-a014-20210625
x86_64               randconfig-a013-20210625
x86_64               randconfig-a011-20210625
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
