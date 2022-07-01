Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21227C43334
	for <linux-serial@archiver.kernel.org>; Fri,  1 Jul 2022 03:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbiGADu1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Jun 2022 23:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbiGADuZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Jun 2022 23:50:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC4765D7E
        for <linux-serial@vger.kernel.org>; Thu, 30 Jun 2022 20:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656647425; x=1688183425;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/5x9g8gnT7bfjuIsBexR7oiuk8RZumhLcQKHkaxgics=;
  b=fyaNUDpeVhzSd1mHwBRIGwF3ohuiGC8rLvUGcRgKlDIDZTXmsFHgXLwJ
   IyNg6QXgi6kpPNjJi6fyaTU8BLOALBHqGBX02+1JEe1kvjuVC2NpwC8y+
   7DlatyzayggS0aEONMg3CkqkkMj53d9ZvEgFJCupOWzxZkmH/p1Lgd+Wc
   HDhdz4qhMV8Pumuv4Uj56uhy3iaRrNLzeynqfX1pyzvCvrtM2WJZVm65l
   esFsBOzL9W9hSU/arjG+mrOzQ+Qd8loO3Bt97va9cd3M+hF8ypVJrvTEH
   Wvnc3I2HNGUXfamnV+yOBj15QqyxszxqoOWt/PBl9RAuH5QmqsfRkIfk1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="282574332"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="282574332"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 20:50:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="596084048"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2022 20:50:23 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o77fi-000DV0-Of;
        Fri, 01 Jul 2022 03:50:22 +0000
Date:   Fri, 01 Jul 2022 11:50:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 b941e487152e0909ef43faacae6eeee266d9b378
Message-ID: <62be6eec.qUBS1y+8jWv47Bcm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: b941e487152e0909ef43faacae6eeee266d9b378  serial: 8250: dw: Fix the macro RZN1_UART_xDMACR_8_WORD_BURST

elapsed time: 725m

configs tested: 52
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20220629
s390                 randconfig-r044-20220629
riscv                randconfig-r042-20220629
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20220629
hexagon              randconfig-r041-20220629

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
