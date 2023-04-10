Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D265C77B61
	for <linux-serial@archiver.kernel.org>; Mon, 10 Apr 2023 21:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjDJVOs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 Apr 2023 17:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDJVOn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Apr 2023 17:14:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21EF1FDD
        for <linux-serial@vger.kernel.org>; Mon, 10 Apr 2023 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681161281; x=1712697281;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=u2lBYPmL3+VhgATREbWyV+WnlTWGUfxhmV1dJJ4GT6A=;
  b=K/pluTu7TDDmXjVHb2cj4wP7VZ1vFEo9j+9x002AwILB86bw+td608P+
   zRITKrS774bquBryBK6cREQdHwtXxlMKgQy2gCirgVeNgb3IKfXVCAKlH
   TOcauLu0Az6+MQM24RdHafmC2sBoZ1THtV07HBPuZE9GLvLTQeodawD39
   FdeziGGrTxNy/Swiep1SI4TWfl+Bf3D4c2byASBBvr+rDg9PCXyFuJ6YY
   ReuTUFy+LafWw8j6vA3bwRwJ0lB3ADkwW3IwCZ/shk9weLv6gfjApH+cw
   pBSHmzIIediiNyWIkwRkk46mTJs3axQhEFsaj/pV0q1ILbFaSFmfS1ADu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="323818868"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="323818868"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 14:14:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="799623837"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="799623837"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2023 14:14:39 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1plyqV-000Vfz-0H;
        Mon, 10 Apr 2023 21:14:39 +0000
Date:   Tue, 11 Apr 2023 05:14:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 039535ecf18e8dc93fe4b294fdf175a31bd023b2
Message-ID: <64347c34.sZv8Wv4dQhibv61Q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 039535ecf18e8dc93fe4b294fdf175a31bd023b2  Merge 6.3-rc6 into tty-next

elapsed time: 847m

