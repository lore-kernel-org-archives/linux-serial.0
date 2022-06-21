Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0168C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jun 2022 18:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiFUSmN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jun 2022 14:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiFUSmM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jun 2022 14:42:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0750210FDF
        for <linux-serial@vger.kernel.org>; Tue, 21 Jun 2022 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655836931; x=1687372931;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XKdfcRvZMWgfbepYApSpj8T28FTmeVQGTmAB/bXYPAE=;
  b=PaqB9odOKSahEKyXSU2FjKRn0F9pV4DB20L7ns2Y2FjSUGXwG+ceajVL
   ErRKmhT83orghGoXVOmnhIbBK+9CB66Rn8eG6IanhoUQ4CB8wu8DmIbhD
   OxJzsT9qC9JKh9ft6yE65s4Ek7QyfC7+not13SyGjZovy/XgMelrNRzT0
   YMx5576LvrJMnMqVa3rCX+fJ1MRgDfgJ6l4khmJxmuzjzKDezQ39KAG6x
   MXR49cbNflRcdrK8Zqeue6jt1p5hlRmIAaafL8oW0ed4yrMz7ZcMjDbVE
   5kOw0Rf7oECSUTBWjlEiFCCoCKQWi05Ij1VkS2Urhej+jYxgoLcYZ/o3W
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="341892238"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="341892238"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 11:42:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="591782277"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jun 2022 11:42:10 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3ipF-0000I0-Op;
        Tue, 21 Jun 2022 18:42:09 +0000
Date:   Wed, 22 Jun 2022 02:41:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 df36f3e3fbb76d30d623a1623e31e3ce9c2fa750
Message-ID: <62b210d0.UyUFpJm4n890fobf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: df36f3e3fbb76d30d623a1623e31e3ce9c2fa750  Merge tag 'v5.19-rc3' into tty-next

elapsed time: 838m

configs tested: 79
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
arc                              alldefconfig
mips                         rt305x_defconfig
m68k                          hp300_defconfig
arc                        vdk_hs38_defconfig
sh                          landisk_defconfig
m68k                          sun3x_defconfig
m68k                          multi_defconfig
xtensa                       common_defconfig
arm                       imx_v6_v7_defconfig
um                                  defconfig
sh                               j2_defconfig
powerpc                       ppc64_defconfig
m68k                       m5249evb_defconfig
arm64                            alldefconfig
m68k                            q40_defconfig
arm                           stm32_defconfig
sh                          kfr2r09_defconfig
powerpc                 linkstation_defconfig
mips                            gpr_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                             allyesconfig
i386                                defconfig
sparc                               defconfig
sparc                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
i386                 randconfig-a005-20220620
i386                 randconfig-a001-20220620
i386                 randconfig-a006-20220620
i386                 randconfig-a004-20220620
i386                 randconfig-a003-20220620
i386                 randconfig-a002-20220620
riscv                            allyesconfig
riscv                            allmodconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                             allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
x86_64                        randconfig-k001
hexagon              randconfig-r041-20220621
hexagon              randconfig-r045-20220621

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
