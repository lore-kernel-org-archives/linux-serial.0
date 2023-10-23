Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BC3C25B41
	for <linux-serial@archiver.kernel.org>; Mon, 23 Oct 2023 05:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjJWFsk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Oct 2023 01:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWFsj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Oct 2023 01:48:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B453FFC
        for <linux-serial@vger.kernel.org>; Sun, 22 Oct 2023 22:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698040117; x=1729576117;
  h=date:from:to:cc:subject:message-id;
  bh=PZIlM7vaJeYBpiJgdpXD7rgUKNt8RUinVV3VMXX++Sc=;
  b=PQId869HQn2O+6v3TUcJSiV4t8eBKb/nlKX9joNdfTnTOpxxUtT3Nlyt
   18FKUaO/hD6Kvf8jvperSsu9Itro8h0LdMuk88Ei7qTqrKKP8YQ0XR+BZ
   uRbqsHKrms8zKCJ3ed3VSIrtEo0RAr9suCMhJcDWV+bj87YL9rPegxwcl
   11hKTEBtLdhDf7a+km+r/9FQUah6i47NjDpHPQu7GINS/wXKZuLnP+kmi
   Tln4rZxKSC1fWqr4htHNZDXN5TSm3x414l2TWuD88bvnQ+HDhl69bti1+
   c20DEFpNhkYgthqRdf3La4FQMgOzFvwuNHuYHeK5NbrNcGc6AcPpSvNGT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="383971675"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="383971675"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 22:48:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="881642260"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="881642260"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Oct 2023 22:48:34 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qunnk-0006br-0v;
        Mon, 23 Oct 2023 05:48:32 +0000
Date:   Mon, 23 Oct 2023 13:47:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 936323f8de4139c9f6ebc0d08e20f1fe200b78a8
Message-ID: <202310231349.6ql02eDy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 936323f8de4139c9f6ebc0d08e20f1fe200b78a8  dt-bindings: serial: drop unsupported samsung bindings

elapsed time: 2181m

configs tested: 153
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231022   gcc  
arc                   randconfig-001-20231023   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231023   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231023   gcc  
i386         buildonly-randconfig-002-20231023   gcc  
i386         buildonly-randconfig-003-20231023   gcc  
i386         buildonly-randconfig-004-20231023   gcc  
i386         buildonly-randconfig-005-20231023   gcc  
i386         buildonly-randconfig-006-20231023   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231023   gcc  
i386                  randconfig-002-20231023   gcc  
i386                  randconfig-003-20231023   gcc  
i386                  randconfig-004-20231023   gcc  
i386                  randconfig-005-20231023   gcc  
i386                  randconfig-006-20231023   gcc  
i386                  randconfig-011-20231023   gcc  
i386                  randconfig-012-20231023   gcc  
i386                  randconfig-013-20231023   gcc  
i386                  randconfig-014-20231023   gcc  
i386                  randconfig-015-20231023   gcc  
i386                  randconfig-016-20231023   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231022   gcc  
loongarch             randconfig-001-20231023   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20231022   gcc  
riscv                 randconfig-001-20231023   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231022   gcc  
s390                  randconfig-001-20231023   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231023   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231022   gcc  
x86_64       buildonly-randconfig-001-20231023   gcc  
x86_64       buildonly-randconfig-002-20231022   gcc  
x86_64       buildonly-randconfig-002-20231023   gcc  
x86_64       buildonly-randconfig-003-20231022   gcc  
x86_64       buildonly-randconfig-003-20231023   gcc  
x86_64       buildonly-randconfig-004-20231022   gcc  
x86_64       buildonly-randconfig-004-20231023   gcc  
x86_64       buildonly-randconfig-005-20231022   gcc  
x86_64       buildonly-randconfig-005-20231023   gcc  
x86_64       buildonly-randconfig-006-20231022   gcc  
x86_64       buildonly-randconfig-006-20231023   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231023   gcc  
x86_64                randconfig-002-20231023   gcc  
x86_64                randconfig-003-20231023   gcc  
x86_64                randconfig-004-20231023   gcc  
x86_64                randconfig-005-20231023   gcc  
x86_64                randconfig-006-20231023   gcc  
x86_64                randconfig-011-20231023   gcc  
x86_64                randconfig-012-20231023   gcc  
x86_64                randconfig-013-20231023   gcc  
x86_64                randconfig-014-20231023   gcc  
x86_64                randconfig-015-20231023   gcc  
x86_64                randconfig-016-20231023   gcc  
x86_64                randconfig-071-20231023   gcc  
x86_64                randconfig-072-20231023   gcc  
x86_64                randconfig-073-20231023   gcc  
x86_64                randconfig-074-20231023   gcc  
x86_64                randconfig-075-20231023   gcc  
x86_64                randconfig-076-20231023   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
