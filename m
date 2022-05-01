Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F6DC433F5
	for <linux-serial@archiver.kernel.org>; Sun,  1 May 2022 02:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiEACOY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 30 Apr 2022 22:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiEACOY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 30 Apr 2022 22:14:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B802332983
        for <linux-serial@vger.kernel.org>; Sat, 30 Apr 2022 19:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651371060; x=1682907060;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=w+6t4L5eFw8ZfD1RFdpc+EjaBe/DY/7IIbyVHE/HPt4=;
  b=BqRV8XiyMBck6Cx93dMik0EUACoQSnZfVBeyaCewcUhRih0hGE1bCLqN
   My2m9hooPDz0PrIY53PUKrZS578JjX7xDUDHSajiKSBjlPuBgjc690uaL
   MJm17dDOSSXPyTZmhXjIxrUdaW690SXHySmt2D3FxzGGxic2OTbsS7rkn
   eYFwoOXTKra0Ft7C7mCC1cheQJNewgaxFdnXQcrZqDqWHn7nE0DkTzJVO
   SuecDCYO/A1ckT4Dp8BKmKNWkNCIU4BsEqOvgpFrzPC95jT7nZ9L9p2iy
   dFysF4oGs/s2ieBWQygdV2dSLD7xJObKiiNWAFe5yxxJMvqZ9dovdLVjn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="267108753"
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="267108753"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 19:11:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="630614656"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 Apr 2022 19:10:58 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkz34-0008GP-5G;
        Sun, 01 May 2022 02:10:58 +0000
Date:   Sun, 01 May 2022 10:10:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 19317433057dc1f2ca9a975e4e6b547282c2a5ef
Message-ID: <626dec00.O28czLNT3kDTd0qy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 19317433057dc1f2ca9a975e4e6b547282c2a5ef  tty: n_gsm: fix sometimes uninitialized warning in gsm_dlci_modem_output()

elapsed time: 6910m

