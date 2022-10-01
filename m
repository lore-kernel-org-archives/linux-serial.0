Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A107C433FE
	for <linux-serial@archiver.kernel.org>; Sat,  1 Oct 2022 16:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJAQMn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 1 Oct 2022 12:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiJAQMn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 1 Oct 2022 12:12:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073C98E9A5
        for <linux-serial@vger.kernel.org>; Sat,  1 Oct 2022 09:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664640762; x=1696176762;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9j2n47svfkSsL577296HTv7GR7KBQIorj2z80ze+dnc=;
  b=kQ/DKFhkTXeHeB4IDN8BqzhEEn4NOkzLbJdAx/53TqPElCiuR/Erjg1+
   saXzAXBodpqt5riv8oxtAITT8H6YNo0kIgsQTlafEbqw3nnpYfVtAfM9f
   VTjIkXw4fpHIMA2G4hDRjC1qlPDvXOEphElgGR3fr7aWclcvYqIK1jIam
   BcxDsMznPYTbmalITuXuwCiRqR/voy58vUOcksWbpq8AvudOdRbC9McD5
   i8wnpLMqdp9lfg14G4UsN7x1TNZ94TwIZKbSb8uSPPGgFoRb/w6Vu6xsI
   yW4ECYBQ3K/6mZCxnuK50RY08s92ccodBIxDYSwM/5s+7NUfojaikJDst
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="328784143"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="328784143"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 09:12:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="623098929"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="623098929"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 Oct 2022 09:12:40 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oef6V-0002Rp-23;
        Sat, 01 Oct 2022 16:12:39 +0000
Date:   Sun, 02 Oct 2022 00:12:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 30963b2f75bfdbbcf1cc5d80bf88fec7aaba808d
Message-ID: <633866e0.LDz3Pc109n3cL+qx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 30963b2f75bfdbbcf1cc5d80bf88fec7aaba808d  serial: cpm_uart: Don't request IRQ too early for console port

elapsed time: 1626m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
arc                                 defconfig
x86_64                           rhel-8.3-syz
powerpc                           allnoconfig
x86_64                         rhel-8.3-kunit
alpha                               defconfig
x86_64                           rhel-8.3-kvm
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
x86_64                          rhel-8.3-func
arc                              allyesconfig
x86_64                    rhel-8.3-kselftests
alpha                            allyesconfig
x86_64                              defconfig
arm                                 defconfig
i386                             allyesconfig
x86_64                               rhel-8.3
i386                 randconfig-a001-20220926
s390                                defconfig
i386                 randconfig-a004-20220926
m68k                             allyesconfig
i386                 randconfig-a002-20220926
s390                             allmodconfig
i386                 randconfig-a003-20220926
m68k                             allmodconfig
i386                 randconfig-a006-20220926
i386                 randconfig-a005-20220926
s390                             allyesconfig
x86_64                           allyesconfig
arc                  randconfig-r043-20220928
arm64                            allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
arc                  randconfig-r043-20220925
riscv                randconfig-r042-20220925
arc                  randconfig-r043-20220926
s390                 randconfig-r044-20220925
ia64                             allmodconfig

clang tested configs:
i386                 randconfig-a011-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a016-20220926
i386                 randconfig-a015-20220926
i386                 randconfig-a014-20220926
hexagon              randconfig-r045-20220928
x86_64               randconfig-a012-20220926
x86_64               randconfig-a014-20220926
hexagon              randconfig-r041-20220928
riscv                randconfig-r042-20220928
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a015-20220926
s390                 randconfig-r044-20220928
x86_64               randconfig-a016-20220926
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220926
hexagon              randconfig-r045-20220926
hexagon              randconfig-r041-20220925
i386                          randconfig-a006
riscv                randconfig-r042-20220926
s390                 randconfig-r044-20220926

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
