Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51245C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 15 Apr 2022 20:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350169AbiDOUiE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Apr 2022 16:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiDOUiD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Apr 2022 16:38:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA1F716E8
        for <linux-serial@vger.kernel.org>; Fri, 15 Apr 2022 13:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650054934; x=1681590934;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ApVk9sn7V5ok3Q8R1V1GMFk1GKpRsipay5gSfhg1Kp0=;
  b=CESTOn48gfc/g1hXLZ5GQrGjvTDoEf/ib+tvCsRcjVRgxn0wYLe3dl3V
   HaP9sTNX5YpOjzt/DKomyNhUOei4dmbqcLyEBAv1tSIrP2cPn6Cuk94/L
   Jpie+UiuzT0bXVBUwyZwJH+smHZxI0a6RO/r/QqUtmfeoKSJDYN5pe8IJ
   OuTiie01TevCR8mbiNeVBt3Rpf1f4p3FLZiuCMmXaieBQLaq6lukg/H3u
   oU20mR3vGBThL9MxQCTYHXPbIPu8g8aiyLdJFREDqrHBCoekq4mKe7/LA
   hw86xWDdyvnF+Ye8d26FLuEwj7KDylEUJaFO1jdGJfh5EnuXz48qJuoEO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="250523275"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="250523275"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 13:35:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="662311381"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Apr 2022 13:35:33 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfSfE-0002OG-AT;
        Fri, 15 Apr 2022 20:35:32 +0000
Date:   Sat, 16 Apr 2022 04:35:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-next] BUILD SUCCESS
 9c3a431a486d0c494a68941045885333a5bc1975
Message-ID: <6259d6f7.BZa5vpupetmW8aKp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
branch HEAD: 9c3a431a486d0c494a68941045885333a5bc1975  tty: serial: altera: use altera_jtaguart_stop_tx()

elapsed time: 1591m

configs tested: 148
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
powerpc              randconfig-c003-20220414
sh                   secureedge5410_defconfig
powerpc                   motionpro_defconfig
arc                     haps_hs_smp_defconfig
arc                          axs103_defconfig
m68k                        stmark2_defconfig
sparc                       sparc64_defconfig
sh                          rsk7264_defconfig
mips                           xway_defconfig
xtensa                       common_defconfig
powerpc64                           defconfig
powerpc                      bamboo_defconfig
microblaze                          defconfig
sparc                            allyesconfig
mips                     loongson1b_defconfig
arm                          pxa910_defconfig
arm                         lubbock_defconfig
arm                           tegra_defconfig
ia64                                defconfig
powerpc                         wii_defconfig
arc                        vdk_hs38_defconfig
mips                           jazz_defconfig
sh                           se7724_defconfig
arm                           imxrt_defconfig
arm                            mps2_defconfig
powerpc                        warp_defconfig
i386                                defconfig
powerpc                       eiger_defconfig
arm                       multi_v4t_defconfig
powerpc                     mpc83xx_defconfig
sh                        sh7757lcr_defconfig
mips                      maltasmvp_defconfig
sh                                  defconfig
alpha                            allyesconfig
mips                            gpr_defconfig
powerpc64                        alldefconfig
arm                     eseries_pxa_defconfig
sh                   sh7724_generic_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                           se7722_defconfig
powerpc                     ep8248e_defconfig
arc                        nsim_700_defconfig
xtensa                  cadence_csp_defconfig
xtensa                  nommu_kc705_defconfig
sh                         microdev_defconfig
mips                         bigsur_defconfig
m68k                          atari_defconfig
sh                           se7712_defconfig
mips                     decstation_defconfig
s390                          debug_defconfig
s390                                defconfig
sh                           se7343_defconfig
sh                          rsk7269_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220414
arm                  randconfig-c002-20220415
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220415
arc                  randconfig-r043-20220415
s390                 randconfig-r044-20220415
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220414
arm                  randconfig-c002-20220414
i386                          randconfig-c001
riscv                randconfig-c006-20220414
x86_64                           allyesconfig
mips                           ip28_defconfig
arm                           omap1_defconfig
arm                            dove_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                      acadia_defconfig
powerpc                      obs600_defconfig
riscv                             allnoconfig
powerpc                     kmeter1_defconfig
arm                       mainstone_defconfig
mips                       rbtx49xx_defconfig
arm                      tct_hammer_defconfig
powerpc                     tqm5200_defconfig
arm                        multi_v5_defconfig
mips                           mtx1_defconfig
arm                        spear3xx_defconfig
arm                        vexpress_defconfig
arm                          collie_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
riscv                randconfig-r042-20220414
hexagon              randconfig-r041-20220414
hexagon              randconfig-r045-20220414

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
