Return-Path: <SRS0=jxo+=BD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39850C433DF
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jul 2020 22:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A72F206F0
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jul 2020 22:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgGXWqI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Jul 2020 18:46:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:16634 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgGXWqI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Jul 2020 18:46:08 -0400
IronPort-SDR: zlVHDkIgGs5/EIYki2HuOnBsm9QpIJIMs1pqg+Ylu6a4EROq2lBQHRU/TpNfMIrVmFMvEFI1af
 c9WJaG72mZUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="148280005"
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="148280005"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 15:46:07 -0700
IronPort-SDR: UynvlEvn/L3NSzWTTy2vELl3ZeWwU50qlQ86Xi2eNexUsrI63bBxKceUvuTrkzXLmu3fyd9Gdz
 6ig9dig1qUbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="463378851"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Jul 2020 15:46:06 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jz6S5-0000bd-Qq; Fri, 24 Jul 2020 22:46:05 +0000
Date:   Sat, 25 Jul 2020 06:45:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 5fdbe136ae19ab751daaa4d08d9a42f3e30d17f9
Message-ID: <5f1b6484.Sr9G2tUefE+NvTEp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-linus
branch HEAD: 5fdbe136ae19ab751daaa4d08d9a42f3e30d17f9  serial: exar: Fix GPIO configuration for Sealevel cards based on XR17V35X

elapsed time: 726m

configs tested: 98
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
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
nds32                             allnoconfig
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
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a003-20200724
i386                 randconfig-a005-20200724
i386                 randconfig-a004-20200724
i386                 randconfig-a006-20200724
i386                 randconfig-a002-20200724
i386                 randconfig-a001-20200724
i386                 randconfig-a003-20200725
i386                 randconfig-a005-20200725
i386                 randconfig-a004-20200725
i386                 randconfig-a006-20200725
i386                 randconfig-a002-20200725
i386                 randconfig-a001-20200725
x86_64               randconfig-a014-20200724
x86_64               randconfig-a016-20200724
x86_64               randconfig-a015-20200724
x86_64               randconfig-a012-20200724
x86_64               randconfig-a013-20200724
x86_64               randconfig-a011-20200724
i386                 randconfig-a016-20200724
i386                 randconfig-a013-20200724
i386                 randconfig-a012-20200724
i386                 randconfig-a015-20200724
i386                 randconfig-a014-20200724
i386                 randconfig-a011-20200724
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
