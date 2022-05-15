Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50713C433F5
	for <linux-serial@archiver.kernel.org>; Sun, 15 May 2022 01:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiEOBx7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 14 May 2022 21:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiEOBx6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 14 May 2022 21:53:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383C5A47F
        for <linux-serial@vger.kernel.org>; Sat, 14 May 2022 18:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652579637; x=1684115637;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=l1nxTqGP51iA3Qu815j5vXtRNs6CV0NdZ7lxs/+OlSU=;
  b=K6xdH3J2c/pFxKg/F/ydc41iOO3b4JsTwkrH0NzABcXIqP6rnbsB/8in
   RDP2YSwcAyBxIliZs9il6XDuGtyTa8tHAGoMyFSSb4iNdnksXY636GW0K
   WL+HtUcNfG6h00T0UlmA6sAlAKpeMWnWD6Ceg0c1txiGkMXg0IjWsv6D7
   lngjSHxs13Pmi9kSvyvBTtRFA4Pmo6QKV1vv29Ke0kBZTWv8TVNz6L6S4
   /cBQjmOnfaqgJLMP9rtdpAKMp7HGiv2QJxMm+ic7Ba6RT6hlKuA86Qs/T
   waulapwo6xsM5+oIG+hhMtEDCqetXFl6qLHIJfLO7BRpnHbvWaU4qaq4k
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10347"; a="270520605"
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="270520605"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 18:53:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="573514524"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 14 May 2022 18:53:53 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nq3SC-0001Cf-Tb;
        Sun, 15 May 2022 01:53:52 +0000
Date:   Sun, 15 May 2022 09:53:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 401fb66a355eb0f22096cf26864324f8e63c7d78
Message-ID: <62805d2e.qOYqmUposkg1nDvh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 401fb66a355eb0f22096cf26864324f8e63c7d78  fsl_lpuart: Don't enable interrupts too early

elapsed time: 13105m

