Return-Path: <SRS0=2ftc=BC=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FE7C433E0
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jul 2020 12:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2AE20768
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jul 2020 12:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGWMBX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:01:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:44345 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgGWMBX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Jul 2020 08:01:23 -0400
IronPort-SDR: sstIwUPqNpdLPohAQSryjY48sJeuZW7SfanM2wrKg53hMFpkFqSdhCKdQk8T1NmKy/8O+V9vyl
 bC1G3yvgyvJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="148000863"
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="148000863"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 05:01:22 -0700
IronPort-SDR: cgmmzoU2HdY6G1YXpLxtfhJZj7Zy+VD63bWD0lv+6NN6NW+/fE09sn6Nk2fXvHzs+Ycst0RWMd
 Wcogo26q0IkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="318972050"
Received: from lkp-server01.sh.intel.com (HELO bd1a4a62506a) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Jul 2020 05:01:18 -0700
Received: from kbuild by bd1a4a62506a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jyZuV-0000R7-DX; Thu, 23 Jul 2020 12:01:15 +0000
Date:   Thu, 23 Jul 2020 20:00:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 bd78ecd6056d9987067db5b100d3667da6b85467
Message-ID: <5f197be6.ZSZgFLGFeZeiM+kO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: bd78ecd6056d9987067db5b100d3667da6b85467  serial: imx: use hrtimers for rs485 delays

elapsed time: 2445m

configs tested: 84
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
arm                         shannon_defconfig
powerpc                       ppc64_defconfig
arm                      footbridge_defconfig
s390                             alldefconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
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
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a014-20200720
x86_64               randconfig-a015-20200720
x86_64               randconfig-a016-20200720
x86_64               randconfig-a012-20200720
x86_64               randconfig-a013-20200720
x86_64               randconfig-a011-20200720
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
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
