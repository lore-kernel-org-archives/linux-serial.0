Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71699C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 27 Jan 2022 21:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbiA0VoU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 27 Jan 2022 16:44:20 -0500
Received: from mga11.intel.com ([192.55.52.93]:49170 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230026AbiA0VoU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 Jan 2022 16:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643319860; x=1674855860;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XP8mBxkBFK4DCXxS4sQBuisBLwxopXXYwRl7tJfw1Ng=;
  b=akRXQr+inQU3Rqib3PP9TQCnF9SdwnmelVDoBvBaiCyM2rsyj7b7p71A
   WJmWJYRxkKcZcZmV9eku+OC4kPnu7rDDQW37FMS4A00djThL+MMdlyQCv
   0Aze5XtQCtTUUvqwU9gPO/9MQAoL031u2f3nOSmjDD8qyZd6dbz2SrUcb
   rpUVPUgBQrK+YDFgTDtIdTtgGjwRG3eeY2RULKm6zyjvubFiRPV3Z2hWe
   nLyeYuCL5Apmk5PCV1/ak8IazKL3R1ZAWWpeMxj/ygVld5AlWq4kdEsI4
   Hztt/XbEU4GupLveoOwFI/RwtVIi5RugQp48UvR3SOkBpNKuVnDdOlpGr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="244574970"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="244574970"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 13:44:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="767662251"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jan 2022 13:44:18 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDCYz-000N4E-Kn; Thu, 27 Jan 2022 21:44:17 +0000
Date:   Fri, 28 Jan 2022 05:43:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 d1ad2721b1eb05d54e81393a7ebc332d4a35c68f
Message-ID: <61f31201.yh/DqDp0qeTTLZ7Z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: d1ad2721b1eb05d54e81393a7ebc332d4a35c68f  kbuild: remove include/linux/cyclades.h from header file check

elapsed time: 723m

configs tested: 216
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220124
i386                          randconfig-c001
powerpc              randconfig-c003-20220124
powerpc                 mpc834x_itx_defconfig
arm                         at91_dt_defconfig
mips                         mpc30x_defconfig
xtensa                              defconfig
mips                        vocore2_defconfig
sh                          kfr2r09_defconfig
powerpc                mpc7448_hpc2_defconfig
um                               alldefconfig
sh                         ecovec24_defconfig
arc                     nsimosci_hs_defconfig
arc                      axs103_smp_defconfig
arm                       imx_v6_v7_defconfig
m68k                       m5275evb_defconfig
um                             i386_defconfig
h8300                    h8300h-sim_defconfig
m68k                            q40_defconfig
powerpc                 linkstation_defconfig
arm                         s3c6400_defconfig
m68k                           sun3_defconfig
arm                        oxnas_v6_defconfig
m68k                          multi_defconfig
nios2                         10m50_defconfig
xtensa                  audio_kc705_defconfig
powerpc                      ppc40x_defconfig
powerpc                 mpc837x_mds_defconfig
sparc                            allyesconfig
powerpc                       ppc64_defconfig
m68k                        stmark2_defconfig
xtensa                  nommu_kc705_defconfig
mips                         rt305x_defconfig
arm                            zeus_defconfig
arc                        vdk_hs38_defconfig
sh                          rsk7269_defconfig
ia64                        generic_defconfig
sh                           sh2007_defconfig
um                                  defconfig
parisc                generic-64bit_defconfig
mips                        bcm47xx_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                       sparc64_defconfig
m68k                          hp300_defconfig
nds32                               defconfig
sh                ecovec24-romimage_defconfig
m68k                       m5249evb_defconfig
arm                             rpc_defconfig
sh                               allmodconfig
powerpc                  storcenter_defconfig
arm                        keystone_defconfig
sh                     sh7710voipgw_defconfig
sh                 kfr2r09-romimage_defconfig
parisc                generic-32bit_defconfig
arm                           viper_defconfig
arm                            xcep_defconfig
sh                            shmin_defconfig
ia64                      gensparse_defconfig
arm                         lubbock_defconfig
riscv                            allyesconfig
powerpc                     rainier_defconfig
mips                    maltaup_xpa_defconfig
sh                        sh7763rdp_defconfig
arm                          pxa910_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                       omap2plus_defconfig
arm                           h5000_defconfig
sh                   sh7724_generic_defconfig
arc                            hsdk_defconfig
arm                            hisi_defconfig
powerpc                     tqm8541_defconfig
mips                           xway_defconfig
powerpc                      ppc6xx_defconfig
arc                              alldefconfig
arc                        nsimosci_defconfig
powerpc                      tqm8xx_defconfig
h8300                            alldefconfig
h8300                     edosk2674_defconfig
powerpc                     pq2fads_defconfig
sh                             shx3_defconfig
sh                             espt_defconfig
arm                           corgi_defconfig
powerpc                  iss476-smp_defconfig
arm                  randconfig-c002-20220127
arm                  randconfig-c002-20220124
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20220124
x86_64               randconfig-a003-20220124
x86_64               randconfig-a004-20220124
x86_64               randconfig-a005-20220124
x86_64               randconfig-a006-20220124
x86_64               randconfig-a001-20220124
i386                 randconfig-a002-20220124
i386                 randconfig-a005-20220124
i386                 randconfig-a003-20220124
i386                 randconfig-a004-20220124
i386                 randconfig-a001-20220124
i386                 randconfig-a006-20220124
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220127
riscv                randconfig-r042-20220125
arc                  randconfig-r043-20220127
arc                  randconfig-r043-20220125
arc                  randconfig-r043-20220124
s390                 randconfig-r044-20220127
s390                 randconfig-r044-20220125
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220124
riscv                randconfig-c006-20220124
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
mips                 randconfig-c004-20220124
x86_64               randconfig-c007-20220124
arm                  colibri_pxa300_defconfig
mips                         tb0219_defconfig
mips                          malta_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                   bluestone_defconfig
mips                           ip27_defconfig
powerpc                      ppc44x_defconfig
arm                     davinci_all_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                          allmodconfig
arm                    vt8500_v6_v7_defconfig
powerpc                          g5_defconfig
powerpc                      acadia_defconfig
arm                        magician_defconfig
mips                     cu1830-neo_defconfig
i386                             allyesconfig
powerpc                      walnut_defconfig
powerpc                     kilauea_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      katmai_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                     am200epdkit_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a014-20220124
x86_64               randconfig-a012-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a011-20220124
i386                 randconfig-a016-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a012-20220124
riscv                randconfig-r042-20220124
s390                 randconfig-r044-20220124
hexagon              randconfig-r045-20220124
hexagon              randconfig-r045-20220127
hexagon              randconfig-r041-20220124
hexagon              randconfig-r041-20220127
hexagon              randconfig-r045-20220125
hexagon              randconfig-r041-20220125

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
