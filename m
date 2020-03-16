Return-Path: <SRS0=SyHF=5B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49420C0044D
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 05:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C932051A
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 05:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgCPFZx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Mar 2020 01:25:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:27558 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729738AbgCPFZx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Mar 2020 01:25:53 -0400
IronPort-SDR: NR4086HeFQJceTap3PQ3q1Fg02ae0qN0LcQWkAMfMe/6+idyJnLLmy/Y5DFfVNWdiEhy0lWg7h
 WtzmhWzs72ZQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2020 22:25:53 -0700
IronPort-SDR: 3+guSCxBNiwXIK6RvIqdNJBS0TizshhtcE9cxo0PoySWflTcCPIeyXtwd5Dwmk4yxp77d4tEQy
 12zW89m2accw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,559,1574150400"; 
   d="scan'208";a="278919743"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 15 Mar 2020 22:25:51 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jDiG7-000F21-9u; Mon, 16 Mar 2020 13:25:51 +0800
Date:   Mon, 16 Mar 2020 13:25:35 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 1aa6e058dd6cd04471b1f21298270014daf48ac9
Message-ID: <5e6f0dcf.iAccwAgCzxUEoHVm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: 1aa6e058dd6cd04471b1f21298270014daf48ac9  vt: vt_ioctl: remove unnecessary console allocation checks

elapsed time: 4832m

configs tested: 182
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
i386                             allyesconfig
openrisc                    or1ksim_defconfig
h8300                       h8s-sim_defconfig
parisc                generic-32bit_defconfig
s390                             alldefconfig
um                                  defconfig
i386                             alldefconfig
sh                                allnoconfig
um                           x86_64_defconfig
ia64                                defconfig
powerpc                             defconfig
i386                              allnoconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
arm                              allmodconfig
arm64                            allmodconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200311
x86_64               randconfig-a002-20200311
x86_64               randconfig-a003-20200311
i386                 randconfig-a001-20200311
i386                 randconfig-a002-20200311
i386                 randconfig-a003-20200311
x86_64               randconfig-a001-20200313
x86_64               randconfig-a002-20200313
x86_64               randconfig-a003-20200313
i386                 randconfig-a001-20200313
i386                 randconfig-a002-20200313
i386                 randconfig-a003-20200313
alpha                randconfig-a001-20200312
m68k                 randconfig-a001-20200312
mips                 randconfig-a001-20200312
nds32                randconfig-a001-20200312
parisc               randconfig-a001-20200312
riscv                randconfig-a001-20200312
alpha                randconfig-a001-20200313
m68k                 randconfig-a001-20200313
mips                 randconfig-a001-20200313
nds32                randconfig-a001-20200313
parisc               randconfig-a001-20200313
riscv                randconfig-a001-20200313
h8300                randconfig-a001-20200312
sparc64              randconfig-a001-20200312
c6x                  randconfig-a001-20200312
nios2                randconfig-a001-20200312
microblaze           randconfig-a001-20200312
csky                 randconfig-a001-20200312
openrisc             randconfig-a001-20200312
s390                 randconfig-a001-20200312
sh                   randconfig-a001-20200312
xtensa               randconfig-a001-20200312
x86_64               randconfig-b001-20200311
x86_64               randconfig-b002-20200311
x86_64               randconfig-b003-20200311
i386                 randconfig-b001-20200311
i386                 randconfig-b002-20200311
i386                 randconfig-b003-20200311
x86_64               randconfig-c001-20200311
x86_64               randconfig-c002-20200311
x86_64               randconfig-c003-20200311
i386                 randconfig-c001-20200311
i386                 randconfig-c002-20200311
i386                 randconfig-c003-20200311
x86_64               randconfig-c001-20200313
x86_64               randconfig-c002-20200313
x86_64               randconfig-c003-20200313
i386                 randconfig-c001-20200313
i386                 randconfig-c002-20200313
i386                 randconfig-c003-20200313
x86_64               randconfig-d001-20200313
x86_64               randconfig-d002-20200313
x86_64               randconfig-d003-20200313
i386                 randconfig-d001-20200313
i386                 randconfig-d002-20200313
i386                 randconfig-d003-20200313
x86_64               randconfig-e001-20200312
x86_64               randconfig-e002-20200312
x86_64               randconfig-e003-20200312
i386                 randconfig-e001-20200312
i386                 randconfig-e002-20200312
i386                 randconfig-e003-20200312
x86_64               randconfig-e001-20200316
x86_64               randconfig-e002-20200316
x86_64               randconfig-e003-20200316
i386                 randconfig-e001-20200316
i386                 randconfig-e002-20200316
i386                 randconfig-e003-20200316
x86_64               randconfig-f001-20200312
x86_64               randconfig-f002-20200312
x86_64               randconfig-f003-20200312
i386                 randconfig-f001-20200312
i386                 randconfig-f002-20200312
i386                 randconfig-f003-20200312
x86_64               randconfig-h001-20200312
x86_64               randconfig-h002-20200312
x86_64               randconfig-h003-20200312
i386                 randconfig-h001-20200312
i386                 randconfig-h002-20200312
i386                 randconfig-h003-20200312
arc                  randconfig-a001-20200312
arm                  randconfig-a001-20200312
arm64                randconfig-a001-20200312
ia64                 randconfig-a001-20200312
powerpc              randconfig-a001-20200312
sparc                randconfig-a001-20200312
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                             i386_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
