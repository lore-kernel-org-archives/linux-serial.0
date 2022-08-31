Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A121ECAAD4
	for <linux-serial@archiver.kernel.org>; Wed, 31 Aug 2022 00:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiHaAos (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 Aug 2022 20:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiHaAoF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Aug 2022 20:44:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103F7AF0DA
        for <linux-serial@vger.kernel.org>; Tue, 30 Aug 2022 17:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661906539; x=1693442539;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jDJ23HkisKzoffPNpUCyDldBsIj7dINOfGr8xxbZS3Q=;
  b=VMhsANpCy63jVrdoZK9Qm8i+SCJLLSj5Ob+BZvUxhfS0HTZ0dVRnZ0Aj
   NeWoJxnTJJsN+6QqtbkRtLpVjRAAhpwirJK3cGsr0k5WSGNizkG93VICm
   dGZQHr1Je83avXsXIwpVR8Eg9Fs2AnSloKnPmSWE1L+pjnAggt5Ql5rab
   KTgewQ7XXjaA/3AGlxDGRCd+XGoHhKz+YAB/Ez15zo5/Wnq5Bsk0WRgom
   UGYypuvgmp/ySLaDfEW8TL625qAFVr7ll+O6U3iJ8u04zoaV0QK19uHOE
   hXlcBixVVtGjEMXGxcjDVmOjs+CMHdrTuvGoAi7DKfl89/kb8fcqnkRL3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="282313035"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="282313035"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 17:41:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="645049326"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2022 17:41:40 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTBnY-0000nl-0d;
        Wed, 31 Aug 2022 00:41:40 +0000
Date:   Wed, 31 Aug 2022 08:41:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 cac8f7194111bc841b609fee5f1b20dad8f86ded
Message-ID: <630eae22.JsyM7BllLEVMAkRD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: cac8f7194111bc841b609fee5f1b20dad8f86ded  serial: tegra: Remove custom frame size calculation

elapsed time: 723m

configs tested: 117
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
m68k                             allmodconfig
arc                              allyesconfig
powerpc                          allmodconfig
alpha                            allyesconfig
arc                  randconfig-r043-20220830
mips                             allyesconfig
m68k                             allyesconfig
sh                               allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
arm                                 defconfig
x86_64                           allyesconfig
ia64                             allmodconfig
i386                          randconfig-a001
arc                                 defconfig
sh                            hp6xx_defconfig
arm                            pleb_defconfig
openrisc                       virt_defconfig
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm64                            allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a013
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a011
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a015
arm                         lubbock_defconfig
arc                           tb10x_defconfig
arc                          axs101_defconfig
xtensa                          iss_defconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm                       imx_v6_v7_defconfig
mips                           jazz_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     asp8347_defconfig
sh                           se7619_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
i386                          randconfig-c001
sparc                               defconfig
mips                      loongson3_defconfig
m68k                       m5475evb_defconfig
xtensa                  nommu_kc705_defconfig
mips                       bmips_be_defconfig
mips                        bcm47xx_defconfig
powerpc                       eiger_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                      integrator_defconfig
sh                          kfr2r09_defconfig
arm                         cm_x300_defconfig
nios2                            alldefconfig
openrisc                  or1klitex_defconfig
sparc                             allnoconfig
sh                           se7721_defconfig
sh                        edosk7760_defconfig
m68k                            mac_defconfig
arc                        nsimosci_defconfig
arm                        oxnas_v6_defconfig
mips                         bigsur_defconfig
m68k                          multi_defconfig
xtensa                              defconfig
powerpc                 mpc834x_itx_defconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc8540_ads_defconfig
xtensa                    smp_lx200_defconfig
arm                          lpd270_defconfig
openrisc                         alldefconfig
xtensa                  cadence_csp_defconfig
x86_64                           alldefconfig
arm                         nhk8815_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
hexagon              randconfig-r045-20220830
riscv                randconfig-r042-20220830
hexagon              randconfig-r041-20220830
s390                 randconfig-r044-20220830
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a001
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
arm                          pcm027_defconfig
x86_64                        randconfig-k001
i386                          randconfig-a011
i386                          randconfig-a015
arm                         s5pv210_defconfig
powerpc                     tqm8560_defconfig
mips                     loongson2k_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
