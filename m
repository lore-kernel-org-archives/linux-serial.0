Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366D3ECAAD5
	for <linux-serial@archiver.kernel.org>; Thu,  8 Sep 2022 23:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiIHX5t (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Sep 2022 19:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiIHX5o (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Sep 2022 19:57:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B184B100407
        for <linux-serial@vger.kernel.org>; Thu,  8 Sep 2022 16:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662681458; x=1694217458;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jHsOdJ+nlb8Xz5i1sRFji/t9FXPx4cfznYZW28wfsB0=;
  b=RmnO9gDaL4kY3whA0357ARXKYMStjKj0FVGHdI9EX3kKhP2tAY75UwXj
   wx/VYie9KqYMlGxFbyb9UUYyEMqN7kg4qimJ5yU6/dCz4G2MGYhNhXZN8
   jD7KsRUjYoHyHEhmAAZQejQm3v9EFdt5VB3lLc/ZyXYiSQeb23+fA9aAU
   D88hN4JN1nvgGGdnUmAiy/VALkxoCHUHN8dX1FLr4vgJ08U4Zzp/4TPOd
   UvJBEi4dbN50EXBhBziZlWbAC/a02HTRi3Y+nCuby1gujHls50lkdRtnD
   G3zKMi8ERrDnZUaRZLU7k/Zpi1kwR/Z212q+a3Lul7gsJsrPQTr2hkTzN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="323555933"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="323555933"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 16:57:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="645310340"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 08 Sep 2022 16:57:36 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWROp-0000SD-2e;
        Thu, 08 Sep 2022 23:57:35 +0000
Date:   Fri, 09 Sep 2022 07:56:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 408e532e80997be64caf8cdf45f2ff53c2279725
Message-ID: <631a813a.zCpKgsqsF3F62mBo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 408e532e80997be64caf8cdf45f2ff53c2279725  tty: serial: qcom-geni-serial: Replace hardcoded icc flags with macros.

elapsed time: 1047m

configs tested: 172
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
x86_64                              defconfig
arc                              allyesconfig
mips                             allyesconfig
alpha                            allyesconfig
x86_64                               rhel-8.3
powerpc                          allmodconfig
i386                          randconfig-a001
sh                               allmodconfig
i386                          randconfig-a003
x86_64                        randconfig-a013
x86_64                        randconfig-a011
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a015
x86_64                           allyesconfig
i386                          randconfig-a005
x86_64                         rhel-8.3-kunit
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                           rhel-8.3-kvm
i386                          randconfig-a016
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20220908
riscv                randconfig-r042-20220908
arc                  randconfig-r043-20220907
s390                 randconfig-r044-20220908
i386                             allyesconfig
i386                                defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                             sh03_defconfig
sh                           se7750_defconfig
s390                             allmodconfig
xtensa                       common_defconfig
powerpc                         wii_defconfig
xtensa                  cadence_csp_defconfig
m68k                       m5275evb_defconfig
sh                         ap325rxa_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
microblaze                          defconfig
powerpc                        cell_defconfig
parisc64                         alldefconfig
arm                          pxa3xx_defconfig
arm                         s3c6400_defconfig
powerpc                     stx_gp3_defconfig
arm64                            alldefconfig
sh                           se7722_defconfig
sparc                             allnoconfig
arm                        cerfcube_defconfig
powerpc                      arches_defconfig
openrisc                 simple_smp_defconfig
powerpc                     asp8347_defconfig
i386                          randconfig-c001
loongarch                           defconfig
loongarch                         allnoconfig
sh                          r7785rp_defconfig
arm                          iop32x_defconfig
powerpc                     mpc83xx_defconfig
xtensa                generic_kc705_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                             alldefconfig
powerpc                     ep8248e_defconfig
m68k                          hp300_defconfig
m68k                        m5272c3_defconfig
arm                          exynos_defconfig
sparc                               defconfig
sh                     sh7710voipgw_defconfig
um                                  defconfig
sh                            titan_defconfig
arm                            mps2_defconfig
ia64                          tiger_defconfig
arc                              alldefconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                          r7780mp_defconfig
arm                            qcom_defconfig
arm                        realview_defconfig
xtensa                              defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
openrisc                            defconfig
sh                        sh7757lcr_defconfig
arm                      integrator_defconfig
sparc64                             defconfig
arc                     haps_hs_smp_defconfig
arm                         assabet_defconfig
arm                            zeus_defconfig
mips                            ar7_defconfig
mips                         rt305x_defconfig
arc                      axs103_smp_defconfig
openrisc                    or1ksim_defconfig
sh                             shx3_defconfig
mips                    maltaup_xpa_defconfig
mips                  maltasmvp_eva_defconfig
sh                        edosk7705_defconfig
mips                     decstation_defconfig
sh                          sdk7780_defconfig
arm                        mini2440_defconfig
sh                            shmin_defconfig
mips                 decstation_r4k_defconfig
arm                      footbridge_defconfig
arm                             pxa_defconfig
arm                           u8500_defconfig
powerpc                      mgcoge_defconfig
m68k                                defconfig
m68k                          multi_defconfig
sh                             espt_defconfig
sh                     magicpanelr2_defconfig
arm                            hisi_defconfig
xtensa                    smp_lx200_defconfig
m68k                          atari_defconfig
m68k                       m5475evb_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     tqm8548_defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
ia64                             allmodconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a013
x86_64                        randconfig-a016
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a015
s390                 randconfig-r044-20220907
hexagon              randconfig-r041-20220907
hexagon              randconfig-r041-20220908
riscv                randconfig-r042-20220907
hexagon              randconfig-r045-20220908
hexagon              randconfig-r045-20220907
powerpc                 mpc8315_rdb_defconfig
mips                           ip22_defconfig
x86_64                        randconfig-k001
powerpc                     tqm8540_defconfig
arm                           spitz_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                     akebono_defconfig
mips                      malta_kvm_defconfig
arm                    vt8500_v6_v7_defconfig
arm                      pxa255-idp_defconfig
s390                             alldefconfig
powerpc                        fsp2_defconfig
powerpc                 mpc8272_ads_defconfig
mips                        qi_lb60_defconfig
arm                          pcm027_defconfig
mips                           mtx1_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
