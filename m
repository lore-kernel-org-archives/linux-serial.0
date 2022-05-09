Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7190C433F5
	for <linux-serial@archiver.kernel.org>; Mon,  9 May 2022 13:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbiEINZ1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 May 2022 09:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbiEINZK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 May 2022 09:25:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5117E2654A
        for <linux-serial@vger.kernel.org>; Mon,  9 May 2022 06:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652102476; x=1683638476;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ciOthC6HTRvYUF9L5MkY4ykxmTft1vd8u1JSeGXcP58=;
  b=Ta3LpFA3idUCShfERa3o/QPrgJxWTDVOcsrSsKsI3UFdwN5XKg3NceLB
   czx3ULESM3s2RWbqBd0qYZCMnANeqK51o+9Mx9DC8RAFDdEUsdWTBV0Kh
   yiDr6nm7xcNiYovhzSwXzwCZRaUxRxWK3zHN6e9gXktTVEM7L1UNpWdOP
   HQU77ybWbOSzOPvxL/JF5gn063JUdWgKn2iycdZ68XNSymbxr1MWCkaop
   gVS/rV+ShOpfu8k/tIbSzKQb9/k2njs00V8CUO5CGoEuaPcu9KcBt2QXK
   b2QwOmpq0fP5z2bI86OQVhotVUBtHGTemScHtLYaBSNlQ/VO1wj0a4cLj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="268976628"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="268976628"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 06:21:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="540863099"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 09 May 2022 06:21:12 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1no3K4-000GXm-6Q;
        Mon, 09 May 2022 13:21:12 +0000
Date:   Mon, 09 May 2022 21:20:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-next] BUILD SUCCESS
 9e6a90790357e8b468445f5c549c498126cedefb
Message-ID: <62791517.j3PmRH1XeS9hgi2z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
branch HEAD: 9e6a90790357e8b468445f5c549c498126cedefb  Merge 5.18-rc5 into tty-next

elapsed time: 10079m

