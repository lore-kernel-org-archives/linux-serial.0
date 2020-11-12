Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2104C2D0E4
	for <linux-serial@archiver.kernel.org>; Thu, 12 Nov 2020 20:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50C2121D91
	for <linux-serial@archiver.kernel.org>; Thu, 12 Nov 2020 20:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgKLUsx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Nov 2020 15:48:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:61988 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgKLUsx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Nov 2020 15:48:53 -0500
IronPort-SDR: 1HUeNwfh9lC+Ey77qs6DLc3C/oDyNusXlUCxzpidOKj7zCWKP2qznsJxPkdpm7ZgR7ior5y8Yj
 u+FkUDwqaA1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="149649046"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="149649046"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 12:48:53 -0800
IronPort-SDR: 1cvNV3rkdZKzOpMBvvgWNmSUK8/CllXMFZGmc8nlDSCRRGN9ffufEIoujUJIuFGIGCFnR1Vt5G
 Uxk0HzTEzaEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="399528616"
Received: from lkp-server02.sh.intel.com (HELO 6c110fa9b5d1) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 12 Nov 2020 12:48:51 -0800
Received: from kbuild by 6c110fa9b5d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kdJWU-00004f-Is; Thu, 12 Nov 2020 20:48:50 +0000
Date:   Fri, 13 Nov 2020 04:48:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 1f78ae99790812481b7944cf40008aed5fd2ef18
Message-ID: <5fad9f88.D2Lg220MzkpJnlw3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: 1f78ae99790812481b7944cf40008aed5fd2ef18  serial: imx: Remove unused platform data support

elapsed time: 720m

configs tested: 175
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                       ebony_defconfig
m68k                          atari_defconfig
mips                        jmr3927_defconfig
sh                         microdev_defconfig
powerpc                      katmai_defconfig
sh                   sh7770_generic_defconfig
sh                            hp6xx_defconfig
riscv                            allmodconfig
arm                            u300_defconfig
sh                   rts7751r2dplus_defconfig
sh                          lboxre2_defconfig
powerpc                       maple_defconfig
sh                          polaris_defconfig
powerpc                     pq2fads_defconfig
sh                          kfr2r09_defconfig
arm                        mvebu_v5_defconfig
powerpc                      obs600_defconfig
arm                             rpc_defconfig
arm                        realview_defconfig
arm                           u8500_defconfig
mips                             allmodconfig
sh                           se7206_defconfig
arm                            qcom_defconfig
sh                            titan_defconfig
arm                        mini2440_defconfig
powerpc                     mpc512x_defconfig
mips                        workpad_defconfig
arc                                 defconfig
m68k                         apollo_defconfig
sh                ecovec24-romimage_defconfig
riscv                            alldefconfig
riscv                             allnoconfig
powerpc                     mpc5200_defconfig
arm                       aspeed_g4_defconfig
sh                           se7712_defconfig
um                            kunit_defconfig
powerpc                    mvme5100_defconfig
powerpc                   lite5200b_defconfig
arm                       cns3420vb_defconfig
csky                             alldefconfig
um                           x86_64_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                         tb0226_defconfig
sh                             shx3_defconfig
arm                           h3600_defconfig
m68k                        m5407c3_defconfig
m68k                        mvme16x_defconfig
xtensa                         virt_defconfig
arm                          gemini_defconfig
powerpc                      pasemi_defconfig
powerpc                      walnut_defconfig
mips                        vocore2_defconfig
arm                          imote2_defconfig
m68k                        m5307c3_defconfig
c6x                                 defconfig
sh                   secureedge5410_defconfig
mips                      pistachio_defconfig
ia64                      gensparse_defconfig
powerpc                     tqm8560_defconfig
nds32                            alldefconfig
powerpc64                           defconfig
arm                       imx_v6_v7_defconfig
arm                        cerfcube_defconfig
m68k                        mvme147_defconfig
sh                             sh03_defconfig
arm                   milbeaut_m10v_defconfig
arm                         nhk8815_defconfig
mips                malta_kvm_guest_defconfig
i386                             alldefconfig
mips                        maltaup_defconfig
powerpc                        warp_defconfig
arm                         mv78xx0_defconfig
arm                          moxart_defconfig
powerpc                     ep8248e_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                           sun3_defconfig
c6x                        evmc6474_defconfig
sh                           se7705_defconfig
arm                          collie_defconfig
mips                         cobalt_defconfig
c6x                        evmc6457_defconfig
powerpc                    socrates_defconfig
powerpc                 mpc832x_rdb_defconfig
m68k                         amcore_defconfig
mips                       lemote2f_defconfig
m68k                             alldefconfig
powerpc                      ep88xc_defconfig
arc                         haps_hs_defconfig
arm                      jornada720_defconfig
m68k                          hp300_defconfig
arm                         socfpga_defconfig
m68k                          sun3x_defconfig
sh                     magicpanelr2_defconfig
m68k                                defconfig
powerpc                           allnoconfig
arm64                            alldefconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     tqm8548_defconfig
sh                        sh7785lcr_defconfig
arm                         orion5x_defconfig
ia64                             allmodconfig
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
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a006-20201112
i386                 randconfig-a005-20201112
i386                 randconfig-a002-20201112
i386                 randconfig-a001-20201112
i386                 randconfig-a003-20201112
i386                 randconfig-a004-20201112
i386                 randconfig-a006-20201111
i386                 randconfig-a005-20201111
i386                 randconfig-a002-20201111
i386                 randconfig-a001-20201111
i386                 randconfig-a003-20201111
i386                 randconfig-a004-20201111
x86_64               randconfig-a015-20201111
x86_64               randconfig-a011-20201111
x86_64               randconfig-a014-20201111
x86_64               randconfig-a013-20201111
x86_64               randconfig-a016-20201111
x86_64               randconfig-a012-20201111
i386                 randconfig-a012-20201111
i386                 randconfig-a014-20201111
i386                 randconfig-a016-20201111
i386                 randconfig-a011-20201111
i386                 randconfig-a015-20201111
i386                 randconfig-a013-20201111
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201111
x86_64               randconfig-a005-20201111
x86_64               randconfig-a004-20201111
x86_64               randconfig-a002-20201111
x86_64               randconfig-a006-20201111
x86_64               randconfig-a001-20201111

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
