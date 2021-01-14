Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05093C433DB
	for <linux-serial@archiver.kernel.org>; Thu, 14 Jan 2021 04:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4DF8238E5
	for <linux-serial@archiver.kernel.org>; Thu, 14 Jan 2021 04:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbhANEha (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 Jan 2021 23:37:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:45026 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbhANEha (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 Jan 2021 23:37:30 -0500
IronPort-SDR: vxT+0Yf2eerKip5bC/ZDaiR9gnyth7LmAad5HZQPqIjpcUmfB5pxwU6FeGOOe0FMGoxeL1LoEe
 J7zRmaEsAH7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="242381803"
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="scan'208";a="242381803"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 20:36:48 -0800
IronPort-SDR: hOUTctKka0DqE8eEUTRRsbDxSlEUtZeWisXCR+dCrh2kGA6aY3nawmtlxe5FI+KopU85IOA7Hp
 xSQ74Nl8N4RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="scan'208";a="382130887"
Received: from lkp-server01.sh.intel.com (HELO d5d1a9a2c6bb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 13 Jan 2021 20:36:46 -0800
Received: from kbuild by d5d1a9a2c6bb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kzuNK-0000aV-7p; Thu, 14 Jan 2021 04:36:46 +0000
Date:   Thu, 14 Jan 2021 12:35:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 9335e23ddc33b5298b4cefdecc962736449fe596
Message-ID: <5fffca2d.wp/p1CldR5wOJB+E%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: 9335e23ddc33b5298b4cefdecc962736449fe596  tty: serial: owl: Add support for kernel debugger

elapsed time: 725m

configs tested: 149
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
powerpc                  mpc885_ads_defconfig
sh                         ap325rxa_defconfig
powerpc                      ep88xc_defconfig
powerpc                 mpc8540_ads_defconfig
mips                      pistachio_defconfig
arm                        spear3xx_defconfig
m68k                          hp300_defconfig
powerpc64                           defconfig
m68k                          multi_defconfig
powerpc                 mpc8560_ads_defconfig
arm                         vf610m4_defconfig
h8300                               defconfig
ia64                      gensparse_defconfig
arm                          pxa910_defconfig
powerpc                         ps3_defconfig
powerpc                 mpc832x_rdb_defconfig
nios2                         10m50_defconfig
arm                           sama5_defconfig
sh                           se7619_defconfig
powerpc                     ksi8560_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                 mpc834x_itx_defconfig
arm                       imx_v6_v7_defconfig
arm                        magician_defconfig
mips                       lemote2f_defconfig
mips                malta_kvm_guest_defconfig
arm                         lpc18xx_defconfig
sh                          polaris_defconfig
ia64                          tiger_defconfig
arm                          ep93xx_defconfig
powerpc                        icon_defconfig
arm                        clps711x_defconfig
m68k                             alldefconfig
powerpc                     sbc8548_defconfig
c6x                        evmc6457_defconfig
arm                        neponset_defconfig
mips                           ci20_defconfig
mips                        bcm63xx_defconfig
sh                      rts7751r2d1_defconfig
mips                           ip28_defconfig
sh                           se7206_defconfig
powerpc                     skiroot_defconfig
mips                 decstation_r4k_defconfig
arm                          simpad_defconfig
arm64                            alldefconfig
powerpc                     pseries_defconfig
mips                        nlm_xlp_defconfig
powerpc                           allnoconfig
mips                        qi_lb60_defconfig
powerpc                    gamecube_defconfig
microblaze                          defconfig
sh                         ecovec24_defconfig
powerpc                      chrp32_defconfig
nios2                            alldefconfig
arm                         s3c6400_defconfig
mips                           jazz_defconfig
powerpc                       holly_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                       maple_defconfig
powerpc                     redwood_defconfig
arm                            xcep_defconfig
mips                        vocore2_defconfig
powerpc                      tqm8xx_defconfig
mips                      pic32mzda_defconfig
arm                     am200epdkit_defconfig
arc                        nsimosci_defconfig
arc                    vdk_hs38_smp_defconfig
arc                              alldefconfig
m68k                        m5272c3_defconfig
arm                       imx_v4_v5_defconfig
arm                             ezx_defconfig
arm                         assabet_defconfig
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
x86_64               randconfig-a006-20210113
x86_64               randconfig-a004-20210113
x86_64               randconfig-a001-20210113
x86_64               randconfig-a005-20210113
x86_64               randconfig-a003-20210113
x86_64               randconfig-a002-20210113
i386                 randconfig-a002-20210113
i386                 randconfig-a005-20210113
i386                 randconfig-a006-20210113
i386                 randconfig-a003-20210113
i386                 randconfig-a001-20210113
i386                 randconfig-a004-20210113
i386                 randconfig-a012-20210113
i386                 randconfig-a011-20210113
i386                 randconfig-a016-20210113
i386                 randconfig-a013-20210113
i386                 randconfig-a015-20210113
i386                 randconfig-a014-20210113
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
x86_64               randconfig-a015-20210113
x86_64               randconfig-a012-20210113
x86_64               randconfig-a013-20210113
x86_64               randconfig-a016-20210113
x86_64               randconfig-a014-20210113
x86_64               randconfig-a011-20210113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
