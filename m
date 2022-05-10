Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6CFC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 10 May 2022 07:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbiEJHiM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 May 2022 03:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240417AbiEJHU6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 May 2022 03:20:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE872FFE1
        for <linux-serial@vger.kernel.org>; Tue, 10 May 2022 00:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652167021; x=1683703021;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0ujstQG8mAIAYvGsoemy13GrhgYFU8yCSHEdq9i4YmQ=;
  b=OsUXhcFNi9+J25Nqc95cCB89IKyGh54MumeQ77FiaILdkWxyFFwrx4od
   oiqfLZuRWJxbKmheWO5s60/waki5/N57T/ovjt9HAJSEs2CKd3VOrfZMD
   5ZSlOtwWHmcr5iX7UZgsvzvYj/LmX8ZtwgonoWHi0/n70OYIPuxhcVuKu
   72m4WB60RWZ4uXlAEzZP3Mp1WFC9NnWVlAbVtIPbz6Ouznprd3z0uVjc7
   JGEhShO55sGG8Ibz63FmYczFrEbyfj1pl5s1xNC+ao5ToQi8vHgrDxsK8
   u3szs28jPAFwVQAyCGe1ZboQu7JARNOGk/s76NRgXJguGhjaRp3cQvtFD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="268129009"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="268129009"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 00:17:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="519616150"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 May 2022 00:16:58 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noK77-000HRx-Tb;
        Tue, 10 May 2022 07:16:57 +0000
Date:   Tue, 10 May 2022 15:16:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 4419da5d5d4b1788568b7bf22c083ba2832891df
Message-ID: <627a115d.ELnR+QN07+RNSxjn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 4419da5d5d4b1788568b7bf22c083ba2832891df  tty: hvc: dcc: Bind driver to CPU core0 for reads and writes

Unverified Warning (likely false positive, please contact us if interested):

drivers/tty/hvc/hvc_dcc.c:98:6: warning: Value stored to 'cpu' during its initialization is never read [clang-analyzer-deadcode.DeadStores]

Warning ids grouped by kconfigs:

clang_recent_errors
`-- arm-randconfig-c002-20220506
    `-- drivers-tty-hvc-hvc_dcc.c:warning:Value-stored-to-cpu-during-its-initialization-is-never-read-clang-analyzer-deadcode.DeadStores

elapsed time: 6227m

