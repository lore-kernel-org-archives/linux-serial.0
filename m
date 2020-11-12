Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F26CC388F7
	for <linux-serial@archiver.kernel.org>; Thu, 12 Nov 2020 20:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38582216FD
	for <linux-serial@archiver.kernel.org>; Thu, 12 Nov 2020 20:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgKLUmy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Nov 2020 15:42:54 -0500
Received: from mga18.intel.com ([134.134.136.126]:21412 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbgKLUmy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Nov 2020 15:42:54 -0500
IronPort-SDR: DKnoM0IeYq4ZTJyn6D//7Gl76BXYALc11kLRysQ6LlXvkN9RR1mnVQYub59c1p55KFtubi7bKU
 qpvuBXcW//oA==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="158155000"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="158155000"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 12:42:52 -0800
IronPort-SDR: RUmWcoh584H+Z4+m6/uovSemrreQy2gtUShBRwfmvzcGmryfuFyVRs2fn/NsxElDptyudXaBqz
 Kta6eJKxLPCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="366489833"
Received: from lkp-server02.sh.intel.com (HELO 6c110fa9b5d1) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Nov 2020 12:42:50 -0800
Received: from kbuild by 6c110fa9b5d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kdJQg-00004W-4d; Thu, 12 Nov 2020 20:42:50 +0000
Date:   Fri, 13 Nov 2020 04:42:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 425af483523b76bc78e14674a430579d38b2a593
Message-ID: <5fad9e1e.7bKGwTkVKg8Jbq/4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-linus
branch HEAD: 425af483523b76bc78e14674a430579d38b2a593  serial: ar933x_uart: disable clk on error handling path in probe

elapsed time: 720m

configs tested: 140
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                            u300_defconfig
sh                   rts7751r2dplus_defconfig
sh                          lboxre2_defconfig
powerpc                      obs600_defconfig
m68k                          atari_defconfig
arm                             rpc_defconfig
arm                        realview_defconfig
arm                           u8500_defconfig
mips                             allmodconfig
sh                           se7206_defconfig
arm                            qcom_defconfig
sh                            titan_defconfig
arm                        mini2440_defconfig
powerpc                     mpc512x_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                 mpc8560_ads_defconfig
m68k                       bvme6000_defconfig
arm                        oxnas_v6_defconfig
powerpc                     mpc5200_defconfig
arm                       aspeed_g4_defconfig
mips                        workpad_defconfig
sh                           se7712_defconfig
um                            kunit_defconfig
m68k                         apollo_defconfig
powerpc                    mvme5100_defconfig
powerpc                   lite5200b_defconfig
arm                       cns3420vb_defconfig
arm                        mvebu_v5_defconfig
csky                             alldefconfig
m68k                        m5307c3_defconfig
c6x                                 defconfig
sh                   secureedge5410_defconfig
mips                      pistachio_defconfig
ia64                      gensparse_defconfig
powerpc                     tqm8560_defconfig
arm                       mainstone_defconfig
xtensa                    xip_kc705_defconfig
arm                         at91_dt_defconfig
arc                 nsimosci_hs_smp_defconfig
c6x                        evmc6474_defconfig
powerpc                      makalu_defconfig
sh                             sh03_defconfig
sh                         microdev_defconfig
arm                   milbeaut_m10v_defconfig
riscv                            allmodconfig
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
sh                           se7705_defconfig
arm                          collie_defconfig
mips                         cobalt_defconfig
arm                      tct_hammer_defconfig
mips                     decstation_defconfig
arm                          ixp4xx_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
alpha                            allyesconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201111
i386                 randconfig-a005-20201111
i386                 randconfig-a002-20201111
i386                 randconfig-a001-20201111
i386                 randconfig-a003-20201111
i386                 randconfig-a004-20201111
i386                 randconfig-a006-20201112
i386                 randconfig-a005-20201112
i386                 randconfig-a002-20201112
i386                 randconfig-a001-20201112
i386                 randconfig-a003-20201112
i386                 randconfig-a004-20201112
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
x86_64               randconfig-a003-20201111
x86_64               randconfig-a005-20201111
x86_64               randconfig-a004-20201111
x86_64               randconfig-a002-20201111
x86_64               randconfig-a006-20201111
x86_64               randconfig-a001-20201111

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
