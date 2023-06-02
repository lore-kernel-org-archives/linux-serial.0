Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32F6C7EE2D
	for <linux-serial@archiver.kernel.org>; Fri,  2 Jun 2023 05:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjFBFrT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 2 Jun 2023 01:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjFBFrQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Jun 2023 01:47:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6B9198
        for <linux-serial@vger.kernel.org>; Thu,  1 Jun 2023 22:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685684835; x=1717220835;
  h=date:from:to:cc:subject:message-id;
  bh=OdhUiPKhBWznrxzjnFjxqVKmGjILjxKx2RnD8WltHA8=;
  b=YgmU+eHC9cuh0OWv3Wr13dG+eM1vfXtD3xFA4UHOLlRpfubOgeq6hPz5
   aUa63Ifed7Yl2zuCIID6skX4sMhEubQF0HGos/z5yr5w2TB8Cm5ReunwU
   PuI6A7KDhyd+O5/VWf8lGeuAT0tH1SfQkeufcYQ6CrwrFyRdhRUC6VOjj
   fsWhhIJLLhu3b0/pHM3a1Ozw1ZAdFsoznWOYZpOLQM15WwOpjHDJk0xmc
   TBSZW4OQIXh0c5mFye1a9VX+emeO/Ae/nw//UDQ0efswQgg3KJLG6jZPo
   G4TLqn5ZINqyQUtn58GiPyRawUfaqRG56lYNKwbOZg9LbgOWkpYDOUfl8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="353273372"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="353273372"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 22:47:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="710793103"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="710793103"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 01 Jun 2023 22:47:13 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4xd3-00008g-10;
        Fri, 02 Jun 2023 05:47:13 +0000
Date:   Fri, 02 Jun 2023 13:46:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-next] BUILD SUCCESS
 539914240a01c7d68476d10c07b7f4f9a05d38ed
Message-ID: <20230602054644.YBKxP%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
branch HEAD: 539914240a01c7d68476d10c07b7f4f9a05d38ed  serial: core: Fix probing serial_base_bus devices

elapsed time: 721m

configs tested: 108
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r031-20230531   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230531   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r014-20230601   clang
arm                  randconfig-r046-20230531   gcc  
arm                        realview_defconfig   gcc  
arm                         s5pv210_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230601   gcc  
arm64                randconfig-r023-20230531   clang
csky         buildonly-randconfig-r005-20230531   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230602   gcc  
csky                 randconfig-r035-20230531   gcc  
hexagon              randconfig-r041-20230531   clang
hexagon              randconfig-r045-20230531   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230531   gcc  
i386                 randconfig-i002-20230531   gcc  
i386                 randconfig-i003-20230531   gcc  
i386                 randconfig-i004-20230531   gcc  
i386                 randconfig-i005-20230531   gcc  
i386                 randconfig-i006-20230531   gcc  
i386                 randconfig-i051-20230531   gcc  
i386                 randconfig-i052-20230531   gcc  
i386                 randconfig-i053-20230531   gcc  
i386                 randconfig-i054-20230531   gcc  
i386                 randconfig-i055-20230531   gcc  
i386                 randconfig-i056-20230531   gcc  
i386                 randconfig-i061-20230531   gcc  
i386                 randconfig-i062-20230531   gcc  
i386                 randconfig-i063-20230531   gcc  
i386                 randconfig-i064-20230531   gcc  
i386                 randconfig-i065-20230531   gcc  
i386                 randconfig-i066-20230531   gcc  
ia64                      gensparse_defconfig   gcc  
ia64                            zx1_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230602   gcc  
loongarch            randconfig-r012-20230601   gcc  
m68k                             allmodconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k         buildonly-randconfig-r001-20230531   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r034-20230531   gcc  
microblaze           randconfig-r024-20230531   gcc  
microblaze           randconfig-r032-20230531   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r003-20230531   clang
mips                           ip28_defconfig   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r002-20230602   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                     skiroot_defconfig   clang
powerpc                     tqm8560_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230531   clang
riscv                               defconfig   gcc  
riscv                randconfig-r036-20230531   gcc  
riscv                randconfig-r042-20230531   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r033-20230531   gcc  
s390                 randconfig-r044-20230531   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230531   gcc  
sh                   randconfig-r004-20230602   gcc  
sh                   randconfig-r015-20230601   gcc  
sh                   randconfig-r022-20230531   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230602   gcc  
sparc                randconfig-r021-20230531   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230531   gcc  
x86_64               randconfig-a002-20230531   gcc  
x86_64               randconfig-a003-20230531   gcc  
x86_64               randconfig-a004-20230531   gcc  
x86_64               randconfig-a005-20230531   gcc  
x86_64               randconfig-a006-20230531   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230531   gcc  
xtensa               randconfig-r026-20230531   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
