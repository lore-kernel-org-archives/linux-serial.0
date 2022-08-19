Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0122FC00140
	for <linux-serial@archiver.kernel.org>; Fri, 19 Aug 2022 02:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243729AbiHSC7a (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Aug 2022 22:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241692AbiHSC73 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Aug 2022 22:59:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15529D2774
        for <linux-serial@vger.kernel.org>; Thu, 18 Aug 2022 19:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660877969; x=1692413969;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=20JSDe1RS+Eq7MkEfdAwatpnj47MqIHb2gbCbOepvtA=;
  b=Hrh29msjqgw3da7ozzga6ifTADJXUDf9hhbyTnTf5Ke64JK3s26IILqm
   tu0b1BGByttRioqyV3qtH2ftSlxWvpB0auXHURfEjwzrXk+FdxAitkkiD
   mjTrkx9Gf7BdmJI8dH2fv4oA8dp91sqspWB0k9/vLqJKWf5nad/U8sFtL
   3YmsAg/D7JVhYMEm/daJOYUWWpPbjOim5uHEzABeLci45ClNJSVRH4cdN
   y48daaFdyBIhlaoldLa+XayCeIkwwtlKU9Ey4J2L0+0WFMWI8js/EMgbY
   HSvrHuiU/dqqxMO81lA37X7rRsloMIH/RVfZMrZ/GjK6MNfzK457+xgMS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="354662582"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="354662582"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 19:59:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="608054023"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Aug 2022 19:59:27 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOsEI-0000zk-2I;
        Fri, 19 Aug 2022 02:59:26 +0000
Date:   Fri, 19 Aug 2022 10:58:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 b5a5b9d5f28d23b84f06b45c61dcad95b07d41bc
Message-ID: <62fefc5e.MA8EtQsWo7nkim1+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: b5a5b9d5f28d23b84f06b45c61dcad95b07d41bc  serial: document start_rx member at struct uart_ops

elapsed time: 723m

configs tested: 119
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
riscv                randconfig-r042-20220818
s390                 randconfig-r044-20220818
arc                  randconfig-r043-20220818
mips                      loongson3_defconfig
sh                          polaris_defconfig
arc                          axs103_defconfig
powerpc                       maple_defconfig
sh                        edosk7705_defconfig
i386                             allyesconfig
i386                                defconfig
powerpc                         wii_defconfig
sh                               j2_defconfig
mips                  decstation_64_defconfig
powerpc                      cm5200_defconfig
mips                            gpr_defconfig
sh                   rts7751r2dplus_defconfig
sh                                  defconfig
sh                               alldefconfig
arm                           sunxi_defconfig
arc                 nsimosci_hs_smp_defconfig
loongarch                        alldefconfig
m68k                                defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
loongarch                           defconfig
loongarch                         allnoconfig
um                                  defconfig
ia64                             alldefconfig
arm                            mps2_defconfig
sparc                             allnoconfig
m68k                         amcore_defconfig
xtensa                              defconfig
ia64                                defconfig
arm                           sama5_defconfig
sparc                       sparc64_defconfig
m68k                        m5307c3_defconfig
i386                          randconfig-c001
m68k                           sun3_defconfig
sh                           sh2007_defconfig
arm                          gemini_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm64                               defconfig
m68k                          hp300_defconfig
sh                          landisk_defconfig
openrisc                       virt_defconfig
arm                          pxa910_defconfig
sh                        apsh4ad0a_defconfig
arm                            pleb_defconfig
parisc                generic-64bit_defconfig
sh                          rsk7201_defconfig
mips                         db1xxx_defconfig
mips                       bmips_be_defconfig
arm                        clps711x_defconfig
arm                      footbridge_defconfig
arm                            qcom_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm                        realview_defconfig
arm                        keystone_defconfig
arm                             ezx_defconfig
xtensa                  audio_kc705_defconfig

clang tested configs:
hexagon              randconfig-r045-20220818
hexagon              randconfig-r041-20220818
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
mips                          ath25_defconfig
powerpc                          allmodconfig
mips                        omega2p_defconfig
arm                             mxs_defconfig
x86_64                        randconfig-k001
arm                  colibri_pxa270_defconfig
hexagon                             defconfig
arm                         bcm2835_defconfig
arm                         s5pv210_defconfig
arm                         shannon_defconfig
riscv                randconfig-r042-20220819
s390                 randconfig-r044-20220819
hexagon              randconfig-r045-20220819
hexagon              randconfig-r041-20220819

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
