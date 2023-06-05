Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B402DC7EE29
	for <linux-serial@archiver.kernel.org>; Mon,  5 Jun 2023 02:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjFECdj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 4 Jun 2023 22:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFECdi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 4 Jun 2023 22:33:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A437BC
        for <linux-serial@vger.kernel.org>; Sun,  4 Jun 2023 19:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685932417; x=1717468417;
  h=date:from:to:cc:subject:message-id;
  bh=7d2J6Cr66QwKT3FNSKmE0cyAvMdV0sAD5+xk5DaG3Jk=;
  b=Sq+TKXHSagtDS+Mc4tMGCI++7ylq72MvfaL+tDeD6DI8eYiy3C9p/VdJ
   NG0l0ZL2xnaAxRYhSGFvp1MAsg9W0giyG6pPpdW9MTQmmsyfR/PqYbql/
   l18WOeuqZQBNvaotMw2AKoGB7lGUofqfLBf+4jfaUY4CFLux7MNq4FKof
   wrku62bTXkI9wDZpe5QDE8A+hg+2m6dEElIBUzkpBsqNp5PJAZBq9uBTf
   +JrL6LDxo5vAG2VFa2KAhDgJoMKIomc89xOCeSkXpZ/GA2GgBlApwInGe
   ACqeZPBpeK+ixWBifCFz7RK7VsojrEgsjvAg08plfZhomy3dyOA1QRKFu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="442638178"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="442638178"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 19:33:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="882750639"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="882750639"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 Jun 2023 19:33:35 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q602J-0003kj-0F;
        Mon, 05 Jun 2023 02:33:35 +0000
Date:   Mon, 05 Jun 2023 10:33:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 49c80922ff8115bc86c82e5fc9e6842cd87db689
Message-ID: <20230605023308.bZ7ZW%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 49c80922ff8115bc86c82e5fc9e6842cd87db689  serial: core: Fix error handling for serial_core_ctrl_device_add()

elapsed time: 1105m

configs tested: 140
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230604   gcc  
alpha                randconfig-r023-20230604   gcc  
alpha                randconfig-r024-20230604   gcc  
alpha                randconfig-r032-20230604   gcc  
alpha                randconfig-r035-20230604   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230604   gcc  
arc          buildonly-randconfig-r003-20230604   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230604   gcc  
arc                  randconfig-r043-20230604   gcc  
arc                           tb10x_defconfig   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                        mvebu_v5_defconfig   clang
arm                         orion5x_defconfig   clang
arm                            qcom_defconfig   gcc  
arm                  randconfig-r031-20230604   clang
arm                  randconfig-r032-20230604   clang
arm                  randconfig-r034-20230604   clang
arm                  randconfig-r046-20230604   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           sama7_defconfig   clang
arm                          sp7021_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230604   gcc  
arm64                randconfig-r011-20230604   clang
arm64                randconfig-r012-20230604   clang
csky                                defconfig   gcc  
csky                 randconfig-r003-20230604   gcc  
hexagon              randconfig-r001-20230604   clang
hexagon              randconfig-r004-20230604   clang
hexagon              randconfig-r005-20230604   clang
hexagon              randconfig-r041-20230604   clang
hexagon              randconfig-r045-20230604   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r002-20230604   gcc  
i386         buildonly-randconfig-r004-20230604   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i006-20230604   gcc  
i386                 randconfig-i051-20230604   gcc  
i386                 randconfig-i052-20230604   gcc  
i386                 randconfig-i053-20230604   gcc  
i386                 randconfig-i054-20230604   gcc  
i386                 randconfig-i055-20230604   gcc  
i386                 randconfig-i056-20230604   gcc  
i386                 randconfig-i066-20230604   gcc  
i386                 randconfig-r006-20230604   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r004-20230604   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230604   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze   buildonly-randconfig-r002-20230604   gcc  
microblaze   buildonly-randconfig-r003-20230604   gcc  
microblaze           randconfig-r011-20230604   gcc  
microblaze           randconfig-r016-20230604   gcc  
microblaze           randconfig-r022-20230604   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            ar7_defconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                 randconfig-r024-20230604   gcc  
mips                 randconfig-r036-20230604   clang
nios2                            alldefconfig   gcc  
nios2        buildonly-randconfig-r006-20230604   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r033-20230604   gcc  
openrisc     buildonly-randconfig-r001-20230604   gcc  
openrisc             randconfig-r025-20230604   gcc  
openrisc             randconfig-r033-20230604   gcc  
openrisc             randconfig-r035-20230604   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                      katmai_defconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                     ksi8560_defconfig   clang
powerpc                 mpc8313_rdb_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc              randconfig-r004-20230604   gcc  
powerpc              randconfig-r015-20230604   clang
powerpc              randconfig-r023-20230604   clang
powerpc                     tqm8541_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230604   gcc  
riscv                randconfig-r021-20230604   clang
riscv                randconfig-r025-20230604   clang
riscv                randconfig-r031-20230604   gcc  
riscv                randconfig-r042-20230604   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r006-20230604   clang
s390                                defconfig   gcc  
s390                 randconfig-r012-20230604   clang
s390                 randconfig-r022-20230604   clang
s390                 randconfig-r044-20230604   clang
sh                               allmodconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r034-20230604   gcc  
sh                   randconfig-r036-20230604   gcc  
sh                           se7619_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc        buildonly-randconfig-r005-20230604   gcc  
sparc                               defconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64              randconfig-r003-20230604   gcc  
sparc64              randconfig-r015-20230604   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a006-20230604   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r002-20230604   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
