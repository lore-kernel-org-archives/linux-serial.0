Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFE1C54EE9
	for <linux-serial@archiver.kernel.org>; Fri, 23 Sep 2022 02:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiIWCrb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Sep 2022 22:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiIWCra (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Sep 2022 22:47:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CADD74F7
        for <linux-serial@vger.kernel.org>; Thu, 22 Sep 2022 19:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663901249; x=1695437249;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WxOu6OV7WzDm6gCXzcsItLXqhMgmrc7QZtL8OjPXtIU=;
  b=ZXifC1iSvKrmXt7aAX2Dh5k7ODe9+1F56dK9zRWGtLNiuHDLLY0TY65g
   k06hdchFkLGc6N24S2M9M5qj7nqLq7vXl9kYeOD5qQWdjNA5+4RpJZ2XL
   LhnLuzCYjya0AXzz6WldYRqR8Yp6P3tqDZEuaI8GwhBAwzH+C5LsJtHOR
   dMtSsSTuSxb1tsrYxNw8qVi2gMe2kRIQay2oe8e9Pqeq/3hmlxfH+UqgE
   jM30yO6kEPjhcBzHQH40EmHU0cJa12SX1A1g+e5tbdvVRYaDyn4ypnUkQ
   lukdpVT3mOrhA8xlCa+3puNHUnEg7XSLebqn04J8fjOwfjwcMHNutmOQv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301372543"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="301372543"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 19:47:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="688561988"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Sep 2022 19:47:28 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obYit-0005Et-1i;
        Fri, 23 Sep 2022 02:47:27 +0000
Date:   Fri, 23 Sep 2022 10:47:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 643792048ee84b199052e9c8f89253649ca78922
Message-ID: <632d1e39.6j1IbADEfpfMIGP+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 643792048ee84b199052e9c8f89253649ca78922  serial: sifive: enable clocks for UART when probed

elapsed time: 725m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
arc                  randconfig-r043-20220922
alpha                               defconfig
i386                                defconfig
s390                                defconfig
s390                             allmodconfig
m68k                             allyesconfig
x86_64                        randconfig-a015
s390                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a002
i386                             allyesconfig
powerpc                           allnoconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
mips                             allyesconfig
ia64                             allmodconfig
x86_64                        randconfig-a004
x86_64                              defconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
sh                               allmodconfig
arm                                 defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a001
i386                          randconfig-a003
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-a014
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                          randconfig-a005
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
i386                          randconfig-a012
i386                          randconfig-a016
sparc                               defconfig
loongarch                        alldefconfig
m68k                        stmark2_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
sparc                       sparc32_defconfig
sh                           se7721_defconfig
m68k                          atari_defconfig
mips                             allmodconfig
xtensa                       common_defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
i386                          randconfig-c001
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
powerpc                 mpc837x_mds_defconfig
xtensa                          iss_defconfig
nios2                            alldefconfig
m68k                            mac_defconfig
sh                        edosk7705_defconfig
xtensa                    smp_lx200_defconfig
csky                             alldefconfig
sh                           se7705_defconfig
powerpc                      tqm8xx_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220922
arm                        cerfcube_defconfig
microblaze                          defconfig
arm                           viper_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                         wii_defconfig
powerpc                    adder875_defconfig
arm                             ezx_defconfig
mips                       bmips_be_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
hexagon              randconfig-r041-20220922
riscv                randconfig-r042-20220922
hexagon              randconfig-r045-20220922
s390                 randconfig-r044-20220922
x86_64                        randconfig-a014
x86_64                        randconfig-a005
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a012
powerpc                      ppc64e_defconfig
arm                          ep93xx_defconfig
i386                          randconfig-a002
i386                          randconfig-a013
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-c007
arm                  randconfig-c002-20220922
i386                          randconfig-c001
s390                 randconfig-c005-20220922
riscv                randconfig-c006-20220922
mips                 randconfig-c004-20220922
powerpc              randconfig-c003-20220922
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
