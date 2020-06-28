Return-Path: <SRS0=iRHZ=AJ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC9AC433E0
	for <linux-serial@archiver.kernel.org>; Sun, 28 Jun 2020 07:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70CCB20775
	for <linux-serial@archiver.kernel.org>; Sun, 28 Jun 2020 07:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgF1HKW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 28 Jun 2020 03:10:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:57027 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgF1HKW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 28 Jun 2020 03:10:22 -0400
IronPort-SDR: jWlM3cco5DHIX4uaizpC27dI9SGpb8YIqy4OfOFLi/2c/wfzUPnc4XVIdRFW/B5h5bNftIb9RG
 jxczdpRxih8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9665"; a="145800256"
X-IronPort-AV: E=Sophos;i="5.75,290,1589266800"; 
   d="scan'208";a="145800256"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2020 00:10:21 -0700
IronPort-SDR: z7bwRP+lwvD+hL0/T3tGvEx4YkN/9ZOfx5+y0GigRzLvyoQlv2B+Jyz4x5ABNwAKbnAtp1TiZq
 pgzrAKJSUsUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,290,1589266800"; 
   d="scan'208";a="312735393"
Received: from lkp-server02.sh.intel.com (HELO 1f25e51baad6) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jun 2020 00:10:20 -0700
Received: from kbuild by 1f25e51baad6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jpRSF-00003b-2y; Sun, 28 Jun 2020 07:10:19 +0000
Date:   Sun, 28 Jun 2020 15:09:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 890814504eeb930c15a1e238c3fff7dfc238b8c9
Message-ID: <5ef84229.g6abpcxLsOQzo2er%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: 890814504eeb930c15a1e238c3fff7dfc238b8c9  tty: fix spelling mistake

elapsed time: 725m

configs tested: 111
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
powerpc                     mpc5200_defconfig
m68k                            q40_defconfig
arm                           tegra_defconfig
mips                        vocore2_defconfig
arm                          simpad_defconfig
arm                         cm_x300_defconfig
sh                         microdev_defconfig
m68k                             allmodconfig
powerpc                       ppc64_defconfig
m68k                             alldefconfig
nios2                         10m50_defconfig
mips                     decstation_defconfig
arm                       versatile_defconfig
mips                          ath25_defconfig
mips                        nlm_xlp_defconfig
sparc                            allyesconfig
arm                       netwinder_defconfig
mips                    maltaup_xpa_defconfig
powerpc                    gamecube_defconfig
ia64                                defconfig
powerpc                      pasemi_defconfig
riscv                             allnoconfig
h8300                    h8300h-sim_defconfig
nds32                             allnoconfig
sparc64                          allmodconfig
h8300                       h8s-sim_defconfig
sh                          landisk_defconfig
sh                          kfr2r09_defconfig
mips                  maltasmvp_eva_defconfig
sh                         apsh4a3a_defconfig
openrisc                    or1ksim_defconfig
mips                           jazz_defconfig
x86_64                           alldefconfig
arm                         s3c2410_defconfig
powerpc                     mpc512x_defconfig
openrisc                 simple_smp_defconfig
sh                           cayman_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
um                               allyesconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
