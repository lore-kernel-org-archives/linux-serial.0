Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873FEC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 21 Apr 2022 19:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385325AbiDUTV1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Apr 2022 15:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiDUTV0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Apr 2022 15:21:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BAE4B415
        for <linux-serial@vger.kernel.org>; Thu, 21 Apr 2022 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650568716; x=1682104716;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=X+8PplsrVapAiahgfSUoma/E/mylwWhvocand0r/DlM=;
  b=X49zZlnl9G3we/83fvwEDb2G0rnVGFE+LjRhic4svdujvHjmi8JHVb19
   KLY03PbvAzDduKEtQlBjFZfkVOG/cOyMPOX7qMFT3KWTDPNAUgja5S91R
   bk/VgWJkVCSagln2cFRa7g1eUS4ovqaL3N9uIDPhEoy5R2mcAPuu6GvY6
   uhw/Nu8lcHTP/a7/dX0cP5NLvfyZu1sraJboR4ziuiy8CalSTbvmy7wGr
   ApBMYqLcX/nRK9E5bYEY0IBNvvt8pQa0GNMIhFohEcg0xN9wWnJNtHDxX
   SRaxE+7cuknVzFy/ejxtm433Z8npdpiP/nxvH0aTWnio+CgRAcP9jJD7H
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263304074"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="263304074"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 12:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="671189494"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Apr 2022 12:18:34 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhcK2-0008hd-8T;
        Thu, 21 Apr 2022 19:18:34 +0000
Date:   Fri, 22 Apr 2022 03:17:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 05fe70dd2efd13de700c2dfe5169d3a7a5050bc2
Message-ID: <6261ade3.Onf7y43r0r5RmCd+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 05fe70dd2efd13de700c2dfe5169d3a7a5050bc2  MAINTAINERS: fix location of moxa-smartio.rst

elapsed time: 731m

configs tested: 121
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                   secureedge5410_defconfig
arm                             ezx_defconfig
sh                          r7780mp_defconfig
powerpc                      makalu_defconfig
arm                        mvebu_v7_defconfig
sparc                            allyesconfig
parisc64                            defconfig
arm                        cerfcube_defconfig
mips                           ip32_defconfig
sh                         ecovec24_defconfig
arm                        mini2440_defconfig
parisc                generic-32bit_defconfig
m68k                        mvme16x_defconfig
mips                         cobalt_defconfig
m68k                          amiga_defconfig
alpha                            alldefconfig
powerpc                 canyonlands_defconfig
arm                     eseries_pxa_defconfig
arm                           sunxi_defconfig
powerpc                    sam440ep_defconfig
powerpc                 mpc834x_mds_defconfig
sh                        edosk7705_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220421
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
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220420
arc                  randconfig-r043-20220421
s390                 randconfig-r044-20220421
riscv                randconfig-r042-20220421
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
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
riscv                randconfig-c006-20220421
mips                 randconfig-c004-20220421
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220421
powerpc              randconfig-c003-20220421
arm                       spear13xx_defconfig
mips                     cu1830-neo_defconfig
arm                          pxa168_defconfig
powerpc                 xes_mpc85xx_defconfig
s390                       zfcpdump_defconfig
arm                           omap1_defconfig
arm                          pxa910_defconfig
powerpc                    gamecube_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220420
hexagon              randconfig-r041-20220420
s390                 randconfig-r044-20220420
riscv                randconfig-r042-20220420

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
