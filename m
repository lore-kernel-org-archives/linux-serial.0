Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8989EB64D7
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jun 2023 22:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjFMW4p (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Jun 2023 18:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241437AbjFMW4c (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Jun 2023 18:56:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E011498
        for <linux-serial@vger.kernel.org>; Tue, 13 Jun 2023 15:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686696991; x=1718232991;
  h=date:from:to:cc:subject:message-id;
  bh=qAMlqqAvSkHVNvOWenUBBEj0CkbKOWB/CGPRSjuJd0U=;
  b=WMFJ3hmMHdQNMm1cpwIA+mpleus33HlTPueRaFGAC6hSvIgcIR4JIax0
   1gAV7qq8Hop43LDK0jo2pYflwYa0N6Oqsjq2NWDLa3yOZ6PKMeU3lcsxx
   81TEov1+ynOytSMm5h8sAaFNg24tHTnZbDURA3KqmFW3667aOgeQ1N/Ej
   T1HtnlGdo0vvchx2GnDBG7qjCKHd1rXLAVkstOe0bcpJOOij3keDamIhr
   2w915/g0LB2tvlgbicLPkgm4t+ZoYVGUi1B5OHPJK7Ya7ryz9H8sqX8qL
   HxH02ncn1Cnx5H8sNNwGjN+roRkqeYlkoCVQZzuR7ii/mgMThuiWikL5q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="338102650"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="338102650"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 15:56:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="744860797"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="744860797"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Jun 2023 15:56:29 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9Cw8-0001u4-2s;
        Tue, 13 Jun 2023 22:56:28 +0000
Date:   Wed, 14 Jun 2023 06:56:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 a82c3df955f8c1c726e4976527aa6ae924a67dd9
Message-ID: <202306140615.cRizLVMI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: a82c3df955f8c1c726e4976527aa6ae924a67dd9  tty: serial: fsl_lpuart: reduce RX watermark to 0 on LS1028A

elapsed time: 721m

configs tested: 113
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230612   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230612   gcc  
arc                  randconfig-r015-20230612   gcc  
arc                  randconfig-r043-20230612   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230612   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230612   clang
arm64                               defconfig   gcc  
arm64                randconfig-r036-20230612   clang
csky                                defconfig   gcc  
csky                 randconfig-r023-20230612   gcc  
csky                 randconfig-r034-20230612   gcc  
hexagon              randconfig-r025-20230612   clang
hexagon              randconfig-r031-20230612   clang
hexagon              randconfig-r041-20230612   clang
hexagon              randconfig-r045-20230612   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230612   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230612   clang
i386                 randconfig-i002-20230612   clang
i386                 randconfig-i003-20230612   clang
i386                 randconfig-i004-20230612   clang
i386                 randconfig-i005-20230612   clang
i386                 randconfig-i006-20230612   clang
i386                 randconfig-i011-20230612   gcc  
i386                 randconfig-i012-20230612   gcc  
i386                 randconfig-i013-20230612   gcc  
i386                 randconfig-i014-20230612   gcc  
i386                 randconfig-i015-20230612   gcc  
i386                 randconfig-i016-20230612   gcc  
i386                 randconfig-r012-20230612   gcc  
i386                 randconfig-r014-20230612   gcc  
i386                 randconfig-r021-20230612   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230612   gcc  
loongarch            randconfig-r005-20230612   gcc  
loongarch            randconfig-r024-20230612   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k         buildonly-randconfig-r004-20230612   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r011-20230612   clang
nios2        buildonly-randconfig-r001-20230612   gcc  
nios2        buildonly-randconfig-r005-20230612   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230612   gcc  
nios2                randconfig-r032-20230612   gcc  
openrisc             randconfig-r013-20230612   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r003-20230612   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r022-20230612   gcc  
parisc               randconfig-r035-20230612   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230612   gcc  
powerpc              randconfig-r024-20230612   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv        buildonly-randconfig-r005-20230612   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230612   clang
riscv                randconfig-r023-20230612   gcc  
riscv                randconfig-r033-20230612   clang
riscv                randconfig-r042-20230612   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230612   clang
s390                 randconfig-r016-20230612   gcc  
s390                 randconfig-r044-20230612   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r003-20230612   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r026-20230612   gcc  
sparc64      buildonly-randconfig-r006-20230612   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230612   clang
x86_64               randconfig-a002-20230612   clang
x86_64               randconfig-a003-20230612   clang
x86_64               randconfig-a004-20230612   clang
x86_64               randconfig-a005-20230612   clang
x86_64               randconfig-a006-20230612   clang
x86_64               randconfig-a011-20230612   gcc  
x86_64               randconfig-a012-20230612   gcc  
x86_64               randconfig-a013-20230612   gcc  
x86_64               randconfig-a014-20230612   gcc  
x86_64               randconfig-a015-20230612   gcc  
x86_64               randconfig-a016-20230612   gcc  
x86_64               randconfig-r005-20230612   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
