Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B946BC433E9
	for <linux-serial@archiver.kernel.org>; Mon,  1 Feb 2021 01:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8133364E15
	for <linux-serial@archiver.kernel.org>; Mon,  1 Feb 2021 01:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhBABR4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 31 Jan 2021 20:17:56 -0500
Received: from mga14.intel.com ([192.55.52.115]:1044 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbhBABRm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 31 Jan 2021 20:17:42 -0500
IronPort-SDR: Dq3FEw+oDzv/eQFFQwgB0KIE9uYUJeIKvg4IZDXXNlk719i/g8wfL5Na/jvMA8LV6djzlc1xCv
 2x3TkGAjwTVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="179842531"
X-IronPort-AV: E=Sophos;i="5.79,391,1602572400"; 
   d="scan'208";a="179842531"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2021 17:17:00 -0800
IronPort-SDR: WQQUTW2/knWHFjwTxtDUo9EwXBj81NeyeauECw0HMtVM7GTF0up6/OuhCeoSP9jFCnx9RdwWV3
 B81ATpxoU7/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,391,1602572400"; 
   d="scan'208";a="478442773"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2021 17:16:59 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l6Npq-0006Gp-Pj; Mon, 01 Feb 2021 01:16:58 +0000
Date:   Mon, 01 Feb 2021 09:16:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 81004f0bf7f04fcdb6344692a563c49897424f14
Message-ID: <60175677.8F1enyJrx+/wTt6S%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 81004f0bf7f04fcdb6344692a563c49897424f14  dt-bindings: serial: imx: Switch to my personal address

i386-tinyconfig vmlinux size:

+-------+-------------------------+------------------------------------------+
| DELTA |         SYMBOL          |                  COMMIT                  |
+-------+-------------------------+------------------------------------------+
|  +471 | TOTAL                   | 5c8fe583cce5..81004f0bf7f0 (ALL COMMITS) |
|  +465 | TEXT                    | 5c8fe583cce5..81004f0bf7f0 (ALL COMMITS) |
|  +101 | kernel_fpu_begin_mask() | 5c8fe583cce5..81004f0bf7f0 (ALL COMMITS) |
|   +91 | shrink_page_list()      | 5c8fe583cce5..81004f0bf7f0 (ALL COMMITS) |
|   -87 | kernel_fpu_begin()      | 5c8fe583cce5..81004f0bf7f0 (ALL COMMITS) |
+-------+-------------------------+------------------------------------------+

elapsed time: 725m

configs tested: 98
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                   bluestone_defconfig
arm                           stm32_defconfig
arm                         lubbock_defconfig
arm                        mvebu_v7_defconfig
sh                        sh7757lcr_defconfig
sh                     magicpanelr2_defconfig
sh                             sh03_defconfig
sh                         microdev_defconfig
mips                       capcella_defconfig
arm                          iop32x_defconfig
sh                           se7780_defconfig
mips                           ip27_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                     pseries_defconfig
arm                           tegra_defconfig
powerpc                  iss476-smp_defconfig
powerpc                      obs600_defconfig
arm                         s3c6400_defconfig
mips                        maltaup_defconfig
arm                            xcep_defconfig
powerpc                 canyonlands_defconfig
arm                           sunxi_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210131
i386                 randconfig-a003-20210131
i386                 randconfig-a002-20210131
i386                 randconfig-a001-20210131
i386                 randconfig-a004-20210131
i386                 randconfig-a006-20210131
x86_64               randconfig-a015-20210131
x86_64               randconfig-a011-20210131
x86_64               randconfig-a014-20210131
x86_64               randconfig-a016-20210131
x86_64               randconfig-a012-20210131
x86_64               randconfig-a013-20210131
i386                 randconfig-a013-20210131
i386                 randconfig-a011-20210131
i386                 randconfig-a015-20210131
i386                 randconfig-a012-20210131
i386                 randconfig-a014-20210131
i386                 randconfig-a016-20210131
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210131
x86_64               randconfig-a002-20210131
x86_64               randconfig-a001-20210131
x86_64               randconfig-a005-20210131
x86_64               randconfig-a006-20210131
x86_64               randconfig-a003-20210131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
