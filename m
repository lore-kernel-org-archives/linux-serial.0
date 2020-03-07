Return-Path: <SRS0=D0ei=4Y=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1571EC10F00
	for <linux-serial@archiver.kernel.org>; Sat,  7 Mar 2020 16:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72F6206D5
	for <linux-serial@archiver.kernel.org>; Sat,  7 Mar 2020 16:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgCGQ73 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 7 Mar 2020 11:59:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:13116 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgCGQ73 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 7 Mar 2020 11:59:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2020 08:59:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,526,1574150400"; 
   d="scan'208";a="235164024"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Mar 2020 08:59:26 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jAcnN-0002Fu-Sb; Sun, 08 Mar 2020 00:59:25 +0800
Date:   Sun, 08 Mar 2020 00:58:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 d24e163af05c93e923aff76e01e6e30182cb38e3
Message-ID: <5e63d2c3.bESc64Rb7SwdmV5o%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: d24e163af05c93e923aff76e01e6e30182cb38e3  tty: mips_ejtag_fdc: Mark expected switch fall-through

elapsed time: 483m

configs tested: 147
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
m68k                           sun3_defconfig
h8300                     edosk2674_defconfig
c6x                              allyesconfig
h8300                       h8s-sim_defconfig
s390                              allnoconfig
riscv                    nommu_virt_defconfig
xtensa                          iss_defconfig
powerpc                       ppc64_defconfig
riscv                          rv32_defconfig
sparc                               defconfig
sh                                allnoconfig
m68k                             allmodconfig
alpha                               defconfig
mips                              allnoconfig
parisc                            allnoconfig
riscv                             allnoconfig
s390                       zfcpdump_defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                    h8300h-sim_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200307
x86_64               randconfig-a002-20200307
x86_64               randconfig-a003-20200307
i386                 randconfig-a001-20200307
i386                 randconfig-a002-20200307
i386                 randconfig-a003-20200307
riscv                randconfig-a001-20200307
alpha                randconfig-a001-20200307
m68k                 randconfig-a001-20200307
nds32                randconfig-a001-20200307
mips                 randconfig-a001-20200307
parisc               randconfig-a001-20200307
csky                 randconfig-a001-20200307
openrisc             randconfig-a001-20200307
s390                 randconfig-a001-20200307
sh                   randconfig-a001-20200307
xtensa               randconfig-a001-20200307
x86_64               randconfig-b002-20200307
x86_64               randconfig-b001-20200307
i386                 randconfig-b001-20200307
i386                 randconfig-b003-20200307
i386                 randconfig-b002-20200307
x86_64               randconfig-b003-20200307
x86_64               randconfig-c001-20200307
x86_64               randconfig-c002-20200307
x86_64               randconfig-c003-20200307
i386                 randconfig-c001-20200307
i386                 randconfig-c002-20200307
i386                 randconfig-c003-20200307
x86_64               randconfig-d001-20200307
x86_64               randconfig-d002-20200307
x86_64               randconfig-d003-20200307
i386                 randconfig-d001-20200307
i386                 randconfig-d002-20200307
i386                 randconfig-d003-20200307
x86_64               randconfig-e001-20200307
x86_64               randconfig-e002-20200307
x86_64               randconfig-e003-20200307
i386                 randconfig-e001-20200307
i386                 randconfig-e002-20200307
i386                 randconfig-e003-20200307
x86_64               randconfig-f001-20200307
x86_64               randconfig-f002-20200307
x86_64               randconfig-f003-20200307
i386                 randconfig-f001-20200307
i386                 randconfig-f002-20200307
i386                 randconfig-f003-20200307
arc                  randconfig-a001-20200307
arm                  randconfig-a001-20200307
arm64                randconfig-a001-20200307
ia64                 randconfig-a001-20200307
powerpc              randconfig-a001-20200307
sparc                randconfig-a001-20200307
riscv                            allmodconfig
riscv                            allyesconfig
riscv                               defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                            allyesconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                                  defconfig
um                             i386_defconfig
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
