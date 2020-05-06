Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81134C28CBC
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 22:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B7E82076D
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 22:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbgEFWtu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 18:49:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:14401 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbgEFWtt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 18:49:49 -0400
IronPort-SDR: niky/JzkjocOyTlFT5mYkD4neyA4Y4cLrBuAQJ8E9b5fL2KIA8VOY9m/WHrcdeDon59cU3CewI
 aG969BbIbpEg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 15:49:49 -0700
IronPort-SDR: FkMyHqsLogLGlWewiu+e1ByqD6XPVFl/2MIvxPs5gkvt6UKvZSoo1+D5zlIxqnjuAp/dQt6fo/
 f6T8m/REesUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,361,1583222400"; 
   d="scan'208";a="296350166"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 May 2020 15:49:48 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jWSrL-0002Cq-DD; Thu, 07 May 2020 06:49:47 +0800
Date:   Thu, 07 May 2020 06:49:07 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 57253ccd5831e7e5720c433437775c3e6b7d0c72
Message-ID: <5eb33ee3.0QErqQeLZnoCfiYB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: 57253ccd5831e7e5720c433437775c3e6b7d0c72  serial: samsung: 32-bit access for TX/RX hold registers

elapsed time: 607m

configs tested: 153
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                             allnoconfig
sparc                            allyesconfig
m68k                             allyesconfig
ia64                              allnoconfig
ia64                             allmodconfig
c6x                               allnoconfig
riscv                               defconfig
powerpc                             defconfig
csky                                defconfig
ia64                             alldefconfig
m68k                             allmodconfig
nds32                               defconfig
ia64                                defconfig
riscv                            allyesconfig
um                                  defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allyesconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                                defconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
openrisc                         allyesconfig
nds32                             allnoconfig
csky                             allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
microblaze                       allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          alldefconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
m68k                 randconfig-a001-20200506
mips                 randconfig-a001-20200506
nds32                randconfig-a001-20200506
parisc               randconfig-a001-20200506
alpha                randconfig-a001-20200506
riscv                randconfig-a001-20200506
h8300                randconfig-a001-20200507
nios2                randconfig-a001-20200507
microblaze           randconfig-a001-20200507
c6x                  randconfig-a001-20200507
sparc64              randconfig-a001-20200507
h8300                randconfig-a001-20200506
nios2                randconfig-a001-20200506
microblaze           randconfig-a001-20200506
c6x                  randconfig-a001-20200506
sparc64              randconfig-a001-20200506
s390                 randconfig-a001-20200506
xtensa               randconfig-a001-20200506
sh                   randconfig-a001-20200506
openrisc             randconfig-a001-20200506
csky                 randconfig-a001-20200506
xtensa               randconfig-a001-20200507
sh                   randconfig-a001-20200507
openrisc             randconfig-a001-20200507
csky                 randconfig-a001-20200507
i386                 randconfig-b003-20200506
i386                 randconfig-b001-20200506
x86_64               randconfig-b001-20200506
x86_64               randconfig-b003-20200506
i386                 randconfig-b002-20200506
x86_64               randconfig-a003-20200506
x86_64               randconfig-a001-20200506
x86_64               randconfig-a002-20200506
i386                 randconfig-a001-20200506
i386                 randconfig-a002-20200506
i386                 randconfig-a003-20200506
i386                 randconfig-d003-20200506
i386                 randconfig-d001-20200506
x86_64               randconfig-d002-20200506
i386                 randconfig-d002-20200506
i386                 randconfig-e003-20200506
x86_64               randconfig-e003-20200506
x86_64               randconfig-e001-20200506
i386                 randconfig-e002-20200506
i386                 randconfig-e001-20200506
i386                 randconfig-f003-20200506
x86_64               randconfig-f001-20200506
x86_64               randconfig-f003-20200506
x86_64               randconfig-f002-20200506
i386                 randconfig-f001-20200506
i386                 randconfig-f002-20200506
x86_64               randconfig-g003-20200506
i386                 randconfig-g003-20200506
i386                 randconfig-g002-20200506
x86_64               randconfig-g001-20200506
i386                 randconfig-g001-20200506
x86_64               randconfig-g002-20200506
i386                 randconfig-h002-20200506
i386                 randconfig-h001-20200506
i386                 randconfig-h003-20200506
x86_64               randconfig-h002-20200506
x86_64               randconfig-h003-20200506
x86_64               randconfig-h001-20200506
ia64                 randconfig-a001-20200506
arm64                randconfig-a001-20200506
arc                  randconfig-a001-20200506
powerpc              randconfig-a001-20200506
arm                  randconfig-a001-20200506
sparc                randconfig-a001-20200506
riscv                             allnoconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                             i386_defconfig
um                               allmodconfig
um                           x86_64_defconfig
um                               allyesconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
