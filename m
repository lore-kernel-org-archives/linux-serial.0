Return-Path: <SRS0=bP+p=DG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79424C4727C
	for <linux-serial@archiver.kernel.org>; Tue, 29 Sep 2020 23:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23C5C21548
	for <linux-serial@archiver.kernel.org>; Tue, 29 Sep 2020 23:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgI2XGz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Sep 2020 19:06:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:63644 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbgI2XGz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Sep 2020 19:06:55 -0400
IronPort-SDR: aQPCHv/88KMgxqfxaliSqiN+zh3dVGzBUh6sr0CwxiBQGVqTKjE4tMxawilPcPWp7KAZkDBXPR
 /TITtveI/kAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="161530371"
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="161530371"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 16:06:54 -0700
IronPort-SDR: 1iVwDdPzTD9Dxo36hsOb6VUWhPLHRRpmlUafPzH0lEyqB6XLSRCe2Zf88dqI1PAaiK56htpzGV
 Krf9LN4C+ipQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="294424676"
Received: from lkp-server02.sh.intel.com (HELO 10ae44db8633) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 29 Sep 2020 16:06:52 -0700
Received: from kbuild by 10ae44db8633 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kNOhw-0000N6-7a; Tue, 29 Sep 2020 23:06:52 +0000
Date:   Wed, 30 Sep 2020 07:05:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 58e49346672f738cf6eeb62009a5b0ae194374c4
Message-ID: <5f73bdd4.B/xQpC0PG36l2geE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: 58e49346672f738cf6eeb62009a5b0ae194374c4  serial: mvebu-uart: fix unused variable warning

elapsed time: 725m

configs tested: 188
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 xes_mpc85xx_defconfig
arc                      axs103_smp_defconfig
arc                         haps_hs_defconfig
arm                         orion5x_defconfig
powerpc                      pcm030_defconfig
arm                        shmobile_defconfig
mips                         db1xxx_defconfig
sh                          sdk7780_defconfig
powerpc                 mpc8560_ads_defconfig
csky                                defconfig
m68k                            q40_defconfig
arc                           tb10x_defconfig
m68k                        mvme147_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                         tb0219_defconfig
mips                         bigsur_defconfig
arc                             nps_defconfig
h8300                            alldefconfig
sh                            hp6xx_defconfig
powerpc                 mpc8540_ads_defconfig
arm                        mvebu_v7_defconfig
arm                        spear3xx_defconfig
ia64                        generic_defconfig
mips                       rbtx49xx_defconfig
powerpc                      pmac32_defconfig
powerpc64                        alldefconfig
sh                        sh7785lcr_defconfig
s390                       zfcpdump_defconfig
mips                      pistachio_defconfig
ia64                            zx1_defconfig
powerpc                     tqm8541_defconfig
arm                         vf610m4_defconfig
xtensa                         virt_defconfig
powerpc                   bluestone_defconfig
arm                         s5pv210_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                      pasemi_defconfig
powerpc                     sequoia_defconfig
mips                           ip32_defconfig
mips                      bmips_stb_defconfig
mips                        maltaup_defconfig
arm                           u8500_defconfig
powerpc                     mpc512x_defconfig
powerpc                    amigaone_defconfig
sh                           se7751_defconfig
mips                      malta_kvm_defconfig
powerpc                     rainier_defconfig
arm                           efm32_defconfig
arm                      tct_hammer_defconfig
powerpc                        icon_defconfig
m68k                             alldefconfig
arm                         socfpga_defconfig
powerpc                 mpc832x_mds_defconfig
arm                       spear13xx_defconfig
powerpc                     kmeter1_defconfig
arm                          gemini_defconfig
i386                                defconfig
powerpc                     stx_gp3_defconfig
ia64                             allmodconfig
xtensa                           allyesconfig
mips                          rm200_defconfig
m68k                       m5249evb_defconfig
arc                    vdk_hs38_smp_defconfig
arm                       versatile_defconfig
arm                       omap2plus_defconfig
powerpc                    socrates_defconfig
parisc                generic-64bit_defconfig
xtensa                  audio_kc705_defconfig
m68k                        mvme16x_defconfig
s390                                defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                      ep88xc_defconfig
sh                         apsh4a3a_defconfig
s390                             allyesconfig
arm                            u300_defconfig
sh                   sh7724_generic_defconfig
powerpc                     tqm8555_defconfig
sh                            shmin_defconfig
xtensa                  cadence_csp_defconfig
sh                           se7206_defconfig
powerpc                      katmai_defconfig
powerpc                     tqm8560_defconfig
microblaze                    nommu_defconfig
arc                            hsdk_defconfig
powerpc                       eiger_defconfig
arm                        multi_v5_defconfig
arc                        vdk_hs38_defconfig
mips                             allmodconfig
m68k                                defconfig
arm                      pxa255-idp_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                          simpad_defconfig
sh                        edosk7705_defconfig
c6x                        evmc6457_defconfig
arm                         s3c6400_defconfig
arm                           sama5_defconfig
powerpc                    mvme5100_defconfig
powerpc                        fsp2_defconfig
sh                   sh7770_generic_defconfig
arm                           h5000_defconfig
arm                         at91_dt_defconfig
mips                         mpc30x_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                       multi_v4t_defconfig
sh                             shx3_defconfig
microblaze                          defconfig
mips                   sb1250_swarm_defconfig
arm                          ep93xx_defconfig
sh                           se7780_defconfig
parisc                           alldefconfig
arm                             mxs_defconfig
mips                            gpr_defconfig
c6x                        evmc6474_defconfig
sh                      rts7751r2d1_defconfig
alpha                            alldefconfig
sh                           se7712_defconfig
mips                     loongson1c_defconfig
sh                          r7785rp_defconfig
mips                         cobalt_defconfig
xtensa                  nommu_kc705_defconfig
um                           x86_64_defconfig
arm                        multi_v7_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20200929
i386                 randconfig-a002-20200929
i386                 randconfig-a003-20200929
i386                 randconfig-a004-20200929
i386                 randconfig-a005-20200929
i386                 randconfig-a001-20200929
x86_64               randconfig-a011-20200929
x86_64               randconfig-a013-20200929
x86_64               randconfig-a015-20200929
x86_64               randconfig-a014-20200929
x86_64               randconfig-a016-20200929
x86_64               randconfig-a012-20200929
i386                 randconfig-a012-20200929
i386                 randconfig-a016-20200929
i386                 randconfig-a014-20200929
i386                 randconfig-a013-20200929
i386                 randconfig-a015-20200929
i386                 randconfig-a011-20200929
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200929
x86_64               randconfig-a003-20200929
x86_64               randconfig-a004-20200929
x86_64               randconfig-a002-20200929
x86_64               randconfig-a006-20200929
x86_64               randconfig-a001-20200929

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
