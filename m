Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2D5C6FD1D
	for <linux-serial@archiver.kernel.org>; Sat, 18 Mar 2023 02:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCRCid (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Mar 2023 22:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjCRCic (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Mar 2023 22:38:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA06F61536
        for <linux-serial@vger.kernel.org>; Fri, 17 Mar 2023 19:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679107110; x=1710643110;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2SxiZpDPdFCQV7pyblOLduEbPQ1H13bUn32SUpYlZ8A=;
  b=K6ty/OblJ4ErWbCY7M1dtJ7eMsR8KIpFYkeyEucF/RL2sHoOCYDhzKy6
   joGZaEWLkqYOcNGZkHni20IOEwcVOBAQ7mr3RJlKgnZo2dDo6Agpgch8s
   d3qP6jgYhEP+RSMC7nnoFH/nHlXt8LrENYczMkQEEjoHwoAEPbJr663ht
   hcLQAwko+UhulQNWm9bLkced7Uz9NxUBFRFpGPQndyxa3HXYPmL7HcY9n
   m6kPusut1h6Ygf3dZstUcRBZg8FOAYBcEJnIhqu1QpTosP72WaLKhNo39
   k0lGhrg0FhuZwpdRB9ONlakq0AacYVBqT6QaSxJnZanyuxezf5RaAnqFI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="338420309"
X-IronPort-AV: E=Sophos;i="5.98,270,1673942400"; 
   d="scan'208";a="338420309"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 19:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="744762225"
X-IronPort-AV: E=Sophos;i="5.98,270,1673942400"; 
   d="scan'208";a="744762225"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 17 Mar 2023 19:38:29 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdMSi-0009k1-2V;
        Sat, 18 Mar 2023 02:38:28 +0000
Date:   Sat, 18 Mar 2023 10:38:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 15ac1122fd6d4bf408a03e6f23c7ad4f60b22f9e
Message-ID: <6415240f.C3mTKItxXSdAFoQ2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 15ac1122fd6d4bf408a03e6f23c7ad4f60b22f9e  serial: 8250_bcm7271: Fix arbitration handling

elapsed time: 733m

configs tested: 118
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r026-20230312   gcc  
alpha                randconfig-r031-20230313   gcc  
alpha                randconfig-r033-20230313   gcc  
alpha                randconfig-r034-20230313   gcc  
alpha                randconfig-r036-20230313   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230312   gcc  
arc                  randconfig-r043-20230313   gcc  
arc                  randconfig-r043-20230315   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r011-20230312   clang
arm                  randconfig-r046-20230312   clang
arm                  randconfig-r046-20230313   gcc  
arm                  randconfig-r046-20230315   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r033-20230312   clang
arm64                randconfig-r035-20230313   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230317   gcc  
csky                 randconfig-r014-20230313   gcc  
csky                 randconfig-r025-20230313   gcc  
csky                 randconfig-r032-20230312   gcc  
hexagon              randconfig-r013-20230312   clang
hexagon              randconfig-r023-20230313   clang
hexagon              randconfig-r041-20230312   clang
hexagon              randconfig-r041-20230313   clang
hexagon              randconfig-r041-20230315   clang
hexagon              randconfig-r045-20230312   clang
hexagon              randconfig-r045-20230313   clang
hexagon              randconfig-r045-20230315   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230313   gcc  
i386                 randconfig-a002-20230313   gcc  
i386                 randconfig-a003-20230313   gcc  
i386                 randconfig-a004-20230313   gcc  
i386                 randconfig-a005-20230313   gcc  
i386                 randconfig-a006-20230313   gcc  
i386                 randconfig-a011-20230313   clang
i386                 randconfig-a012-20230313   clang
i386                 randconfig-a013-20230313   clang
i386                 randconfig-a014-20230313   clang
i386                 randconfig-a015-20230313   clang
i386                 randconfig-a016-20230313   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r014-20230312   gcc  
ia64                 randconfig-r015-20230313   gcc  
ia64                 randconfig-r016-20230313   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r021-20230313   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r005-20230317   clang
nios2                               defconfig   gcc  
nios2                randconfig-r022-20230312   gcc  
nios2                randconfig-r031-20230312   gcc  
openrisc             randconfig-r032-20230313   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r025-20230312   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230313   clang
riscv                randconfig-r022-20230313   clang
riscv                randconfig-r024-20230312   gcc  
riscv                randconfig-r042-20230312   gcc  
riscv                randconfig-r042-20230313   clang
riscv                randconfig-r042-20230315   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r026-20230313   clang
s390                 randconfig-r036-20230312   clang
s390                 randconfig-r044-20230312   gcc  
s390                 randconfig-r044-20230313   clang
s390                 randconfig-r044-20230315   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r024-20230313   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230313   gcc  
sparc                randconfig-r034-20230312   gcc  
sparc64              randconfig-r013-20230313   gcc  
sparc64              randconfig-r015-20230312   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230313   gcc  
x86_64               randconfig-a002-20230313   gcc  
x86_64               randconfig-a003-20230313   gcc  
x86_64               randconfig-a004-20230313   gcc  
x86_64               randconfig-a005-20230313   gcc  
x86_64               randconfig-a006-20230313   gcc  
x86_64               randconfig-a011-20230313   clang
x86_64               randconfig-a012-20230313   clang
x86_64               randconfig-a013-20230313   clang
x86_64               randconfig-a014-20230313   clang
x86_64               randconfig-a015-20230313   clang
x86_64               randconfig-a016-20230313   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
