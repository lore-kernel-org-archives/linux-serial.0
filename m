Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90062C433F5
	for <linux-serial@archiver.kernel.org>; Fri,  7 Jan 2022 12:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiAGMm7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 7 Jan 2022 07:42:59 -0500
Received: from mga18.intel.com ([134.134.136.126]:42432 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbiAGMm6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 7 Jan 2022 07:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641559378; x=1673095378;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ri7bOFc1ix6Qp6S+KpH6bZBbTwi9/CWd7Tp4XqMDXHo=;
  b=bLU1g4e0AxLAMdNUbCnyFTJLIFFjWbY57R3G55AT6UIJNPpMAMBV7eil
   caiO6/aIHnk/8GFZiBvaf14+qbWzMB1TLdBmJM84tb9QEUGcqgR5xVPrW
   obOqp8rcPpktB7/DtnTn6Sjk14GB0SL/Q1FujK2FvKfmAsIteSj7BoimH
   SdGNQ/71GlQj+15xS/d9yx7NvvHIR108WAyM+CQPtdiwKNEwQmeTWQVbS
   mxY7sIsiSBidBaNNZ6qsqTK8fSEyWw5dbD7uzl4AgtVgILeIvUQyMYPPP
   uY+lq75ssOW3vUkB3inXrX36ZdrM7Jk2El4Yq0cFsiooQi9o0lGTC75/Q
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="229668899"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="229668899"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 04:42:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="473307417"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Jan 2022 04:42:57 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5oa8-000IgC-Fp; Fri, 07 Jan 2022 12:42:56 +0000
Date:   Fri, 07 Jan 2022 20:42:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 93a770b7e16772530196674ffc79bb13fa927dc6
Message-ID: <61d8354a.AINS0ImjOfOPOSt+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 93a770b7e16772530196674ffc79bb13fa927dc6  serial: core: Keep mctrl register state and cached copy in sync

elapsed time: 1252m

configs tested: 128
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
i386                 randconfig-c001-20220106
s390                       zfcpdump_defconfig
arm                     eseries_pxa_defconfig
powerpc                    adder875_defconfig
sh                        sh7785lcr_defconfig
powerpc                    klondike_defconfig
m68k                          atari_defconfig
m68k                          multi_defconfig
sh                        sh7763rdp_defconfig
sh                            shmin_defconfig
sh                           se7705_defconfig
powerpc                      tqm8xx_defconfig
sh                           se7206_defconfig
powerpc64                        alldefconfig
arc                          axs101_defconfig
powerpc                     taishan_defconfig
sh                        edosk7705_defconfig
sh                          r7780mp_defconfig
mips                      loongson3_defconfig
ia64                      gensparse_defconfig
openrisc                    or1ksim_defconfig
xtensa                  cadence_csp_defconfig
sh                         ap325rxa_defconfig
powerpc                      ep88xc_defconfig
m68k                        m5407c3_defconfig
mips                         cobalt_defconfig
sh                           se7721_defconfig
mips                            gpr_defconfig
arm                  randconfig-c002-20220106
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a012-20220106
x86_64               randconfig-a015-20220106
x86_64               randconfig-a014-20220106
x86_64               randconfig-a013-20220106
x86_64               randconfig-a011-20220106
x86_64               randconfig-a016-20220106
i386                 randconfig-a012-20220106
i386                 randconfig-a016-20220106
i386                 randconfig-a014-20220106
i386                 randconfig-a015-20220106
i386                 randconfig-a011-20220106
i386                 randconfig-a013-20220106
s390                 randconfig-r044-20220106
arc                  randconfig-r043-20220106
riscv                randconfig-r042-20220106
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
mips                 randconfig-c004-20220106
arm                  randconfig-c002-20220106
i386                 randconfig-c001-20220106
riscv                randconfig-c006-20220106
powerpc              randconfig-c003-20220106
x86_64               randconfig-c007-20220106
s390                 randconfig-c005-20220106
arm                  colibri_pxa300_defconfig
mips                       lemote2f_defconfig
mips                         tb0219_defconfig
powerpc                 xes_mpc85xx_defconfig
s390                             alldefconfig
mips                           ip28_defconfig
mips                      bmips_stb_defconfig
i386                 randconfig-a003-20220106
i386                 randconfig-a005-20220106
i386                 randconfig-a004-20220106
i386                 randconfig-a006-20220106
i386                 randconfig-a002-20220106
i386                 randconfig-a001-20220106
x86_64               randconfig-a012-20220107
x86_64               randconfig-a015-20220107
x86_64               randconfig-a014-20220107
x86_64               randconfig-a013-20220107
x86_64               randconfig-a011-20220107
x86_64               randconfig-a016-20220107
x86_64               randconfig-a005-20220106
x86_64               randconfig-a001-20220106
x86_64               randconfig-a004-20220106
x86_64               randconfig-a006-20220106
x86_64               randconfig-a002-20220106
x86_64               randconfig-a003-20220106

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
