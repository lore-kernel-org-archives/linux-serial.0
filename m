Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523E2C433ED
	for <linux-serial@archiver.kernel.org>; Mon,  5 Apr 2021 22:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15712613DB
	for <linux-serial@archiver.kernel.org>; Mon,  5 Apr 2021 22:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhDEWTz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 5 Apr 2021 18:19:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:54124 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241409AbhDEWTy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Apr 2021 18:19:54 -0400
IronPort-SDR: yeKq/L4JtQjLeF4rFxIPgjRXpwrLGCgAMB52oKizIHkrSJusiQ4yUGCKW2vYtFPMEJkdVZ2mY7
 nEnct4PwOErA==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="278183510"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="278183510"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 15:19:47 -0700
IronPort-SDR: kGHV9VT2Zcanw+uhkOmVSqSNzjdhS6Snjyofb9hJAQ3Mg8XG3hJUWpC0tiw+CfCg082e9n1F4s
 Qbg4NTPcQPRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="457582697"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2021 15:19:46 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lTXZR-000Aos-Kg; Mon, 05 Apr 2021 22:19:45 +0000
Date:   Tue, 06 Apr 2021 06:19:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 158e800e0fde91014812f5cdfb92ce812e3a33b4
Message-ID: <606b8ce0.+d61p71Eqa7YkqVM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 158e800e0fde91014812f5cdfb92ce812e3a33b4  sc16is7xx: Defer probe if device read fails

elapsed time: 721m

configs tested: 203
configs skipped: 3

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
riscv                            allyesconfig
i386                             allyesconfig
mips                        workpad_defconfig
xtensa                generic_kc705_defconfig
sh                         microdev_defconfig
arm                            mmp2_defconfig
sparc64                             defconfig
sh                           se7343_defconfig
arm                         cm_x300_defconfig
powerpc                      chrp32_defconfig
arm                           sama5_defconfig
powerpc                          g5_defconfig
m68k                         amcore_defconfig
powerpc                   motionpro_defconfig
arm                         hackkit_defconfig
mips                      pic32mzda_defconfig
arm                     am200epdkit_defconfig
microblaze                      mmu_defconfig
powerpc                     akebono_defconfig
powerpc                    ge_imp3a_defconfig
arm                       mainstone_defconfig
mips                         mpc30x_defconfig
powerpc                      mgcoge_defconfig
arm                             rpc_defconfig
arm                           spitz_defconfig
arm                          imote2_defconfig
sh                           se7705_defconfig
arm                     davinci_all_defconfig
sh                           se7751_defconfig
sh                           sh2007_defconfig
powerpc                     tqm8540_defconfig
riscv                          rv32_defconfig
mips                         tb0219_defconfig
mips                           mtx1_defconfig
arm                         s5pv210_defconfig
ia64                             allyesconfig
mips                           gcw0_defconfig
sh                         ap325rxa_defconfig
arm                         at91_dt_defconfig
mips                             allyesconfig
mips                           rs90_defconfig
powerpc                   lite5200b_defconfig
parisc                generic-64bit_defconfig
mips                          malta_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                      obs600_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                      cm5200_defconfig
arm                        realview_defconfig
m68k                          hp300_defconfig
arm                         lubbock_defconfig
powerpc                        cell_defconfig
mips                       lemote2f_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                        spear3xx_defconfig
xtensa                  audio_kc705_defconfig
arm                        magician_defconfig
powerpc                     kilauea_defconfig
mips                        nlm_xlp_defconfig
arc                                 defconfig
arm                        spear6xx_defconfig
sh                         apsh4a3a_defconfig
openrisc                            defconfig
sh                             shx3_defconfig
s390                             allyesconfig
openrisc                 simple_smp_defconfig
mips                 decstation_r4k_defconfig
m68k                        stmark2_defconfig
nios2                               defconfig
arm                      tct_hammer_defconfig
mips                      malta_kvm_defconfig
powerpc                     skiroot_defconfig
mips                           ci20_defconfig
sh                               allmodconfig
mips                  cavium_octeon_defconfig
arc                     haps_hs_smp_defconfig
m68k                         apollo_defconfig
sh                   sh7770_generic_defconfig
powerpc                 mpc837x_mds_defconfig
arm                      integrator_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                  iss476-smp_defconfig
arm                       imx_v4_v5_defconfig
mips                           ip28_defconfig
m68k                       m5249evb_defconfig
h8300                               defconfig
arm                      jornada720_defconfig
powerpc                      ep88xc_defconfig
arm                         palmz72_defconfig
alpha                            allyesconfig
arm                       cns3420vb_defconfig
um                             i386_defconfig
arm                            hisi_defconfig
arm                             pxa_defconfig
sh                        edosk7760_defconfig
powerpc                      ppc40x_defconfig
arm                          ixp4xx_defconfig
sh                           se7721_defconfig
powerpc                 mpc8313_rdb_defconfig
openrisc                         alldefconfig
arm                       aspeed_g5_defconfig
powerpc                     sbc8548_defconfig
mips                      loongson3_defconfig
i386                                defconfig
powerpc                    socrates_defconfig
arm                        cerfcube_defconfig
m68k                           sun3_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                          rsk7203_defconfig
sh                          landisk_defconfig
mips                       rbtx49xx_defconfig
mips                      maltasmvp_defconfig
xtensa                  nommu_kc705_defconfig
arm                       omap2plus_defconfig
mips                     loongson1c_defconfig
alpha                               defconfig
riscv                    nommu_k210_defconfig
mips                        qi_lb60_defconfig
powerpc                      pmac32_defconfig
m68k                             alldefconfig
sh                           se7712_defconfig
powerpc                        fsp2_defconfig
powerpc                       ppc64_defconfig
arm                       versatile_defconfig
arc                          axs101_defconfig
um                               alldefconfig
mips                            gpr_defconfig
sh                         ecovec24_defconfig
arm                          simpad_defconfig
s390                       zfcpdump_defconfig
mips                           ip27_defconfig
mips                     cu1000-neo_defconfig
powerpc                     mpc83xx_defconfig
h8300                     edosk2674_defconfig
powerpc                    klondike_defconfig
mips                          rm200_defconfig
parisc                              defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210405
i386                 randconfig-a003-20210405
i386                 randconfig-a001-20210405
i386                 randconfig-a004-20210405
i386                 randconfig-a002-20210405
i386                 randconfig-a005-20210405
x86_64               randconfig-a014-20210405
x86_64               randconfig-a015-20210405
x86_64               randconfig-a013-20210405
x86_64               randconfig-a011-20210405
x86_64               randconfig-a012-20210405
x86_64               randconfig-a016-20210405
i386                 randconfig-a014-20210405
i386                 randconfig-a011-20210405
i386                 randconfig-a016-20210405
i386                 randconfig-a012-20210405
i386                 randconfig-a015-20210405
i386                 randconfig-a013-20210405
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
x86_64               randconfig-a004-20210405
x86_64               randconfig-a003-20210405
x86_64               randconfig-a005-20210405
x86_64               randconfig-a001-20210405
x86_64               randconfig-a002-20210405
x86_64               randconfig-a006-20210405

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
