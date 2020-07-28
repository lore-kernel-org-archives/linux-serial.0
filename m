Return-Path: <SRS0=Ntbd=BH=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C1FC433DF
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jul 2020 20:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B78742070B
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jul 2020 20:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgG1UrL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:47:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:27214 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728453AbgG1UrL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jul 2020 16:47:11 -0400
IronPort-SDR: S8V6kO7mBLwU9D3c8gvBEaTHUSf0Rqf6/dL2tQpcOpLowXDX9Wto2sjVPYBlIe469rAhut/WA7
 HLWL3sMl8IkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="148770797"
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="148770797"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 13:47:10 -0700
IronPort-SDR: GKubtO7IXk7VQQEibUWZ7zHCPU6YOYSrK2zmzTpDHsaaq7YG84biauYoJ9PWk6YohB7V+3iy+2
 OcurX0Z8WwLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="328450941"
Received: from lkp-server01.sh.intel.com (HELO d27eb53fc52b) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jul 2020 13:47:08 -0700
Received: from kbuild by d27eb53fc52b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k0WV9-00013j-MV; Tue, 28 Jul 2020 20:47:07 +0000
Date:   Wed, 29 Jul 2020 04:46:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 dbaab9469b257f98723ff9eacddaac68706033a1
Message-ID: <5f208eac.lMmeyt6X+eYCUQZT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: dbaab9469b257f98723ff9eacddaac68706033a1  Merge 5.8-rc7 into tty-next

elapsed time: 1912m

configs tested: 54
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
nios2                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
sparc                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20200727
i386                 randconfig-a005-20200727
i386                 randconfig-a004-20200727
i386                 randconfig-a006-20200727
i386                 randconfig-a002-20200727
i386                 randconfig-a001-20200727
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
