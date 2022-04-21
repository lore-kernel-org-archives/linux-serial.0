Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC87BC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 21 Apr 2022 04:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351945AbiDUEw3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Apr 2022 00:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384157AbiDUEwP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Apr 2022 00:52:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32C412774
        for <linux-serial@vger.kernel.org>; Wed, 20 Apr 2022 21:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650516566; x=1682052566;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=S/mRuaVWGw4KG+bB04wt8O+jve+CCBgz9XG3Xrd8HnE=;
  b=Nwg1CVjgw3Zw51I2UlS3VOlKKAjJ5NX3dUnBV+ZzwN14dzyJ0BOuasL4
   6i+WgISw2oPtUkte3L9LBUENpdUmgmbYhly7RlSa+aECzgMSc1X9nUrHs
   uzMT2tqtGQ2Y3e6FiJ0klJ9F467PJK6CcMUpCL74Hp1+8qsxBycC61qGP
   iavrAmneFnunGFDlv9M0pCcvbJgxLl7c6qiHOQsIbud+5VVqI65qYD1lL
   26NTIPPzWsh0odQ56IpWC3Ey7SvC/jl12trM9vPJBquj8Rsk1wLs8jzQA
   Q3dnScgzR2Xt5FIOusDyEzpqb9DAgOQ2ruPcIJwP8y/djOo0j8EdMwnTD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="289350835"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="289350835"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 21:49:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="614725239"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 20 Apr 2022 21:49:25 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhOku-0007rw-Ou;
        Thu, 21 Apr 2022 04:49:24 +0000
Date:   Thu, 21 Apr 2022 12:49:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 48473802506d2d6151f59e0e764932b33b53cb3b
Message-ID: <6260e248.+26l3lSDquFE0Xp0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 48473802506d2d6151f59e0e764932b33b53cb3b  tty: n_gsm: fix missing update of modem controls after DLCI open

elapsed time: 798m

configs tested: 122
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc                      pcm030_defconfig
mips                     loongson1b_defconfig
arm                          lpd270_defconfig
arm                         lpc18xx_defconfig
powerpc                 canyonlands_defconfig
mips                       bmips_be_defconfig
arm                      jornada720_defconfig
xtensa                         virt_defconfig
powerpc                      chrp32_defconfig
ia64                      gensparse_defconfig
mips                         cobalt_defconfig
arm                            qcom_defconfig
sh                        apsh4ad0a_defconfig
xtensa                           allyesconfig
powerpc                 mpc8540_ads_defconfig
powerpc                 mpc837x_rdb_defconfig
openrisc                 simple_smp_defconfig
powerpc                 mpc834x_itx_defconfig
xtensa                    xip_kc705_defconfig
m68k                       bvme6000_defconfig
sh                   secureedge5410_defconfig
sh                   rts7751r2dplus_defconfig
h8300                       h8s-sim_defconfig
arm                          pxa910_defconfig
powerpc                      ep88xc_defconfig
sh                          rsk7269_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220420
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220420
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                              defconfig

clang tested configs:
riscv                randconfig-c006-20220420
mips                 randconfig-c004-20220420
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220420
powerpc              randconfig-c003-20220420
mips                         tb0219_defconfig
arm                         socfpga_defconfig
riscv                    nommu_virt_defconfig
powerpc                     skiroot_defconfig
powerpc                      ppc44x_defconfig
arm                          ep93xx_defconfig
powerpc                    gamecube_defconfig
arm                        neponset_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220420
riscv                randconfig-r042-20220420
hexagon              randconfig-r045-20220420
s390                 randconfig-r044-20220420

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
