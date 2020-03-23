Return-Path: <SRS0=3mQv=5I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01EAC3F2CD
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 15:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8792D20714
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 15:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgCWPKc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:10:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:29009 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbgCWPKb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Mar 2020 11:10:31 -0400
IronPort-SDR: 1DMRJuzAxiamPIsx7/f530hQdmFYT5GBi3UvLQuFHd+AmuvMVgzxx8wStIjX1IUewTSnOD6aPQ
 HcVald12XTmQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 08:10:31 -0700
IronPort-SDR: 5wFksTlhR4nmLKBrvwbP15IYLfu6GtnaGeBtZxqN4RP5nZTv7VyT/w9zAH+AV9P93pCRsuoq52
 bHGSdAad9JTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,296,1580803200"; 
   d="scan'208";a="292598041"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Mar 2020 08:10:25 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jGOie-0009W9-O2; Mon, 23 Mar 2020 23:10:24 +0800
Date:   Mon, 23 Mar 2020 23:09:40 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 cbf580ff093861f021b31b2f8d0f03173fb58520
Message-ID: <5e78d134.x9MBmfIzUelrMbPc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: cbf580ff093861f021b31b2f8d0f03173fb58520  Merge 5.6-rc7 into tty-next

elapsed time: 483m

configs tested: 179
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
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
ia64                                defconfig
powerpc                             defconfig
h8300                     edosk2674_defconfig
microblaze                    nommu_defconfig
xtensa                          iss_defconfig
h8300                       h8s-sim_defconfig
i386                             allyesconfig
m68k                       m5475evb_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                                 defconfig
arc                              allyesconfig
microblaze                      mmu_defconfig
powerpc                           allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200323
x86_64               randconfig-a002-20200323
x86_64               randconfig-a003-20200323
i386                 randconfig-a001-20200323
i386                 randconfig-a002-20200323
i386                 randconfig-a003-20200323
x86_64               randconfig-a001-20200322
x86_64               randconfig-a002-20200322
x86_64               randconfig-a003-20200322
i386                 randconfig-a001-20200322
i386                 randconfig-a002-20200322
i386                 randconfig-a003-20200322
mips                 randconfig-a001-20200323
nds32                randconfig-a001-20200323
m68k                 randconfig-a001-20200323
parisc               randconfig-a001-20200323
alpha                randconfig-a001-20200323
riscv                randconfig-a001-20200323
c6x                  randconfig-a001-20200323
h8300                randconfig-a001-20200323
microblaze           randconfig-a001-20200323
nios2                randconfig-a001-20200323
sparc64              randconfig-a001-20200323
c6x                  randconfig-a001-20200322
h8300                randconfig-a001-20200322
microblaze           randconfig-a001-20200322
nios2                randconfig-a001-20200322
sparc64              randconfig-a001-20200322
csky                 randconfig-a001-20200323
openrisc             randconfig-a001-20200323
s390                 randconfig-a001-20200323
sh                   randconfig-a001-20200323
xtensa               randconfig-a001-20200323
x86_64               randconfig-b001-20200323
x86_64               randconfig-b002-20200323
x86_64               randconfig-b003-20200323
i386                 randconfig-b001-20200323
i386                 randconfig-b002-20200323
i386                 randconfig-b003-20200323
x86_64               randconfig-c003-20200323
x86_64               randconfig-c001-20200323
i386                 randconfig-c002-20200323
x86_64               randconfig-c002-20200323
i386                 randconfig-c003-20200323
i386                 randconfig-c001-20200323
x86_64               randconfig-d001-20200323
x86_64               randconfig-d002-20200323
x86_64               randconfig-d003-20200323
i386                 randconfig-d001-20200323
i386                 randconfig-d002-20200323
i386                 randconfig-d003-20200323
x86_64               randconfig-e001-20200323
x86_64               randconfig-e002-20200323
x86_64               randconfig-e003-20200323
i386                 randconfig-e001-20200323
i386                 randconfig-e002-20200323
i386                 randconfig-e003-20200323
x86_64               randconfig-f001-20200322
x86_64               randconfig-f002-20200322
x86_64               randconfig-f003-20200322
i386                 randconfig-f001-20200322
i386                 randconfig-f002-20200322
i386                 randconfig-f003-20200322
x86_64               randconfig-f001-20200323
x86_64               randconfig-f002-20200323
x86_64               randconfig-f003-20200323
i386                 randconfig-f001-20200323
i386                 randconfig-f002-20200323
i386                 randconfig-f003-20200323
i386                 randconfig-g003-20200323
i386                 randconfig-g001-20200323
i386                 randconfig-g002-20200323
x86_64               randconfig-g001-20200323
x86_64               randconfig-g003-20200323
x86_64               randconfig-g002-20200323
x86_64               randconfig-h001-20200323
x86_64               randconfig-h002-20200323
x86_64               randconfig-h003-20200323
i386                 randconfig-h001-20200323
i386                 randconfig-h002-20200323
i386                 randconfig-h003-20200323
arm                  randconfig-a001-20200323
powerpc              randconfig-a001-20200323
arm64                randconfig-a001-20200323
ia64                 randconfig-a001-20200323
sparc                randconfig-a001-20200323
arc                  randconfig-a001-20200323
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                                defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
