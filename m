Return-Path: <SRS0=FrDw=4M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15660C38BE0
	for <linux-serial@archiver.kernel.org>; Mon, 24 Feb 2020 19:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2002080D
	for <linux-serial@archiver.kernel.org>; Mon, 24 Feb 2020 19:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgBXTDu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 24 Feb 2020 14:03:50 -0500
Received: from mga18.intel.com ([134.134.136.126]:4093 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgBXTDu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Feb 2020 14:03:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 11:03:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; 
   d="scan'208";a="284436545"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Feb 2020 11:03:45 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j6J17-0002Vx-RX; Tue, 25 Feb 2020 03:03:45 +0800
Date:   Tue, 25 Feb 2020 03:02:35 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 ba08cf452f3493e96793c9fec4ebb45e7101a0c0
Message-ID: <5e541dcb.9civieKIb3z98PJ8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: ba08cf452f3493e96793c9fec4ebb45e7101a0c0  Merge 5.6-rc3 into tty-next

elapsed time: 481m

configs tested: 170
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
ia64                                defconfig
parisc                generic-32bit_defconfig
nios2                         3c120_defconfig
parisc                generic-64bit_defconfig
powerpc                       ppc64_defconfig
mips                      fuloong2e_defconfig
riscv                    nommu_virt_defconfig
mips                             allmodconfig
arc                                 defconfig
s390                          debug_defconfig
h8300                    h8300h-sim_defconfig
s390                             allmodconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200224
x86_64               randconfig-a002-20200224
x86_64               randconfig-a003-20200224
i386                 randconfig-a001-20200224
i386                 randconfig-a002-20200224
i386                 randconfig-a003-20200224
alpha                randconfig-a001-20200224
m68k                 randconfig-a001-20200224
mips                 randconfig-a001-20200224
nds32                randconfig-a001-20200224
parisc               randconfig-a001-20200224
riscv                randconfig-a001-20200224
c6x                  randconfig-a001-20200224
h8300                randconfig-a001-20200224
microblaze           randconfig-a001-20200224
nios2                randconfig-a001-20200224
sparc64              randconfig-a001-20200224
csky                 randconfig-a001-20200224
openrisc             randconfig-a001-20200224
s390                 randconfig-a001-20200224
sh                   randconfig-a001-20200224
xtensa               randconfig-a001-20200224
x86_64               randconfig-b001-20200224
x86_64               randconfig-b002-20200224
x86_64               randconfig-b003-20200224
i386                 randconfig-b001-20200224
i386                 randconfig-b002-20200224
i386                 randconfig-b003-20200224
x86_64               randconfig-c001-20200224
x86_64               randconfig-c002-20200224
x86_64               randconfig-c003-20200224
i386                 randconfig-c001-20200224
i386                 randconfig-c002-20200224
i386                 randconfig-c003-20200224
x86_64               randconfig-d001-20200224
x86_64               randconfig-d002-20200224
x86_64               randconfig-d003-20200224
i386                 randconfig-d001-20200224
i386                 randconfig-d002-20200224
i386                 randconfig-d003-20200224
x86_64               randconfig-e001-20200224
x86_64               randconfig-e002-20200224
x86_64               randconfig-e003-20200224
i386                 randconfig-e001-20200224
i386                 randconfig-e002-20200224
i386                 randconfig-e003-20200224
x86_64               randconfig-f001-20200224
x86_64               randconfig-f002-20200224
x86_64               randconfig-f003-20200224
i386                 randconfig-f001-20200224
i386                 randconfig-f002-20200224
i386                 randconfig-f003-20200224
x86_64               randconfig-g001-20200224
x86_64               randconfig-g002-20200224
x86_64               randconfig-g003-20200224
i386                 randconfig-g001-20200224
i386                 randconfig-g002-20200224
i386                 randconfig-g003-20200224
x86_64               randconfig-g001-20200223
x86_64               randconfig-g002-20200223
x86_64               randconfig-g003-20200223
i386                 randconfig-g001-20200223
i386                 randconfig-g002-20200223
i386                 randconfig-g003-20200223
x86_64               randconfig-h001-20200224
x86_64               randconfig-h002-20200224
x86_64               randconfig-h003-20200224
i386                 randconfig-h001-20200224
i386                 randconfig-h002-20200224
i386                 randconfig-h003-20200224
arc                  randconfig-a001-20200224
arm                  randconfig-a001-20200224
arm64                randconfig-a001-20200224
ia64                 randconfig-a001-20200224
powerpc              randconfig-a001-20200224
sparc                randconfig-a001-20200224
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                              allnoconfig
s390                             allyesconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                             i386_defconfig
um                                  defconfig
um                           x86_64_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
