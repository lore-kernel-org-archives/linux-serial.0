Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10278C00140
	for <linux-serial@archiver.kernel.org>; Fri, 29 Jul 2022 03:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiG2DTQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 Jul 2022 23:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiG2DTP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Jul 2022 23:19:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB7B7A51C
        for <linux-serial@vger.kernel.org>; Thu, 28 Jul 2022 20:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659064754; x=1690600754;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8V2X01Fx0uor5lnCqn2mDvR12EmxD/LGyQH3CUhhFB0=;
  b=RrArO1S8+ceg1AacpaDnKzGKSNJA8/MUEeKeTd/wpkU9sOClHE4sOXFO
   zYCQ/0fOIMlzupAl+3QTOnEMMlmpMtiizSI38tQkfb5H/UcvujnfpsNlz
   msDXc7sd0lvCLanQ0s80MkNAIIhjBdASYbVfQuXnRfHuoCKDpoxQ8Br3H
   qzPAdzIeRjjBcatyRWPsXN9sadGO/UJhD4TYcbnxX4Zaqqm34LzLXLiOH
   8DsrtjJ7n1U/e5mKJy8YF1lNH2DtDD7XBoJRdPD8DfD+gegYbg9U9LRnN
   CslchHGfYs6K4g5ZIrr9TfLLjiFrCZst6ks2lQifAnV6FeXIvcHWww/7x
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="288692203"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="288692203"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 20:19:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="576777484"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Jul 2022 20:19:13 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHGWu-000Aza-1Y;
        Fri, 29 Jul 2022 03:19:12 +0000
Date:   Fri, 29 Jul 2022 11:18:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 014482b667d3550d7a610c5f11b6351fe47eb39a
Message-ID: <62e351a3.qS3LrkoPqoYlKYQq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 014482b667d3550d7a610c5f11b6351fe47eb39a  tty: amiserial: Fix comment typo

elapsed time: 739m

configs tested: 89
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
ia64                             allmodconfig
i386                                defconfig
arm                                 defconfig
i386                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a004
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a002
arc                  randconfig-r043-20220728
riscv                randconfig-r042-20220728
s390                 randconfig-r044-20220728
x86_64                        randconfig-a006
arm64                            allyesconfig
arm                              allyesconfig
powerpc                           allnoconfig
i386                          randconfig-a014
i386                          randconfig-a012
powerpc                          allmodconfig
i386                          randconfig-a016
mips                             allyesconfig
sh                               allmodconfig
loongarch                           defconfig
loongarch                         allnoconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
ia64                        generic_defconfig
sh                           se7343_defconfig
arm                            mps2_defconfig
openrisc                    or1ksim_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
m68k                        m5407c3_defconfig
powerpc                     taishan_defconfig
sh                         ap325rxa_defconfig
powerpc                      tqm8xx_defconfig
arm                          lpd270_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
xtensa                  cadence_csp_defconfig
mips                           ip32_defconfig
arc                            hsdk_defconfig
sh                 kfr2r09-romimage_defconfig
sh                     sh7710voipgw_defconfig
mips                 randconfig-c004-20220728
powerpc              randconfig-c003-20220728
i386                          randconfig-c001
nios2                               defconfig
m68k                            mac_defconfig
s390                       zfcpdump_defconfig
openrisc                         alldefconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a014
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a012
hexagon              randconfig-r045-20220728
hexagon              randconfig-r041-20220728
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
powerpc                   microwatt_defconfig
powerpc                      ppc64e_defconfig
powerpc                      katmai_defconfig
mips                          rm200_defconfig
arm                  colibri_pxa270_defconfig
arm                      pxa255-idp_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                 mpc836x_mds_defconfig
riscv                             allnoconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