configs tested: 347
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220507
powerpc                          allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
s390                             allmodconfig
s390                             allyesconfig
powerpc                          allyesconfig
parisc                           allyesconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arm                        clps711x_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                         tb0226_defconfig
xtensa                       common_defconfig
arm                      jornada720_defconfig
m68k                         apollo_defconfig
m68k                          atari_defconfig
sh                          sdk7786_defconfig
arm                           h3600_defconfig
powerpc                     rainier_defconfig
sh                ecovec24-romimage_defconfig
arm                           sunxi_defconfig
ia64                             alldefconfig
arm                          exynos_defconfig
h8300                    h8300h-sim_defconfig
arm                        multi_v7_defconfig
powerpc                      mgcoge_defconfig
xtensa                    smp_lx200_defconfig
ia64                      gensparse_defconfig
sparc64                             defconfig
m68k                       m5475evb_defconfig
arm                        shmobile_defconfig
m68k                        mvme16x_defconfig
m68k                       m5249evb_defconfig
arm                            pleb_defconfig
mips                          rb532_defconfig
riscv                               defconfig
powerpc                     sequoia_defconfig
arc                          axs103_defconfig
sh                             sh03_defconfig
sh                   sh7724_generic_defconfig
powerpc                      cm5200_defconfig
powerpc                       eiger_defconfig
h8300                            alldefconfig
sh                           se7343_defconfig
powerpc                      pasemi_defconfig
ia64                         bigsur_defconfig
powerpc                     redwood_defconfig
mips                  decstation_64_defconfig
h8300                       h8s-sim_defconfig
sh                          kfr2r09_defconfig
sh                           se7712_defconfig
sparc                       sparc32_defconfig
powerpc                     pq2fads_defconfig
arm                         axm55xx_defconfig
arm                        spear6xx_defconfig
x86_64                           alldefconfig
powerpc                     tqm8548_defconfig
m68k                       bvme6000_defconfig
m68k                       m5208evb_defconfig
xtensa                  audio_kc705_defconfig
arm                          pxa3xx_defconfig
sh                           se7705_defconfig
mips                       bmips_be_defconfig
sh                          landisk_defconfig
csky                                defconfig
xtensa                  nommu_kc705_defconfig
arm                      footbridge_defconfig
sh                           se7750_defconfig
arc                         haps_hs_defconfig
powerpc                    klondike_defconfig
mips                        vocore2_defconfig
mips                             allmodconfig
s390                       zfcpdump_defconfig
m68k                           sun3_defconfig
sh                            hp6xx_defconfig
powerpc                      ppc40x_defconfig
powerpc                    adder875_defconfig
arc                        nsim_700_defconfig
sh                         ecovec24_defconfig
sh                        dreamcast_defconfig
mips                 decstation_r4k_defconfig
powerpc64                        alldefconfig
arc                        nsimosci_defconfig
um                           x86_64_defconfig
powerpc                      tqm8xx_defconfig
mips                           jazz_defconfig
sh                     magicpanelr2_defconfig
powerpc                     tqm8555_defconfig
sh                         ap325rxa_defconfig
x86_64                              defconfig
mips                      loongson3_defconfig
sparc                            alldefconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                       ppc64_defconfig
arm                        mvebu_v7_defconfig
sh                          r7785rp_defconfig
xtensa                          iss_defconfig
sh                   rts7751r2dplus_defconfig
m68k                        m5307c3_defconfig
m68k                          hp300_defconfig
ia64                          tiger_defconfig
powerpc                     ep8248e_defconfig
sh                             espt_defconfig
arm                       multi_v4t_defconfig
arm                             ezx_defconfig
arm                        mini2440_defconfig
xtensa                              defconfig
arm                           sama5_defconfig
sh                         microdev_defconfig
sh                           se7724_defconfig
mips                           ci20_defconfig
sh                          r7780mp_defconfig
arc                     nsimosci_hs_defconfig
powerpc                     stx_gp3_defconfig
um                               alldefconfig
openrisc                    or1ksim_defconfig
arm                            xcep_defconfig
riscv                            allyesconfig
arm                           viper_defconfig
sparc                       sparc64_defconfig
sh                          polaris_defconfig
sh                        sh7763rdp_defconfig
powerpc                         wii_defconfig
microblaze                      mmu_defconfig
sparc                               defconfig
sh                                  defconfig
mips                         mpc30x_defconfig
arm                            zeus_defconfig
arm                     eseries_pxa_defconfig
powerpc                  storcenter_defconfig
arm                         lubbock_defconfig
parisc                generic-32bit_defconfig
alpha                               defconfig
mips                         bigsur_defconfig
arm                         nhk8815_defconfig
i386                                defconfig
sh                 kfr2r09-romimage_defconfig
mips                      fuloong2e_defconfig
powerpc                      ep88xc_defconfig
sh                          rsk7269_defconfig
alpha                            alldefconfig
sh                          rsk7203_defconfig
powerpc                       maple_defconfig
ia64                            zx1_defconfig
xtensa                           alldefconfig
ia64                        generic_defconfig
powerpc                   motionpro_defconfig
arm                      integrator_defconfig
nios2                         10m50_defconfig
arm                          gemini_defconfig
powerpc                      pcm030_defconfig
powerpc                       holly_defconfig
powerpc                      ppc6xx_defconfig
sh                           se7721_defconfig
alpha                            allyesconfig
arm                          lpd270_defconfig
arm                             pxa_defconfig
arm                        cerfcube_defconfig
sparc                            allyesconfig
arm                         vf610m4_defconfig
arc                           tb10x_defconfig
microblaze                          defconfig
mips                         db1xxx_defconfig
powerpc                   currituck_defconfig
mips                      maltasmvp_defconfig
m68k                          sun3x_defconfig
powerpc                      chrp32_defconfig
powerpc                     tqm8541_defconfig
nios2                            allyesconfig
sh                        apsh4ad0a_defconfig
sh                          lboxre2_defconfig
mips                           ip32_defconfig
arm                         lpc18xx_defconfig
arm                         s3c6400_defconfig
arm                           stm32_defconfig
arm                       aspeed_g5_defconfig
m68k                        stmark2_defconfig
xtensa                    xip_kc705_defconfig
powerpc                mpc7448_hpc2_defconfig
nios2                               defconfig
arm                         cm_x300_defconfig
m68k                        mvme147_defconfig
arm                             rpc_defconfig
nios2                            alldefconfig
arm                            lart_defconfig
arm                       imx_v6_v7_defconfig
openrisc                 simple_smp_defconfig
mips                        bcm47xx_defconfig
m68k                          multi_defconfig
arm                            hisi_defconfig
arc                    vdk_hs38_smp_defconfig
arc                              alldefconfig
m68k                         amcore_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                          amiga_defconfig
parisc                generic-64bit_defconfig
um                             i386_defconfig
arm                         at91_dt_defconfig
h8300                               defconfig
m68k                            mac_defconfig
sh                          sdk7780_defconfig
sh                               j2_defconfig
riscv                    nommu_k210_defconfig
powerpc                     asp8347_defconfig
mips                            ar7_defconfig
sh                          rsk7264_defconfig
arm                       omap2plus_defconfig
powerpc                      arches_defconfig
powerpc                    sam440ep_defconfig
sh                           se7722_defconfig
arm                          iop32x_defconfig
openrisc                            defconfig
powerpc                 mpc85xx_cds_defconfig
mips                  maltasmvp_eva_defconfig
arm                  randconfig-c002-20220505
x86_64                        randconfig-c001
arm                  randconfig-c002-20220506
arm                  randconfig-c002-20220507
arm                  randconfig-c002-20220508
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
arc                              allyesconfig
arc                                 defconfig
s390                                defconfig
parisc                              defconfig
parisc64                            defconfig
i386                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                           allnoconfig
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
riscv                randconfig-r042-20220505
s390                 randconfig-r044-20220505
arc                  randconfig-r043-20220505
arc                  randconfig-r043-20220507
s390                 randconfig-r044-20220507
riscv                randconfig-r042-20220507
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220506
riscv                randconfig-c006-20220506
mips                 randconfig-c004-20220506
arm                  randconfig-c002-20220506
s390                 randconfig-c005-20220506
powerpc              randconfig-c003-20220507
riscv                randconfig-c006-20220507
mips                 randconfig-c004-20220507
arm                  randconfig-c002-20220507
powerpc              randconfig-c003-20220508
riscv                randconfig-c006-20220508
mips                 randconfig-c004-20220508
arm                  randconfig-c002-20220508
arm                           omap1_defconfig
arm                          moxart_defconfig
arm                          collie_defconfig
mips                          ath25_defconfig
arm                         socfpga_defconfig
mips                         tb0219_defconfig
powerpc                     mpc5200_defconfig
arm                       cns3420vb_defconfig
mips                      pic32mzda_defconfig
i386                             allyesconfig
powerpc                     ksi8560_defconfig
mips                           rs90_defconfig
powerpc                   microwatt_defconfig
powerpc                     skiroot_defconfig
arm                        vexpress_defconfig
arm                     davinci_all_defconfig
powerpc                      pmac32_defconfig
mips                        maltaup_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                 mpc8560_ads_defconfig
mips                      malta_kvm_defconfig
hexagon                             defconfig
mips                       lemote2f_defconfig
mips                          ath79_defconfig
arm                            mmp2_defconfig
arm                            dove_defconfig
arm                         lpc32xx_defconfig
arm                          ixp4xx_defconfig
powerpc                    ge_imp3a_defconfig
mips                      maltaaprp_defconfig
mips                   sb1250_swarm_defconfig
arm                           spitz_defconfig
mips                     cu1000-neo_defconfig
arm                        neponset_defconfig
arm                       aspeed_g4_defconfig
powerpc                   lite5200b_defconfig
powerpc                     tqm5200_defconfig
arm                         s5pv210_defconfig
arm                       versatile_defconfig
mips                malta_qemu_32r6_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a004-20220509
i386                 randconfig-a006-20220509
i386                 randconfig-a002-20220509
i386                 randconfig-a003-20220509
i386                 randconfig-a001-20220509
i386                 randconfig-a005-20220509
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220506
riscv                randconfig-r042-20220506
hexagon              randconfig-r041-20220506
hexagon              randconfig-r045-20220508
riscv                randconfig-r042-20220508
hexagon              randconfig-r041-20220508
hexagon              randconfig-r045-20220505
hexagon              randconfig-r041-20220505
hexagon              randconfig-r045-20220509
hexagon              randconfig-r041-20220509

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
