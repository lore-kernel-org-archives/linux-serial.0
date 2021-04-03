Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3272C433ED
	for <linux-serial@archiver.kernel.org>; Sat,  3 Apr 2021 02:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67078611C0
	for <linux-serial@archiver.kernel.org>; Sat,  3 Apr 2021 02:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbhDCCr5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 2 Apr 2021 22:47:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:18559 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231256AbhDCCr5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Apr 2021 22:47:57 -0400
IronPort-SDR: aRfEKm7Ogr1ArQNQrel6bvzAe5+50Ocp1H1yMTJTR5g+GqRNXI1hoNbFf2cVIN8ZtrZ7N8n6DG
 dvLYix/WCk7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="189311897"
X-IronPort-AV: E=Sophos;i="5.81,301,1610438400"; 
   d="scan'208";a="189311897"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 19:47:55 -0700
IronPort-SDR: 8H5b+yKJhWLclykCizTKyyH2WzfXs5KhpcJXkrzntcm2r0i/oCFSgNKO39bARO/B0cbOoD9DXk
 B4MRSWDTBsnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,301,1610438400"; 
   d="scan'208";a="378287089"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Apr 2021 19:47:53 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lSWKH-0007Tr-8L; Sat, 03 Apr 2021 02:47:53 +0000
Date:   Sat, 03 Apr 2021 10:47:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 202680c7a93713283207dedfbc4b550ad6836a43
Message-ID: <6067d749.+67HSM30MlZFcKJP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 202680c7a93713283207dedfbc4b550ad6836a43  tty: pty: Add a blank line after declarations

elapsed time: 721m

configs tested: 168
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
powerpc                     powernv_defconfig
mips                      malta_kvm_defconfig
m68k                        mvme16x_defconfig
powerpc                      ppc40x_defconfig
mips                         tb0226_defconfig
arm                             rpc_defconfig
xtensa                       common_defconfig
powerpc                     ksi8560_defconfig
arm                          lpd270_defconfig
arm                       aspeed_g4_defconfig
riscv                    nommu_k210_defconfig
m68k                          amiga_defconfig
sh                            titan_defconfig
arm                        trizeps4_defconfig
mips                          rm200_defconfig
parisc                generic-64bit_defconfig
powerpc                     mpc83xx_defconfig
ia64                      gensparse_defconfig
mips                      fuloong2e_defconfig
powerpc                     sequoia_defconfig
arm                          ixp4xx_defconfig
arm                          pxa910_defconfig
m68k                         amcore_defconfig
m68k                       bvme6000_defconfig
arm                       spear13xx_defconfig
powerpc                     ppa8548_defconfig
ia64                             allmodconfig
arm                             pxa_defconfig
mips                        workpad_defconfig
nios2                         10m50_defconfig
arm                          iop32x_defconfig
ia64                             alldefconfig
s390                       zfcpdump_defconfig
ia64                          tiger_defconfig
powerpc                  storcenter_defconfig
arm                         s5pv210_defconfig
arm                          ep93xx_defconfig
parisc                              defconfig
arc                 nsimosci_hs_smp_defconfig
mips                malta_qemu_32r6_defconfig
arm                           stm32_defconfig
mips                          rb532_defconfig
powerpc                 mpc8540_ads_defconfig
arm                        shmobile_defconfig
m68k                         apollo_defconfig
xtensa                          iss_defconfig
sh                          rsk7201_defconfig
powerpc                    amigaone_defconfig
sh                           se7724_defconfig
powerpc                         wii_defconfig
arm                           h5000_defconfig
arm                       multi_v4t_defconfig
sh                        sh7785lcr_defconfig
mips                  cavium_octeon_defconfig
mips                     loongson1c_defconfig
arm                         palmz72_defconfig
sh                     sh7710voipgw_defconfig
mips                        vocore2_defconfig
s390                                defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      tqm8xx_defconfig
sh                 kfr2r09-romimage_defconfig
sparc64                             defconfig
powerpc                 mpc834x_mds_defconfig
mips                           gcw0_defconfig
mips                        omega2p_defconfig
arm                          pxa168_defconfig
sh                           se7780_defconfig
sh                           se7750_defconfig
powerpc                    ge_imp3a_defconfig
arc                        vdk_hs38_defconfig
parisc                generic-32bit_defconfig
powerpc                           allnoconfig
arm                    vt8500_v6_v7_defconfig
xtensa                         virt_defconfig
arc                        nsim_700_defconfig
xtensa                              defconfig
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
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20210402
x86_64               randconfig-a005-20210402
x86_64               randconfig-a003-20210402
x86_64               randconfig-a001-20210402
x86_64               randconfig-a002-20210402
x86_64               randconfig-a006-20210402
i386                 randconfig-a006-20210402
i386                 randconfig-a003-20210402
i386                 randconfig-a001-20210402
i386                 randconfig-a004-20210402
i386                 randconfig-a005-20210402
i386                 randconfig-a002-20210402
i386                 randconfig-a006-20210401
i386                 randconfig-a003-20210401
i386                 randconfig-a001-20210401
i386                 randconfig-a004-20210401
i386                 randconfig-a002-20210401
i386                 randconfig-a005-20210401
i386                 randconfig-a014-20210402
i386                 randconfig-a016-20210402
i386                 randconfig-a011-20210402
i386                 randconfig-a012-20210402
i386                 randconfig-a013-20210402
i386                 randconfig-a015-20210402
i386                 randconfig-a014-20210401
i386                 randconfig-a011-20210401
i386                 randconfig-a016-20210401
i386                 randconfig-a012-20210401
i386                 randconfig-a013-20210401
i386                 randconfig-a015-20210401
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210401
x86_64               randconfig-a005-20210401
x86_64               randconfig-a003-20210401
x86_64               randconfig-a001-20210401
x86_64               randconfig-a002-20210401
x86_64               randconfig-a006-20210401
x86_64               randconfig-a014-20210402
x86_64               randconfig-a015-20210402
x86_64               randconfig-a011-20210402
x86_64               randconfig-a013-20210402
x86_64               randconfig-a012-20210402
x86_64               randconfig-a016-20210402

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
