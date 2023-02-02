Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C51AC636D3
	for <linux-serial@archiver.kernel.org>; Thu,  2 Feb 2023 01:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjBBBmG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Feb 2023 20:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBBBmF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Feb 2023 20:42:05 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0447750D
        for <linux-serial@vger.kernel.org>; Wed,  1 Feb 2023 17:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675302125; x=1706838125;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FHXQTZMnpTe4aIc9nMRJQdTfL7W8w0H4uIK8yc+XX6A=;
  b=BHahd3lhC41anfC5JppNo2jk0Qyq3RfqQPyNjQv/IEOPN9y4pASyrXLZ
   VUOpqb4H63xhHQGql2D1rNymYRGt3CjOe1698aPJB24X8LPjDZdXvjXGy
   jCRIiebGqTU/vvksdCaDHYqefLLxlSzsHll6Bz4hvWf46AZnhC06TCydy
   xPNnBJKTS7J/NyHck2Fd3GrIP2mv+SHtabWjT4r00Wg0iLK6ZU8n+HN4Q
   nQB4eOt0ZWP7rsRR878gw76na4E7dVaPea+SfOJmPpHoiCXmedma5A6sU
   LPC3oBLWb7jXxiD9N9q74eq7VYVjCdTWQK43ww+jB/vIypUMzD7GWI5A2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="329615006"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="329615006"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 17:42:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="733771789"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="733771789"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 01 Feb 2023 17:42:02 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNObx-00060G-1R;
        Thu, 02 Feb 2023 01:42:01 +0000
Date:   Thu, 02 Feb 2023 09:41:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 2115a84d3688faef106abd19581a5a3b77845824
Message-ID: <63db14ce.vsfDdoOo6HUFBHbB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 2115a84d3688faef106abd19581a5a3b77845824  dt-bindings: serial: example cleanup

elapsed time: 1222m

configs tested: 79
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
alpha                            allyesconfig
arc                                 defconfig
m68k                             allyesconfig
arc                              allyesconfig
s390                             allmodconfig
m68k                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
ia64                             allmodconfig
i386                 randconfig-a002-20230130
i386                 randconfig-a001-20230130
i386                 randconfig-a005-20230130
i386                 randconfig-a004-20230130
i386                 randconfig-a003-20230130
i386                 randconfig-a006-20230130
um                             i386_defconfig
um                           x86_64_defconfig
x86_64               randconfig-a006-20230130
x86_64               randconfig-a005-20230130
x86_64               randconfig-a003-20230130
x86_64               randconfig-a002-20230130
x86_64               randconfig-a001-20230130
x86_64               randconfig-a004-20230130
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
arm                                 defconfig
i386                          randconfig-c001
arc                          axs101_defconfig
m68k                       m5475evb_defconfig
arm                              allyesconfig
powerpc                        warp_defconfig
sh                            shmin_defconfig
sh                            titan_defconfig
mips                  decstation_64_defconfig
arm                         cm_x300_defconfig
m68k                           virt_defconfig
arm64                            allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a016-20230130
x86_64               randconfig-a014-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a012-20230130
x86_64               randconfig-a015-20230130
i386                 randconfig-a014-20230130
i386                 randconfig-a013-20230130
i386                 randconfig-a015-20230130
i386                 randconfig-a016-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a011-20230130
arm                  colibri_pxa300_defconfig
mips                      pic32mzda_defconfig
hexagon              randconfig-r045-20230130
s390                 randconfig-r044-20230130
riscv                randconfig-r042-20230129
hexagon              randconfig-r041-20230129
hexagon              randconfig-r045-20230129
hexagon              randconfig-r041-20230130
riscv                randconfig-r042-20230130
s390                 randconfig-r044-20230129
x86_64                        randconfig-k001
powerpc                     akebono_defconfig
i386                             allyesconfig
arm                          pcm027_defconfig
powerpc                       ebony_defconfig

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
