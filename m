Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A14C43217
	for <linux-serial@archiver.kernel.org>; Wed,  2 Nov 2022 19:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKBTiQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Nov 2022 15:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKBTiO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Nov 2022 15:38:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46A41006
        for <linux-serial@vger.kernel.org>; Wed,  2 Nov 2022 12:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667417892; x=1698953892;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TTLTeuHSKo6ds6rrlmONPNZirietQ6qL7O5TNK+plKs=;
  b=Ecz9O+9sJF2BDGXBX/yEStDnadI/eUE6WDIToBx1QpDqF7/x7q6Mnilj
   9MO0dKds5q4SuZ4mbjaYPhNvxI+tfJ8/scHrD2dTL6bZ4kOU8H1clihxe
   Bt3bUdS9FNOZNvUXVzmqepN92QNfq8LEBs8HNSEKL/FqZLH2PiGScFoQ2
   NZtCmbVphK/izgE1EEAExLGdnFOBD1bjcAUfPucLPoWuoUv0HPaXc4zYg
   ywMF7VHfNOVOY0j6B5w5lW7ZuxK36L080PRtaZXBwALwp+/RPzKxDcR51
   Ucg83iN66iwsdBg4KWmBs2Twww1+/oxO2jnFpcDCZPrKR9tpZjU6MHhpE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="308223474"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="308223474"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 12:38:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="667701689"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="667701689"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 02 Nov 2022 12:38:11 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqJYw-000F39-1x;
        Wed, 02 Nov 2022 19:38:10 +0000
Date:   Thu, 03 Nov 2022 03:37:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 72da688b457d738b943016dabc603efb1be5f4e1
Message-ID: <6362c700.tgO5eGfxPDbpuyZt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 72da688b457d738b943016dabc603efb1be5f4e1  tty: evh_bytechan: Replace NO_IRQ by 0

elapsed time: 721m

configs tested: 124
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a002
arc                                 defconfig
alpha                               defconfig
i386                          randconfig-a001
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a005
s390                                defconfig
x86_64                        randconfig-a004
arc                              allyesconfig
ia64                             allmodconfig
arc                  randconfig-r043-20221101
alpha                            allyesconfig
x86_64                               rhel-8.3
x86_64                              defconfig
m68k                             allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a014-20221031
m68k                             allmodconfig
i386                 randconfig-a011-20221031
mips                             allyesconfig
s390                             allmodconfig
sh                               allmodconfig
x86_64                        randconfig-a015
s390                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                           allyesconfig
sh                           se7724_defconfig
nios2                         3c120_defconfig
m68k                       bvme6000_defconfig
arm                          badge4_defconfig
powerpc                          allmodconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                             allyesconfig
i386                                defconfig
sh                           se7751_defconfig
powerpc                    sam440ep_defconfig
xtensa                          iss_defconfig
i386                          randconfig-c001
ia64                         bigsur_defconfig
arm                         axm55xx_defconfig
arm                       multi_v4t_defconfig
nios2                               defconfig
arm                           sama5_defconfig
arm                          pxa910_defconfig
ia64                          tiger_defconfig
sh                            hp6xx_defconfig
sh                     magicpanelr2_defconfig
arm                       omap2plus_defconfig
arm                         lubbock_defconfig
sparc                       sparc32_defconfig
microblaze                          defconfig
arm                         assabet_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                      rts7751r2d1_defconfig
mips                             allmodconfig
mips                    maltaup_xpa_defconfig
nios2                            allyesconfig
arm                            zeus_defconfig
openrisc                       virt_defconfig
arm                      jornada720_defconfig
mips                           xway_defconfig
arm                         vf610m4_defconfig
xtensa                       common_defconfig
arm                          lpd270_defconfig
m68k                         apollo_defconfig
mips                     decstation_defconfig
m68k                          multi_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
arm                        multi_v7_defconfig
arm                         s3c6400_defconfig
sh                        apsh4ad0a_defconfig
arm                           tegra_defconfig
sh                          rsk7203_defconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a002
x86_64                        randconfig-a003
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r041-20221101
hexagon              randconfig-r045-20221101
s390                 randconfig-r044-20221101
riscv                randconfig-r042-20221101
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20221102
hexagon              randconfig-r045-20221102
x86_64                        randconfig-a012
x86_64                        randconfig-a014
mips                       rbtx49xx_defconfig
hexagon                             defconfig
powerpc               mpc834x_itxgp_defconfig
x86_64                        randconfig-k001
powerpc                     kilauea_defconfig
riscv                randconfig-r042-20221103
hexagon              randconfig-r041-20221103
hexagon              randconfig-r045-20221103
s390                 randconfig-r044-20221103
arm                       netwinder_defconfig
arm                         bcm2835_defconfig
powerpc                      ppc44x_defconfig
riscv                    nommu_virt_defconfig
arm                         socfpga_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
