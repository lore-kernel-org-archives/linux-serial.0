Return-Path: <SRS0=PCYV=4X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9676EC10DCE
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 21:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612FA206E6
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 21:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgCFVLM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Mar 2020 16:11:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:30711 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgCFVLL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Mar 2020 16:11:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 13:11:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,523,1574150400"; 
   d="scan'208";a="275691082"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Mar 2020 13:11:09 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jAKFQ-000AAD-RL; Sat, 07 Mar 2020 05:11:08 +0800
Date:   Sat, 07 Mar 2020 05:11:03 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD REGRESSION
 8434c477300896e50907650a7476116249030b16
Message-ID: <5e62bc67.L5nVVFXwiuJE2P3O%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: 8434c477300896e50907650a7476116249030b16  tty: mips_ejtag_fdc: Mark expected switch fall-through

Regressions in current branch:

drivers/tty/serial/sifive.c:904:19: error: 'sifive_serial_poll_get_char' undeclared here (not in a function); did you mean 'sifive_serial_clk_notifier'?
drivers/tty/serial/sifive.c:905:19: error: 'sifive_serial_poll_put_char' undeclared here (not in a function); did you mean 'sifive_serial_poll_get_char'?

Error ids grouped by kconfigs:

recent_errors
|-- arm-allmodconfig
|   |-- drivers-tty-serial-sifive.c:error:sifive_serial_poll_get_char-undeclared-here-(not-in-a-function)-did-you-mean-sifive_serial_clk_notifier
|   `-- drivers-tty-serial-sifive.c:error:sifive_serial_poll_put_char-undeclared-here-(not-in-a-function)-did-you-mean-sifive_serial_poll_get_char
|-- arm64-allmodconfig
|   |-- drivers-tty-serial-sifive.c:error:sifive_serial_poll_get_char-undeclared-here-(not-in-a-function)-did-you-mean-sifive_serial_clk_notifier
|   `-- drivers-tty-serial-sifive.c:error:sifive_serial_poll_put_char-undeclared-here-(not-in-a-function)-did-you-mean-sifive_serial_poll_get_char
|-- i386-allmodconfig
|   |-- drivers-tty-serial-sifive.c:error:sifive_serial_poll_get_char-undeclared-here-(not-in-a-function)-did-you-mean-sifive_serial_clk_notifier
|   `-- drivers-tty-serial-sifive.c:error:sifive_serial_poll_put_char-undeclared-here-(not-in-a-function)-did-you-mean-sifive_serial_poll_get_char
|-- mips-allmodconfig
|   |-- drivers-tty-serial-sifive.c:error:sifive_serial_poll_get_char-undeclared-here-(not-in-a-function)-did-you-mean-sifive_serial_clk_notifier
|   `-- drivers-tty-serial-sifive.c:error:sifive_serial_poll_put_char-undeclared-here-(not-in-a-function)-did-you-mean-sifive_serial_poll_get_char
|-- sh-allmodconfig
|   |-- drivers-tty-serial-sifive.c:error:sifive_serial_poll_get_char-undeclared-here-(not-in-a-function)-did-you-mean-sifive_serial_clk_notifier
|   `-- drivers-tty-serial-sifive.c:error:sifive_serial_poll_put_char-undeclared-here-(not-in-a-function)-did-you-mean-sifive_serial_poll_get_char
`-- sparc64-allmodconfig
    |-- drivers-tty-serial-sifive.c:error:sifive_serial_poll_get_char-undeclared-here-(not-in-a-function)-did-you-mean-sifive_serial_clk_notifier
    `-- drivers-tty-serial-sifive.c:error:sifive_serial_poll_put_char-undeclared-here-(not-in-a-function)-did-you-mean-sifive_serial_poll_get_char

elapsed time: 482m

configs tested: 161
configs skipped: 0

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
h8300                    h8300h-sim_defconfig
alpha                               defconfig
ia64                             allmodconfig
csky                                defconfig
ia64                             allyesconfig
i386                             alldefconfig
c6x                        evmc6678_defconfig
m68k                          multi_defconfig
s390                       zfcpdump_defconfig
h8300                     edosk2674_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             alldefconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
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
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200305
x86_64               randconfig-a002-20200305
x86_64               randconfig-a003-20200305
i386                 randconfig-a001-20200305
i386                 randconfig-a002-20200305
i386                 randconfig-a003-20200305
riscv                randconfig-a001-20200306
alpha                randconfig-a001-20200306
m68k                 randconfig-a001-20200306
nds32                randconfig-a001-20200306
mips                 randconfig-a001-20200306
csky                 randconfig-a001-20200305
openrisc             randconfig-a001-20200305
s390                 randconfig-a001-20200305
sh                   randconfig-a001-20200305
xtensa               randconfig-a001-20200305
x86_64               randconfig-b001-20200306
x86_64               randconfig-b002-20200306
x86_64               randconfig-b003-20200306
i386                 randconfig-b001-20200306
i386                 randconfig-b002-20200306
i386                 randconfig-b003-20200306
x86_64               randconfig-b001-20200305
x86_64               randconfig-b002-20200305
x86_64               randconfig-b003-20200305
i386                 randconfig-b001-20200305
i386                 randconfig-b002-20200305
i386                 randconfig-b003-20200305
i386                 randconfig-c002-20200305
x86_64               randconfig-c003-20200305
i386                 randconfig-c001-20200305
x86_64               randconfig-c002-20200305
i386                 randconfig-c003-20200305
x86_64               randconfig-c001-20200305
x86_64               randconfig-d003-20200306
i386                 randconfig-d001-20200306
x86_64               randconfig-d001-20200306
i386                 randconfig-d003-20200306
i386                 randconfig-d002-20200306
x86_64               randconfig-d002-20200306
i386                 randconfig-e001-20200305
i386                 randconfig-e003-20200305
x86_64               randconfig-e002-20200305
x86_64               randconfig-e001-20200305
x86_64               randconfig-e003-20200305
i386                 randconfig-e002-20200305
i386                 randconfig-f003-20200305
x86_64               randconfig-f001-20200305
i386                 randconfig-f001-20200305
i386                 randconfig-f002-20200305
x86_64               randconfig-f002-20200305
x86_64               randconfig-f003-20200305
x86_64               randconfig-f001-20200306
x86_64               randconfig-f002-20200306
x86_64               randconfig-f003-20200306
i386                 randconfig-f001-20200306
i386                 randconfig-f002-20200306
i386                 randconfig-f003-20200306
arc                  randconfig-a001-20200307
arm                  randconfig-a001-20200307
arm64                randconfig-a001-20200307
ia64                 randconfig-a001-20200307
powerpc              randconfig-a001-20200307
sparc                randconfig-a001-20200307
arc                  randconfig-a001-20200306
ia64                 randconfig-a001-20200306
sparc                randconfig-a001-20200306
arm                  randconfig-a001-20200306
arm64                randconfig-a001-20200306
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
