Return-Path: <SRS0=aTVb=7K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB736C433DF
	for <linux-serial@archiver.kernel.org>; Thu, 28 May 2020 05:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D3602084C
	for <linux-serial@archiver.kernel.org>; Thu, 28 May 2020 05:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgE1F6T (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 May 2020 01:58:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:28889 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgE1F6T (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 May 2020 01:58:19 -0400
IronPort-SDR: 2eXUPsl0rXA2mA40PV9HJnVg6j0SY9wUvkxJGvB2lG4HPofrvymTIQxHfXKUH7p+dRuitQvPzH
 GY2XdVGknX1Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 22:58:17 -0700
IronPort-SDR: jrMom2fRECI5ixLv1a3WpygCU9oUkrveinTi5bYiMqXIsfzl0Owl73qmhQxz2YePqm8GAioRR4
 fcdoL/9bHxsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; 
   d="scan'208";a="469019051"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 27 May 2020 22:58:16 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jeBYV-0008XN-Ms; Thu, 28 May 2020 13:58:15 +0800
Date:   Thu, 28 May 2020 13:57:34 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 b86dab054059b970111b5516ae548efaae5b3aae
Message-ID: <5ecf52ce.w1Cv7HnCJlgJvUIY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: b86dab054059b970111b5516ae548efaae5b3aae  vt: keyboard: avoid signed integer overflow in k_ascii

elapsed time: 1173m

configs tested: 91
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
sh                           se7724_defconfig
arm                            mmp2_defconfig
mips                        maltaup_defconfig
arm                        realview_defconfig
arm                      footbridge_defconfig
arm                      jornada720_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                              allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                              allnoconfig
m68k                             allmodconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                            allyesconfig
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
nios2                               defconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                           allyesconfig
parisc                           allmodconfig
parisc                            allnoconfig
parisc                              defconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20200527
i386                 randconfig-a004-20200527
i386                 randconfig-a003-20200527
i386                 randconfig-a006-20200527
i386                 randconfig-a002-20200527
i386                 randconfig-a005-20200527
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
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
um                                allnoconfig
um                               allyesconfig
um                               allmodconfig
um                                  defconfig
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
