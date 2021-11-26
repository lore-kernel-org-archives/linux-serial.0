Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C773BC4332F
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 07:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347023AbhKZHOc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 02:14:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:26459 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352744AbhKZHMc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 02:12:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="235861987"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="235861987"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 23:09:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="592204252"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Nov 2021 23:09:18 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqVMD-0007kJ-RH; Fri, 26 Nov 2021 07:09:17 +0000
Date:   Fri, 26 Nov 2021 15:08:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 bb1201d4b38ec67bd9a871cf86b0cc10f28b15b5
Message-ID: <61a087eb.AGGvFiQm6KARIYHK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: bb1201d4b38ec67bd9a871cf86b0cc10f28b15b5  serial: 8250_pci: rewrite pericom_do_set_divisor()

elapsed time: 724m

configs tested: 54
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211125
riscv                            allyesconfig
mips                             allyesconfig
um                             i386_defconfig
mips                             allmodconfig
riscv                            allmodconfig
um                           x86_64_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
