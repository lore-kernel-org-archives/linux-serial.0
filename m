Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BFAC04A95
	for <linux-serial@archiver.kernel.org>; Sun, 25 Sep 2022 19:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiIYTwM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 25 Sep 2022 15:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiIYTwL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 25 Sep 2022 15:52:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA60226129
        for <linux-serial@vger.kernel.org>; Sun, 25 Sep 2022 12:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664135530; x=1695671530;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TpLdQaHxrkuzLw+La6R3b/vHMOeZoT+t5Y40/PA5q4c=;
  b=EjFjHmu5CEchRryoUjpjQTDUtcMfKH01J1iQMpE0Hvf6325IehjDdDGk
   s/523gphGKouLIrqlImUNjez9pZLWuHWrnyAt/sK2YnMIRgJpy5J3+4KI
   Gl72Qhu2YL8Eyjd3d0S4Y1KEDqzBcmCL2mHGWU4DAgB0lO5HHoq6iAF+8
   o4E9yjNJCa+PI7+S7pMvmhoP51YrIASk56tSwCAHuH0KgN1r2MejFIAK5
   o7D91qIKapKBVaIWZAiEt5wDxIeICacFzrDEDr3T4infGVsk5d/Qkmz2Y
   9nzO/BXX7MbTrmV9SZgMGERz21B8RFITt/SfrzRNeED+KRI1TZJsbA2ik
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="288024274"
X-IronPort-AV: E=Sophos;i="5.93,344,1654585200"; 
   d="scan'208";a="288024274"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2022 12:52:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,344,1654585200"; 
   d="scan'208";a="724796222"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 25 Sep 2022 12:52:08 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ocXfc-0008KC-0U;
        Sun, 25 Sep 2022 19:52:08 +0000
Date:   Mon, 26 Sep 2022 03:51:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-next] BUILD SUCCESS
 a12c689209185c1ad872723a644d0cd27e52d49c
Message-ID: <6330b150.PxIJSWspuS2jEys2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
branch HEAD: a12c689209185c1ad872723a644d0cd27e52d49c  Merge 7e2cd21e02b3 ("Merge tag 'tty-6.0-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty") into tty-next

elapsed time: 723m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
um                             i386_defconfig
um                           x86_64_defconfig
alpha                               defconfig
arc                  randconfig-r043-20220925
riscv                randconfig-r042-20220925
sh                               allmodconfig
x86_64                         rhel-8.3-kunit
mips                             allyesconfig
x86_64                           rhel-8.3-kvm
powerpc                          allmodconfig
x86_64                           rhel-8.3-syz
s390                 randconfig-r044-20220925
i386                          randconfig-a001
i386                          randconfig-a003
arm                                 defconfig
s390                             allmodconfig
i386                          randconfig-a014
i386                          randconfig-a005
s390                                defconfig
i386                          randconfig-a012
i386                                defconfig
alpha                            allyesconfig
i386                          randconfig-a016
i386                             allyesconfig
arm64                            allyesconfig
x86_64                        randconfig-a004
x86_64                              defconfig
x86_64                        randconfig-a013
x86_64                           allyesconfig
arc                              allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a011
s390                             allyesconfig
m68k                             allyesconfig
arm                              allyesconfig
m68k                             allmodconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a006
x86_64                        randconfig-a015
ia64                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220925
i386                          randconfig-a002
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a001
x86_64                        randconfig-a014
x86_64                        randconfig-a003
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