configs tested: 234
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                         tb0226_defconfig
powerpc                      cm5200_defconfig
powerpc                       holly_defconfig
powerpc                         ps3_defconfig
arc                     haps_hs_smp_defconfig
arc                            hsdk_defconfig
arm                         vf610m4_defconfig
xtensa                           allyesconfig
powerpc                     ep8248e_defconfig
nios2                            allyesconfig
s390                       zfcpdump_defconfig
arm                        realview_defconfig
arm                       multi_v4t_defconfig
xtensa                  nommu_kc705_defconfig
sparc64                          alldefconfig
parisc                              defconfig
sh                         microdev_defconfig
powerpc                     taishan_defconfig
m68k                           sun3_defconfig
powerpc                      pcm030_defconfig
parisc                           allyesconfig
arm                     eseries_pxa_defconfig
sh                           se7780_defconfig
powerpc                     pq2fads_defconfig
m68k                          hp300_defconfig
ia64                          tiger_defconfig
m68k                          atari_defconfig
powerpc                           allnoconfig
powerpc                     tqm8555_defconfig
h8300                               defconfig
sh                          rsk7264_defconfig
sparc                            alldefconfig
sh                           se7619_defconfig
mips                        bcm47xx_defconfig
sh                        apsh4ad0a_defconfig
arm                        keystone_defconfig
i386                                defconfig
mips                         rt305x_defconfig
alpha                            alldefconfig
powerpc                      ep88xc_defconfig
arm                           imxrt_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                    klondike_defconfig
m68k                       m5275evb_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
parisc                generic-64bit_defconfig
sh                          lboxre2_defconfig
m68k                       m5249evb_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                           ip32_defconfig
powerpc                     asp8347_defconfig
sh                            shmin_defconfig
arc                     nsimosci_hs_defconfig
sh                 kfr2r09-romimage_defconfig
arm                         nhk8815_defconfig
sh                            migor_defconfig
arc                        vdk_hs38_defconfig
m68k                        mvme16x_defconfig
arc                        nsimosci_defconfig
powerpc64                           defconfig
arm                       omap2plus_defconfig
mips                  decstation_64_defconfig
sh                          kfr2r09_defconfig
mips                      fuloong2e_defconfig
sh                        edosk7760_defconfig
s390                          debug_defconfig
sh                      rts7751r2d1_defconfig
powerpc                        cell_defconfig
arc                         haps_hs_defconfig
powerpc                     sequoia_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                         cobalt_defconfig
openrisc                  or1klitex_defconfig
sh                        sh7757lcr_defconfig
mips                     decstation_defconfig
powerpc                         wii_defconfig
powerpc                 mpc8540_ads_defconfig
s390                             allyesconfig
powerpc                    amigaone_defconfig
powerpc                       maple_defconfig
mips                      maltasmvp_defconfig
sh                             espt_defconfig
xtensa                    smp_lx200_defconfig
openrisc                            defconfig
sh                          urquell_defconfig
sh                                  defconfig
arm                         at91_dt_defconfig
h8300                       h8s-sim_defconfig
sh                           sh2007_defconfig
powerpc                     mpc83xx_defconfig
mips                             allyesconfig
m68k                             alldefconfig
arm                            qcom_defconfig
mips                       bmips_be_defconfig
sparc                       sparc64_defconfig
sh                        sh7763rdp_defconfig
m68k                             allmodconfig
arm                        oxnas_v6_defconfig
sh                           se7721_defconfig
sh                           se7705_defconfig
arm                        mini2440_defconfig
m68k                             allyesconfig
microblaze                      mmu_defconfig
arc                                 defconfig
sh                             sh03_defconfig
sh                               j2_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220501
arm                  randconfig-c002-20220505
x86_64               randconfig-c001-20220502
i386                 randconfig-c001-20220502
arm                  randconfig-c002-20220502
arm                  randconfig-c002-20220506
ia64                                defconfig
ia64                             allyesconfig
ia64                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
sh                               allmodconfig
h8300                            allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc64                            defconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a006-20220502
x86_64               randconfig-a001-20220502
x86_64               randconfig-a003-20220502
x86_64               randconfig-a002-20220502
x86_64               randconfig-a004-20220502
x86_64               randconfig-a005-20220502
i386                 randconfig-a004-20220502
i386                 randconfig-a006-20220502
i386                 randconfig-a002-20220502
i386                 randconfig-a003-20220502
i386                 randconfig-a001-20220502
i386                 randconfig-a005-20220502
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220501
arc                  randconfig-r043-20220502
s390                 randconfig-r044-20220501
riscv                randconfig-r042-20220501
arc                  randconfig-r043-20220505
s390                 randconfig-r044-20220505
riscv                randconfig-r042-20220505
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220501
riscv                randconfig-c006-20220501
mips                 randconfig-c004-20220501
arm                  randconfig-c002-20220501
powerpc              randconfig-c003-20220505
riscv                randconfig-c006-20220505
arm                  randconfig-c002-20220505
riscv                    nommu_virt_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                      katmai_defconfig
arm                          moxart_defconfig
arm                  colibri_pxa270_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      ppc44x_defconfig
powerpc                        fsp2_defconfig
powerpc                   microwatt_defconfig
mips                       lemote2f_defconfig
arm                         bcm2835_defconfig
arm                          ep93xx_defconfig
mips                           rs90_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                            dove_defconfig
powerpc                      pmac32_defconfig
powerpc                     ksi8560_defconfig
riscv                          rv32_defconfig
mips                          ath25_defconfig
powerpc                       ebony_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a015-20220502
x86_64               randconfig-a012-20220502
x86_64               randconfig-a016-20220502
x86_64               randconfig-a014-20220502
x86_64               randconfig-a013-20220502
x86_64               randconfig-a011-20220502
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220502
hexagon              randconfig-r045-20220501
riscv                randconfig-r042-20220502
hexagon              randconfig-r041-20220502
hexagon              randconfig-r041-20220501

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
