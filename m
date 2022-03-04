Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC525C433EF
	for <linux-serial@archiver.kernel.org>; Fri,  4 Mar 2022 02:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiCDCV0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Mar 2022 21:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiCDCVZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Mar 2022 21:21:25 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6D017CC61
        for <linux-serial@vger.kernel.org>; Thu,  3 Mar 2022 18:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646360439; x=1677896439;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=znn5aCz57RibmqUhVbWjVLWqoB296JsibHcME4WJDoA=;
  b=TtQ1Mxq3+m5itQngql31DRFl/0Pr/YqUxotlqMJBVeFiRi/1RMkKztM+
   4ek3MYIyXIwfTkwRdOM/+vESkEaWbXBvRleOhylTkhznLyrqnJ6u/jg8e
   PTnZZdsX6by/td8uyqTnjSUiTh6hcKLhW8516JeJKdIyOxSfPhNMyXG1g
   QjJZqgWWp0RVamUi0cuctr1xqp5nH/gEPwsi59YqFDyBpuJ4Gn6Zd0e+u
   dnqNIGMV/aKVB+7doiiENsv/IY/TMp7w5VXNVgAQpWnXJMwhexr/3Gv/j
   mSEKtkL+/UBdnloFxz7UG9yliE8yhtwh1I6VMnRqTN38bTuhtXWK6Cf20
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="317098337"
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="317098337"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 18:20:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="642352200"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 03 Mar 2022 18:20:37 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPxYb-0001A2-0y; Fri, 04 Mar 2022 02:20:37 +0000
Date:   Fri, 04 Mar 2022 10:19:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 3631e48df0dbfcce3b08f0ccafcaa587657379cd
Message-ID: <62217748.aM1Jby602fFe8Psu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 3631e48df0dbfcce3b08f0ccafcaa587657379cd  serial: samsung: Add samsung_early_read to support early kgdboc

elapsed time: 722m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
sh                            migor_defconfig
arm                           sunxi_defconfig
sh                             sh03_defconfig
m68k                       m5275evb_defconfig
sh                          kfr2r09_defconfig
sh                          r7780mp_defconfig
arm                           sama5_defconfig
arm                         lubbock_defconfig
sparc                       sparc64_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                   sh7724_generic_defconfig
sparc                            allyesconfig
powerpc                     taishan_defconfig
microblaze                          defconfig
m68k                        stmark2_defconfig
arm                         axm55xx_defconfig
xtensa                generic_kc705_defconfig
sh                          urquell_defconfig
powerpc                     ep8248e_defconfig
arm                         vf610m4_defconfig
m68k                          multi_defconfig
sh                           se7722_defconfig
sparc64                          alldefconfig
arm                          badge4_defconfig
um                           x86_64_defconfig
h8300                     edosk2674_defconfig
arc                        vdk_hs38_defconfig
arm                            hisi_defconfig
arm                            mps2_defconfig
arm                  randconfig-c002-20220302
arm                  randconfig-c002-20220303
arm                  randconfig-c002-20220304
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
mips                      maltaaprp_defconfig
i386                             allyesconfig
powerpc                      ppc64e_defconfig
mips                        workpad_defconfig
mips                           mtx1_defconfig
arm                        vexpress_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220304
hexagon              randconfig-r041-20220304
hexagon              randconfig-r045-20220303
riscv                randconfig-r042-20220303
hexagon              randconfig-r041-20220303

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
