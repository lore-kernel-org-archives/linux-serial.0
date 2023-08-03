Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E675C00528
	for <linux-serial@archiver.kernel.org>; Thu,  3 Aug 2023 19:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjHCT4w (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Aug 2023 15:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjHCT4v (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Aug 2023 15:56:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCED1706
        for <linux-serial@vger.kernel.org>; Thu,  3 Aug 2023 12:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691092609; x=1722628609;
  h=date:from:to:cc:subject:message-id;
  bh=lld7UwSrrzf8oHYdixA++4LjvcwMu5yV4MvDPORbwNQ=;
  b=fZInsie7qI304ZYaNPdVPTBciEQFMroo91P1HvJBCqW+dMJdZVeQO+Dj
   Dw1EkRsQNpDHYsLml4hyB3bX20YNLtYWsH3vC90wwQWCby7W4kPobncfL
   IDkVCV0FaIL+F/KWyH7Iwxw86snyPOzyiMNILSH5mJ9xYsMwtXIgI79CK
   Fj2lNpmsyoaEccQ4noqH33RzuuszQzuZjbA2c7lrHzMYr6muqaodlSruD
   GsxpSsFoHdxq/TVUz0QrG8cRm9u0AePw+qYFxiJtgAIK/QM89PXL7TpEh
   utv456FaUBDN2d0QwuPFGNDajH2J6nbqbs8irUXTvzEkE78jaFtRMAKfs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="456355508"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="456355508"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 12:56:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="723363588"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="723363588"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 03 Aug 2023 12:56:48 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qReRD-0002Kf-1K;
        Thu, 03 Aug 2023 19:56:47 +0000
Date:   Fri, 04 Aug 2023 03:56:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 7d695d83767cdb4288b101affef6d1d1bcf44d31
Message-ID: <202308040327.bXmFt3gu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 7d695d83767cdb4288b101affef6d1d1bcf44d31  serial: core: Fix serial_base_match() after fixing controller port name

elapsed time: 722m

configs tested: 108
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230731   gcc  
arc                  randconfig-r033-20230731   gcc  
arc                  randconfig-r043-20230731   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r012-20230731   gcc  
arm                  randconfig-r046-20230731   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230731   gcc  
arm64                randconfig-r013-20230731   clang
csky                                defconfig   gcc  
hexagon              randconfig-r001-20230731   clang
hexagon              randconfig-r014-20230731   clang
hexagon              randconfig-r041-20230731   clang
hexagon              randconfig-r045-20230731   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230731   gcc  
i386         buildonly-randconfig-r005-20230731   gcc  
i386         buildonly-randconfig-r006-20230731   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230801   gcc  
i386                 randconfig-i002-20230801   gcc  
i386                 randconfig-i003-20230801   gcc  
i386                 randconfig-i004-20230801   gcc  
i386                 randconfig-i005-20230801   gcc  
i386                 randconfig-i006-20230801   gcc  
i386                 randconfig-i011-20230731   clang
i386                 randconfig-i012-20230731   clang
i386                 randconfig-i013-20230731   clang
i386                 randconfig-i014-20230731   clang
i386                 randconfig-i015-20230731   clang
i386                 randconfig-i016-20230731   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r002-20230731   gcc  
microblaze           randconfig-r015-20230731   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                 randconfig-r026-20230801   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r022-20230801   gcc  
nios2                randconfig-r035-20230731   gcc  
nios2                randconfig-r036-20230731   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230731   gcc  
parisc               randconfig-r021-20230801   gcc  
parisc               randconfig-r031-20230731   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     tqm8548_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230731   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r034-20230731   gcc  
s390                 randconfig-r044-20230731   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r023-20230801   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r025-20230801   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230731   gcc  
x86_64       buildonly-randconfig-r002-20230731   gcc  
x86_64       buildonly-randconfig-r003-20230731   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230731   clang
x86_64               randconfig-x002-20230731   clang
x86_64               randconfig-x003-20230731   clang
x86_64               randconfig-x004-20230731   clang
x86_64               randconfig-x005-20230731   clang
x86_64               randconfig-x006-20230731   clang
x86_64               randconfig-x011-20230731   gcc  
x86_64               randconfig-x012-20230731   gcc  
x86_64               randconfig-x013-20230731   gcc  
x86_64               randconfig-x014-20230731   gcc  
x86_64               randconfig-x015-20230731   gcc  
x86_64               randconfig-x016-20230731   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
