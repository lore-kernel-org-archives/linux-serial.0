Return-Path: <SRS0=keEz=C2=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8638C43461
	for <linux-serial@archiver.kernel.org>; Thu, 17 Sep 2020 00:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D106206CA
	for <linux-serial@archiver.kernel.org>; Thu, 17 Sep 2020 00:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgIQAvq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Sep 2020 20:51:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:18602 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgIQAvo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Sep 2020 20:51:44 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 20:51:42 EDT
IronPort-SDR: /Z71qvlntY6UxvDj0nh9BYmyjJG0Vla8ipgWwzz1P/mxFGHr0umDz5IJhXN/uicmKCgQlmulVC
 L6ULFCBrGBxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="223777781"
X-IronPort-AV: E=Sophos;i="5.76,434,1592895600"; 
   d="scan'208";a="223777781"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 17:44:33 -0700
IronPort-SDR: tGS+y3TsiJEPsdmxVy0Anm7pEuy+SmuYWX6jxyVBSO794viU+9JICb81DMf0yYR5B2BxBWPlmG
 /6/TC/xaXqow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,434,1592895600"; 
   d="scan'208";a="336225313"
Received: from lkp-server02.sh.intel.com (HELO bdcb92cf8b4e) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Sep 2020 17:44:31 -0700
Received: from kbuild by bdcb92cf8b4e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kIi2J-0000KU-4c; Thu, 17 Sep 2020 00:44:31 +0000
Date:   Thu, 17 Sep 2020 08:44:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 23f87274f0ad4a9167de23a330ed88966634fdf6
Message-ID: <5f62b168.3mvhbZxFMQ+wUZyo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: 23f87274f0ad4a9167de23a330ed88966634fdf6  sticon: remove no-op sticon_set_origin()

elapsed time: 724m

configs tested: 125
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     redwood_defconfig
xtensa                    xip_kc705_defconfig
mips                 pnx8335_stb225_defconfig
mips                        qi_lb60_defconfig
parisc                generic-32bit_defconfig
arm                          pxa168_defconfig
arm                      integrator_defconfig
arc                     nsimosci_hs_defconfig
arm                         ebsa110_defconfig
openrisc                         alldefconfig
arm                      tct_hammer_defconfig
openrisc                 simple_smp_defconfig
arm                      jornada720_defconfig
arm                           corgi_defconfig
powerpc                 mpc8272_ads_defconfig
nios2                         10m50_defconfig
arm                        spear3xx_defconfig
arm                         socfpga_defconfig
sh                          r7785rp_defconfig
s390                             alldefconfig
mips                        nlm_xlp_defconfig
microblaze                    nommu_defconfig
sh                           se7780_defconfig
arm                         axm55xx_defconfig
mips                          rm200_defconfig
m68k                        stmark2_defconfig
arm                  colibri_pxa300_defconfig
arm                        clps711x_defconfig
sh                           se7724_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                    sam440ep_defconfig
arm                         at91_dt_defconfig
powerpc                     kilauea_defconfig
arm                          imote2_defconfig
powerpc                  mpc885_ads_defconfig
nios2                            allyesconfig
arm                           sama5_defconfig
sh                ecovec24-romimage_defconfig
powerpc                 mpc8313_rdb_defconfig
um                             i386_defconfig
powerpc                       holly_defconfig
arm                         assabet_defconfig
mips                      pistachio_defconfig
m68k                          multi_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                    klondike_defconfig
c6x                        evmc6472_defconfig
arc                        nsimosci_defconfig
mips                         tb0219_defconfig
arm                        mini2440_defconfig
arm                          lpd270_defconfig
mips                   sb1250_swarm_defconfig
sh                         apsh4a3a_defconfig
powerpc                       eiger_defconfig
powerpc                mpc7448_hpc2_defconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20200916
x86_64               randconfig-a004-20200916
x86_64               randconfig-a003-20200916
x86_64               randconfig-a002-20200916
x86_64               randconfig-a001-20200916
x86_64               randconfig-a005-20200916
i386                 randconfig-a004-20200916
i386                 randconfig-a006-20200916
i386                 randconfig-a003-20200916
i386                 randconfig-a001-20200916
i386                 randconfig-a002-20200916
i386                 randconfig-a005-20200916
i386                 randconfig-a015-20200916
i386                 randconfig-a014-20200916
i386                 randconfig-a011-20200916
i386                 randconfig-a013-20200916
i386                 randconfig-a016-20200916
i386                 randconfig-a012-20200916
riscv                            allyesconfig
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
x86_64               randconfig-a014-20200916
x86_64               randconfig-a011-20200916
x86_64               randconfig-a016-20200916
x86_64               randconfig-a012-20200916
x86_64               randconfig-a015-20200916
x86_64               randconfig-a013-20200916

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
