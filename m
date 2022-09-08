Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61D6C38145
	for <linux-serial@archiver.kernel.org>; Thu,  8 Sep 2022 06:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiIHG05 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Sep 2022 02:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIHG04 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Sep 2022 02:26:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5E3C6B59
        for <linux-serial@vger.kernel.org>; Wed,  7 Sep 2022 23:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662618415; x=1694154415;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=q99Tm8QnTTQTdDY3Uh7hMJPCKZHkNigrvyKEI7uJcUA=;
  b=YbOiDEfRFe0yGv7cuN6uz6j8yytPq4GYoM1+lVjC24GGrzrSl2ba+5M4
   VQQUU1r+qOym6uZ9P2mbMEhsBft3VsG/aXC23/c7B155ZCMVwzFKw+UML
   yzSF8cP1TEn4JGxc6SdVfXnc1QhlQLoUJjcRUgRDxub0CqEfXpQ4xvZdf
   DSzW5ICzKbpwdNRSj5DpD6eeLUBILhgdOFtYDPkIvVahOIxTVHW8eacms
   6HQ+uuxBDMNWW1/Br9VM/Ver3yGUyqlZqQSIzEiioWhNxxhJU/gEuq7m1
   m0BUGst51wm3+cg35bNkrQx/Z2ZHHgQWX070Ipao3n7ENDrtwfTpVV53r
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="280109931"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="280109931"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 23:26:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="565817074"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2022 23:26:54 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWB01-0007RV-2Q;
        Thu, 08 Sep 2022 06:26:53 +0000
Date:   Thu, 08 Sep 2022 14:25:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 1d10cd4da593bc0196a239dcc54dac24b6b0a74e
Message-ID: <63198af3.cbyURGuko+J3HoKU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 1d10cd4da593bc0196a239dcc54dac24b6b0a74e  serial: tegra-tcu: Use uart_xmit_advance(), fixes icount.tx accounting

elapsed time: 915m

configs tested: 118
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                        randconfig-a013
arc                  randconfig-r043-20220907
x86_64                        randconfig-a011
x86_64                           allyesconfig
sh                               allmodconfig
i386                          randconfig-a001
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a003
x86_64                        randconfig-a015
x86_64                        randconfig-a004
i386                          randconfig-a005
x86_64                        randconfig-a002
m68k                             allmodconfig
x86_64                        randconfig-a006
m68k                             allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
sparc                             allnoconfig
arm                        cerfcube_defconfig
powerpc                      arches_defconfig
openrisc                 simple_smp_defconfig
powerpc                     asp8347_defconfig
arm                          pxa3xx_defconfig
arm                         s3c6400_defconfig
powerpc                     stx_gp3_defconfig
arm64                            alldefconfig
sh                           se7722_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                             sh03_defconfig
sh                           se7750_defconfig
s390                             allmodconfig
xtensa                       common_defconfig
csky                                defconfig
sparc                            alldefconfig
sparc                               defconfig
um                                  defconfig
sh                            titan_defconfig
arm                            mps2_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
sh                     sh7710voipgw_defconfig
i386                             alldefconfig
powerpc                     ep8248e_defconfig
m68k                          hp300_defconfig
m68k                        m5272c3_defconfig
arm                          exynos_defconfig
ia64                          tiger_defconfig
arc                              alldefconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                          r7785rp_defconfig
arm                          iop32x_defconfig
powerpc                     mpc83xx_defconfig
xtensa                generic_kc705_defconfig
arm                        clps711x_defconfig
arc                           tb10x_defconfig
powerpc                       eiger_defconfig
sh                          r7780mp_defconfig
arm                            qcom_defconfig
riscv                randconfig-r042-20220908
arc                  randconfig-r043-20220908
s390                 randconfig-r044-20220908
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220907
hexagon              randconfig-r045-20220907
s390                 randconfig-r044-20220907
riscv                randconfig-r042-20220907
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a002
x86_64                        randconfig-a014
i386                          randconfig-a006
x86_64                        randconfig-a001
i386                          randconfig-a004
x86_64                        randconfig-a003
x86_64                        randconfig-a005
powerpc                     tqm8540_defconfig
arm                           spitz_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                           ip22_defconfig
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-k001
powerpc                     akebono_defconfig
mips                      malta_kvm_defconfig
arm                    vt8500_v6_v7_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
