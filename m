Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3523BC433E9
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 20:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEED864F6B
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 20:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhCDU1d (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:27:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:18257 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238634AbhCDU11 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Mar 2021 15:27:27 -0500
IronPort-SDR: s8g5MSugK/yPvoS140N3/D0jTcJr6h9d7OFtULzbpYgouXWTAI2NpcMIx+2IQ9JQzDH19BkZsn
 LVFglrgcbS9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="251539633"
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="251539633"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 12:26:47 -0800
IronPort-SDR: Zg758I9f3A4iDZJpUh2lWMsvPyNVVNN0P2C9Wela2jC/oH9M9vA2rr/WKW7eKzkLEAOuO3Xh+b
 oHy6KmCkKYlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="435989529"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Mar 2021 12:26:45 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHuYW-0002NN-Mp; Thu, 04 Mar 2021 20:26:44 +0000
Date:   Fri, 05 Mar 2021 04:26:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 d1c1b2005dadca26cb1689063af3366de4398f78
Message-ID: <60414260.noIjiYx4ZqJ0E+JO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: d1c1b2005dadca26cb1689063af3366de4398f78  drivers: tty: serial: IMX_EARLYCON: fix Kconfig dependency on SERIAL_CORE

elapsed time: 721m

configs tested: 128
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                             pxa_defconfig
xtensa                         virt_defconfig
powerpc                          allyesconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                        icon_defconfig
arm                         axm55xx_defconfig
sparc                               defconfig
mips                           jazz_defconfig
h8300                    h8300h-sim_defconfig
riscv                          rv32_defconfig
mips                malta_kvm_guest_defconfig
arm                          badge4_defconfig
arm                            mps2_defconfig
arm                        multi_v7_defconfig
mips                      maltaaprp_defconfig
arc                          axs103_defconfig
powerpc                     ep8248e_defconfig
mips                      bmips_stb_defconfig
alpha                               defconfig
arm                        multi_v5_defconfig
mips                        vocore2_defconfig
sh                           se7780_defconfig
mips                         tb0287_defconfig
m68k                        m5307c3_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                          imote2_defconfig
arm                         hackkit_defconfig
um                             i386_defconfig
mips                        maltaup_defconfig
powerpc                     sequoia_defconfig
arm                             ezx_defconfig
arm                         s3c2410_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                      malta_kvm_defconfig
m68k                         amcore_defconfig
arm                          ep93xx_defconfig
powerpc                      pmac32_defconfig
microblaze                          defconfig
mips                      fuloong2e_defconfig
m68k                       m5208evb_defconfig
powerpc                       ebony_defconfig
sh                            titan_defconfig
mips                     loongson1c_defconfig
riscv                            allmodconfig
powerpc                     akebono_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                      pasemi_defconfig
powerpc64                           defconfig
ia64                                defconfig
powerpc                      bamboo_defconfig
powerpc                     mpc83xx_defconfig
powerpc                      chrp32_defconfig
xtensa                generic_kc705_defconfig
m68k                        m5407c3_defconfig
arm64                            alldefconfig
mips                          rb532_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc8315_rdb_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
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
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
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
