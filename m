Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821D4C433FE
	for <linux-serial@archiver.kernel.org>; Thu, 24 Nov 2022 08:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiKXIyI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Nov 2022 03:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiKXIyH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Nov 2022 03:54:07 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E981C9A5E7
        for <linux-serial@vger.kernel.org>; Thu, 24 Nov 2022 00:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669280043; x=1700816043;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=l6RCoWYGhJ6FwrLCqn1ZF+LXAXaW/jbLRsPFVgyOCgI=;
  b=H3M2Jbh8mXIhjNmNQs9LPmOCsHWl2BILNZ5GiWxY5V6fhMv4luCbl+E3
   fWJEQo2KJUQPPvujdVPUg4QqhJ9Zryp1gRBfKB0gtX5i5nyoCGYfHIZoY
   PNGr37VbBptNZcI27lk/8UN8LsACWyMqPt1GC90Pr1rsnFFB5F46qi9D8
   sssqBRu7WI9pGBd5a5veGqiyoxbfdZKgtOB3A5MC+QclWr0BwIfKo+kV1
   pi397mqpX2MdjZFmEKG6d7+WzzLyjARR9f+qoBEbdWrnsEWwrKYJZsfbF
   rNWQuUSDKdzmLKhyvpfge8boX1hKvFTz+sB9rKiRFQxoX2Z7np/wEnkWp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="314289608"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="314289608"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 00:54:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="642243084"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="642243084"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Nov 2022 00:54:02 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oy7zd-0003gb-1C;
        Thu, 24 Nov 2022 08:54:01 +0000
Date:   Thu, 24 Nov 2022 16:53:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 6373ab4dfee731deec62b4452ea641611feff9b3
Message-ID: <637f30f7.JEQMR0Trq0M+Xbic%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 6373ab4dfee731deec62b4452ea641611feff9b3  serial: atmel: don't stop the transmitter when doing PIO

elapsed time: 1450m

configs tested: 80
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
sh                               allmodconfig
arc                                 defconfig
powerpc                          allmodconfig
s390                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a012-20221121
i386                 randconfig-a014-20221121
i386                 randconfig-a015-20221121
i386                 randconfig-a016-20221121
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                                defconfig
x86_64               randconfig-a011-20221121
x86_64               randconfig-a015-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a014-20221121
x86_64               randconfig-a012-20221121
i386                             allyesconfig
x86_64               randconfig-a016-20221121
arc                  randconfig-r043-20221121
riscv                randconfig-r042-20221121
s390                 randconfig-r044-20221121
x86_64                            allnoconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm                                 defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                         lpc18xx_defconfig
mips                         db1xxx_defconfig
arm                         assabet_defconfig
mips                     loongson1b_defconfig
ia64                          tiger_defconfig
powerpc                     redwood_defconfig
arm                          lpd270_defconfig
sh                           se7724_defconfig
powerpc                       ppc64_defconfig
sh                          r7785rp_defconfig
arm                             pxa_defconfig
arm                     eseries_pxa_defconfig
sh                           se7721_defconfig
sh                          polaris_defconfig
mips                         cobalt_defconfig
arm                         nhk8815_defconfig

clang tested configs:
x86_64               randconfig-a001-20221121
x86_64               randconfig-a003-20221121
x86_64               randconfig-a002-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a006-20221121
x86_64               randconfig-a005-20221121
i386                 randconfig-a004-20221121
i386                 randconfig-a001-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a006-20221121
hexagon              randconfig-r041-20221121
hexagon              randconfig-r045-20221121
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
