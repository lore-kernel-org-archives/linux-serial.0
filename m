Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F60C433EF
	for <linux-serial@archiver.kernel.org>; Sun, 24 Apr 2022 23:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbiDXXDN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 24 Apr 2022 19:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiDXXDM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 24 Apr 2022 19:03:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9E322BF4
        for <linux-serial@vger.kernel.org>; Sun, 24 Apr 2022 16:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650841209; x=1682377209;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KEJu2WK25UCzva4NSMnEyBj0xfnihgF4sAYHqn6nF/w=;
  b=IJM9ND1uUnYaFUHK5MFgPo2bJe02xYxpBlg81sTfHfNziYWidcOjGSac
   +5D+6wW+jY8KvYhm6j8Awcy6cbJrg7tzGcMjTm9pqUTDK2ZZ6k2swruZD
   He0tbzKJxMb+eLaqeGh5ggS0Pe3C6v07UM08JxA+OJmTw9mtKkHwP4Uk3
   bCmg5/s3apyTbOdr4J9sDtIa85jiTp61OqbIh9VHQzndu1+D0bLr40IO6
   +BVM8D0x8Zwh2nKYf4Xn4DXr1cEfsLBDnz6V81GOoDGrjHWdLDwXPqVY/
   MsV0Zsl89uVQo0j0gE4EaS2QSlafl+qrruV+B3WdvuvAGcMI5kn5zmvif
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="265260861"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="265260861"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 16:00:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="616253628"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 24 Apr 2022 16:00:06 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nilD4-0001tA-7o;
        Sun, 24 Apr 2022 23:00:06 +0000
Date:   Mon, 25 Apr 2022 06:59:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 8043b16f522c9e21e2361a67514386bee3731c6e
Message-ID: <6265d66d.2CKc2UWk7a00bUit%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 8043b16f522c9e21e2361a67514386bee3731c6e  serial: stm32: add earlycon support

elapsed time: 3313m

configs tested: 206
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                        keystone_defconfig
arm                        mvebu_v7_defconfig
powerpc                        cell_defconfig
mips                         rt305x_defconfig
sh                           se7750_defconfig
sh                           sh2007_defconfig
i386                                defconfig
powerpc                       maple_defconfig
arc                          axs101_defconfig
arc                          axs103_defconfig
sh                        edosk7705_defconfig
powerpc                   currituck_defconfig
powerpc                      pcm030_defconfig
arm                          simpad_defconfig
m68k                        m5407c3_defconfig
um                                  defconfig
arc                        nsimosci_defconfig
h8300                       h8s-sim_defconfig
sh                     sh7710voipgw_defconfig
arc                      axs103_smp_defconfig
sh                          r7785rp_defconfig
mips                  decstation_64_defconfig
powerpc                      tqm8xx_defconfig
arm                      jornada720_defconfig
arm                        shmobile_defconfig
powerpc                       holly_defconfig
arm                     eseries_pxa_defconfig
um                             i386_defconfig
arc                     nsimosci_hs_defconfig
sh                        apsh4ad0a_defconfig
m68k                        mvme147_defconfig
arm                          exynos_defconfig
x86_64                           alldefconfig
mips                        bcm47xx_defconfig
sparc64                             defconfig
um                               alldefconfig
ia64                        generic_defconfig
arm                           viper_defconfig
arm                           sama5_defconfig
arm                             pxa_defconfig
arm                            lart_defconfig
arm                            zeus_defconfig
sh                        sh7763rdp_defconfig
sh                         ap325rxa_defconfig
nios2                            alldefconfig
riscv             nommu_k210_sdcard_defconfig
arm                          badge4_defconfig
sh                              ul2_defconfig
ia64                             allyesconfig
mips                     loongson1b_defconfig
arc                         haps_hs_defconfig
arm                         s3c6400_defconfig
arm                           stm32_defconfig
xtensa                  nommu_kc705_defconfig
mips                  maltasmvp_eva_defconfig
arm                          pxa3xx_defconfig
arm                           imxrt_defconfig
sh                           se7780_defconfig
parisc64                            defconfig
sh                      rts7751r2d1_defconfig
ia64                      gensparse_defconfig
powerpc                      cm5200_defconfig
h8300                    h8300h-sim_defconfig
riscv                               defconfig
arm                        realview_defconfig
mips                       capcella_defconfig
sh                   sh7724_generic_defconfig
sh                          r7780mp_defconfig
powerpc                      chrp32_defconfig
sh                         ecovec24_defconfig
riscv                            allyesconfig
sh                           se7722_defconfig
arm                            xcep_defconfig
sh                           se7619_defconfig
arm                           corgi_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                    maltaup_xpa_defconfig
m68k                       m5475evb_defconfig
powerpc                 canyonlands_defconfig
xtensa                  audio_kc705_defconfig
arm                            mps2_defconfig
mips                 decstation_r4k_defconfig
openrisc                         alldefconfig
sh                         apsh4a3a_defconfig
sh                          sdk7780_defconfig
arm                        spear6xx_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220422
arm                  randconfig-c002-20220424
ia64                             allmodconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
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
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220422
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
riscv                randconfig-c006-20220424
mips                 randconfig-c004-20220424
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220424
powerpc              randconfig-c003-20220424
s390                 randconfig-c005-20220424
arm                     davinci_all_defconfig
powerpc                      acadia_defconfig
mips                           ip27_defconfig
mips                  cavium_octeon_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      ppc64e_defconfig
powerpc                      pmac32_defconfig
powerpc                    mvme5100_defconfig
powerpc                       ebony_defconfig
riscv                            alldefconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     ksi8560_defconfig
arm64                            allyesconfig
arm                            dove_defconfig
hexagon                          alldefconfig
powerpc                 xes_mpc85xx_defconfig
mips                          malta_defconfig
arm                   milbeaut_m10v_defconfig
arm                         hackkit_defconfig
mips                       rbtx49xx_defconfig
arm                              alldefconfig
arm                       versatile_defconfig
powerpc                    gamecube_defconfig
x86_64                           allyesconfig
mips                   sb1250_swarm_defconfig
hexagon                             defconfig
powerpc                  mpc885_ads_defconfig
riscv                    nommu_virt_defconfig
mips                       lemote2f_defconfig
arm                           spitz_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                         socfpga_defconfig
arm                       mainstone_defconfig
arm                          moxart_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220422
riscv                randconfig-r042-20220422
hexagon              randconfig-r045-20220422
hexagon              randconfig-r041-20220424
riscv                randconfig-r042-20220424
hexagon              randconfig-r045-20220424
s390                 randconfig-r044-20220422

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
