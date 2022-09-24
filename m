Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CE6C32771
	for <linux-serial@archiver.kernel.org>; Sat, 24 Sep 2022 21:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiIXVpF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 24 Sep 2022 17:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiIXVpF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 24 Sep 2022 17:45:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A62525C56
        for <linux-serial@vger.kernel.org>; Sat, 24 Sep 2022 14:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664055904; x=1695591904;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PsRbqLZ5LTVgGqSqbTqAkkfcWm4MWGdN5fKqwnDa7jw=;
  b=KB1MHBTaFAu4iY7zrxsMmAKj/5YykBtahaPV0VNOwqfdqKlLW43WLUk/
   eKjXMLr9Sfy3H/R5+CD40PF3p/TPWABQbrm7LPqttn3oRk4+UFskWatho
   qI1MAukELdtBr3Ztt4uJuacmmX5dDtH9nKFVscjFKA/Tho1KBhYZa8nnj
   N1LQ2XdLmgp+DdKdLKEmJlRz821Hz5iEWjQr6m7qJvy5as1/t7TM9XPBD
   cbCZmzora0+YrV/5d5E9GlSPYVRgIVhEu8ArmuYCSGAmYLabarWe07Pjl
   dpVG60Ja5C1hslxOA0RNCJr1nBYSctlGuhBt5nVvAqG8OS+nnaX5HwTob
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10480"; a="298409585"
X-IronPort-AV: E=Sophos;i="5.93,343,1654585200"; 
   d="scan'208";a="298409585"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2022 14:45:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,343,1654585200"; 
   d="scan'208";a="949417908"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Sep 2022 14:45:02 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ocCxK-000724-0w;
        Sat, 24 Sep 2022 21:45:02 +0000
Date:   Sun, 25 Sep 2022 05:44:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 4c8928850c9dc5c849ee37d89a79d44a283bdd87
Message-ID: <632f7a3b.DeXuI/hkG2Gcl2af%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 4c8928850c9dc5c849ee37d89a79d44a283bdd87  MAINTAINERS: Solve warning regarding inexistent atmel-usart binding

elapsed time: 793m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                          rhel-8.3-func
i386                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                        randconfig-a002
s390                             allyesconfig
arc                                 defconfig
s390                             allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
alpha                               defconfig
x86_64                        randconfig-a004
s390                                defconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
i386                             allyesconfig
i386                          randconfig-a005
powerpc                          allmodconfig
sh                               allmodconfig
mips                             allyesconfig
s390                 randconfig-r044-20220923
arm                                 defconfig
i386                          randconfig-a016
m68k                             allmodconfig
x86_64                        randconfig-a015
arc                              allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a013
arm64                            allyesconfig
x86_64                        randconfig-a011
arc                  randconfig-r043-20220923
riscv                randconfig-r042-20220923
alpha                            allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
m68k                             allyesconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r045-20220923
i386                          randconfig-a015
x86_64                        randconfig-a016
x86_64                        randconfig-a012
hexagon              randconfig-r041-20220923
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
