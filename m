Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D52FC2D0E4
	for <linux-serial@archiver.kernel.org>; Fri, 27 Nov 2020 08:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B78CE2223C
	for <linux-serial@archiver.kernel.org>; Fri, 27 Nov 2020 08:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgK0I3v (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 Nov 2020 03:29:51 -0500
Received: from mga12.intel.com ([192.55.52.136]:35532 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbgK0I3u (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Nov 2020 03:29:50 -0500
IronPort-SDR: D7XtT5jSu+CaeRtThVWs/eOxGKn5fwLhBFsu64NnIq6cDrYdkUd7ediOvL9FttLyoMjju9H8sa
 EZhbjZizoR8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9817"; a="151623023"
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="151623023"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2020 00:29:50 -0800
IronPort-SDR: FklEjG8ddeR4Wf07vKume1XkMwZxYN1bAwrIKqBb1cxtW4BCj4WcDtzkSxD3E9ZQeOpWIWlZtr
 6H9bTQrf7uRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="359749265"
Received: from lkp-server02.sh.intel.com (HELO c88ef3cb410b) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2020 00:29:48 -0800
Received: from kbuild by c88ef3cb410b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kiZ8W-00003D-3b; Fri, 27 Nov 2020 08:29:48 +0000
Date:   Fri, 27 Nov 2020 16:29:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS WITH WARNING
 f35a07f92616700733636c06dd6e5b6cdc807fe4
Message-ID: <5fc0b8db.+mYJZL5cdoxZk8g6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: f35a07f92616700733636c06dd6e5b6cdc807fe4  tty: serial: bcm63xx: lower driver dependencies

Warning reports:

https://lore.kernel.org/linux-serial/202011270526.uhlQ2Ov9-lkp@intel.com

Warning in current branch:

drivers/tty/serial/mxs-auart.c:1656:15: warning: cast to smaller integer type 'enum mxs_auart_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]

Warning ids grouped by kconfigs:

clang_recent_errors
`-- riscv-randconfig-r001-20201127
    `-- drivers-tty-serial-mxs-auart.c:warning:cast-to-smaller-integer-type-enum-mxs_auart_type-from-const-void

elapsed time: 725m

configs tested: 130
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
h8300                       h8s-sim_defconfig
powerpc                 mpc834x_itx_defconfig
sh                          rsk7203_defconfig
arm                         lubbock_defconfig
sparc                       sparc32_defconfig
powerpc                 mpc837x_mds_defconfig
arc                          axs101_defconfig
mips                      pic32mzda_defconfig
arm                       imx_v6_v7_defconfig
powerpc64                        alldefconfig
sh                   sh7724_generic_defconfig
m68k                        m5307c3_defconfig
csky                             alldefconfig
xtensa                          iss_defconfig
powerpc                      ep88xc_defconfig
powerpc                        fsp2_defconfig
powerpc                      acadia_defconfig
xtensa                    xip_kc705_defconfig
parisc                generic-32bit_defconfig
arm                        magician_defconfig
powerpc                   currituck_defconfig
powerpc                     tqm8548_defconfig
sh                            migor_defconfig
powerpc                     skiroot_defconfig
parisc                           allyesconfig
arm                           corgi_defconfig
arc                              allyesconfig
sh                            titan_defconfig
mips                   sb1250_swarm_defconfig
powerpc                     mpc5200_defconfig
powerpc                      chrp32_defconfig
arm                      tct_hammer_defconfig
powerpc                     rainier_defconfig
m68k                        mvme147_defconfig
c6x                                 defconfig
powerpc                      katmai_defconfig
arm                         assabet_defconfig
c6x                        evmc6474_defconfig
mips                        nlm_xlp_defconfig
powerpc                      pasemi_defconfig
sparc                               defconfig
sh                ecovec24-romimage_defconfig
arc                    vdk_hs38_smp_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      arches_defconfig
x86_64                           alldefconfig
sh                             shx3_defconfig
powerpc                        cell_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                         tb0287_defconfig
nios2                         10m50_defconfig
mips                         db1xxx_defconfig
mips                            gpr_defconfig
arm                              alldefconfig
powerpc                  mpc885_ads_defconfig
sh                         microdev_defconfig
arm                          tango4_defconfig
arc                          axs103_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201127
i386                 randconfig-a003-20201127
i386                 randconfig-a002-20201127
i386                 randconfig-a005-20201127
i386                 randconfig-a001-20201127
i386                 randconfig-a006-20201127
x86_64               randconfig-a015-20201127
x86_64               randconfig-a011-20201127
x86_64               randconfig-a014-20201127
x86_64               randconfig-a016-20201127
x86_64               randconfig-a012-20201127
x86_64               randconfig-a013-20201127
i386                 randconfig-a012-20201127
i386                 randconfig-a013-20201127
i386                 randconfig-a011-20201127
i386                 randconfig-a016-20201127
i386                 randconfig-a014-20201127
i386                 randconfig-a015-20201127
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20201127
x86_64               randconfig-a003-20201127
x86_64               randconfig-a004-20201127
x86_64               randconfig-a005-20201127
x86_64               randconfig-a002-20201127
x86_64               randconfig-a001-20201127

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
