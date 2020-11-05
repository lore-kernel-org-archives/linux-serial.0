Return-Path: <SRS0=qe7h=EL=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C91C4742C
	for <linux-serial@archiver.kernel.org>; Thu,  5 Nov 2020 03:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B8762072C
	for <linux-serial@archiver.kernel.org>; Thu,  5 Nov 2020 03:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbgKEDrv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 22:47:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:10342 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733135AbgKEDru (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 22:47:50 -0500
IronPort-SDR: zltGo/Vxh3ztMKYxNn0aCSQvNPtvn2IOTUI6DK/CaAq3HA3fujVRJH9QFxYt29wCPGkGLhp3WA
 KoPdk+JfUM4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="149177492"
X-IronPort-AV: E=Sophos;i="5.77,452,1596524400"; 
   d="scan'208";a="149177492"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 19:47:49 -0800
IronPort-SDR: +w4VFCjqnUVhyToK+ZRqR6d8sdWZxqfBtWFmDtBNVekM38LQIVHBP4YhHJ1ykfNzb83DEn/Rh0
 SP/9mxazqVZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,452,1596524400"; 
   d="scan'208";a="364203772"
Received: from lkp-server02.sh.intel.com (HELO e61783667810) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Nov 2020 19:47:47 -0800
Received: from kbuild by e61783667810 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kaWFX-0001DU-9m; Thu, 05 Nov 2020 03:47:47 +0000
Date:   Thu, 05 Nov 2020 11:47:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-next] BUILD SUCCESS
 724ec7c190c1893ea55fd7143e7e1c8c5b61a0e7
Message-ID: <5fa375d5.aXWgwZiphQFCOlLk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-next
branch HEAD: 724ec7c190c1893ea55fd7143e7e1c8c5b61a0e7  Merge 5.10-rc2 into tty-next

elapsed time: 724m

configs tested: 157
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                      bmips_stb_defconfig
powerpc                  storcenter_defconfig
arm                      pxa255-idp_defconfig
sh                             shx3_defconfig
powerpc                      makalu_defconfig
arm                        shmobile_defconfig
sh                           se7751_defconfig
arm                        vexpress_defconfig
mips                          ath25_defconfig
arm                            u300_defconfig
arm                           efm32_defconfig
arm                     davinci_all_defconfig
riscv                    nommu_k210_defconfig
sh                               alldefconfig
arm                          prima2_defconfig
powerpc                        fsp2_defconfig
sh                          rsk7269_defconfig
sh                   secureedge5410_defconfig
mips                        maltaup_defconfig
arm                          tango4_defconfig
parisc                           alldefconfig
powerpc               mpc834x_itxgp_defconfig
arm                           tegra_defconfig
mips                         cobalt_defconfig
openrisc                            defconfig
mips                         tb0226_defconfig
xtensa                              defconfig
alpha                            allyesconfig
powerpc                    sam440ep_defconfig
mips                         db1xxx_defconfig
arm                            pleb_defconfig
arm                        mvebu_v7_defconfig
sh                        sh7785lcr_defconfig
arm                        spear3xx_defconfig
powerpc                 mpc834x_itx_defconfig
ia64                                defconfig
mips                       capcella_defconfig
mips                       rbtx49xx_defconfig
arc                              alldefconfig
um                            kunit_defconfig
powerpc                      cm5200_defconfig
arc                            hsdk_defconfig
mips                        jmr3927_defconfig
powerpc                      ppc6xx_defconfig
arm                      integrator_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     mpc5200_defconfig
m68k                       m5475evb_defconfig
m68k                          atari_defconfig
sh                            titan_defconfig
arm                        clps711x_defconfig
sh                        edosk7760_defconfig
parisc                generic-64bit_defconfig
powerpc                     tqm8555_defconfig
i386                             alldefconfig
sh                           se7722_defconfig
powerpc                       holly_defconfig
mips                        bcm47xx_defconfig
mips                            gpr_defconfig
powerpc                     taishan_defconfig
arm                          ep93xx_defconfig
powerpc                      katmai_defconfig
m68k                       bvme6000_defconfig
sh                     sh7710voipgw_defconfig
arm                         orion5x_defconfig
riscv                    nommu_virt_defconfig
sh                   sh7724_generic_defconfig
powerpc                    klondike_defconfig
mips                       lemote2f_defconfig
riscv                            allmodconfig
mips                            ar7_defconfig
powerpc                        cell_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                  iss476-smp_defconfig
arm                          moxart_defconfig
m68k                             allmodconfig
arc                           tb10x_defconfig
arm                          gemini_defconfig
powerpc                     asp8347_defconfig
powerpc                      ppc64e_defconfig
powerpc                     tqm8548_defconfig
powerpc                     ksi8560_defconfig
arc                     nsimosci_hs_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201104
i386                 randconfig-a006-20201104
i386                 randconfig-a005-20201104
i386                 randconfig-a001-20201104
i386                 randconfig-a002-20201104
i386                 randconfig-a003-20201104
i386                 randconfig-a004-20201105
i386                 randconfig-a006-20201105
i386                 randconfig-a005-20201105
i386                 randconfig-a001-20201105
i386                 randconfig-a002-20201105
i386                 randconfig-a003-20201105
x86_64               randconfig-a012-20201104
x86_64               randconfig-a015-20201104
x86_64               randconfig-a013-20201104
x86_64               randconfig-a011-20201104
x86_64               randconfig-a014-20201104
x86_64               randconfig-a016-20201104
i386                 randconfig-a015-20201104
i386                 randconfig-a013-20201104
i386                 randconfig-a014-20201104
i386                 randconfig-a016-20201104
i386                 randconfig-a011-20201104
i386                 randconfig-a012-20201104
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201104
x86_64               randconfig-a003-20201104
x86_64               randconfig-a005-20201104
x86_64               randconfig-a002-20201104
x86_64               randconfig-a006-20201104
x86_64               randconfig-a001-20201104

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
