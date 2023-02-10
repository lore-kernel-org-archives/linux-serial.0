Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC92C61DA4
	for <linux-serial@archiver.kernel.org>; Fri, 10 Feb 2023 02:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBJCHS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Feb 2023 21:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBJCHR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Feb 2023 21:07:17 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DEE6A730
        for <linux-serial@vger.kernel.org>; Thu,  9 Feb 2023 18:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675994836; x=1707530836;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yCLkDkybS6dnNM0PjdHdKpC7YEL4OYxKZdBFmKPp908=;
  b=i8TmDaSN1qxR0lrwH+ChLAqI5ie3ha6m0s3jYO+TWbrLXOio+yWrwzuN
   lM4Aho/gALPQroA7b/G4X83Jga80Z9OPOaXwljscIJ43ZbM9a9E8UeV3+
   VKItD0RQzO+LyO9E2JTiBRXOYZkO+DH6FEM+PZG2xtymUHWhVJ0/YJjqJ
   pxe61FiC02+cL7L37ws20H91RZq0g+jsMgqhDo/RSMXXRyNV+l89qIx2Z
   chojj1MQg8zBCP3WDyFUaFmNImMro16hBQjb6GXyRdCK6HIUJhwnZz/Ff
   /N3IiaSHSccdWCZ5E/l6OaoDOYze94a6mzkaq3nkuQjgfMMx1EfCFMGK1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="318328589"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="318328589"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 18:07:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="669829224"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="669829224"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Feb 2023 18:07:14 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQIok-0005Rz-0q;
        Fri, 10 Feb 2023 02:07:14 +0000
Date:   Fri, 10 Feb 2023 10:06:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 370f696e44745b321054496fa351dade03fc4bd9
Message-ID: <63e5a69f.OjfwvM2khhI7nLjc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 370f696e44745b321054496fa351dade03fc4bd9  dt-bindings: serial: snps-dw-apb-uart: add dma & dma-names properties

elapsed time: 721m

configs tested: 56
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
x86_64                              defconfig
i386                                defconfig
x86_64                           allyesconfig
i386                          randconfig-a001
x86_64                               rhel-8.3
arm                                 defconfig
i386                          randconfig-a003
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
i386                          randconfig-a005
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arm64                            allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a006
arc                  randconfig-r043-20230209
x86_64                        randconfig-a013
i386                             allyesconfig
x86_64                        randconfig-a011
arm                  randconfig-r046-20230209
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
sh                               allmodconfig
alpha                               defconfig
s390                                defconfig
mips                             allyesconfig
powerpc                          allmodconfig
s390                             allyesconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r045-20230209
hexagon              randconfig-r041-20230209
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
s390                 randconfig-r044-20230209
i386                          randconfig-a013
i386                          randconfig-a011
riscv                randconfig-r042-20230209
i386                          randconfig-a015
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
