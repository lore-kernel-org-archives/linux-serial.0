Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF0DC4332F
	for <linux-serial@archiver.kernel.org>; Thu,  3 Nov 2022 15:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiKCPqd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Nov 2022 11:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiKCPqc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Nov 2022 11:46:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0811D9
        for <linux-serial@vger.kernel.org>; Thu,  3 Nov 2022 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667490390; x=1699026390;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vQqioxYwDLRD7ltBhQZeVAHaMTZUDlIQO8TmhMoNCbQ=;
  b=YzOeJioXNH/CkX3ndu9pHodvLVm9/O0umhns/c2UtcGg576DfZ9PsTIJ
   6dXuVtD2IooyE8uUgJyGQSNcG8pX7oOOx0XeYkCTyX8h2CQIAxllLJjRg
   tgk3uIM3UPjBClnP91gyJC95FjZohVm6k1u3GzF5re72P5e51wPesdrje
   DRk0pmDarilzFTmFjQHLevd5JP6h+1v77VIxlqACEIALI0x9jhV0fS9xh
   qVksEOYakbZFqcKgfqZawYxSegSe9+GO/uisLcNnbwDCwvJQfek3G9kjr
   gsQud8DH8sSmzzsCRcB12wT9T5jAMlt0Bm8k1JjKxA+kKStxRE9TLeh9z
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="396025281"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="396025281"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 08:46:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="963978493"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="963978493"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 03 Nov 2022 08:46:29 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqcQH-000G33-03;
        Thu, 03 Nov 2022 15:46:29 +0000
Date:   Thu, 03 Nov 2022 23:45:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 7b7dfe4833c70a11cdfa51b38705103bd31eddaa
Message-ID: <6363e218.KMuC+XU5ul6eWQcz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 7b7dfe4833c70a11cdfa51b38705103bd31eddaa  tty: n_gsm: fix sleep-in-atomic-context bug in gsm_control_send

elapsed time: 723m

configs tested: 99
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
arc                  randconfig-r043-20221102
riscv                randconfig-r042-20221102
i386                          randconfig-a001
s390                 randconfig-r044-20221102
i386                          randconfig-a003
x86_64                        randconfig-a002
arc                                 defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                             allyesconfig
i386                          randconfig-a005
s390                             allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                        randconfig-a015
arm                                 defconfig
x86_64                        randconfig-a006
alpha                               defconfig
i386                          randconfig-a016
x86_64                        randconfig-a004
s390                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                                defconfig
um                                  defconfig
riscv                               defconfig
arm                        keystone_defconfig
openrisc                    or1ksim_defconfig
ia64                             allmodconfig
arm                              allyesconfig
m68k                             allyesconfig
arm64                            allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arm                        clps711x_defconfig
csky                                defconfig
powerpc                     stx_gp3_defconfig
sh                      rts7751r2d1_defconfig
mips                       bmips_be_defconfig
m68k                           sun3_defconfig
arm                         nhk8815_defconfig
i386                          randconfig-c001
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arm                        multi_v7_defconfig
arm                         s3c6400_defconfig
sh                        apsh4ad0a_defconfig
arm                           tegra_defconfig
sh                          rsk7203_defconfig
m68k                         apollo_defconfig
mips                     decstation_defconfig
sparc                       sparc32_defconfig
m68k                          multi_defconfig
m68k                       m5208evb_defconfig
powerpc                         wii_defconfig
m68k                       m5275evb_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
parisc64                            defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
arm                            pleb_defconfig

clang tested configs:
hexagon              randconfig-r041-20221102
hexagon              randconfig-r045-20221102
i386                          randconfig-a013
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a015
x86_64                        randconfig-a005
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a011
i386                          randconfig-a006
x86_64                        randconfig-a003
arm                         socfpga_defconfig
arm                      tct_hammer_defconfig
arm                         mv78xx0_defconfig
mips                     loongson1c_defconfig
mips                           mtx1_defconfig
powerpc               mpc834x_itxgp_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
