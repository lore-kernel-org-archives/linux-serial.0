Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C97C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 31 Dec 2021 03:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhLaDfr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Dec 2021 22:35:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:32518 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242613AbhLaDfp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Dec 2021 22:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640921745; x=1672457745;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rM6mWTYAUtLn43XoKyTPk9EXs3cgxdas7ouGlQ8JI/Q=;
  b=lK6k0By/AQUzdMke7b3PKoh3IM1qSwCx6S/fcze0Thj/X9o7e+5R/pEd
   l7DXorq4eTGRCLVGOR9yA5nyEWEIHqnpKUBeic6lkNxfz7y4xBO4BT4pk
   G47HNmYouheVlF1xIptkPsa91hV8kdozhYKYKjasf4m6/j305mvWoVcAo
   gw/NVU3kqZPOfoBOYFz8tK4DyrFyTncviRgO0WNwx8JJDPkkWIcGi1gGc
   jkYAUAUAyhVAu2bN0bd2N6ZX2fzf2cHWp8qsAB2I9Rizfq/WFmYtriRQn
   kMOdd3ItR9kBGN+aG8ZK1roI8jYEL23RFniZFAZ/bKVPcWbE6mRjZffWj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="241722425"
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="241722425"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 19:35:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,250,1635231600"; 
   d="scan'208";a="487054443"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 30 Dec 2021 19:35:41 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n38hg-000AuC-Fk; Fri, 31 Dec 2021 03:35:40 +0000
Date:   Fri, 31 Dec 2021 11:35:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 5acb78dc72b48bc44226a86368fb442800981a0c
Message-ID: <61ce7a69.8u3qS6AVISgo8wU5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 5acb78dc72b48bc44226a86368fb442800981a0c  tty: goldfish: Use platform_get_irq() to get the interrupt

elapsed time: 725m

configs tested: 173
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                 randconfig-c001-20211229
i386                 randconfig-c001-20211230
sh                             sh03_defconfig
sh                   secureedge5410_defconfig
powerpc                 canyonlands_defconfig
sh                            hp6xx_defconfig
arc                        nsimosci_defconfig
arm                            hisi_defconfig
riscv                             allnoconfig
mips                       lemote2f_defconfig
powerpc                     ppa8548_defconfig
powerpc                      makalu_defconfig
sh                           se7780_defconfig
sh                          landisk_defconfig
sh                   sh7724_generic_defconfig
riscv                            alldefconfig
arm                         vf610m4_defconfig
ia64                            zx1_defconfig
arm                         at91_dt_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                          sdk7780_defconfig
powerpc                    mvme5100_defconfig
ia64                        generic_defconfig
mips                          rm200_defconfig
powerpc                      pmac32_defconfig
powerpc                     kilauea_defconfig
sh                          lboxre2_defconfig
mips                     loongson2k_defconfig
openrisc                         alldefconfig
mips                        bcm63xx_defconfig
sh                                  defconfig
csky                                defconfig
powerpc                      walnut_defconfig
powerpc                       ppc64_defconfig
mips                         mpc30x_defconfig
arm                        cerfcube_defconfig
mips                          ath25_defconfig
sh                          rsk7203_defconfig
arm                      footbridge_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                            e55_defconfig
powerpc                     ksi8560_defconfig
h8300                       h8s-sim_defconfig
powerpc                          g5_defconfig
arm                           spitz_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                          pxa168_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                   lite5200b_defconfig
h8300                               defconfig
parisc                           allyesconfig
arm                         nhk8815_defconfig
mips                           ip28_defconfig
xtensa                         virt_defconfig
arm                         bcm2835_defconfig
powerpc                     tqm8540_defconfig
arm                         orion5x_defconfig
powerpc                    adder875_defconfig
mips                         bigsur_defconfig
mips                      malta_kvm_defconfig
powerpc                     asp8347_defconfig
ia64                             allyesconfig
um                               alldefconfig
mips                            gpr_defconfig
m68k                           sun3_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                    ge_imp3a_defconfig
mips                           mtx1_defconfig
sh                ecovec24-romimage_defconfig
arm                        mini2440_defconfig
xtensa                           alldefconfig
sh                            migor_defconfig
sparc64                          alldefconfig
xtensa                  cadence_csp_defconfig
arm                        spear3xx_defconfig
arc                              allyesconfig
arm                        spear6xx_defconfig
arc                         haps_hs_defconfig
powerpc                     ep8248e_defconfig
sh                        sh7785lcr_defconfig
sh                           se7750_defconfig
m68k                       m5475evb_defconfig
arm                           sama5_defconfig
sh                          sdk7786_defconfig
parisc                generic-64bit_defconfig
riscv                            allmodconfig
powerpc                     powernv_defconfig
mips                        qi_lb60_defconfig
arm                        mvebu_v7_defconfig
arm                  randconfig-c002-20211230
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a013-20211230
x86_64               randconfig-a015-20211230
x86_64               randconfig-a012-20211230
x86_64               randconfig-a011-20211230
x86_64               randconfig-a016-20211230
x86_64               randconfig-a014-20211230
i386                 randconfig-a016-20211230
i386                 randconfig-a011-20211230
i386                 randconfig-a012-20211230
i386                 randconfig-a013-20211230
i386                 randconfig-a014-20211230
i386                 randconfig-a015-20211230
arc                  randconfig-r043-20211230
riscv                randconfig-r042-20211230
s390                 randconfig-r044-20211230
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20211230
x86_64               randconfig-a001-20211230
x86_64               randconfig-a003-20211230
x86_64               randconfig-a006-20211230
x86_64               randconfig-a004-20211230
x86_64               randconfig-a005-20211230
i386                 randconfig-a001-20211230
i386                 randconfig-a005-20211230
i386                 randconfig-a004-20211230
i386                 randconfig-a002-20211230
i386                 randconfig-a006-20211230
i386                 randconfig-a003-20211230
x86_64               randconfig-a015-20211228
x86_64               randconfig-a014-20211228
x86_64               randconfig-a013-20211228
x86_64               randconfig-a012-20211228
x86_64               randconfig-a011-20211228
x86_64               randconfig-a016-20211228
hexagon              randconfig-r041-20211230
hexagon              randconfig-r045-20211230

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
