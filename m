Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EF2C636CC
	for <linux-serial@archiver.kernel.org>; Thu,  9 Feb 2023 00:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBIA61 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Feb 2023 19:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBIA60 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Feb 2023 19:58:26 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1F4222FF
        for <linux-serial@vger.kernel.org>; Wed,  8 Feb 2023 16:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675904305; x=1707440305;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9P+lAjvfsykuA/mByVkrisFXimILp24qZcbEfBkAiiU=;
  b=QaX402ONzU9bZ8y5SdJgKxLlCW9IfzN+EDcuC3KGSiV3S1vpqZ4BGh8/
   ZhULZD6YltKx1yZuCAKwFz+EiJ6cPcTzfr97kY93At1LAvC3o059w5prx
   J1uQYbPx01mCzmMFU6wcyyHyYt2zTh3G6XZUT13j0My/00edGP7AYwpah
   o/2CWiFcFYkmvkX9ZbInLdp2TIjjg155vQ5DASaAPMDylLXa54SHyk19E
   5kQTBIKs90um5F+3rqXV45B7riiHl+Qc/gX7Fjd+VmOZMb439S27rPmJQ
   BG4356O7Q+cMbtDJQjnBFvNd8yPtF+zpWnCA/G1u4Y3EXqBwMWT1YZJIY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="357375948"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="357375948"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 16:58:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="645070633"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="645070633"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Feb 2023 16:58:24 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPvGU-0004j2-1d;
        Thu, 09 Feb 2023 00:58:18 +0000
Date:   Thu, 09 Feb 2023 08:58:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 684ae4f9513c2bb9443794608b7fc754c4ca2483
Message-ID: <63e44522.t0PyHXeqeeaLxdUU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 684ae4f9513c2bb9443794608b7fc754c4ca2483  tty: n_gsm: add TIOCMIWAIT support

elapsed time: 727m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
sh                               allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
mips                             allyesconfig
alpha                            allyesconfig
arm                                 defconfig
x86_64                              defconfig
i386                          randconfig-a014
powerpc                          allmodconfig
i386                                defconfig
i386                          randconfig-a012
x86_64                               rhel-8.3
i386                          randconfig-a016
m68k                             allyesconfig
x86_64               randconfig-a014-20230206
x86_64               randconfig-a013-20230206
x86_64               randconfig-a011-20230206
x86_64               randconfig-a012-20230206
x86_64               randconfig-a015-20230206
x86_64               randconfig-a016-20230206
x86_64                           allyesconfig
arm64                            allyesconfig
s390                 randconfig-r044-20230206
arm                              allyesconfig
arc                  randconfig-r043-20230205
arm                  randconfig-r046-20230205
arc                  randconfig-r043-20230206
i386                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
riscv                randconfig-r042-20230206
ia64                             allmodconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64               randconfig-a001-20230206
hexagon              randconfig-r041-20230205
riscv                randconfig-r042-20230205
x86_64               randconfig-a002-20230206
i386                 randconfig-a004-20230206
i386                 randconfig-a003-20230206
i386                 randconfig-a001-20230206
hexagon              randconfig-r045-20230206
x86_64               randconfig-a004-20230206
i386                 randconfig-a002-20230206
hexagon              randconfig-r041-20230206
x86_64               randconfig-a003-20230206
x86_64               randconfig-a005-20230206
x86_64               randconfig-a006-20230206
i386                 randconfig-a005-20230206
arm                  randconfig-r046-20230206
i386                 randconfig-a006-20230206
x86_64                          rhel-8.3-rust
s390                 randconfig-r044-20230205
hexagon              randconfig-r045-20230205

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
