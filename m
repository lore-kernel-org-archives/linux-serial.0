Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6BEC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 22 Oct 2021 03:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C6BC61004
	for <linux-serial@archiver.kernel.org>; Fri, 22 Oct 2021 03:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhJVD7T (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Oct 2021 23:59:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:29129 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230393AbhJVD7S (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Oct 2021 23:59:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="227984508"
X-IronPort-AV: E=Sophos;i="5.87,171,1631602800"; 
   d="scan'208";a="227984508"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 20:56:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,171,1631602800"; 
   d="scan'208";a="445110050"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 20:56:47 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mdlfi-000F4J-Sd; Fri, 22 Oct 2021 03:56:46 +0000
Date:   Fri, 22 Oct 2021 11:56:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 7c0408d805797178f075f33d0f705a1c6ef76c82
Message-ID: <6172367c.fe8Vff26LgIcm2o7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 7c0408d805797178f075f33d0f705a1c6ef76c82  tty: add rpmsg driver

elapsed time: 1018m

configs tested: 143
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211021
m68k                         apollo_defconfig
arm                            mmp2_defconfig
arm                         vf610m4_defconfig
powerpc                    gamecube_defconfig
h8300                            alldefconfig
powerpc                  mpc866_ads_defconfig
powerpc                     ep8248e_defconfig
mips                            gpr_defconfig
powerpc                      makalu_defconfig
arm                        trizeps4_defconfig
arm                  colibri_pxa300_defconfig
powerpc                   bluestone_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     sequoia_defconfig
arm                        magician_defconfig
xtensa                  cadence_csp_defconfig
powerpc                        warp_defconfig
powerpc                 mpc834x_mds_defconfig
sh                        sh7757lcr_defconfig
arm                      jornada720_defconfig
mips                        omega2p_defconfig
mips                         mpc30x_defconfig
um                                  defconfig
arm                         orion5x_defconfig
powerpc                     akebono_defconfig
powerpc                      chrp32_defconfig
powerpc                      ppc64e_defconfig
arm                         s3c2410_defconfig
arm                       multi_v4t_defconfig
parisc                              defconfig
m68k                          atari_defconfig
mips                        qi_lb60_defconfig
m68k                                defconfig
powerpc                      obs600_defconfig
mips                malta_qemu_32r6_defconfig
openrisc                            defconfig
mips                           ip32_defconfig
arm                        neponset_defconfig
sh                        edosk7705_defconfig
arm                             pxa_defconfig
arm                      footbridge_defconfig
sh                     magicpanelr2_defconfig
nios2                               defconfig
mips                       capcella_defconfig
arm                         s5pv210_defconfig
sh                          rsk7201_defconfig
m68k                            q40_defconfig
parisc                           alldefconfig
arm                           u8500_defconfig
riscv                    nommu_virt_defconfig
powerpc                      tqm8xx_defconfig
sh                         ap325rxa_defconfig
powerpc                          allyesconfig
arm                            mps2_defconfig
arm                          moxart_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7751_defconfig
mips                          rb532_defconfig
openrisc                 simple_smp_defconfig
arm                  randconfig-c002-20211022
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a013-20211021
x86_64               randconfig-a015-20211021
x86_64               randconfig-a011-20211021
x86_64               randconfig-a014-20211021
x86_64               randconfig-a016-20211021
x86_64               randconfig-a012-20211021
i386                 randconfig-a012-20211021
i386                 randconfig-a013-20211021
i386                 randconfig-a011-20211021
i386                 randconfig-a016-20211021
i386                 randconfig-a015-20211021
i386                 randconfig-a014-20211021
arc                  randconfig-r043-20211021
riscv                randconfig-r042-20211021
s390                 randconfig-r044-20211021
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
powerpc              randconfig-c003-20211021
riscv                randconfig-c006-20211021
arm                  randconfig-c002-20211021
x86_64               randconfig-c007-20211021
mips                 randconfig-c004-20211021
s390                 randconfig-c005-20211021
i386                 randconfig-c001-20211021
x86_64               randconfig-a002-20211021
x86_64               randconfig-a004-20211021
x86_64               randconfig-a005-20211021
x86_64               randconfig-a001-20211021
x86_64               randconfig-a006-20211021
x86_64               randconfig-a003-20211021
i386                 randconfig-a004-20211021
i386                 randconfig-a003-20211021
i386                 randconfig-a002-20211021
i386                 randconfig-a005-20211021
i386                 randconfig-a001-20211021
i386                 randconfig-a006-20211021
hexagon              randconfig-r045-20211021
hexagon              randconfig-r041-20211021

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