configs tested: 208
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230409   gcc  
alpha        buildonly-randconfig-r006-20230409   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230409   gcc  
alpha                randconfig-r005-20230410   gcc  
alpha                randconfig-r021-20230409   gcc  
alpha                randconfig-r025-20230410   gcc  
alpha                randconfig-r031-20230410   gcc  
alpha                randconfig-r034-20230409   gcc  
alpha                randconfig-r035-20230410   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230409   gcc  
arc          buildonly-randconfig-r005-20230410   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230409   gcc  
arc                  randconfig-r016-20230410   gcc  
arc                  randconfig-r022-20230409   gcc  
arc                  randconfig-r024-20230409   gcc  
arc                  randconfig-r031-20230410   gcc  
arc                  randconfig-r032-20230410   gcc  
arc                  randconfig-r043-20230409   gcc  
arc                  randconfig-r043-20230410   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          ep93xx_defconfig   clang
arm                  randconfig-r002-20230409   gcc  
arm                  randconfig-r006-20230410   gcc  
arm                  randconfig-r024-20230409   clang
arm                  randconfig-r026-20230409   clang
arm                  randconfig-r032-20230410   gcc  
arm                  randconfig-r034-20230410   gcc  
arm                  randconfig-r046-20230409   clang
arm                  randconfig-r046-20230410   clang
arm                         s3c6400_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r015-20230409   gcc  
arm64                randconfig-r031-20230409   clang
csky         buildonly-randconfig-r006-20230410   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r024-20230410   gcc  
csky                 randconfig-r034-20230410   gcc  
hexagon      buildonly-randconfig-r001-20230409   clang
hexagon      buildonly-randconfig-r002-20230409   clang
hexagon              randconfig-r012-20230409   clang
hexagon              randconfig-r013-20230410   clang
hexagon              randconfig-r024-20230410   clang
hexagon              randconfig-r041-20230409   clang
hexagon              randconfig-r041-20230410   clang
hexagon              randconfig-r045-20230409   clang
hexagon              randconfig-r045-20230410   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230410   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230410   clang
i386                 randconfig-a002-20230410   clang
i386                 randconfig-a003-20230410   clang
i386                 randconfig-a004-20230410   clang
i386                 randconfig-a005-20230410   clang
i386                 randconfig-a006-20230410   clang
i386                 randconfig-a011-20230410   gcc  
i386                 randconfig-a012-20230410   gcc  
i386                 randconfig-a013-20230410   gcc  
i386                 randconfig-a014-20230410   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                 randconfig-a016-20230410   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r003-20230409   gcc  
ia64         buildonly-randconfig-r003-20230410   gcc  
ia64         buildonly-randconfig-r004-20230410   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230410   gcc  
ia64                 randconfig-r002-20230409   gcc  
ia64                 randconfig-r013-20230409   gcc  
ia64                 randconfig-r016-20230410   gcc  
ia64                 randconfig-r023-20230409   gcc  
ia64                 randconfig-r023-20230410   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230409   gcc  
loongarch            randconfig-r006-20230409   gcc  
loongarch            randconfig-r011-20230410   gcc  
loongarch            randconfig-r021-20230409   gcc  
loongarch            randconfig-r034-20230409   gcc  
loongarch            randconfig-r035-20230409   gcc  
loongarch            randconfig-r036-20230410   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230410   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230409   gcc  
m68k                 randconfig-r005-20230409   gcc  
m68k                 randconfig-r015-20230410   gcc  
m68k                 randconfig-r021-20230410   gcc  
m68k                 randconfig-r022-20230409   gcc  
microblaze           randconfig-r003-20230409   gcc  
microblaze           randconfig-r005-20230410   gcc  
microblaze           randconfig-r021-20230410   gcc  
microblaze           randconfig-r032-20230409   gcc  
microblaze           randconfig-r035-20230409   gcc  
microblaze           randconfig-r036-20230409   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip27_defconfig   clang
mips                 randconfig-r025-20230409   clang
mips                 randconfig-r026-20230410   clang
mips                           rs90_defconfig   clang
nios2        buildonly-randconfig-r001-20230410   gcc  
nios2        buildonly-randconfig-r006-20230409   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r013-20230409   gcc  
nios2                randconfig-r026-20230409   gcc  
openrisc             randconfig-r003-20230409   gcc  
openrisc             randconfig-r006-20230409   gcc  
openrisc             randconfig-r006-20230410   gcc  
openrisc             randconfig-r022-20230410   gcc  
openrisc             randconfig-r026-20230410   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230409   gcc  
parisc               randconfig-r003-20230410   gcc  
parisc               randconfig-r005-20230410   gcc  
parisc               randconfig-r011-20230409   gcc  
parisc               randconfig-r011-20230410   gcc  
parisc               randconfig-r016-20230409   gcc  
parisc               randconfig-r023-20230409   gcc  
parisc               randconfig-r032-20230409   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                 mpc836x_mds_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc              randconfig-r003-20230410   clang
powerpc              randconfig-r014-20230410   gcc  
powerpc              randconfig-r015-20230410   gcc  
powerpc              randconfig-r022-20230410   gcc  
powerpc              randconfig-r033-20230409   clang
powerpc                     skiroot_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230410   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230409   clang
riscv                randconfig-r012-20230409   gcc  
riscv                randconfig-r036-20230410   clang
riscv                randconfig-r042-20230409   gcc  
riscv                randconfig-r042-20230410   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230410   clang
s390                 randconfig-r044-20230409   gcc  
s390                 randconfig-r044-20230410   gcc  
sh                               allmodconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh           buildonly-randconfig-r001-20230410   gcc  
sh                   randconfig-r001-20230410   gcc  
sh                   randconfig-r002-20230410   gcc  
sh                   randconfig-r013-20230410   gcc  
sh                   randconfig-r014-20230409   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sparc        buildonly-randconfig-r004-20230410   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230409   gcc  
sparc                randconfig-r012-20230410   gcc  
sparc                randconfig-r033-20230409   gcc  
sparc                randconfig-r033-20230410   gcc  
sparc64      buildonly-randconfig-r003-20230410   gcc  
sparc64      buildonly-randconfig-r005-20230409   gcc  
sparc64              randconfig-r001-20230410   gcc  
sparc64              randconfig-r004-20230410   gcc  
sparc64              randconfig-r006-20230409   gcc  
sparc64              randconfig-r006-20230410   gcc  
sparc64              randconfig-r025-20230410   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230410   clang
x86_64               randconfig-a002-20230410   clang
x86_64               randconfig-a003-20230410   clang
x86_64               randconfig-a004-20230410   clang
x86_64               randconfig-a005-20230410   clang
x86_64               randconfig-a006-20230410   clang
x86_64               randconfig-a011-20230410   gcc  
x86_64               randconfig-a012-20230410   gcc  
x86_64               randconfig-a013-20230410   gcc  
x86_64               randconfig-a014-20230410   gcc  
x86_64               randconfig-a015-20230410   gcc  
x86_64               randconfig-a016-20230410   gcc  
x86_64                        randconfig-k001   clang
x86_64               randconfig-r002-20230410   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230409   gcc  
xtensa               randconfig-r011-20230409   gcc  
xtensa               randconfig-r014-20230410   gcc  
xtensa               randconfig-r015-20230409   gcc  
xtensa               randconfig-r016-20230409   gcc  
xtensa               randconfig-r033-20230410   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
