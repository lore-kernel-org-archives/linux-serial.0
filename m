Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAF9C4361B
	for <linux-serial@archiver.kernel.org>; Thu, 10 Dec 2020 06:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAEE02332A
	for <linux-serial@archiver.kernel.org>; Thu, 10 Dec 2020 06:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgLJGz1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Dec 2020 01:55:27 -0500
Received: from mga03.intel.com ([134.134.136.65]:32463 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbgLJGzR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Dec 2020 01:55:17 -0500
IronPort-SDR: 9RLjNsE6AKL99Hhwksgpvz4tf1BHuJomWszGktwAmImRzDf9+kcmjTkzpmprqUq/b7V8Ji7p3B
 278AF1FUiEtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="174323430"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="174323430"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 22:54:31 -0800
IronPort-SDR: R+EHeBlz+1tKG7xaxHBFQ/Gi0G8u76zuKaBBwm3MTtMVlVYLsK1nvKpnL8Qv2dfSMwLbyQ44w1
 cM04OIJcSrBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="438228256"
Received: from lkp-server01.sh.intel.com (HELO ecc0cebe68d1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 Dec 2020 22:54:29 -0800
Received: from kbuild by ecc0cebe68d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1knFqP-00007D-57; Thu, 10 Dec 2020 06:54:29 +0000
Date:   Thu, 10 Dec 2020 14:53:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS WITH WARNING
 603012f78a3f5cb2e7f529b8e318321117a9cf7c
Message-ID: <5fd1c5fe.LD8Yy4wNmeKUloNz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: 603012f78a3f5cb2e7f529b8e318321117a9cf7c  serial: imx: Remove unneeded of_device_get_match_data() NULL check

Warning reports:

https://lore.kernel.org/linux-serial/202011270526.uhlQ2Ov9-lkp@intel.com

Warning in current branch:

drivers/tty/serial/mxs-auart.c:1656:15: warning: cast to smaller integer type 'enum mxs_auart_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]

Warning ids grouped by kconfigs:

clang_recent_errors
`-- powerpc64-randconfig-r031-20201209
    `-- drivers-tty-serial-mxs-auart.c:warning:cast-to-smaller-integer-type-enum-mxs_auart_type-from-const-void

elapsed time: 725m

configs tested: 136
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          kfr2r09_defconfig
x86_64                           alldefconfig
arm                     am200epdkit_defconfig
arm                  colibri_pxa270_defconfig
arm                          lpd270_defconfig
powerpc                      tqm8xx_defconfig
arc                        vdk_hs38_defconfig
powerpc                      walnut_defconfig
ia64                         bigsur_defconfig
m68k                         apollo_defconfig
powerpc                     tqm8555_defconfig
riscv                            allmodconfig
m68k                        mvme16x_defconfig
mips                        omega2p_defconfig
ia64                        generic_defconfig
um                             i386_defconfig
mips                           gcw0_defconfig
sh                           se7724_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                           viper_defconfig
arm                         socfpga_defconfig
alpha                            alldefconfig
arm                        vexpress_defconfig
powerpc                      makalu_defconfig
arm                    vt8500_v6_v7_defconfig
mips                  maltasmvp_eva_defconfig
sh                        edosk7760_defconfig
arm                       imx_v6_v7_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                         tb0219_defconfig
mips                     cu1000-neo_defconfig
powerpc                     rainier_defconfig
arm                          pcm027_defconfig
mips                          ath25_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        oxnas_v6_defconfig
s390                                defconfig
arm                        spear6xx_defconfig
arm                         s3c6400_defconfig
mips                         db1xxx_defconfig
mips                            ar7_defconfig
arm                       versatile_defconfig
powerpc                        icon_defconfig
nios2                            alldefconfig
arm                       aspeed_g5_defconfig
powerpc                 canyonlands_defconfig
sh                      rts7751r2d1_defconfig
mips                         bigsur_defconfig
mips                           xway_defconfig
mips                         cobalt_defconfig
mips                        nlm_xlp_defconfig
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
i386                 randconfig-a004-20201209
i386                 randconfig-a005-20201209
i386                 randconfig-a001-20201209
i386                 randconfig-a002-20201209
i386                 randconfig-a006-20201209
i386                 randconfig-a003-20201209
i386                 randconfig-a001-20201210
i386                 randconfig-a004-20201210
i386                 randconfig-a003-20201210
i386                 randconfig-a002-20201210
i386                 randconfig-a005-20201210
i386                 randconfig-a006-20201210
x86_64               randconfig-a016-20201209
x86_64               randconfig-a012-20201209
x86_64               randconfig-a013-20201209
x86_64               randconfig-a014-20201209
x86_64               randconfig-a015-20201209
x86_64               randconfig-a011-20201209
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209
x86_64               randconfig-a003-20201210
x86_64               randconfig-a006-20201210
x86_64               randconfig-a002-20201210
x86_64               randconfig-a005-20201210
x86_64               randconfig-a004-20201210
x86_64               randconfig-a001-20201210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
