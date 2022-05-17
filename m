Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752ADC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 17 May 2022 17:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiEQR7z (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 May 2022 13:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351685AbiEQR7y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 May 2022 13:59:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDC350075
        for <linux-serial@vger.kernel.org>; Tue, 17 May 2022 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652810393; x=1684346393;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2LzDF9SfsP+L8cTn2Z23YUhxgAMrv1apwxukZzFXSIc=;
  b=I0+y+tF2xz+V47K8Oah6iOgx1ATaY6JJbyJPc/hwiiBPvPmYrIiJRgHO
   +VpInymZiuzJWRwxy7SZfoRShkojBtSsiT0coVrAPM3xI+Nw9G5xU6oWW
   hwTd9CVOekDsNs8me+R13s88KxLvon5+2vLcDCJORlbSzPuhjx79zgcxF
   N6t7FVfWWyWiskHGdHMSgktDJdTg2bzxHpJvkFmUp7YPhhSY6YXw2KIQe
   2Z3woqhglg5ZVujxvaD4jSCtMpYTxqNyqC0J6bgxVNgTcC4ucPBAMptwV
   6mwYU48gEiRRSXS7cHrP5TIqvNnauxg/Hn+HyN+MwixUrq0U27Bo/A9eB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="271218864"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="271218864"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 10:59:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="741894790"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 May 2022 10:59:51 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nr1U7-0001Ea-5g;
        Tue, 17 May 2022 17:59:51 +0000
Date:   Wed, 18 May 2022 01:59:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 d6da35e0c6d50f76eaf11a0496d3d2ec1a1fea3f
Message-ID: <6283e269.h7qoDzD+Z2ajzNc/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: d6da35e0c6d50f76eaf11a0496d3d2ec1a1fea3f  Merge 5.18-rc7 into usb-next

elapsed time: 1687m

configs tested: 128
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220516
powerpc                     asp8347_defconfig
sh                            shmin_defconfig
sh                ecovec24-romimage_defconfig
sh                            titan_defconfig
powerpc                     redwood_defconfig
arm                      integrator_defconfig
mips                            gpr_defconfig
ia64                          tiger_defconfig
openrisc                 simple_smp_defconfig
arc                          axs101_defconfig
mips                         cobalt_defconfig
sh                          urquell_defconfig
powerpc64                        alldefconfig
sh                               j2_defconfig
s390                          debug_defconfig
xtensa                    smp_lx200_defconfig
powerpc                     rainier_defconfig
arm                             ezx_defconfig
arm                        oxnas_v6_defconfig
m68k                       m5208evb_defconfig
arm                          simpad_defconfig
xtensa                          iss_defconfig
arm                        mvebu_v7_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                        shmobile_defconfig
sh                        sh7757lcr_defconfig
sh                           se7722_defconfig
sh                        dreamcast_defconfig
mips                       bmips_be_defconfig
sh                            hp6xx_defconfig
m68k                          sun3x_defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                                defconfig
sparc                               defconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                             allyesconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a016-20220516
x86_64               randconfig-a012-20220516
x86_64               randconfig-a011-20220516
x86_64               randconfig-a014-20220516
x86_64               randconfig-a013-20220516
x86_64               randconfig-a015-20220516
i386                 randconfig-a016-20220516
i386                 randconfig-a013-20220516
i386                 randconfig-a015-20220516
i386                 randconfig-a012-20220516
i386                 randconfig-a014-20220516
i386                 randconfig-a011-20220516
s390                 randconfig-r044-20220516
riscv                randconfig-r042-20220516
arc                  randconfig-r043-20220516
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
arm                  colibri_pxa270_defconfig
arm                       cns3420vb_defconfig
arm                         orion5x_defconfig
arm                       versatile_defconfig
arm                       mainstone_defconfig
arm                  colibri_pxa300_defconfig
powerpc                    mvme5100_defconfig
arm                     davinci_all_defconfig
arm                         mv78xx0_defconfig
arm                   milbeaut_m10v_defconfig
mips                            e55_defconfig
arm                           omap1_defconfig
x86_64               randconfig-a005-20220516
x86_64               randconfig-a006-20220516
i386                 randconfig-a002-20220516
i386                 randconfig-a003-20220516
i386                 randconfig-a001-20220516
i386                 randconfig-a005-20220516
i386                 randconfig-a004-20220516
i386                 randconfig-a006-20220516
x86_64               randconfig-a002-20220516
x86_64               randconfig-a001-20220516
x86_64               randconfig-a003-20220516
x86_64               randconfig-a004-20220516
hexagon              randconfig-r045-20220516
hexagon              randconfig-r041-20220516

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
