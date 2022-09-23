Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E48ECAAD8
	for <linux-serial@archiver.kernel.org>; Fri, 23 Sep 2022 03:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiIWDRd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Sep 2022 23:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiIWDRc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Sep 2022 23:17:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31986115A59
        for <linux-serial@vger.kernel.org>; Thu, 22 Sep 2022 20:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663903051; x=1695439051;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FyWyuBn3TVL1ZosfRbu1mnqFR9j4jNh9Ap6fPZNsCuQ=;
  b=W4Yif7CVBNYubqPA06VF8gJYkKfzJniLWElGNEHSo4VHsRS7fjhafznb
   ILBErcxvkNoIdXeevoeInL2XSPGR5rju7xMpshC0TVwiznIUn+NEwr1x4
   JLVeYvFkdMsFxM8rM2RUMD0uKns6tubU/UjnJhltGjtPbwHe31aiQxZEo
   loWgwg3Fj/cc9FTq/W3A2GoP4Uq1Y4z8qOb8h404MZzZJcgozQwMbzMQS
   ow0wGaq+8el5edCN0XQNzbilBIn9zQjndMduEUv3lgY/FDRH8LQmdr8AJ
   4cfKGfGMSxh8m410WfQFTuZSym59nOkCfZTMHDy8VhdpMzZHngWKhAIAK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="280221824"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="280221824"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 20:17:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="597716499"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Sep 2022 20:17:29 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obZBx-0005Gc-0R;
        Fri, 23 Sep 2022 03:17:29 +0000
Date:   Fri, 23 Sep 2022 11:16:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 adafbbf6895eb0ce41a313c6ee68870ab9aa93cd
Message-ID: <632d2510.fOX6a/rceaid1Q1b%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: adafbbf6895eb0ce41a313c6ee68870ab9aa93cd  serial: stm32: Deassert Transmit Enable on ->rs485_config()

elapsed time: 724m

configs tested: 89
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                  randconfig-r043-20220922
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a013
x86_64                        randconfig-a011
m68k                             allmodconfig
alpha                            allyesconfig
x86_64                           allyesconfig
arc                              allyesconfig
x86_64                        randconfig-a015
arc                                 defconfig
s390                             allmodconfig
m68k                             allyesconfig
alpha                               defconfig
i386                          randconfig-a001
i386                                defconfig
s390                                defconfig
powerpc                           allnoconfig
i386                          randconfig-a003
arm                                 defconfig
x86_64                        randconfig-a002
s390                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-a005
powerpc                          allmodconfig
x86_64                        randconfig-a006
mips                             allyesconfig
sh                               allmodconfig
x86_64                        randconfig-a004
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
csky                              allnoconfig
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
microblaze                          defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220922
i386                          randconfig-c001
sparc                               defconfig
loongarch                        alldefconfig
xtensa                       common_defconfig
m68k                        stmark2_defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
arm                        cerfcube_defconfig
arm                           viper_defconfig

clang tested configs:
hexagon              randconfig-r041-20220922
riscv                randconfig-r042-20220922
hexagon              randconfig-r045-20220922
s390                 randconfig-r044-20220922
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a002
x86_64                        randconfig-a001
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a003
i386                          randconfig-a013
x86_64                        randconfig-a005
i386                          randconfig-a011
i386                          randconfig-a015
mips                     loongson1c_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
