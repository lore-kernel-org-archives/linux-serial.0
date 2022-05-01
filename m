Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DFEC433FE
	for <linux-serial@archiver.kernel.org>; Sun,  1 May 2022 03:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbiEADua (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 30 Apr 2022 23:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiEADu3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 30 Apr 2022 23:50:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867314ECDF
        for <linux-serial@vger.kernel.org>; Sat, 30 Apr 2022 20:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651376825; x=1682912825;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8pjeLqEY5oMDBaFaMmEBFKnHizfIXK3YoXyO9r7bVaw=;
  b=WFVDWqIcfOcVv9AvnXl9kns7spjSTPId8v/cVq0i9Hg9t+VEj9w+B8nP
   vBr29ICIJoVF1UuWMbp/TpN0FnV1ygF2lZwzyRqj6FDk6ab2+dEvY9At/
   a013bNoZF73Dk/gWpuyODMtNQUYeyo4CHMKWDsATG/0vOFq9babFISTwL
   myYaR1pa6SfcbCfP/dHqZgpDYXrT3sSPuutWdsqO5BUej6+6RE9msTycu
   benRvfljp2DPHSGJuq8yuYBRyM1JBdNboHNSuvAX0bx10eOt0PrjG6O5Y
   uhGOUE3zZFat5JlRgUgEVBPr4W3JhjBH0YcN852kH2i50rpQzZJ/ETj7i
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="327478347"
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="327478347"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 20:47:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="809682606"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 Apr 2022 20:47:03 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nl0Y2-0008NO-E8;
        Sun, 01 May 2022 03:47:02 +0000
Date:   Sun, 01 May 2022 11:46:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 1e70d57e7285996bcf0a226eac8c5ba43a89f85d
Message-ID: <626e02a1.4SmEQvyAiYwchuYS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 1e70d57e7285996bcf0a226eac8c5ba43a89f85d  ACPI / property: Document RS485 _DSD properties

elapsed time: 6606m

configs tested: 266
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
i386                 randconfig-c001-20220425
arc                        nsim_700_defconfig
powerpc                     tqm8541_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                          lboxre2_defconfig
sh                           se7750_defconfig
powerpc                      pcm030_defconfig
xtensa                          iss_defconfig
m68k                         amcore_defconfig
sh                           se7206_defconfig
ia64                          tiger_defconfig
mips                         cobalt_defconfig
sh                        sh7763rdp_defconfig
mips                           ci20_defconfig
arm                         lubbock_defconfig
m68k                                defconfig
sh                          sdk7780_defconfig
powerpc                     tqm8555_defconfig
arc                        nsimosci_defconfig
powerpc                      arches_defconfig
powerpc                 linkstation_defconfig
sh                     sh7710voipgw_defconfig
sh                        edosk7705_defconfig
powerpc                      ppc6xx_defconfig
arm                       multi_v4t_defconfig
arm                      jornada720_defconfig
powerpc                    adder875_defconfig
sh                           se7619_defconfig
mips                  maltasmvp_eva_defconfig
sh                   secureedge5410_defconfig
sh                            shmin_defconfig
sh                          r7780mp_defconfig
parisc                generic-32bit_defconfig
sh                     magicpanelr2_defconfig
nios2                               defconfig
arc                     haps_hs_smp_defconfig
parisc                           alldefconfig
sh                         microdev_defconfig
powerpc                        cell_defconfig
parisc                generic-64bit_defconfig
arm                         cm_x300_defconfig
m68k                       m5208evb_defconfig
arc                              alldefconfig
sparc                       sparc64_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                       common_defconfig
sh                             sh03_defconfig
arm                       imx_v6_v7_defconfig
ia64                      gensparse_defconfig
m68k                            mac_defconfig
i386                             alldefconfig
arm                        clps711x_defconfig
powerpc                       holly_defconfig
mips                            gpr_defconfig
arm                            lart_defconfig
powerpc                         ps3_defconfig
sh                          r7785rp_defconfig
powerpc                 mpc8540_ads_defconfig
alpha                               defconfig
m68k                           sun3_defconfig
xtensa                         virt_defconfig
powerpc                      mgcoge_defconfig
powerpc                   motionpro_defconfig
m68k                       m5475evb_defconfig
m68k                       bvme6000_defconfig
arc                            hsdk_defconfig
arm                            qcom_defconfig
mips                            ar7_defconfig
arm                          lpd270_defconfig
openrisc                  or1klitex_defconfig
ia64                            zx1_defconfig
arm                        cerfcube_defconfig
arm                      integrator_defconfig
um                               alldefconfig
m68k                          sun3x_defconfig
sh                          rsk7201_defconfig
arm                        oxnas_v6_defconfig
m68k                          multi_defconfig
mips                     loongson1b_defconfig
sh                         ecovec24_defconfig
arm                           sunxi_defconfig
sh                           se7751_defconfig
ia64                             alldefconfig
parisc                              defconfig
arm                         nhk8815_defconfig
mips                       capcella_defconfig
h8300                     edosk2674_defconfig
xtensa                           alldefconfig
sh                   sh7724_generic_defconfig
arc                 nsimosci_hs_smp_defconfig
sparc                       sparc32_defconfig
xtensa                  audio_kc705_defconfig
sparc64                          alldefconfig
sh                        edosk7760_defconfig
arm                       aspeed_g5_defconfig
sh                      rts7751r2d1_defconfig
powerpc                    amigaone_defconfig
sh                           se7721_defconfig
powerpc                           allnoconfig
powerpc                      cm5200_defconfig
sh                          landisk_defconfig
i386                                defconfig
mips                           jazz_defconfig
powerpc                      makalu_defconfig
powerpc                      chrp32_defconfig
arm                         lpc18xx_defconfig
arm                      footbridge_defconfig
arm                        mini2440_defconfig
sparc                               defconfig
sh                   rts7751r2dplus_defconfig
parisc64                            defconfig
sh                ecovec24-romimage_defconfig
sh                          kfr2r09_defconfig
openrisc                    or1ksim_defconfig
powerpc                    sam440ep_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220428
arm                  randconfig-c002-20220427
arm                  randconfig-c002-20220429
arm                  randconfig-c002-20220426
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64               randconfig-a012-20220425
x86_64               randconfig-a011-20220425
x86_64               randconfig-a014-20220425
x86_64               randconfig-a013-20220425
x86_64               randconfig-a015-20220425
i386                          randconfig-a012
i386                          randconfig-a016
i386                 randconfig-a016-20220425
i386                 randconfig-a015-20220425
i386                          randconfig-a014
x86_64                        randconfig-a006
x86_64                        randconfig-a004
arc                  randconfig-r043-20220425
riscv                randconfig-r042-20220425
s390                 randconfig-r044-20220425
arc                  randconfig-r043-20220428
arc                  randconfig-r043-20220429
s390                 randconfig-r044-20220429
riscv                randconfig-r042-20220429
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
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
riscv                randconfig-c006-20220428
mips                 randconfig-c004-20220428
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220428
powerpc              randconfig-c003-20220428
s390                 randconfig-c005-20220428
powerpc              randconfig-c003-20220501
riscv                randconfig-c006-20220501
mips                 randconfig-c004-20220501
arm                  randconfig-c002-20220501
powerpc              randconfig-c003-20220425
riscv                randconfig-c006-20220429
mips                 randconfig-c004-20220429
arm                  randconfig-c002-20220429
powerpc              randconfig-c003-20220429
powerpc              randconfig-c003-20220427
mips                 randconfig-c004-20220427
arm                  randconfig-c002-20220427
riscv                randconfig-c006-20220427
s390                 randconfig-c005-20220427
arm                       spear13xx_defconfig
arm                         shannon_defconfig
mips                   sb1250_swarm_defconfig
arm                        vexpress_defconfig
arm                         palmz72_defconfig
arm                       cns3420vb_defconfig
powerpc                     tqm5200_defconfig
arm                           spitz_defconfig
mips                  cavium_octeon_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                     cu1830-neo_defconfig
powerpc                    mvme5100_defconfig
powerpc                      ppc44x_defconfig
arm                         s3c2410_defconfig
mips                     loongson2k_defconfig
powerpc                     tqm8540_defconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      walnut_defconfig
arm                              alldefconfig
mips                            e55_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                         tb0287_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    socrates_defconfig
arm                         bcm2835_defconfig
arm                       netwinder_defconfig
mips                          ath25_defconfig
i386                             allyesconfig
arm                         hackkit_defconfig
mips                           mtx1_defconfig
riscv                          rv32_defconfig
mips                     cu1000-neo_defconfig
arm                             mxs_defconfig
powerpc                 linkstation_defconfig
powerpc                        fsp2_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                 randconfig-a003-20220425
i386                 randconfig-a002-20220425
i386                 randconfig-a001-20220425
i386                 randconfig-a004-20220425
i386                 randconfig-a005-20220425
i386                 randconfig-a006-20220425
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220428
riscv                randconfig-r042-20220428
hexagon              randconfig-r045-20220428
hexagon              randconfig-r041-20220425
hexagon              randconfig-r045-20220425
s390                 randconfig-r044-20220428

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
