Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B43C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 14 Feb 2022 21:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiBNVs7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Feb 2022 16:48:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiBNVs6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Feb 2022 16:48:58 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27944192F2D
        for <linux-serial@vger.kernel.org>; Mon, 14 Feb 2022 13:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644875330; x=1676411330;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=V6Rc1kdjHr+Xc6VwjwdfduJRkpeBYKuSkzQSqcv/ngc=;
  b=g0Jn2J2Req824ERduzQOnpJLWhIa3wBTDCGH/gB+JfRbeovxf7rDrHNr
   0jwK4iYymIoroY0ilEap15YFxWm6Xh9yMkn+cJmmyefpF1fqTMnmk71qk
   YV2ydr1g0mmwVvVt4ypWrKEs9uyRxDhCFV2ikEF0wHp/eg1H6eLFkc75d
   CBu99yPD8Vv/B6EgZ5fJ7w80uxLqLGg7I2MsD62hrlxviRBORPbhJ6ZdP
   X3gu02Lv7nAU7WhoP1mMSxQWcNbs07ZXDZln6xf7OY4BlMp3Qljfv1IZl
   8qmMGLDvUJqCH2gQkY78b7Tfh38/+LpTvCq7djrDmEpb9U37Qk6dg3Nzk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250125321"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="250125321"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 12:26:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="773217146"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 14 Feb 2022 12:26:18 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJhvO-0008uy-8K; Mon, 14 Feb 2022 20:26:18 +0000
Date:   Tue, 15 Feb 2022 04:25:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 802d00bd774b77fe132e9e83462b96fb9919411c
Message-ID: <620ababf.+xEEoh9TALZbNZVp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 802d00bd774b77fe132e9e83462b96fb9919411c  Merge 5.17-rc4 into tty-next

elapsed time: 735m

