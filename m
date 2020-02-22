Return-Path: <SRS0=H3zm=4K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB11C35669
	for <linux-serial@archiver.kernel.org>; Sat, 22 Feb 2020 06:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6AD02071E
	for <linux-serial@archiver.kernel.org>; Sat, 22 Feb 2020 06:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgBVGpF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 22 Feb 2020 01:45:05 -0500
Received: from mga11.intel.com ([192.55.52.93]:29580 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbgBVGpF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 22 Feb 2020 01:45:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 22:45:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,471,1574150400"; 
   d="scan'208";a="349538413"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2020 22:45:03 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j5OX8-0005CX-Pn; Sat, 22 Feb 2020 14:45:02 +0800
Date:   Sat, 22 Feb 2020 14:43:47 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-next] BUILD SUCCESS
 3b3845bb6c78760e97f2d50cce5b527a0fc27ff3
Message-ID: <5e50cda3.mJXUxbdjoVTZti9K%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-next
branch HEAD: 3b3845bb6c78760e97f2d50cce5b527a0fc27ff3  tty: serial: samsung_tty: remove SERIAL_SAMSUNG_DEBUG

elapsed time: 2323m

configs tested: 279
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
openrisc                 simple_smp_defconfig
m68k                          multi_defconfig
nds32                             allnoconfig
powerpc                             defconfig
sh                               allmodconfig
sparc64                             defconfig
h8300                       h8s-sim_defconfig
mips                              allnoconfig
um                                  defconfig
arc                              allyesconfig
m68k                             allmodconfig
um                           x86_64_defconfig
m68k                           sun3_defconfig
ia64                             allyesconfig
x86_64                            allnoconfig
mips                             allmodconfig
i386                              allnoconfig
openrisc                    or1ksim_defconfig
parisc                generic-32bit_defconfig
c6x                              allyesconfig
h8300                     edosk2674_defconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
csky                                defconfig
nds32                               defconfig
h8300                    h8300h-sim_defconfig
m68k                       m5475evb_defconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200220
x86_64               randconfig-a002-20200220
i386                 randconfig-a002-20200220
x86_64               randconfig-a003-20200220
i386                 randconfig-a001-20200220
i386                 randconfig-a003-20200220
x86_64               randconfig-a001-20200221
x86_64               randconfig-a002-20200221
x86_64               randconfig-a003-20200221
i386                 randconfig-a001-20200221
i386                 randconfig-a002-20200221
i386                 randconfig-a003-20200221
x86_64               randconfig-a001-20200219
x86_64               randconfig-a002-20200219
x86_64               randconfig-a003-20200219
i386                 randconfig-a001-20200219
i386                 randconfig-a002-20200219
i386                 randconfig-a003-20200219
alpha                randconfig-a001-20200220
m68k                 randconfig-a001-20200220
mips                 randconfig-a001-20200220
nds32                randconfig-a001-20200220
parisc               randconfig-a001-20200220
riscv                randconfig-a001-20200220
alpha                randconfig-a001-20200221
m68k                 randconfig-a001-20200221
mips                 randconfig-a001-20200221
nds32                randconfig-a001-20200221
parisc               randconfig-a001-20200221
riscv                randconfig-a001-20200221
alpha                randconfig-a001-20200219
m68k                 randconfig-a001-20200219
nds32                randconfig-a001-20200219
parisc               randconfig-a001-20200219
riscv                randconfig-a001-20200219
alpha                randconfig-a001-20200222
m68k                 randconfig-a001-20200222
mips                 randconfig-a001-20200222
nds32                randconfig-a001-20200222
parisc               randconfig-a001-20200222
riscv                randconfig-a001-20200222
c6x                  randconfig-a001-20200221
h8300                randconfig-a001-20200221
microblaze           randconfig-a001-20200221
nios2                randconfig-a001-20200221
sparc64              randconfig-a001-20200221
c6x                  randconfig-a001-20200220
h8300                randconfig-a001-20200220
microblaze           randconfig-a001-20200220
nios2                randconfig-a001-20200220
sparc64              randconfig-a001-20200220
csky                 randconfig-a001-20200219
openrisc             randconfig-a001-20200219
s390                 randconfig-a001-20200219
xtensa               randconfig-a001-20200219
csky                 randconfig-a001-20200220
openrisc             randconfig-a001-20200220
s390                 randconfig-a001-20200220
sh                   randconfig-a001-20200220
xtensa               randconfig-a001-20200220
csky                 randconfig-a001-20200221
openrisc             randconfig-a001-20200221
s390                 randconfig-a001-20200221
sh                   randconfig-a001-20200221
xtensa               randconfig-a001-20200221
csky                 randconfig-a001-20200222
openrisc             randconfig-a001-20200222
s390                 randconfig-a001-20200222
sh                   randconfig-a001-20200222
xtensa               randconfig-a001-20200222
x86_64               randconfig-b001-20200220
x86_64               randconfig-b002-20200220
x86_64               randconfig-b003-20200220
i386                 randconfig-b001-20200220
i386                 randconfig-b002-20200220
i386                 randconfig-b003-20200220
x86_64               randconfig-b001-20200221
x86_64               randconfig-b002-20200221
x86_64               randconfig-b003-20200221
i386                 randconfig-b001-20200221
i386                 randconfig-b002-20200221
i386                 randconfig-b003-20200221
x86_64               randconfig-b001-20200219
x86_64               randconfig-b002-20200219
x86_64               randconfig-b003-20200219
i386                 randconfig-b001-20200219
i386                 randconfig-b002-20200219
i386                 randconfig-b003-20200219
x86_64               randconfig-c001-20200220
x86_64               randconfig-c002-20200220
x86_64               randconfig-c003-20200220
i386                 randconfig-c001-20200220
i386                 randconfig-c002-20200220
i386                 randconfig-c003-20200220
x86_64               randconfig-c001-20200221
x86_64               randconfig-c002-20200221
x86_64               randconfig-c003-20200221
i386                 randconfig-c001-20200221
i386                 randconfig-c002-20200221
i386                 randconfig-c003-20200221
x86_64               randconfig-d001-20200220
x86_64               randconfig-d002-20200220
x86_64               randconfig-d003-20200220
i386                 randconfig-d001-20200220
i386                 randconfig-d002-20200220
i386                 randconfig-d003-20200220
x86_64               randconfig-d001-20200221
x86_64               randconfig-d002-20200221
x86_64               randconfig-d003-20200221
i386                 randconfig-d001-20200221
i386                 randconfig-d002-20200221
i386                 randconfig-d003-20200221
x86_64               randconfig-e001-20200220
x86_64               randconfig-e002-20200220
x86_64               randconfig-e003-20200220
i386                 randconfig-e001-20200220
i386                 randconfig-e002-20200220
i386                 randconfig-e003-20200220
x86_64               randconfig-e001-20200219
x86_64               randconfig-e002-20200219
x86_64               randconfig-e003-20200219
i386                 randconfig-e001-20200219
i386                 randconfig-e002-20200219
i386                 randconfig-e003-20200219
x86_64               randconfig-e001-20200221
x86_64               randconfig-e002-20200221
x86_64               randconfig-e003-20200221
i386                 randconfig-e001-20200221
i386                 randconfig-e002-20200221
i386                 randconfig-e003-20200221
x86_64               randconfig-f001-20200220
x86_64               randconfig-f002-20200220
x86_64               randconfig-f003-20200220
i386                 randconfig-f001-20200220
i386                 randconfig-f002-20200220
i386                 randconfig-f003-20200220
x86_64               randconfig-f001-20200221
x86_64               randconfig-f002-20200221
x86_64               randconfig-f003-20200221
i386                 randconfig-f001-20200221
i386                 randconfig-f002-20200221
i386                 randconfig-f003-20200221
x86_64               randconfig-g001-20200220
x86_64               randconfig-g002-20200220
x86_64               randconfig-g003-20200220
i386                 randconfig-g001-20200220
i386                 randconfig-g002-20200220
i386                 randconfig-g003-20200220
x86_64               randconfig-g001-20200221
x86_64               randconfig-g002-20200221
x86_64               randconfig-g003-20200221
i386                 randconfig-g001-20200221
i386                 randconfig-g002-20200221
i386                 randconfig-g003-20200221
x86_64               randconfig-h001-20200219
x86_64               randconfig-h002-20200219
x86_64               randconfig-h003-20200219
i386                 randconfig-h001-20200219
i386                 randconfig-h002-20200219
i386                 randconfig-h003-20200219
x86_64               randconfig-h001-20200221
x86_64               randconfig-h002-20200221
x86_64               randconfig-h003-20200221
i386                 randconfig-h001-20200221
i386                 randconfig-h002-20200221
i386                 randconfig-h003-20200221
x86_64               randconfig-h001-20200220
x86_64               randconfig-h002-20200220
x86_64               randconfig-h003-20200220
i386                 randconfig-h001-20200220
i386                 randconfig-h002-20200220
i386                 randconfig-h003-20200220
arm64                randconfig-a001-20200220
ia64                 randconfig-a001-20200220
arm                  randconfig-a001-20200220
arc                  randconfig-a001-20200220
sparc                randconfig-a001-20200220
powerpc              randconfig-a001-20200220
arc                  randconfig-a001-20200221
arm                  randconfig-a001-20200221
arm64                randconfig-a001-20200221
ia64                 randconfig-a001-20200221
powerpc              randconfig-a001-20200221
sparc                randconfig-a001-20200221
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
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
