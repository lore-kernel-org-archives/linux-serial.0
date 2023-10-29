Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A550C4332F
	for <linux-serial@archiver.kernel.org>; Sun, 29 Oct 2023 06:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjJ2GRz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 29 Oct 2023 02:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2GRz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 29 Oct 2023 02:17:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC72D3
        for <linux-serial@vger.kernel.org>; Sat, 28 Oct 2023 23:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698560272; x=1730096272;
  h=date:from:to:cc:subject:message-id;
  bh=THMn2x89D3it/PxdnIcdxyt1hVGQ3LpSHH4T2MfBG1Q=;
  b=juNQj0rj66lBQmLeeg4H5fCJXRU0BuZN3HpZ9f4g+bBvmiAGsJwSVT1m
   Npqzpw2RYzuwtHHaOKk6So2amLH+SydEBPNHAwe+uzAm9W0wT3Hf2F7Yl
   t0BdMoQal7HIfAl8mepGeO/J7CKWH5sFCh9ya6veSHFPqnbaEewjmnFuc
   8XxpHKZlGSM5jn1r52TSpudG0lc03uNRpaY9nGiki8Wm+rJU+CvVqToCP
   xBFaQ7hiYtVqPGAYYDmVyCr3CfzJQyRNsVlUDyBjDo7oHreHDTJ3IEKxi
   jbAzveZKpUQR6vXoOHMi9As9N7jqBftwzWqMy4zB6cXTQrzj2m3fG+AK9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="452185836"
X-IronPort-AV: E=Sophos;i="6.03,260,1694761200"; 
   d="scan'208";a="452185836"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 23:17:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,260,1694761200"; 
   d="scan'208";a="1176483"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 28 Oct 2023 23:17:14 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwz7M-000CNF-1l;
        Sun, 29 Oct 2023 06:17:48 +0000
Date:   Sun, 29 Oct 2023 14:17:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 64ebf8797249e792af2143eb9e4bd404d10a022e
Message-ID: <202310291421.NT3MQoaA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 64ebf8797249e792af2143eb9e4bd404d10a022e  serdev: Replace custom code with device_match_acpi_handle()

elapsed time: 2569m