configs tested: 392
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
i386                 randconfig-c001-20220509
arm                        clps711x_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                         tb0226_defconfig
m68k                             allmodconfig
xtensa                       common_defconfig
arm                      jornada720_defconfig
arm                           h5000_defconfig
m68k                          hp300_defconfig
alpha                            alldefconfig
arm                         nhk8815_defconfig
sh                ecovec24-romimage_defconfig
arm                           sunxi_defconfig
ia64                             alldefconfig
arm                          exynos_defconfig
h8300                    h8300h-sim_defconfig
arm                        multi_v7_defconfig
powerpc                      mgcoge_defconfig
xtensa                    smp_lx200_defconfig
ia64                      gensparse_defconfig
sh                              ul2_defconfig
mips                           ci20_defconfig
sparc                       sparc64_defconfig
nios2                         3c120_defconfig
sh                           se7619_defconfig
sparc64                             defconfig
m68k                       m5475evb_defconfig
arm                        shmobile_defconfig
m68k                        mvme16x_defconfig
riscv                               defconfig
powerpc                     sequoia_defconfig
arc                          axs103_defconfig
powerpc                      makalu_defconfig
arm                         axm55xx_defconfig
powerpc                 linkstation_defconfig
powerpc                       ppc64_defconfig
csky                             alldefconfig
mips                           ip32_defconfig
sh                             sh03_defconfig
sh                   sh7724_generic_defconfig
m68k                          atari_defconfig
powerpc                      cm5200_defconfig
powerpc                       eiger_defconfig
arm                       omap2plus_defconfig
csky                                defconfig
xtensa                  cadence_csp_defconfig
ia64                        generic_defconfig
arm                            qcom_defconfig
arc                     nsimosci_hs_defconfig
powerpc                        warp_defconfig
sh                           se7721_defconfig
arm                           corgi_defconfig
mips                 decstation_r4k_defconfig
arm                        spear6xx_defconfig
x86_64                           alldefconfig
powerpc                     tqm8548_defconfig
m68k                       bvme6000_defconfig
arm                         lubbock_defconfig
parisc                           alldefconfig
sh                          urquell_defconfig
sh                          landisk_defconfig
xtensa                  nommu_kc705_defconfig
sh                           se7705_defconfig
arm                             rpc_defconfig
mips                         cobalt_defconfig
s390                       zfcpdump_defconfig
m68k                           sun3_defconfig
sh                          sdk7780_defconfig
sh                           se7712_defconfig
powerpc                      ppc40x_defconfig
powerpc                    adder875_defconfig
sh                        dreamcast_defconfig
arc                              alldefconfig
powerpc                      tqm8xx_defconfig
sh                         ap325rxa_defconfig
x86_64                              defconfig
mips                      loongson3_defconfig
sparc                            alldefconfig
powerpc                 mpc837x_rdb_defconfig
ia64                          tiger_defconfig
powerpc                           allnoconfig
powerpc                     tqm8555_defconfig
powerpc                     ep8248e_defconfig
sh                             espt_defconfig
arm                       multi_v4t_defconfig
arm                             ezx_defconfig
arm                        mini2440_defconfig
xtensa                              defconfig
arm                           sama5_defconfig
mips                    maltaup_xpa_defconfig
powerpc64                           defconfig
arc                        vdk_hs38_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                  iss476-smp_defconfig
sparc                            allyesconfig
sh                          rsk7203_defconfig
h8300                       h8s-sim_defconfig
sh                         microdev_defconfig
sh                               j2_defconfig
powerpc                       holly_defconfig
mips                        vocore2_defconfig
powerpc                     stx_gp3_defconfig
mips                           jazz_defconfig
um                               alldefconfig
openrisc                    or1ksim_defconfig
arm                            xcep_defconfig
riscv                            allyesconfig
arm                           viper_defconfig
sh                          polaris_defconfig
sh                        sh7763rdp_defconfig
powerpc                         wii_defconfig
mips                             allmodconfig
powerpc                    klondike_defconfig
arm                        realview_defconfig
mips                     decstation_defconfig
arm                         assabet_defconfig
h8300                            allyesconfig
powerpc                     rainier_defconfig
arc                                 defconfig
m68k                         apollo_defconfig
powerpc                     taishan_defconfig
powerpc                     tqm8541_defconfig
powerpc                 mpc834x_itx_defconfig
xtensa                  audio_kc705_defconfig
mips                         mpc30x_defconfig
arm                            zeus_defconfig
arm                     eseries_pxa_defconfig
powerpc                  storcenter_defconfig
sh                               allmodconfig
sh                           se7343_defconfig
parisc                generic-32bit_defconfig
alpha                               defconfig
powerpc                      pasemi_defconfig
mips                         bigsur_defconfig
sh                   rts7751r2dplus_defconfig
arm                      footbridge_defconfig
sh                          kfr2r09_defconfig
i386                                defconfig
sh                 kfr2r09-romimage_defconfig
m68k                       m5208evb_defconfig
mips                      fuloong2e_defconfig
powerpc                      ep88xc_defconfig
sh                          rsk7269_defconfig
m68k                        m5307c3_defconfig
arm                      integrator_defconfig
nios2                         10m50_defconfig
arm                          gemini_defconfig
powerpc                      pcm030_defconfig
sh                           sh2007_defconfig
arm                         at91_dt_defconfig
xtensa                           allyesconfig
arm                          badge4_defconfig
arm                             pxa_defconfig
arm                         vf610m4_defconfig
arc                           tb10x_defconfig
microblaze                          defconfig
mips                         db1xxx_defconfig
powerpc                   currituck_defconfig
mips                      maltasmvp_defconfig
m68k                          sun3x_defconfig
powerpc                      chrp32_defconfig
powerpc                 mpc8540_ads_defconfig
nios2                            allyesconfig
sh                        apsh4ad0a_defconfig
powerpc                     redwood_defconfig
sh                          lboxre2_defconfig
powerpc                      ppc6xx_defconfig
sh                          sdk7786_defconfig
arm                         lpc18xx_defconfig
arm                          pxa3xx_defconfig
m68k                        m5272c3_defconfig
arm                            pleb_defconfig
mips                          rb532_defconfig
arm                         s3c6400_defconfig
m68k                       m5249evb_defconfig
arm                         cm_x300_defconfig
sh                   secureedge5410_defconfig
arm                        mvebu_v7_defconfig
arm                            lart_defconfig
mips                  decstation_64_defconfig
powerpc                     pq2fads_defconfig
arm                       imx_v6_v7_defconfig
openrisc                 simple_smp_defconfig
mips                        bcm47xx_defconfig
arm                        cerfcube_defconfig
m68k                          multi_defconfig
sh                           se7724_defconfig
sh                           se7780_defconfig
sh                        edosk7705_defconfig
m68k                         amcore_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                          amiga_defconfig
parisc                generic-64bit_defconfig
sh                                  defconfig
sh                     magicpanelr2_defconfig
arc                         haps_hs_defconfig
sh                         apsh4a3a_defconfig
mips                            ar7_defconfig
arc                    vdk_hs38_smp_defconfig
sh                           se7750_defconfig
powerpc                      arches_defconfig
powerpc                      bamboo_defconfig
ia64                         bigsur_defconfig
arc                        nsimosci_defconfig
ia64                            zx1_defconfig
s390                                defconfig
arm                       aspeed_g5_defconfig
powerpc                     asp8347_defconfig
h8300                               defconfig
arm                            hisi_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                  maltasmvp_eva_defconfig
um                                  defconfig
sh                         ecovec24_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220506
x86_64               randconfig-c001-20220509
arm                  randconfig-c002-20220509
arm                  randconfig-c002-20220505
arm                  randconfig-c002-20220507
arm                  randconfig-c002-20220508
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
alpha                            allyesconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64               randconfig-a015-20220509
x86_64               randconfig-a012-20220509
x86_64               randconfig-a016-20220509
x86_64               randconfig-a014-20220509
x86_64               randconfig-a013-20220509
x86_64               randconfig-a011-20220509
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                 randconfig-a011-20220509
i386                 randconfig-a013-20220509
i386                 randconfig-a016-20220509
i386                 randconfig-a015-20220509
i386                 randconfig-a014-20220509
i386                 randconfig-a012-20220509
arc                  randconfig-r043-20220505
s390                 randconfig-r044-20220505
riscv                randconfig-r042-20220505
arc                  randconfig-r043-20220509
s390                 randconfig-r044-20220509
riscv                randconfig-r042-20220509
arc                  randconfig-r043-20220507
s390                 randconfig-r044-20220507
riscv                randconfig-r042-20220507
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                           allyesconfig
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
x86_64               randconfig-c007-20220509
i386                 randconfig-c001-20220509
powerpc              randconfig-c003-20220509
riscv                randconfig-c006-20220509
arm                  randconfig-c002-20220509
mips                 randconfig-c004-20220509
powerpc              randconfig-c003-20220508
riscv                randconfig-c006-20220508
mips                 randconfig-c004-20220508
arm                  randconfig-c002-20220508
powerpc              randconfig-c003-20220505
riscv                randconfig-c006-20220505
arm                  randconfig-c002-20220505
mips                        omega2p_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                         tb0219_defconfig
powerpc                     mpc5200_defconfig
arm                       cns3420vb_defconfig
arm                          collie_defconfig
powerpc                     tqm5200_defconfig
arm                                 defconfig
mips                      pic32mzda_defconfig
i386                             allyesconfig
mips                           mtx1_defconfig
arm                         socfpga_defconfig
powerpc                     ksi8560_defconfig
mips                          ath25_defconfig
mips                           rs90_defconfig
mips                          ath79_defconfig
powerpc                      ppc64e_defconfig
mips                        workpad_defconfig
arm                          pcm027_defconfig
powerpc                     pseries_defconfig
arm                      pxa255-idp_defconfig
hexagon                             defconfig
arm                        mvebu_v5_defconfig
powerpc                  mpc885_ads_defconfig
arm                        vexpress_defconfig
arm                     davinci_all_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     skiroot_defconfig
powerpc                      walnut_defconfig
arm                     am200epdkit_defconfig
mips                            e55_defconfig
arm                             mxs_defconfig
arm                        neponset_defconfig
mips                       lemote2f_defconfig
arm                       aspeed_g4_defconfig
arm                       versatile_defconfig
arm                         s3c2410_defconfig
mips                  cavium_octeon_defconfig
arm                            mmp2_defconfig
arm                            dove_defconfig
arm                         lpc32xx_defconfig
arm                          ixp4xx_defconfig
powerpc                     tqm8560_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                   sb1250_swarm_defconfig
arm                           spitz_defconfig
arm                       spear13xx_defconfig
powerpc                      katmai_defconfig
mips                     loongson1c_defconfig
mips                     cu1830-neo_defconfig
powerpc                   lite5200b_defconfig
arm                         s5pv210_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64               randconfig-a006-20220509
x86_64               randconfig-a002-20220509
x86_64               randconfig-a001-20220509
x86_64               randconfig-a004-20220509
x86_64               randconfig-a005-20220509
x86_64               randconfig-a003-20220509
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
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220506
riscv                randconfig-r042-20220506
hexagon              randconfig-r041-20220506
hexagon              randconfig-r045-20220509
hexagon              randconfig-r041-20220509
hexagon              randconfig-r045-20220505
hexagon              randconfig-r041-20220505

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