configs tested: 222
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220214
sh                          rsk7264_defconfig
arm                           h3600_defconfig
openrisc                            defconfig
nios2                            alldefconfig
sh                          r7780mp_defconfig
sh                            titan_defconfig
ia64                         bigsur_defconfig
m68k                        mvme147_defconfig
sh                            hp6xx_defconfig
powerpc64                        alldefconfig
sh                               alldefconfig
arm                           tegra_defconfig
powerpc                     stx_gp3_defconfig
mips                        vocore2_defconfig
powerpc                     pq2fads_defconfig
m68k                         apollo_defconfig
ia64                        generic_defconfig
mips                      maltasmvp_defconfig
i386                             alldefconfig
sh                          sdk7780_defconfig
powerpc                    klondike_defconfig
powerpc                       ppc64_defconfig
arm                        trizeps4_defconfig
xtensa                         virt_defconfig
arc                     haps_hs_smp_defconfig
xtensa                              defconfig
arm                          lpd270_defconfig
csky                                defconfig
powerpc                     mpc83xx_defconfig
arm                          pxa910_defconfig
arm                           corgi_defconfig
mips                     decstation_defconfig
sh                ecovec24-romimage_defconfig
sh                              ul2_defconfig
mips                         rt305x_defconfig
sh                        edosk7705_defconfig
powerpc                      cm5200_defconfig
powerpc                       eiger_defconfig
arm                        shmobile_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                         lubbock_defconfig
parisc                           allyesconfig
arm                      integrator_defconfig
mips                          rb532_defconfig
s390                       zfcpdump_defconfig
sh                          polaris_defconfig
m68k                       m5475evb_defconfig
mips                     loongson1b_defconfig
sparc64                             defconfig
sh                             shx3_defconfig
sh                         apsh4a3a_defconfig
m68k                            mac_defconfig
mips                         tb0226_defconfig
sparc                               defconfig
arm64                            alldefconfig
arm                        mvebu_v7_defconfig
sparc64                          alldefconfig
mips                            gpr_defconfig
arm                         axm55xx_defconfig
sh                           se7721_defconfig
powerpc                     rainier_defconfig
s390                                defconfig
powerpc                 linkstation_defconfig
m68k                        stmark2_defconfig
mips                             allmodconfig
powerpc                           allnoconfig
sh                           se7722_defconfig
mips                         db1xxx_defconfig
powerpc                      ppc40x_defconfig
h8300                               defconfig
arm                         lpc18xx_defconfig
powerpc                      bamboo_defconfig
arc                        nsimosci_defconfig
powerpc                      tqm8xx_defconfig
sh                         ap325rxa_defconfig
powerpc                    adder875_defconfig
m68k                       bvme6000_defconfig
arm                      jornada720_defconfig
mips                            ar7_defconfig
sparc                       sparc64_defconfig
xtensa                           alldefconfig
mips                 decstation_r4k_defconfig
powerpc                  iss476-smp_defconfig
arm                  randconfig-c002-20220214
arm                  randconfig-c002-20220213
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a013-20220214
x86_64               randconfig-a014-20220214
x86_64               randconfig-a012-20220214
x86_64               randconfig-a015-20220214
x86_64               randconfig-a011-20220214
x86_64               randconfig-a016-20220214
x86_64                        randconfig-a006
i386                 randconfig-a013-20220214
i386                 randconfig-a016-20220214
i386                 randconfig-a012-20220214
i386                 randconfig-a015-20220214
i386                 randconfig-a011-20220214
i386                 randconfig-a014-20220214
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                randconfig-r042-20220214
arc                  randconfig-r043-20220214
s390                 randconfig-r044-20220214
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
riscv                randconfig-c006-20220214
i386                 randconfig-c001-20220214
x86_64               randconfig-c007-20220214
powerpc              randconfig-c003-20220214
arm                  randconfig-c002-20220214
mips                 randconfig-c004-20220214
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220213
arm                  randconfig-c002-20220213
i386                          randconfig-c001
mips                 randconfig-c004-20220213
riscv                randconfig-c006-20220213
arm                       aspeed_g4_defconfig
hexagon                             defconfig
mips                        workpad_defconfig
arm                         s3c2410_defconfig
powerpc                     ppa8548_defconfig
powerpc                     pseries_defconfig
powerpc                      ppc64e_defconfig
arm                        spear3xx_defconfig
powerpc                     tqm8560_defconfig
powerpc                     kmeter1_defconfig
arm                         socfpga_defconfig
powerpc                    socrates_defconfig
powerpc                          allmodconfig
mips                          ath25_defconfig
powerpc                        icon_defconfig
powerpc                     mpc5200_defconfig
arm                  colibri_pxa300_defconfig
arm                         bcm2835_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                  mpc885_ads_defconfig
mips                     loongson1c_defconfig
arm                        magician_defconfig
mips                         tb0287_defconfig
powerpc                     tqm8540_defconfig
powerpc                    gamecube_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                           rs90_defconfig
mips                          ath79_defconfig
mips                     cu1000-neo_defconfig
arm                            dove_defconfig
mips                            e55_defconfig
x86_64               randconfig-a002-20220214
x86_64               randconfig-a006-20220214
x86_64               randconfig-a005-20220214
x86_64               randconfig-a004-20220214
x86_64               randconfig-a003-20220214
x86_64               randconfig-a001-20220214
i386                 randconfig-a004-20220214
i386                 randconfig-a005-20220214
i386                 randconfig-a006-20220214
i386                 randconfig-a002-20220214
i386                 randconfig-a003-20220214
i386                 randconfig-a001-20220214
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a015
i386                          randconfig-a013
i386                          randconfig-a011
hexagon              randconfig-r045-20220213
hexagon              randconfig-r045-20220214
hexagon              randconfig-r041-20220214
hexagon              randconfig-r041-20220213
riscv                randconfig-r042-20220213
s390                 randconfig-r044-20220213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
