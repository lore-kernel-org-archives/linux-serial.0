Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C05C636D3
	for <linux-serial@archiver.kernel.org>; Mon,  6 Feb 2023 22:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBFWFU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Feb 2023 17:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjBFWFT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Feb 2023 17:05:19 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A4F2FCCB
        for <linux-serial@vger.kernel.org>; Mon,  6 Feb 2023 14:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675721118; x=1707257118;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pg39sCBxRLNH/vzDCwf12IalJ1swCnRdsO8o1Fr3q8o=;
  b=Duji6TNGNZORfydLTr1hc08D2l7fNQsLAgyeVn3y200uLQgWO7YtE4ix
   1z+RNj+4kPmGxx6Sp1gOL7jtlpS9O/ti9ZQaxCbdV2KZAretxtbe29bN6
   VhufhbABJMaaW4/Smc1nh2V29a8OexxuwB0kWRBhLIBvUkj3JZsJHHM+M
   MZJwjNgsoSkKNE/fwk8EtooGXZjRfWbuFC0ceAkq+yAguJ4rdT/4LgxVl
   w52mUFG39e1UGmjcLSi6YyzuO2Sj2kuIG9FwgVV+LZ4jPwM+pTqE23yD8
   Gu0YHJigwtv1mc/dZDvXm2GTwy7LPL7p9CwsLS5rn+XCXSYSeF0Kx/yFw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="331462250"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="331462250"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 14:05:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="644208046"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="644208046"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Feb 2023 14:05:16 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pP9bv-0002of-1O;
        Mon, 06 Feb 2023 22:05:15 +0000
Date:   Tue, 07 Feb 2023 06:04:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 f6b2ce79b5fbbb330f56262f0f4373d6af60b602
Message-ID: <63e17966.zq0Q168+CcSubEg1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: f6b2ce79b5fbbb330f56262f0f4373d6af60b602  Merge 6.2-rc7 into tty-next

elapsed time: 722m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
i386                 randconfig-a011-20230206
alpha                               defconfig
i386                 randconfig-a014-20230206
i386                 randconfig-a012-20230206
i386                 randconfig-a013-20230206
sh                               allmodconfig
i386                 randconfig-a016-20230206
s390                                defconfig
i386                 randconfig-a015-20230206
mips                             allyesconfig
powerpc                          allmodconfig
s390                             allyesconfig
x86_64                              defconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
m68k                             allyesconfig
x86_64                           rhel-8.3-bpf
m68k                             allmodconfig
i386                                defconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64               randconfig-a016-20230206
arc                  randconfig-r043-20230205
x86_64                    rhel-8.3-kselftests
arm                  randconfig-r046-20230205
arc                  randconfig-r043-20230206
arm                                 defconfig
i386                          randconfig-a001
riscv                randconfig-r042-20230206
i386                          randconfig-a003
x86_64                          rhel-8.3-func
i386                             allyesconfig
i386                          randconfig-a005
s390                 randconfig-r044-20230206
x86_64               randconfig-a012-20230206
x86_64               randconfig-a013-20230206
x86_64               randconfig-a011-20230206
x86_64               randconfig-a014-20230206
x86_64               randconfig-a015-20230206
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64               randconfig-a002-20230206
x86_64               randconfig-a004-20230206
x86_64               randconfig-a003-20230206
x86_64               randconfig-a001-20230206
x86_64               randconfig-a006-20230206
hexagon              randconfig-r041-20230205
x86_64               randconfig-a005-20230206
riscv                randconfig-r042-20230205
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230206
hexagon              randconfig-r045-20230205
hexagon              randconfig-r045-20230206
arm                  randconfig-r046-20230206
s390                 randconfig-r044-20230205
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a005-20230206
i386                 randconfig-a004-20230206
i386                 randconfig-a001-20230206
i386                 randconfig-a002-20230206
i386                 randconfig-a006-20230206
i386                 randconfig-a003-20230206

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
