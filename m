Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611FAC43381
	for <linux-serial@archiver.kernel.org>; Sat, 16 Jan 2021 04:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3903D23A9C
	for <linux-serial@archiver.kernel.org>; Sat, 16 Jan 2021 04:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbhAPEdl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Jan 2021 23:33:41 -0500
Received: from mga11.intel.com ([192.55.52.93]:8630 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729816AbhAPEdk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Jan 2021 23:33:40 -0500
IronPort-SDR: az18lJkacvqKz4/pgCTd4qP4p3Ayd0i1nK4fYbaKd6oFfw9d0gL5SFDB5vu1at+u3NWQKnzC3p
 lQfaClFDQt8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="175137220"
X-IronPort-AV: E=Sophos;i="5.79,351,1602572400"; 
   d="scan'208";a="175137220"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 20:32:59 -0800
IronPort-SDR: oMRqekTF3raRBGBmxZTBS0g1nAy/L+45Gti/mXAmmK465+jEND+26eBNt4uPZg3KwQYZlN4Fyf
 uCZBgsTlE3eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,351,1602572400"; 
   d="scan'208";a="354567661"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jan 2021 20:32:58 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0dGj-0000iH-MO; Sat, 16 Jan 2021 04:32:57 +0000
Date:   Sat, 16 Jan 2021 12:32:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 429b29aef7f841086949c7359f9c3ccb051e7ea3
Message-ID: <60026c56.W3f/bvZ95rZU7MDF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 429b29aef7f841086949c7359f9c3ccb051e7ea3  tty: serial: Drop unused efm32 serial driver

elapsed time: 726m

configs tested: 158
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                        edosk7760_defconfig
powerpc                   lite5200b_defconfig
mips                     loongson1c_defconfig
powerpc                     tqm8560_defconfig
arm                           viper_defconfig
xtensa                  cadence_csp_defconfig
mips                  cavium_octeon_defconfig
powerpc                      ppc6xx_defconfig
c6x                              alldefconfig
arc                        nsimosci_defconfig
mips                         rt305x_defconfig
sh                      rts7751r2d1_defconfig
powerpc                 mpc8272_ads_defconfig
arm                           h3600_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                       mainstone_defconfig
sh                        apsh4ad0a_defconfig
arm                        magician_defconfig
arm                         assabet_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     tqm8548_defconfig
arm                  colibri_pxa300_defconfig
xtensa                    xip_kc705_defconfig
arm                             rpc_defconfig
sparc64                             defconfig
powerpc                      ppc44x_defconfig
sh                          r7785rp_defconfig
arm                          pcm027_defconfig
sparc64                          alldefconfig
arm                            mps2_defconfig
openrisc                    or1ksim_defconfig
nios2                            alldefconfig
sh                          rsk7264_defconfig
c6x                                 defconfig
sh                               j2_defconfig
mips                          ath25_defconfig
sh                   rts7751r2dplus_defconfig
mips                  maltasmvp_eva_defconfig
powerpc               mpc834x_itxgp_defconfig
um                             i386_defconfig
mips                     cu1830-neo_defconfig
sh                   sh7724_generic_defconfig
mips                         mpc30x_defconfig
arm                          exynos_defconfig
mips                            gpr_defconfig
m68k                         apollo_defconfig
m68k                        m5407c3_defconfig
arm                            pleb_defconfig
m68k                        mvme147_defconfig
arm                         bcm2835_defconfig
sh                             sh03_defconfig
powerpc                     tqm8555_defconfig
mips                           ip32_defconfig
powerpc                       maple_defconfig
sh                ecovec24-romimage_defconfig
sparc                       sparc64_defconfig
sh                        dreamcast_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                       cns3420vb_defconfig
powerpc                       eiger_defconfig
powerpc                 mpc834x_itx_defconfig
arc                              allyesconfig
powerpc                      katmai_defconfig
m68k                        m5272c3_defconfig
sh                           se7206_defconfig
powerpc                 mpc8560_ads_defconfig
m68k                             allmodconfig
c6x                         dsk6455_defconfig
arm                      tct_hammer_defconfig
sh                         apsh4a3a_defconfig
arc                        nsim_700_defconfig
arm                        mini2440_defconfig
sh                           se7780_defconfig
arm                         hackkit_defconfig
sh                          urquell_defconfig
powerpc                     redwood_defconfig
mips                      malta_kvm_defconfig
m68k                          atari_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
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
powerpc                           allnoconfig
x86_64               randconfig-a004-20210115
x86_64               randconfig-a006-20210115
x86_64               randconfig-a001-20210115
x86_64               randconfig-a003-20210115
x86_64               randconfig-a005-20210115
x86_64               randconfig-a002-20210115
i386                 randconfig-a002-20210115
i386                 randconfig-a005-20210115
i386                 randconfig-a006-20210115
i386                 randconfig-a001-20210115
i386                 randconfig-a003-20210115
i386                 randconfig-a004-20210115
i386                 randconfig-a012-20210115
i386                 randconfig-a011-20210115
i386                 randconfig-a016-20210115
i386                 randconfig-a015-20210115
i386                 randconfig-a013-20210115
i386                 randconfig-a014-20210115
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
x86_64               randconfig-a015-20210115
x86_64               randconfig-a012-20210115
x86_64               randconfig-a013-20210115
x86_64               randconfig-a016-20210115
x86_64               randconfig-a014-20210115
x86_64               randconfig-a011-20210115
x86_64               randconfig-a006-20210116
x86_64               randconfig-a004-20210116
x86_64               randconfig-a001-20210116
x86_64               randconfig-a005-20210116
x86_64               randconfig-a003-20210116
x86_64               randconfig-a002-20210116

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
