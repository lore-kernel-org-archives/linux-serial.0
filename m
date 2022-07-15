Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DF4C43334
	for <linux-serial@archiver.kernel.org>; Fri, 15 Jul 2022 15:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbiGOPTL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Jul 2022 11:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiGOPSw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Jul 2022 11:18:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662B11144D
        for <linux-serial@vger.kernel.org>; Fri, 15 Jul 2022 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657898323; x=1689434323;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PL2lqJDfMC7ccNc03p6i/mdppqrOMEEY06HpVQeTmZ0=;
  b=XkTASb+Xipnx8f4GXMJvYW7nznkKpyxAGGBRN+UqfG4pxC3mVxtiaOL4
   4vrOGxOBf2UOzWNuyh4ec9Na5L+HI6i/b7E1j379CeZM1w1jkhI9d7KEb
   QQOxBg/2x7MSPayPGQFSQU44skO8AYJ3ZCcA7P2kg9HLDHi2BCq9vZYl2
   9gSu/vRQiAED0FWIXdSBsI+cWw/HONe1qeY21X7dBJKSJE7lB6Mqds3j+
   DZAi/pb0QXqkZBS/DfM7YkGjZJigqKGDbwA5JhMIlJHutZ+i579wd2l27
   OtxgSAhQ2YJe0Kn+qlakY2bmBWikFaWoZm449BDEQjTDasE1N/3Tpu/J0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="285840937"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="285840937"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 08:18:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="600526788"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jul 2022 08:18:40 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCN5T-0000Dg-Le;
        Fri, 15 Jul 2022 15:18:39 +0000
Date:   Fri, 15 Jul 2022 17:10:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 5095ca634f8b134cc202a5f5e4985d2b81f0ef0a
Message-ID: <62d12ef8.nePqRML/H0R6h1oT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 5095ca634f8b134cc202a5f5e4985d2b81f0ef0a  serial: 8250: lpc18xx: Remove redundant sanity check for RS485 flags

elapsed time: 1094m

configs tested: 85
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                          randconfig-c001
sparc                             allnoconfig
arm                           h3600_defconfig
mips                         cobalt_defconfig
sh                        sh7785lcr_defconfig
m68k                       m5275evb_defconfig
arm                        oxnas_v6_defconfig
arm                        clps711x_defconfig
powerpc                      pcm030_defconfig
m68k                          atari_defconfig
arc                          axs103_defconfig
powerpc                     pq2fads_defconfig
arm                             ezx_defconfig
sh                             sh03_defconfig
m68k                        m5272c3_defconfig
arc                                 defconfig
arm                         at91_dt_defconfig
powerpc                 mpc8540_ads_defconfig
alpha                             allnoconfig
arm                           viper_defconfig
sh                        edosk7705_defconfig
x86_64                                  kexec
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
csky                              allnoconfig
arc                               allnoconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz

clang tested configs:
powerpc                 mpc836x_rdk_defconfig
powerpc                    gamecube_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    mvme5100_defconfig
powerpc                        fsp2_defconfig
hexagon                             defconfig
powerpc                      ppc44x_defconfig
powerpc                     ppa8548_defconfig
powerpc                     kilauea_defconfig
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20220714
hexagon              randconfig-r041-20220714

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
