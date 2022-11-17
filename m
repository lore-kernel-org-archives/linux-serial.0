Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A767CC433FE
	for <linux-serial@archiver.kernel.org>; Thu, 17 Nov 2022 18:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbiKQS5N (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Nov 2022 13:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiKQS5M (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Nov 2022 13:57:12 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE288755B
        for <linux-serial@vger.kernel.org>; Thu, 17 Nov 2022 10:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668711431; x=1700247431;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lhxhNHDULyU/iY/UtmVwOUNdUiW54jfrbu2WwSGZHvI=;
  b=hjnaOdkib0oxBl7pH/6q0UXP0td/oJqdwDgC1u3qRlaX7ZfyH+e0rupq
   T5oGx1EGlX0A4UjrOc4rNtj+NbbWqtpggCETCaXPZpocVFUur4bairjuE
   IdMN6O6stJrVHut/Z2O6/gaDioKoktETDaFVZvN2Wpq1ka1XgZ6urq9l6
   cK77B4o7sLDr9Epcjtl2ES+hfOA75pTgljFs3pZ+ynJ9bXuu1HQjeiVhf
   0RkB3rhMb+iw0eHo90l6nTGe6/G8aPle4fuB2UC6iI9L6jn6MK0xzx9tW
   rIXeUJHLPEbphIKQfDwc4pnUVYW/tNkjflk80sOCi3WRmSwtKB/ApXIOr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="314092643"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="314092643"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 10:57:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="814628316"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="814628316"
Received: from lkp-server01.sh.intel.com (HELO 55744f5052f8) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 17 Nov 2022 10:57:09 -0800
Received: from kbuild by 55744f5052f8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ovk4S-0000Yp-2o;
        Thu, 17 Nov 2022 18:57:08 +0000
Date:   Fri, 18 Nov 2022 02:56:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-next] BUILD SUCCESS
 a3be423f0657e603b45998ef2bb9e5d27dc226c3
Message-ID: <637683df.n/NSLsjSMdJmOCl+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
branch HEAD: a3be423f0657e603b45998ef2bb9e5d27dc226c3  tty: n_gsm: Delete unneeded semicolon

elapsed time: 11910m

configs tested: 432
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
powerpc                           allnoconfig
arm                                 defconfig
x86_64                            allnoconfig
x86_64                              defconfig
s390                       zfcpdump_defconfig
powerpc                      arches_defconfig
powerpc                     sequoia_defconfig
mips                         cobalt_defconfig
arm                      footbridge_defconfig
xtensa                  cadence_csp_defconfig
mips                         db1xxx_defconfig
arm                        spear6xx_defconfig
powerpc                      pasemi_defconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
sh                           se7722_defconfig
arm                         cm_x300_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc              randconfig-c003-20221110
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
alpha                               defconfig
sh                   secureedge5410_defconfig
powerpc                 mpc837x_rdb_defconfig
xtensa                    xip_kc705_defconfig
xtensa                          iss_defconfig
powerpc                 mpc834x_mds_defconfig
sh                           se7724_defconfig
microblaze                          defconfig
parisc                           alldefconfig
arm                          pxa910_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm64                               defconfig
powerpc                 linkstation_defconfig
parisc                generic-64bit_defconfig
loongarch                           defconfig
arm64                            allyesconfig
arm                              allyesconfig
powerpc                    amigaone_defconfig
arc                        nsimosci_defconfig
arm                             rpc_defconfig
m68k                          multi_defconfig
arc                         haps_hs_defconfig
powerpc                       ppc64_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          randconfig-c001
xtensa                           alldefconfig
parisc                generic-32bit_defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
ia64                        generic_defconfig
openrisc                         alldefconfig
sparc                               defconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
powerpc                     taishan_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         vf610m4_defconfig
xtensa                           allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                 randconfig-r044-20221111
arm                           viper_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221110
arc                           tb10x_defconfig
sh                         apsh4a3a_defconfig
powerpc              randconfig-c003-20221111
riscv                randconfig-r042-20221111
arc                  randconfig-r043-20221111
arm                      integrator_defconfig
arc                          axs101_defconfig
loongarch                 loongson3_defconfig
mips                 randconfig-c004-20221111
powerpc                         ps3_defconfig
loongarch                        alldefconfig
arm                            pleb_defconfig
arm                           sunxi_defconfig
xtensa                  nommu_kc705_defconfig
arm                            qcom_defconfig
powerpc                      ppc40x_defconfig
sparc64                             defconfig
arm                         lpc18xx_defconfig
powerpc                       maple_defconfig
arc                          axs103_defconfig
powerpc                          allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
arm                       imx_v6_v7_defconfig
mips                 decstation_r4k_defconfig
arm                        oxnas_v6_defconfig
m68k                          hp300_defconfig
arm                         at91_dt_defconfig
riscv                               defconfig
arm                  randconfig-c002-20221111
sh                          r7780mp_defconfig
arm                           u8500_defconfig
mips                           gcw0_defconfig
mips                     loongson1b_defconfig
m68k                       m5208evb_defconfig
mips                           jazz_defconfig
mips                      loongson3_defconfig
powerpc                      cm5200_defconfig
mips                            gpr_defconfig
sparc                       sparc32_defconfig
powerpc                     mpc83xx_defconfig
sh                        apsh4ad0a_defconfig
sh                   rts7751r2dplus_defconfig
sh                        sh7757lcr_defconfig
mips                      fuloong2e_defconfig
arm                         axm55xx_defconfig
openrisc                            defconfig
openrisc                  or1klitex_defconfig
arm                        mvebu_v7_defconfig
ia64                             allyesconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
powerpc                     tqm8541_defconfig
sh                            hp6xx_defconfig
powerpc                     asp8347_defconfig
m68k                       m5275evb_defconfig
m68k                         apollo_defconfig
sh                               alldefconfig
mips                  maltasmvp_eva_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                 mpc837x_mds_defconfig
ia64                             alldefconfig
sh                     magicpanelr2_defconfig
powerpc                      ppc6xx_defconfig
powerpc                    sam440ep_defconfig
powerpc                    adder875_defconfig
powerpc                  storcenter_defconfig
mips                           ip32_defconfig
m68k                        m5407c3_defconfig
arm                          iop32x_defconfig
arm                             pxa_defconfig
sh                          sdk7786_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                      pcm030_defconfig
sh                   sh7770_generic_defconfig
arc                     nsimosci_hs_defconfig
sh                   sh7724_generic_defconfig
mips                         rt305x_defconfig
m68k                           virt_defconfig
m68k                       m5249evb_defconfig
m68k                        mvme147_defconfig
sh                         ecovec24_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                  decstation_64_defconfig
arm                        multi_v7_defconfig
mips                    maltaup_xpa_defconfig
um                               alldefconfig
mips                           ci20_defconfig
arc                        nsim_700_defconfig
m68k                        m5272c3_defconfig
sh                          rsk7201_defconfig
powerpc                    klondike_defconfig
arm                          badge4_defconfig
m68k                           sun3_defconfig
sparc64                          alldefconfig
arm                          pxa3xx_defconfig
sh                              ul2_defconfig
sh                           se7619_defconfig
arm64                            alldefconfig
powerpc                     pq2fads_defconfig
openrisc                    or1ksim_defconfig
sh                         microdev_defconfig
ia64                            zx1_defconfig
powerpc                     ep8248e_defconfig
sh                          r7785rp_defconfig
arm                          simpad_defconfig
arm                        mini2440_defconfig
sh                            migor_defconfig
arm                  randconfig-c002-20221113
arm                           tegra_defconfig
xtensa                  audio_kc705_defconfig
powerpc                     redwood_defconfig
xtensa                         virt_defconfig
powerpc                        warp_defconfig
m68k                          amiga_defconfig
sh                        edosk7760_defconfig
i386                 randconfig-a002-20221114
i386                 randconfig-a004-20221114
i386                 randconfig-a003-20221114
i386                 randconfig-a005-20221114
i386                 randconfig-a006-20221114
i386                 randconfig-a001-20221114
arm                             ezx_defconfig
mips                      maltasmvp_defconfig
x86_64               randconfig-a003-20221114
x86_64               randconfig-a005-20221114
x86_64               randconfig-a004-20221114
x86_64               randconfig-a002-20221114
x86_64               randconfig-a001-20221114
x86_64               randconfig-a006-20221114
microblaze                      mmu_defconfig
m68k                          sun3x_defconfig
arc                     haps_hs_smp_defconfig
mips                       bmips_be_defconfig
ia64                          tiger_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                               allnoconfig
sh                           se7343_defconfig
sh                            shmin_defconfig
xtensa                              defconfig
mips                        vocore2_defconfig
powerpc                     stx_gp3_defconfig
sh                           sh2007_defconfig
m68k                       m5475evb_defconfig
arm                  randconfig-c002-20221115
ia64                         bigsur_defconfig
arc                  randconfig-r043-20221114
sh                               j2_defconfig
arm                           stm32_defconfig
arm                         assabet_defconfig
arc                               allnoconfig
sh                            titan_defconfig
sparc                       sparc64_defconfig
sh                          kfr2r09_defconfig
arm                       multi_v4t_defconfig
sh                 kfr2r09-romimage_defconfig
mips                     decstation_defconfig
openrisc                 simple_smp_defconfig
s390                          debug_defconfig
arm                            hisi_defconfig
powerpc                   motionpro_defconfig
sh                           se7721_defconfig
m68k                            q40_defconfig
sh                        dreamcast_defconfig
sh                          rsk7203_defconfig
arm                         lubbock_defconfig
sh                           se7705_defconfig
powerpc                      makalu_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                          rsk7264_defconfig
arm                         s3c6400_defconfig
arm                        shmobile_defconfig
alpha                            alldefconfig
powerpc                     tqm8555_defconfig
um                                  defconfig
sh                ecovec24-romimage_defconfig
openrisc                       virt_defconfig
sh                           se7751_defconfig
arm                        realview_defconfig
powerpc                   currituck_defconfig
mips                            ar7_defconfig
arm                            zeus_defconfig
arm                  randconfig-c002-20221116
sh                      rts7751r2d1_defconfig
powerpc                        cell_defconfig
sh                         ap325rxa_defconfig
arc                  randconfig-r043-20221117
riscv                randconfig-r042-20221117
s390                 randconfig-r044-20221117
powerpc                      bamboo_defconfig
sh                        sh7785lcr_defconfig
arm                       omap2plus_defconfig
sh                        edosk7705_defconfig
x86_64                           alldefconfig
arm                  randconfig-c002-20221117
arm                        trizeps4_defconfig
m68k                        stmark2_defconfig
sh                          sdk7780_defconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a004
s390                 randconfig-r044-20221110
riscv                randconfig-r042-20221110
hexagon              randconfig-r041-20221110
hexagon              randconfig-r045-20221110
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a012
powerpc                        fsp2_defconfig
powerpc                    gamecube_defconfig
mips                malta_qemu_32r6_defconfig
mips                     loongson2k_defconfig
riscv                             allnoconfig
x86_64                        randconfig-k001
hexagon              randconfig-r041-20221111
hexagon              randconfig-r045-20221111
arm                        vexpress_defconfig
powerpc                    mvme5100_defconfig
arm                       versatile_defconfig
riscv                randconfig-c006-20221110
x86_64                        randconfig-c007
mips                 randconfig-c004-20221110
i386                          randconfig-c001
arm                  randconfig-c002-20221110
powerpc              randconfig-c003-20221110
s390                 randconfig-c005-20221110
arm                       aspeed_g4_defconfig
mips                      pic32mzda_defconfig
arm                         lpc32xx_defconfig
powerpc                      obs600_defconfig
powerpc                    socrates_defconfig
powerpc                        icon_defconfig
arm                         hackkit_defconfig
arm                       netwinder_defconfig
arm                          ixp4xx_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         s3c2410_defconfig
arm                           sama7_defconfig
arm                          pcm027_defconfig
arm                           omap1_defconfig
mips                        qi_lb60_defconfig
mips                  cavium_octeon_defconfig
powerpc                     skiroot_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                     ppa8548_defconfig
riscv                randconfig-c006-20221111
mips                 randconfig-c004-20221111
powerpc              randconfig-c003-20221111
s390                 randconfig-c005-20221111
riscv                            alldefconfig
powerpc                      ppc44x_defconfig
mips                           rs90_defconfig
arm                          sp7021_defconfig
powerpc                 mpc8560_ads_defconfig
arm                  randconfig-c002-20221111
powerpc                  mpc885_ads_defconfig
riscv                    nommu_virt_defconfig
arm                       cns3420vb_defconfig
arm                     am200epdkit_defconfig
powerpc                 mpc8272_ads_defconfig
mips                           ip27_defconfig
mips                        bcm63xx_defconfig
mips                     cu1000-neo_defconfig
mips                           ip22_defconfig
x86_64                           allyesconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                          ath25_defconfig
arm                        magician_defconfig
arm                       spear13xx_defconfig
powerpc                     kilauea_defconfig
powerpc                          g5_defconfig
powerpc                          allyesconfig
mips                        maltaup_defconfig
arm                         mv78xx0_defconfig
powerpc                     akebono_defconfig
powerpc                 xes_mpc85xx_defconfig
hexagon                             defconfig
mips                          malta_defconfig
i386                              allnoconfig
i386                             allyesconfig
powerpc                      ppc64e_defconfig
mips                     cu1830-neo_defconfig
mips                      malta_kvm_defconfig
i386                 randconfig-a015-20221114
i386                 randconfig-a013-20221114
i386                 randconfig-a011-20221114
i386                 randconfig-a016-20221114
i386                 randconfig-a012-20221114
i386                 randconfig-a014-20221114
mips                       lemote2f_defconfig
s390                 randconfig-r044-20221114
riscv                randconfig-r042-20221114
hexagon              randconfig-r041-20221114
hexagon              randconfig-r045-20221114
x86_64               randconfig-a012-20221114
x86_64               randconfig-a013-20221114
x86_64               randconfig-a016-20221114
x86_64               randconfig-a014-20221114
x86_64               randconfig-a015-20221114
x86_64               randconfig-a011-20221114
mips                           mtx1_defconfig
arm                       mainstone_defconfig
mips                      bmips_stb_defconfig
arm                        multi_v5_defconfig
arm                                 defconfig
powerpc                     mpc512x_defconfig
powerpc                     kmeter1_defconfig
hexagon              randconfig-r041-20221115
hexagon              randconfig-r045-20221115
riscv                randconfig-c006-20221114
mips                 randconfig-c004-20221114
arm                  randconfig-c002-20221114
powerpc              randconfig-c003-20221114
s390                 randconfig-c005-20221114
powerpc                   bluestone_defconfig
powerpc               mpc834x_itxgp_defconfig
riscv                randconfig-c006-20221115
mips                 randconfig-c004-20221115
arm                  randconfig-c002-20221115
powerpc              randconfig-c003-20221115
s390                 randconfig-c005-20221115
mips                        omega2p_defconfig
s390                 randconfig-r044-20221116
riscv                randconfig-r042-20221116
hexagon              randconfig-r041-20221116
hexagon              randconfig-r045-20221116
powerpc                     pseries_defconfig
hexagon              randconfig-r041-20221117
hexagon              randconfig-r045-20221117
riscv                randconfig-c006-20221116
mips                 randconfig-c004-20221116
arm                  randconfig-c002-20221116
powerpc              randconfig-c003-20221116
s390                 randconfig-c005-20221116
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