configs tested: 278
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20231027   gcc  
arc                   randconfig-001-20231028   gcc  
arc                   randconfig-001-20231029   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                       netwinder_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20231027   gcc  
arm                   randconfig-001-20231028   gcc  
arm                   randconfig-001-20231029   gcc  
arm                         s3c6400_defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          alldefconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231028   gcc  
i386         buildonly-randconfig-001-20231029   gcc  
i386         buildonly-randconfig-002-20231027   gcc  
i386         buildonly-randconfig-002-20231028   gcc  
i386         buildonly-randconfig-002-20231029   gcc  
i386         buildonly-randconfig-003-20231028   gcc  
i386         buildonly-randconfig-003-20231029   gcc  
i386         buildonly-randconfig-004-20231028   gcc  
i386         buildonly-randconfig-004-20231029   gcc  
i386         buildonly-randconfig-005-20231028   gcc  
i386         buildonly-randconfig-005-20231029   gcc  
i386         buildonly-randconfig-006-20231028   gcc  
i386         buildonly-randconfig-006-20231029   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231027   gcc  
i386                  randconfig-001-20231028   gcc  
i386                  randconfig-001-20231029   gcc  
i386                  randconfig-002-20231027   gcc  
i386                  randconfig-002-20231028   gcc  
i386                  randconfig-002-20231029   gcc  
i386                  randconfig-003-20231027   gcc  
i386                  randconfig-003-20231028   gcc  
i386                  randconfig-003-20231029   gcc  
i386                  randconfig-004-20231027   gcc  
i386                  randconfig-004-20231028   gcc  
i386                  randconfig-004-20231029   gcc  
i386                  randconfig-005-20231027   gcc  
i386                  randconfig-005-20231028   gcc  
i386                  randconfig-005-20231029   gcc  
i386                  randconfig-006-20231027   gcc  
i386                  randconfig-006-20231028   gcc  
i386                  randconfig-006-20231029   gcc  
i386                  randconfig-011-20231027   gcc  
i386                  randconfig-011-20231028   gcc  
i386                  randconfig-011-20231029   gcc  
i386                  randconfig-012-20231027   gcc  
i386                  randconfig-012-20231028   gcc  
i386                  randconfig-012-20231029   gcc  
i386                  randconfig-013-20231027   gcc  
i386                  randconfig-013-20231028   gcc  
i386                  randconfig-013-20231029   gcc  
i386                  randconfig-014-20231027   gcc  
i386                  randconfig-014-20231028   gcc  
i386                  randconfig-014-20231029   gcc  
i386                  randconfig-015-20231027   gcc  
i386                  randconfig-015-20231028   gcc  
i386                  randconfig-015-20231029   gcc  
i386                  randconfig-016-20231027   gcc  
i386                  randconfig-016-20231028   gcc  
i386                  randconfig-016-20231029   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231027   gcc  
loongarch             randconfig-001-20231028   gcc  
loongarch             randconfig-001-20231029   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       alldefconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc                      chrp32_defconfig   gcc  
powerpc                       ebony_defconfig   clang
powerpc                      katmai_defconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                     ksi8560_defconfig   clang
powerpc                      mgcoge_defconfig   gcc  
powerpc                  mpc885_ads_defconfig   clang
powerpc                      ppc40x_defconfig   gcc  
powerpc                     taishan_defconfig   gcc  
powerpc                     tqm8555_defconfig   gcc  
powerpc                      walnut_defconfig   clang
powerpc                         wii_defconfig   gcc  
powerpc64                           defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20231027   gcc  
riscv                 randconfig-001-20231028   gcc  
riscv                 randconfig-001-20231029   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231027   gcc  
s390                  randconfig-001-20231028   gcc  
s390                  randconfig-001-20231029   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231028   gcc  
sparc                 randconfig-001-20231029   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231028   gcc  
x86_64       buildonly-randconfig-001-20231029   gcc  
x86_64       buildonly-randconfig-002-20231027   gcc  
x86_64       buildonly-randconfig-002-20231028   gcc  
x86_64       buildonly-randconfig-002-20231029   gcc  
x86_64       buildonly-randconfig-003-20231027   gcc  
x86_64       buildonly-randconfig-003-20231028   gcc  
x86_64       buildonly-randconfig-003-20231029   gcc  
x86_64       buildonly-randconfig-004-20231027   gcc  
x86_64       buildonly-randconfig-004-20231028   gcc  
x86_64       buildonly-randconfig-004-20231029   gcc  
x86_64       buildonly-randconfig-005-20231027   gcc  
x86_64       buildonly-randconfig-005-20231028   gcc  
x86_64       buildonly-randconfig-005-20231029   gcc  
x86_64       buildonly-randconfig-006-20231028   gcc  
x86_64       buildonly-randconfig-006-20231029   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231027   gcc  
x86_64                randconfig-001-20231028   gcc  
x86_64                randconfig-001-20231029   gcc  
x86_64                randconfig-002-20231027   gcc  
x86_64                randconfig-002-20231028   gcc  
x86_64                randconfig-002-20231029   gcc  
x86_64                randconfig-003-20231027   gcc  
x86_64                randconfig-003-20231028   gcc  
x86_64                randconfig-003-20231029   gcc  
x86_64                randconfig-004-20231027   gcc  
x86_64                randconfig-004-20231028   gcc  
x86_64                randconfig-004-20231029   gcc  
x86_64                randconfig-005-20231027   gcc  
x86_64                randconfig-005-20231028   gcc  
x86_64                randconfig-005-20231029   gcc  
x86_64                randconfig-006-20231027   gcc  
x86_64                randconfig-006-20231028   gcc  
x86_64                randconfig-006-20231029   gcc  
x86_64                randconfig-011-20231028   gcc  
x86_64                randconfig-011-20231029   gcc  
x86_64                randconfig-012-20231028   gcc  
x86_64                randconfig-012-20231029   gcc  
x86_64                randconfig-013-20231028   gcc  
x86_64                randconfig-013-20231029   gcc  
x86_64                randconfig-014-20231028   gcc  
x86_64                randconfig-014-20231029   gcc  
x86_64                randconfig-015-20231028   gcc  
x86_64                randconfig-015-20231029   gcc  
x86_64                randconfig-016-20231028   gcc  
x86_64                randconfig-016-20231029   gcc  
x86_64                randconfig-071-20231027   gcc  
x86_64                randconfig-071-20231028   gcc  
x86_64                randconfig-071-20231029   gcc  
x86_64                randconfig-072-20231027   gcc  
x86_64                randconfig-072-20231028   gcc  
x86_64                randconfig-072-20231029   gcc  
x86_64                randconfig-073-20231027   gcc  
x86_64                randconfig-073-20231028   gcc  
x86_64                randconfig-073-20231029   gcc  
x86_64                randconfig-074-20231027   gcc  
x86_64                randconfig-074-20231028   gcc  
x86_64                randconfig-074-20231029   gcc  
x86_64                randconfig-075-20231027   gcc  
x86_64                randconfig-075-20231028   gcc  
x86_64                randconfig-075-20231029   gcc  
x86_64                randconfig-076-20231027   gcc  
x86_64                randconfig-076-20231028   gcc  
x86_64                randconfig-076-20231029   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
