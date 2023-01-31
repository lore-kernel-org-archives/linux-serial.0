Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6F4C38142
	for <linux-serial@archiver.kernel.org>; Tue, 31 Jan 2023 22:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjAaWbc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 Jan 2023 17:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjAaWbb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 Jan 2023 17:31:31 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511D21CF73
        for <linux-serial@vger.kernel.org>; Tue, 31 Jan 2023 14:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675204290; x=1706740290;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=CAcnjdP/4fahmfFO6bBN1QOoNAj93igX0ZAfO7XQuLc=;
  b=BbefmO4ED9ilBjRA8NX5DlFYsstc1q3BCT7bLdX+8PJOZuHrwLqqVNEU
   DtL1IgHG1cAcuyLX0N32Omp4bFBBdPRvjFyoqTheX5ON/kIb720bO3HK9
   shXzj6w6YovW2RZqDUQNHlXKr2PKbCR5sO0AnltiTRCiTH3MrtpijIO3D
   pccqInYTdvRTnQMJXyyd2cCC31iv7uZdDf/7orWuyVjpcjqID1DYYBb3k
   rRfpKEIFNgFiQfXPZ9QM06nOHt26yIPitiSGYdcLH2ZKxzp0yIvSe/Zor
   A9WyLXNXLRK6/uSZiJT92uin59nle02wwlMCaWPxDfVJE01NyrttkUVGX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="325677421"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="325677421"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 14:31:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="664654741"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="664654741"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 31 Jan 2023 14:31:28 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMz9z-0004lE-2O;
        Tue, 31 Jan 2023 22:31:27 +0000
Date:   Wed, 01 Feb 2023 06:30:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 2070812595963f34205272fdb30674dc8c12b1b4
Message-ID: <63d99692.b4aYhzyNszcH5alj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 2070812595963f34205272fdb30674dc8c12b1b4  dt-bindings: serial: example cleanup

elapsed time: 726m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a001-20230130
x86_64               randconfig-a003-20230130
x86_64               randconfig-a004-20230130
x86_64               randconfig-a002-20230130
ia64                             allmodconfig
x86_64                           allyesconfig
x86_64               randconfig-a006-20230130
x86_64               randconfig-a005-20230130
x86_64                           rhel-8.3-syz
m68k                             allyesconfig
x86_64                         rhel-8.3-kunit
m68k                             allmodconfig
x86_64                           rhel-8.3-kvm
arc                              allyesconfig
x86_64                           rhel-8.3-bpf
alpha                            allyesconfig
i386                 randconfig-a002-20230130
i386                 randconfig-a001-20230130
i386                 randconfig-a004-20230130
i386                 randconfig-a003-20230130
i386                 randconfig-a006-20230130
i386                             allyesconfig
i386                 randconfig-a005-20230130
arc                  randconfig-r043-20230129
arm                  randconfig-r046-20230129
arm                  randconfig-r046-20230130
arc                  randconfig-r043-20230130
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230129
riscv                randconfig-r042-20230129
riscv                randconfig-r042-20230130
hexagon              randconfig-r045-20230130
hexagon              randconfig-r041-20230130
hexagon              randconfig-r045-20230129
s390                 randconfig-r044-20230129
s390                 randconfig-r044-20230130
x86_64               randconfig-a014-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a012-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130
i386                 randconfig-a013-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a014-20230130
i386                 randconfig-a011-20230130
i386                 randconfig-a015-20230130
i386                 randconfig-a016-20230130

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
