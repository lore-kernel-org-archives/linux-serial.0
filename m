Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCD8C19F28
	for <linux-serial@archiver.kernel.org>; Wed,  3 Aug 2022 18:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiHCStW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 3 Aug 2022 14:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbiHCStW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 3 Aug 2022 14:49:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5055A2D5
        for <linux-serial@vger.kernel.org>; Wed,  3 Aug 2022 11:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659552561; x=1691088561;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PVFJ+W1+V2F8+E0v5Cs8PRQ84wGwqYgt+0KK4TrU+7U=;
  b=bqcgm/mwKqPNI3sXeDjiJuiMenFvtyBV55y0SCURtro2crJQptX5wDuJ
   fsalWlOMfrsNYQ/W3+YOry1vBnqegdBr2R+Tb+kev84DaTnShbj527kBV
   OctTXo+s0lrUEDFcE83fE3NvxYPdkhqC3AX0UZJ/6TUTXwk20LFYofYb/
   L83NkHnniJ1wLH7faRxbfiG1oBwO/5dnrP1Vj2sUv1NTHWPMostbFnEY9
   xGMceXi/oD2m/hBFb3p5Ct0HgbyY5FBYf5JsOyzGeKR0En43VaBXTPzus
   DXGIFDw9V1W5pMRr4ZhCXiC9P6eBH791UQ0+hmV9pccwZ78fUXlRX4s1u
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="315620092"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="315620092"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 11:49:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="578763872"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Aug 2022 11:49:19 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJJQk-000HZN-1d;
        Wed, 03 Aug 2022 18:49:18 +0000
Date:   Thu, 04 Aug 2022 02:48:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 0fec518018cc5ceffa706370b6e3acbbb1e3c798
Message-ID: <62eac317.kvsZ8KsEGYuo4VaF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 0fec518018cc5ceffa706370b6e3acbbb1e3c798  tty: serial: qcom-geni-serial: Fix %lu -> %u in print statements

elapsed time: 717m

configs tested: 81
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a014
x86_64                              defconfig
s390                 randconfig-r044-20220803
i386                          randconfig-a012
x86_64                               rhel-8.3
i386                          randconfig-a016
powerpc                           allnoconfig
x86_64                           allyesconfig
i386                          randconfig-a001
arm                                 defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
i386                          randconfig-a003
powerpc                          allmodconfig
mips                             allyesconfig
arm                              allyesconfig
sh                               allmodconfig
m68k                             allmodconfig
riscv                randconfig-r042-20220803
i386                          randconfig-a005
arm64                            allyesconfig
x86_64                           rhel-8.3-kvm
arc                              allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
ia64                             allmodconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
ia64                             alldefconfig
mips                            ar7_defconfig
arm                       multi_v4t_defconfig
xtensa                              defconfig
arm64                               defconfig
um                                  defconfig
sh                         microdev_defconfig
sh                          urquell_defconfig
powerpc              randconfig-c003-20220803
i386                          randconfig-c001
arm                           h5000_defconfig
m68k                           sun3_defconfig
sh                             shx3_defconfig
loongarch                           defconfig
arm                        cerfcube_defconfig
arm                           tegra_defconfig
nios2                               defconfig
loongarch                         allnoconfig
m68k                            mac_defconfig
sh                   secureedge5410_defconfig
arm                      footbridge_defconfig
sh                          landisk_defconfig
powerpc                      makalu_defconfig
sh                          sdk7780_defconfig
arm                            qcom_defconfig

clang tested configs:
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a002
hexagon              randconfig-r041-20220803
i386                          randconfig-a013
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r045-20220803
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a014
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
