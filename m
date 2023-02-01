Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6002CC38142
	for <linux-serial@archiver.kernel.org>; Wed,  1 Feb 2023 02:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBAC7m (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 Jan 2023 21:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBAC7l (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 Jan 2023 21:59:41 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102B317141
        for <linux-serial@vger.kernel.org>; Tue, 31 Jan 2023 18:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675220381; x=1706756381;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uMe/HKGuUipApW4b7wic0RDphsRXV5WNHB2HtinDg0k=;
  b=R1tAtghMDYf5rHM9QrQVg9GC0yCr2vfKKDUgDiP5R5gRsTI67UdfIi72
   sqMe22XUOaeca+4Mrtb6U4HZ1Qdp3VVTXuujhh8dMo4iyjVIhJBwtPqR3
   wXVzKU4ZRGWCFNlxj2Q5//yeB3dtfJyZKjTlWlMmYmrwdBy8PKDAgKYHU
   UKsJu4UjZF3CukFC5K79n5totjRCr6Ze20U6oODwA76CHgQKHAH6ggdHV
   lMfZ8E4b37SjAASFFVoUAz/joLlnudrY8R4DE7/AJv13JR537xWwRFsLe
   FPn5lsi4XKdQctNf8n6ZdwOZ5o7USiDEsmgODBNsTSGYQaTJ43T4aMS4S
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="315994040"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="315994040"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 18:59:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="666750396"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="666750396"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 31 Jan 2023 18:59:39 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pN3LW-0004xe-1h;
        Wed, 01 Feb 2023 02:59:38 +0000
Date:   Wed, 01 Feb 2023 10:58:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 226fae124b2dac217ea5436060d623ff3385bc34
Message-ID: <63d9d56f.wTc3DCRH/Tl8PLeZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 226fae124b2dac217ea5436060d623ff3385bc34  vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF

elapsed time: 721m

configs tested: 75
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
x86_64                            allnoconfig
s390                             allyesconfig
powerpc                           allnoconfig
um                             i386_defconfig
sh                               allmodconfig
um                           x86_64_defconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
mips                             allyesconfig
x86_64               randconfig-a001-20230130
x86_64                              defconfig
x86_64               randconfig-a003-20230130
arc                              allyesconfig
x86_64               randconfig-a004-20230130
x86_64               randconfig-a002-20230130
x86_64               randconfig-a006-20230130
i386                 randconfig-a001-20230130
x86_64               randconfig-a005-20230130
i386                 randconfig-a004-20230130
i386                 randconfig-a003-20230130
x86_64                               rhel-8.3
i386                 randconfig-a002-20230130
ia64                             allmodconfig
i386                 randconfig-a005-20230130
i386                 randconfig-a006-20230130
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
powerpc                          allmodconfig
i386                             allyesconfig
i386                                defconfig
i386                          randconfig-c001
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
arm                                 defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm64                            allyesconfig
arm                              allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64                        randconfig-k001
x86_64               randconfig-a014-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a012-20230130
i386                 randconfig-a014-20230130
i386                 randconfig-a013-20230130
i386                 randconfig-a015-20230130
i386                 randconfig-a016-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a011-20230130
hexagon              randconfig-r045-20230130
s390                 randconfig-r044-20230130
riscv                randconfig-r042-20230129
hexagon              randconfig-r041-20230129
hexagon              randconfig-r045-20230129
hexagon              randconfig-r041-20230130
riscv                randconfig-r042-20230130
s390                 randconfig-r044-20230129

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