configs tested: 221
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                           allyesconfig
i386                             allyesconfig
ia64                             allmodconfig
ia64                             allyesconfig
i386                          randconfig-c001
mips                             allyesconfig
um                           x86_64_defconfig
riscv                            allmodconfig
um                             i386_defconfig
mips                             allmodconfig
riscv                            allyesconfig
powerpc                          allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
s390                             allmodconfig
powerpc                          allyesconfig
s390                             allyesconfig
i386                 randconfig-c001-20220425
sparc                            allyesconfig
parisc                           allyesconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                              allyesconfig
sh                           se7750_defconfig
powerpc                      pcm030_defconfig
xtensa                          iss_defconfig
mips                          rb532_defconfig
mips                         tb0226_defconfig
powerpc                     tqm8541_defconfig
sh                        sh7763rdp_defconfig
mips                           ci20_defconfig
powerpc                  iss476-smp_defconfig
arc                        nsimosci_defconfig
powerpc                      arches_defconfig
powerpc                 linkstation_defconfig
sh                     sh7710voipgw_defconfig
sh                        edosk7705_defconfig
mips                           ip32_defconfig
arm                          lpd270_defconfig
ia64                      gensparse_defconfig
powerpc                 mpc837x_rdb_defconfig
m68k                       bvme6000_defconfig
sh                           se7619_defconfig
mips                  maltasmvp_eva_defconfig
sh                   secureedge5410_defconfig
sh                            shmin_defconfig
sh                          r7780mp_defconfig
h8300                     edosk2674_defconfig
arm                      footbridge_defconfig
arc                     haps_hs_smp_defconfig
parisc                           alldefconfig
sh                         microdev_defconfig
powerpc                     taishan_defconfig
sparc                       sparc64_defconfig
arm                         lpc18xx_defconfig
riscv             nommu_k210_sdcard_defconfig
microblaze                      mmu_defconfig
m68k                       m5208evb_defconfig
arc                              alldefconfig
powerpc                   currituck_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                       common_defconfig
xtensa                         virt_defconfig
powerpc                      mgcoge_defconfig
powerpc                   motionpro_defconfig
m68k                       m5475evb_defconfig
mips                         db1xxx_defconfig
m68k                          multi_defconfig
arm                          exynos_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        cerfcube_defconfig
ia64                             alldefconfig
parisc                              defconfig
mips                         cobalt_defconfig
sh                          lboxre2_defconfig
arm                         nhk8815_defconfig
h8300                       h8s-sim_defconfig
m68k                        mvme147_defconfig
sh                             sh03_defconfig
sparc64                          alldefconfig
sh                   rts7751r2dplus_defconfig
sparc                               defconfig
arm                     eseries_pxa_defconfig
arm                           imxrt_defconfig
mips                    maltaup_xpa_defconfig
openrisc                    or1ksim_defconfig
arm                      integrator_defconfig
sh                          landisk_defconfig
powerpc                      ppc6xx_defconfig
i386                                defconfig
powerpc                     tqm8555_defconfig
powerpc                    klondike_defconfig
sh                           se7206_defconfig
parisc64                            defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220428
x86_64               randconfig-c001-20220425
arm                  randconfig-c002-20220425
arm                  randconfig-c002-20220427
arm                  randconfig-c002-20220426
ia64                                defconfig
m68k                                defconfig
nios2                               defconfig
csky                                defconfig
alpha                               defconfig
arc                                 defconfig
s390                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                           allnoconfig
x86_64               randconfig-a015-20220425
x86_64               randconfig-a014-20220425
x86_64               randconfig-a011-20220425
x86_64               randconfig-a013-20220425
x86_64               randconfig-a012-20220425
x86_64               randconfig-a016-20220425
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                 randconfig-a011-20220425
i386                 randconfig-a014-20220425
i386                 randconfig-a015-20220425
i386                 randconfig-a012-20220425
i386                 randconfig-a013-20220425
i386                 randconfig-a016-20220425
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                  randconfig-r043-20220425
s390                 randconfig-r044-20220425
riscv                randconfig-r042-20220425
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
powerpc              randconfig-c003-20220425
i386                 randconfig-c001-20220425
arm                  randconfig-c002-20220425
mips                 randconfig-c004-20220425
x86_64               randconfig-c007-20220425
s390                 randconfig-c005-20220425
riscv                randconfig-c006-20220425
riscv                randconfig-c006-20220428
mips                 randconfig-c004-20220428
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220428
powerpc              randconfig-c003-20220428
s390                 randconfig-c005-20220428
riscv                randconfig-c006-20220427
mips                 randconfig-c004-20220427
arm                  randconfig-c002-20220427
powerpc              randconfig-c003-20220427
riscv                randconfig-c006-20220429
mips                 randconfig-c004-20220429
arm                  randconfig-c002-20220429
powerpc              randconfig-c003-20220429
arm                       spear13xx_defconfig
mips                   sb1250_swarm_defconfig
arm                         shannon_defconfig
powerpc                     kmeter1_defconfig
mips                          malta_defconfig
arm                          moxart_defconfig
arm64                            allyesconfig
powerpc                     tqm8540_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                     cu1830-neo_defconfig
powerpc                  mpc885_ads_defconfig
arm                       cns3420vb_defconfig
powerpc                    socrates_defconfig
arm                         bcm2835_defconfig
arm                       netwinder_defconfig
mips                          ath25_defconfig
arm                       mainstone_defconfig
powerpc                     skiroot_defconfig
mips                     loongson1c_defconfig
i386                             allyesconfig
arm                         hackkit_defconfig
mips                           mtx1_defconfig
arm                          pxa168_defconfig
mips                         tb0287_defconfig
powerpc                        fsp2_defconfig
arm                      pxa255-idp_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a003-20220425
i386                 randconfig-a002-20220425
i386                 randconfig-a001-20220425
i386                 randconfig-a005-20220425
i386                 randconfig-a006-20220425
i386                 randconfig-a004-20220425
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a003-20220425
x86_64               randconfig-a002-20220425
x86_64               randconfig-a004-20220425
x86_64               randconfig-a001-20220425
x86_64               randconfig-a005-20220425
x86_64               randconfig-a006-20220425
hexagon              randconfig-r041-20220425
hexagon              randconfig-r045-20220425
hexagon              randconfig-r041-20220428
riscv                randconfig-r042-20220428
hexagon              randconfig-r045-20220428

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
