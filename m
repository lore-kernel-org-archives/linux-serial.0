Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C677EECAAD5
	for <linux-serial@archiver.kernel.org>; Mon,  5 Sep 2022 18:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiIESYA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 5 Sep 2022 14:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbiIESXs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Sep 2022 14:23:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1262528E0A
        for <linux-serial@vger.kernel.org>; Mon,  5 Sep 2022 11:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662402228; x=1693938228;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZZI0drPdHAap2qyf1Eirh2O7nIQbXLQlMw9KysmF2oY=;
  b=ICN4d04jfGexPI0Lt01oiSvLwzPvvv6CPx8NuboQqhL4hKvM2FwpaPMU
   USAAoQn6kmUy/5AdElgnrX51/AjhcZ2HpRiS6LgS3tBGNzMR0H+8ndwNt
   3Xx3pWJZ5LSKsrcYbAmp+eeoP3TFyxOTKX+l0V1D+JcoUrMFU+RJgNCAu
   LGA9Yqtnn1ETmLmdQJ0kV4CUFn7TgUqGXy1GRRk69XJSIliaSLczRIjnm
   kbGNUSN7io3wlz5BoSdPObUzX7ySg0uI+6bFR0+ehA/vpo/DnBAtDNyNs
   KH6SOxuyu9NjlaI53JikMrJU4keSh95oVMgt8HnWtnePCXoxRwSxl7oyW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="297223709"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="297223709"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 11:23:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="682138559"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 05 Sep 2022 11:23:46 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVGl7-0004QG-26;
        Mon, 05 Sep 2022 18:23:45 +0000
Date:   Tue, 06 Sep 2022 02:23:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 35f2e3c267f07a42bc1bf08081e963b3a33e6d7c
Message-ID: <63163ea0.iutkpx5k6CPnoQtR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 35f2e3c267f07a42bc1bf08081e963b3a33e6d7c  Merge 6.0-rc4 into tty-next

elapsed time: 727m

configs tested: 134
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                 randconfig-a001-20220905
x86_64                              defconfig
i386                 randconfig-a002-20220905
i386                                defconfig
x86_64               randconfig-a005-20220905
x86_64               randconfig-a006-20220905
i386                 randconfig-a003-20220905
x86_64               randconfig-a002-20220905
x86_64               randconfig-a004-20220905
arm                                 defconfig
arc                  randconfig-r043-20220905
x86_64               randconfig-a001-20220905
csky                              allnoconfig
m68k                             allyesconfig
x86_64                          rhel-8.3-func
powerpc                           allnoconfig
x86_64                               rhel-8.3
alpha                            allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
arc                               allnoconfig
arc                              allyesconfig
i386                 randconfig-a005-20220905
x86_64               randconfig-a003-20220905
arm                              allyesconfig
alpha                             allnoconfig
i386                 randconfig-a006-20220905
riscv                             allnoconfig
m68k                             allmodconfig
arm64                            allyesconfig
i386                             allyesconfig
ia64                             allmodconfig
i386                 randconfig-a004-20220905
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                             alldefconfig
powerpc                      mgcoge_defconfig
sh                           se7343_defconfig
arm                            mps2_defconfig
openrisc                    or1ksim_defconfig
sparc                               defconfig
sh                               j2_defconfig
sh                             espt_defconfig
sh                 kfr2r09-romimage_defconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                 randconfig-c001-20220905
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                       imx_v6_v7_defconfig
arc                              alldefconfig
arm                         axm55xx_defconfig
sh                           se7780_defconfig
sh                   sh7770_generic_defconfig
alpha                            alldefconfig
powerpc                      pasemi_defconfig
powerpc                      ep88xc_defconfig
sh                           se7721_defconfig
powerpc                  storcenter_defconfig
sh                               alldefconfig
arm                       omap2plus_defconfig
powerpc                         ps3_defconfig
arm                           sama5_defconfig
arm                            qcom_defconfig
nios2                            allyesconfig
sh                     magicpanelr2_defconfig
mips                           jazz_defconfig
m68k                            q40_defconfig
ia64                         bigsur_defconfig
powerpc                  iss476-smp_defconfig
mips                        vocore2_defconfig
arc                        vdk_hs38_defconfig
mips                         bigsur_defconfig
arm                            zeus_defconfig
m68k                          hp300_defconfig
arm                        realview_defconfig
arc                          axs103_defconfig
alpha                               defconfig
mips                     loongson1b_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
m68k                        m5272c3_defconfig
m68k                             alldefconfig
arm                  randconfig-c002-20220905
x86_64               randconfig-c001-20220905
mips                      loongson3_defconfig
arm                           h3600_defconfig
sh                        sh7757lcr_defconfig
arm                            hisi_defconfig
sh                          r7780mp_defconfig
openrisc                 simple_smp_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                             sh03_defconfig
powerpc                      pcm030_defconfig
riscv                               defconfig
powerpc                     tqm8541_defconfig
arm                           corgi_defconfig

clang tested configs:
i386                 randconfig-a012-20220905
i386                 randconfig-a011-20220905
s390                 randconfig-r044-20220905
x86_64               randconfig-a012-20220905
x86_64               randconfig-a011-20220905
x86_64               randconfig-a016-20220905
riscv                randconfig-r042-20220905
hexagon              randconfig-r041-20220905
x86_64               randconfig-a015-20220905
hexagon              randconfig-r045-20220905
i386                 randconfig-a016-20220905
x86_64               randconfig-a014-20220905
x86_64               randconfig-a013-20220905
arm                  colibri_pxa270_defconfig
powerpc                    socrates_defconfig
i386                 randconfig-a014-20220905
i386                 randconfig-a013-20220905
powerpc                     ksi8560_defconfig
i386                 randconfig-a015-20220905
powerpc                     akebono_defconfig
powerpc                      ppc64e_defconfig
arm                     davinci_all_defconfig
arm                           sama7_defconfig
powerpc                       ebony_defconfig
powerpc                      walnut_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                    mvme5100_defconfig
arm                        magician_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
