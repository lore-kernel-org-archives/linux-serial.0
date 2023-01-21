Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664E0C05027
	for <linux-serial@archiver.kernel.org>; Sat, 21 Jan 2023 01:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjAUBEl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Jan 2023 20:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjAUBEk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Jan 2023 20:04:40 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DAB3B671
        for <linux-serial@vger.kernel.org>; Fri, 20 Jan 2023 17:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674263079; x=1705799079;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=iB2GxqYz8bqFpW/epZ+HPhiYf7IHZs16EOXXTI22dkQ=;
  b=I6K4yRepBimlAUthT56Bs3SEQPOqXNxp5WUOfr7QJsM6qcbND7r6r7Qi
   hy6R/WFjJ+g15pKPqKJPr2dmARB7vC+hguE6dQ6i8D+hEhDIIhFBEF8Tt
   ENRrmK9OcJauouGQRn1SoN//MmLdkBc+SA0Orfwqb2cCYYrnYJFuHoMru
   DAYZgS8zk23EZv62SggZ2LbOOSYBIc0nbJj2jOInLNYCSaNGH8yw+AdzL
   ezEuOrYSzFryRP1HWQEC6aYo19JEYMapjl/OoJsPQC4cX/T8ApzjQA5ae
   d4mp+UYNJZHcfDBeWi1mBCTIdqC0t9qXZ8r2KVeaxEDFRcdglsFcvTH3X
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="390250055"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="390250055"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 17:04:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="724149089"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="724149089"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jan 2023 17:04:37 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJ2JA-0003C2-1y;
        Sat, 21 Jan 2023 01:04:36 +0000
Date:   Sat, 21 Jan 2023 09:04:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 14ee78d5932afeb710c8305196a676a715bfdea8
Message-ID: <63cb3a12.ueAbhYuOqaYCIScw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: 14ee78d5932afeb710c8305196a676a715bfdea8  serial: exar: Add support for Sealevel 7xxxC serial cards

elapsed time: 727m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
arm                                 defconfig
i386                          randconfig-a001
arc                                 defconfig
i386                          randconfig-a003
s390                             allmodconfig
arm64                            allyesconfig
alpha                               defconfig
i386                          randconfig-a005
arm                              allyesconfig
s390                                defconfig
m68k                             allmodconfig
alpha                            allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arc                              allyesconfig
x86_64                    rhel-8.3-kselftests
m68k                             allyesconfig
x86_64                          rhel-8.3-func
s390                             allyesconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a004
arm                  randconfig-r046-20230119
x86_64                        randconfig-a002
arc                  randconfig-r043-20230119
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                               rhel-8.3
i386                          randconfig-a014
ia64                             allmodconfig
i386                             allyesconfig
x86_64                         rhel-8.3-kunit
i386                          randconfig-a012
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a006
i386                          randconfig-a016
x86_64                           rhel-8.3-bpf
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
hexagon              randconfig-r045-20230119
i386                          randconfig-a013
x86_64                        randconfig-a003
hexagon              randconfig-r041-20230119
riscv                randconfig-r042-20230119
i386                          randconfig-a011
s390                 randconfig-r044-20230119
i386                          randconfig-a015
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
