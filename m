Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61DCC38142
	for <linux-serial@archiver.kernel.org>; Tue, 24 Jan 2023 06:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjAXGIq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Jan 2023 01:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjAXGIp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Jan 2023 01:08:45 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C3D2CC41
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 22:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674540524; x=1706076524;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4714TAaz3WLiC/6vHWaLuEvSs4Q9GZcuj24SoHHL1KQ=;
  b=Zr1+3omvY/2Dz2qxviCpv7LbVoxeBTiXHK7EuHDz0XNoB9DqAUrfE+yJ
   zG5xBiMBesnuDekOK09cGCeUHP8rWJ+17pPZZJzpM2HFr3CXyr0E8pLL2
   w1zZq686D7IHJdRP4CuA0WzXICGVg7U4L8U8CR00HzVmrEBSRX1tD8do/
   oOR8YdMVt0YfgwkZ7/zf//KZ/siVXHgXbN4EjAt8bh0V1BhpNLERjAoaq
   VZx1x6Y2JV/iWoBxMPY4bKyNB8kCIcfI5aevGLpf4Hr0G8ZNMKnQ6XtxI
   n4rZZ7BkLFQFvAF3/qYCpcQLr+uXO956PKQkb2icWdrCtUpDq/CiQ+GgY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="328322420"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="328322420"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 22:08:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="804464451"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="804464451"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jan 2023 22:08:42 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKCU5-0006Bp-2M;
        Tue, 24 Jan 2023 06:08:41 +0000
Date:   Tue, 24 Jan 2023 14:08:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 ed0400ad547c0b88d2f06ecf22a089eb2e84c9b7
Message-ID: <63cf75df.Lq957k9f6ldUsDKQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: ed0400ad547c0b88d2f06ecf22a089eb2e84c9b7  serial: liteuart: Correct error rollback

elapsed time: 723m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
sh                               allmodconfig
arc                              allyesconfig
x86_64                            allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
ia64                             allmodconfig
arc                  randconfig-r043-20230123
arm                  randconfig-r046-20230123
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
i386                 randconfig-a006-20230123
x86_64               randconfig-a006-20230123
i386                                defconfig
arm                                 defconfig
x86_64               randconfig-a002-20230123
x86_64                           rhel-8.3-syz
x86_64               randconfig-a004-20230123
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a003-20230123
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a001-20230123
x86_64                           rhel-8.3-bpf
x86_64               randconfig-a005-20230123
i386                 randconfig-a003-20230123
i386                 randconfig-a002-20230123
i386                 randconfig-a001-20230123
i386                 randconfig-a004-20230123
i386                 randconfig-a005-20230123
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
s390                 randconfig-r044-20230123
riscv                randconfig-r042-20230123
i386                 randconfig-a016-20230123
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a014-20230123
i386                 randconfig-a012-20230123
x86_64               randconfig-a016-20230123
i386                 randconfig-a013-20230123
x86_64               randconfig-a015-20230123
i386                 randconfig-a011-20230123
i386                 randconfig-a014-20230123
i386                 randconfig-a015-20230123
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
