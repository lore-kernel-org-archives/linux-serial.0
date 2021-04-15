Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093FBC433ED
	for <linux-serial@archiver.kernel.org>; Thu, 15 Apr 2021 21:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5877600EF
	for <linux-serial@archiver.kernel.org>; Thu, 15 Apr 2021 21:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbhDOVoX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Apr 2021 17:44:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:20057 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235892AbhDOVoX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Apr 2021 17:44:23 -0400
IronPort-SDR: N/GIuOyzr9CiC8JUpW/V6QR/vVnqqsy9zKz0kTpVe6Zieaz6v4OE9HU+aGCiBQcILHy8kLxi4p
 t6LvxeL+UqRQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="194508480"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="194508480"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 14:43:59 -0700
IronPort-SDR: op1mWnB4RbhEC6jjTkEKvuV9v6wqznH0oBrTw/ZcuKO5rYfFduRfMDK3twpm7dGA1mfr3+p245
 n5i8rm0KV5Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="389854575"
Received: from lkp-server02.sh.intel.com (HELO fa9c8fcc3464) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 15 Apr 2021 14:43:58 -0700
Received: from kbuild by fa9c8fcc3464 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lX9mI-00017s-12; Thu, 15 Apr 2021 21:43:58 +0000
Date:   Fri, 16 Apr 2021 05:43:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty_msg_cleanup] BUILD SUCCESS
 f37d7eed9dd8074c05110dcbd57764c622d2e263
Message-ID: <6078b389.B4Rj6Yz5btzlqkhz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty_msg_cleanup
branch HEAD: f37d7eed9dd8074c05110dcbd57764c622d2e263  tty: remove tty_driver_name()

elapsed time: 733m

configs tested: 141
configs skipped: 2

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
i386                             allyesconfig
riscv                            allyesconfig
xtensa                    xip_kc705_defconfig
sparc64                          alldefconfig
ia64                      gensparse_defconfig
arc                          axs103_defconfig
powerpc                    amigaone_defconfig
mips                        qi_lb60_defconfig
powerpc                 canyonlands_defconfig
m68k                             alldefconfig
arc                         haps_hs_defconfig
powerpc                      ppc64e_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      makalu_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     mpc5200_defconfig
sh                         apsh4a3a_defconfig
powerpc                     taishan_defconfig
s390                             alldefconfig
arm                          pxa168_defconfig
um                                allnoconfig
sh                          polaris_defconfig
m68k                        m5307c3_defconfig
ia64                            zx1_defconfig
sh                           se7619_defconfig
arm                       spear13xx_defconfig
arm                           corgi_defconfig
powerpc                     ep8248e_defconfig
arm                       netwinder_defconfig
powerpc                      katmai_defconfig
arm                       multi_v4t_defconfig
powerpc                   lite5200b_defconfig
arm                         vf610m4_defconfig
sh                            shmin_defconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                     tqm8555_defconfig
arm                          iop32x_defconfig
sh                           sh2007_defconfig
powerpc                     stx_gp3_defconfig
arm                          moxart_defconfig
arm                           sama5_defconfig
powerpc                 mpc836x_mds_defconfig
arm                         cm_x300_defconfig
sh                          rsk7203_defconfig
arm                          pxa910_defconfig
arm                           sunxi_defconfig
powerpc                     redwood_defconfig
powerpc                      arches_defconfig
m68k                        m5272c3_defconfig
powerpc                   bluestone_defconfig
arm                          lpd270_defconfig
mips                        nlm_xlp_defconfig
i386                                defconfig
arm                           h3600_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
arc                           tb10x_defconfig
arc                        vdk_hs38_defconfig
powerpc                    mvme5100_defconfig
mips                       capcella_defconfig
arm                          ixp4xx_defconfig
sh                        edosk7705_defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc834x_itx_defconfig
mips                         db1xxx_defconfig
sh                   rts7751r2dplus_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210415
x86_64               randconfig-a002-20210415
x86_64               randconfig-a005-20210415
x86_64               randconfig-a001-20210415
x86_64               randconfig-a006-20210415
x86_64               randconfig-a004-20210415
i386                 randconfig-a003-20210415
i386                 randconfig-a006-20210415
i386                 randconfig-a001-20210415
i386                 randconfig-a005-20210415
i386                 randconfig-a004-20210415
i386                 randconfig-a002-20210415
i386                 randconfig-a015-20210415
i386                 randconfig-a014-20210415
i386                 randconfig-a013-20210415
i386                 randconfig-a012-20210415
i386                 randconfig-a016-20210415
i386                 randconfig-a011-20210415
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210415
x86_64               randconfig-a015-20210415
x86_64               randconfig-a011-20210415
x86_64               randconfig-a013-20210415
x86_64               randconfig-a012-20210415
x86_64               randconfig-a016-20210415

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
