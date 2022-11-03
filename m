Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097C7C433FE
	for <linux-serial@archiver.kernel.org>; Thu,  3 Nov 2022 15:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiKCPOi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Nov 2022 11:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiKCPOg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Nov 2022 11:14:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7B510CC
        for <linux-serial@vger.kernel.org>; Thu,  3 Nov 2022 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667488475; x=1699024475;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1c9NaBb1WZGjhtOI1YGlj30jdSiQEGI2VgLiNzqx6Ak=;
  b=BVzNMUi+rEv/o4jmjAB2SydYXBK6hLkktdBiFtdeARNb4KsOZ4GY6oUI
   yn2B9lMMGJnfRmnyjIUx+Lk35a8y7VBKDis5c8FZJt9tyqe3as23g0o9/
   4c4TYncrtOOuo6iKq93mNhPZ1opEg+reuSUbkyOdkw+heoi6flm3jlEZ6
   JNhPfvTzozEetJ/SVdiY2SLcTGrBjpWiWWi+S3oM5pvkM2DHKAJOpgWL8
   13WhSljoIh5w6B/tavon/NBagTYVoEHQZH+epzQr93DEFfPK7pCb+pVUn
   rQXwZH77HmV1zOC7FdIHo2bBdViCiQvZr79V613YQl+bzW3N2Lv383Gyk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="307329352"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="307329352"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 08:14:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="585829292"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="585829292"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Nov 2022 08:14:18 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqbv7-000G2D-14;
        Thu, 03 Nov 2022 15:14:17 +0000
Date:   Thu, 03 Nov 2022 23:13:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 15730dc45dc7432713c7af9ee5abad76872f6405
Message-ID: <6363dab7.7Yp4VMH3riKjpcBl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 15730dc45dc7432713c7af9ee5abad76872f6405  tty: Cleanup tty buffer align mask

elapsed time: 721m

configs tested: 81
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
arc                                 defconfig
alpha                               defconfig
i386                                defconfig
s390                                defconfig
s390                             allmodconfig
ia64                             allmodconfig
arc                              allyesconfig
x86_64                        randconfig-a013
alpha                            allyesconfig
s390                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a011
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                               rhel-8.3
s390                 randconfig-r044-20221102
m68k                             allyesconfig
arc                  randconfig-r043-20221102
x86_64                              defconfig
i386                          randconfig-a014
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a015
riscv                randconfig-r042-20221102
arm                                 defconfig
i386                          randconfig-a001
i386                          randconfig-a012
m68k                             allmodconfig
i386                          randconfig-a016
x86_64                           allyesconfig
x86_64                        randconfig-a006
i386                          randconfig-a003
x86_64                         rhel-8.3-kunit
i386                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
i386                          randconfig-a005
sh                               allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
arm                        multi_v7_defconfig
arm                         s3c6400_defconfig
sh                        apsh4ad0a_defconfig
arm                           tegra_defconfig
sh                          rsk7203_defconfig
m68k                         apollo_defconfig
mips                     decstation_defconfig
sparc                       sparc32_defconfig
m68k                          multi_defconfig
m68k                       m5208evb_defconfig
powerpc                         wii_defconfig
um                                  defconfig
m68k                       m5275evb_defconfig
i386                          randconfig-c001
parisc64                            defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig

clang tested configs:
hexagon              randconfig-r041-20221102
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a014
i386                          randconfig-a015
x86_64                        randconfig-a003
hexagon              randconfig-r045-20221102
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
arm                      tct_hammer_defconfig
arm                         mv78xx0_defconfig
mips                     loongson1c_defconfig
mips                           mtx1_defconfig
powerpc               mpc834x_itxgp_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
