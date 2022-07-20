Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BE4C43334
	for <linux-serial@archiver.kernel.org>; Wed, 20 Jul 2022 00:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiGTAeo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Jul 2022 20:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiGTAen (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Jul 2022 20:34:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949A648E96
        for <linux-serial@vger.kernel.org>; Tue, 19 Jul 2022 17:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658277282; x=1689813282;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pZ7HJVjqMphN1sSxFdg4VbCIrylIxFpu+sD2evqaYSI=;
  b=i2CZEgkqa9JxbRWULZu54cNgKuVa6ofOGz7C6P4G/aWW3/Nl8nzD8t1C
   mJ5rZwJ5z78Gkqpwb1ZEsfbKCrdXjVCju9PqixdXBeLifSPXpHsH4xJGf
   6pHoZyG39GfHnqYWJAU8ZBzkE6pRTwbRp//SEnQKiOCBdub58KxrklYId
   9l1P+F5CmZFen43GgrtU27u37HBfA2E+pHV6nhIa+ILWfaBGaG3ywiis7
   ohREvcmIA3lrN1ZElXXVGXPaownd8aGTqKrHVSsoyRQMnbkH1vWVd7vY6
   Yh5JhDZqnkz4/GaNPfZVzr5WUnHWaBAkC6V5osrOze/I6yChNZn8VltLm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="312334103"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="312334103"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 17:34:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="573079789"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 19 Jul 2022 17:34:40 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDxfj-0006Gx-Fc;
        Wed, 20 Jul 2022 00:34:39 +0000
Date:   Wed, 20 Jul 2022 08:34:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 af77c56aa35325daa2bc2bed5c2ebf169be61b86
Message-ID: <62d74d9a.9A12Hh6otMM3D847%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: af77c56aa35325daa2bc2bed5c2ebf169be61b86  tty: vt: initialize unicode screen buffer

elapsed time: 726m

configs tested: 99
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220718
powerpc                    sam440ep_defconfig
xtensa                    smp_lx200_defconfig
m68k                             alldefconfig
arc                     haps_hs_smp_defconfig
powerpc                     pq2fads_defconfig
sh                         microdev_defconfig
arc                     nsimosci_hs_defconfig
m68k                          atari_defconfig
powerpc                     asp8347_defconfig
m68k                           virt_defconfig
mips                        bcm47xx_defconfig
powerpc                      ppc40x_defconfig
arm64                            alldefconfig
mips                            ar7_defconfig
powerpc                     ep8248e_defconfig
arc                        nsimosci_defconfig
sh                             shx3_defconfig
sh                        sh7757lcr_defconfig
mips                           jazz_defconfig
xtensa                  cadence_csp_defconfig
sh                           se7343_defconfig
arm                         at91_dt_defconfig
mips                      loongson3_defconfig
sh                        dreamcast_defconfig
xtensa                       common_defconfig
mips                            gpr_defconfig
sh                          lboxre2_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a014-20220718
x86_64               randconfig-a016-20220718
x86_64               randconfig-a012-20220718
x86_64               randconfig-a013-20220718
x86_64               randconfig-a015-20220718
x86_64               randconfig-a011-20220718
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                 randconfig-a015-20220718
i386                 randconfig-a011-20220718
i386                 randconfig-a012-20220718
i386                 randconfig-a014-20220718
i386                 randconfig-a016-20220718
i386                 randconfig-a013-20220718
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220718
riscv                randconfig-r042-20220718
s390                 randconfig-r044-20220718
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                    gamecube_defconfig
mips                      maltaaprp_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a004-20220718
i386                 randconfig-a001-20220718
i386                 randconfig-a005-20220718
i386                 randconfig-a006-20220718
i386                 randconfig-a002-20220718
i386                 randconfig-a003-20220718
hexagon              randconfig-r041-20220718
hexagon              randconfig-r045-20220718

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
