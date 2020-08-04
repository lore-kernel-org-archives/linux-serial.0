Return-Path: <SRS0=ea2O=BO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EA4C433E0
	for <linux-serial@archiver.kernel.org>; Tue,  4 Aug 2020 20:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E5521744
	for <linux-serial@archiver.kernel.org>; Tue,  4 Aug 2020 20:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHDUaK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:30:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:21456 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgHDUaJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Aug 2020 16:30:09 -0400
IronPort-SDR: ekb4fk+iQ5iz3smjsWiy+g9Jiz0YCwojIdbtIOQ2g7dec86CqMmrUcwDTd+3cVlxFu3hzODlxB
 +ysOxqj/DyJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="132488908"
X-IronPort-AV: E=Sophos;i="5.75,435,1589266800"; 
   d="scan'208";a="132488908"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 13:30:07 -0700
IronPort-SDR: FmmiH3TgDo67aFdzvFbLdmy8LWyDGWA8JdJyInjytQdEjPsq691obOTNLd+H9cRPw4j8UM8ia7
 g7xrLqemgI0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,435,1589266800"; 
   d="scan'208";a="436936653"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 04 Aug 2020 13:30:07 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k33ZW-0000EO-Ep; Tue, 04 Aug 2020 20:30:06 +0000
Date:   Wed, 05 Aug 2020 04:29:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 f6c6eb2fe8223f8e64babcdaad2838ba6ede277d
Message-ID: <5f29c521.XW8/bJYF7gWdG36A%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git  tty-testing
branch HEAD: f6c6eb2fe8223f8e64babcdaad2838ba6ede277d  MAINTAINERS: enlist Greg formally for console stuff

elapsed time: 722m

configs tested: 90
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7206_defconfig
arm                           spitz_defconfig
arm                        neponset_defconfig
mips                malta_kvm_guest_defconfig
arm                            qcom_defconfig
m68k                        m5407c3_defconfig
mips                          rm200_defconfig
arm                           viper_defconfig
arm                       netwinder_defconfig
c6x                              alldefconfig
powerpc                           allnoconfig
arm                      tct_hammer_defconfig
sh                         microdev_defconfig
mips                    maltaup_xpa_defconfig
arm                          gemini_defconfig
powerpc                     pq2fads_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                     skiroot_defconfig
sh                         ecovec24_defconfig
sh                        sh7757lcr_defconfig
powerpc                      chrp32_defconfig
s390                          debug_defconfig
parisc                           alldefconfig
parisc                generic-32bit_defconfig
c6x                        evmc6472_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a005-20200804
i386                 randconfig-a004-20200804
i386                 randconfig-a001-20200804
i386                 randconfig-a003-20200804
i386                 randconfig-a002-20200804
i386                 randconfig-a006-20200804
x86_64               randconfig-a006-20200804
x86_64               randconfig-a001-20200804
x86_64               randconfig-a004-20200804
x86_64               randconfig-a005-20200804
x86_64               randconfig-a002-20200804
x86_64               randconfig-a003-20200804
i386                 randconfig-a011-20200804
i386                 randconfig-a012-20200804
i386                 randconfig-a013-20200804
i386                 randconfig-a014-20200804
i386                 randconfig-a015-20200804
i386                 randconfig-a016-20200804
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
