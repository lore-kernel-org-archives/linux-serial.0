Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3908EC46467
	for <linux-serial@archiver.kernel.org>; Fri, 20 Jan 2023 05:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjATFDT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Jan 2023 00:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjATFDG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Jan 2023 00:03:06 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F22BD0DBA
        for <linux-serial@vger.kernel.org>; Thu, 19 Jan 2023 20:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674190231; x=1705726231;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XBPrToKy4m2DOzlnvfhFKnySJPpYetNXbadAdfNrD6A=;
  b=DXFTWiJh69WYDkIh7VNMUzSHieK6zG02tc9S/5irCSiWijUtOpB6Qn4U
   1ICPr69fUV/j1N4X4yE/QpcrQ/CdRhg/FHPST2LnTYtHKoOBHNcfiUm11
   XXr+d5Hm93zdO6ZYTSnKqlcwBNxwKHFz+WdPfMZz0kC45pi7zE7q48qCS
   Avx0sWQaMtwNn5heYjhjQVZnPOgdbsW7zi6zX2Xyo5L6vTUYemK6sd5Ye
   iUvWddOHrJocadotIzEzAjeBkE5IRPP03D7YhBQr8utVg0IxONXm9Vc/h
   W2kVaUXovJk1zvGadFYxJnmKtklE/Feej67t/jlTrz6Rc6dEQR9aW+3v+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="309077611"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="309077611"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 19:57:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="728988185"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="728988185"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jan 2023 19:57:38 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIiX4-00029f-0E;
        Fri, 20 Jan 2023 03:57:38 +0000
Date:   Fri, 20 Jan 2023 11:57:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 05e2600cb0a4d73b0779cf29512819616252aeeb
Message-ID: <63ca1111.EVUhSqgun+Q9g/Xk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 05e2600cb0a4d73b0779cf29512819616252aeeb  VT: Bump font size limitation to 64x128 pixels

elapsed time: 722m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                    rhel-8.3-kselftests
alpha                            allyesconfig
x86_64                          rhel-8.3-func
arc                              allyesconfig
powerpc                           allnoconfig
arm                                 defconfig
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a013
x86_64                        randconfig-a004
x86_64                        randconfig-a011
x86_64                        randconfig-a002
x86_64                               rhel-8.3
x86_64                        randconfig-a015
arm64                            allyesconfig
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
arm                              allyesconfig
i386                                defconfig
arc                                 defconfig
x86_64                           allyesconfig
arm                  randconfig-r046-20230119
arc                  randconfig-r043-20230119
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
ia64                             allmodconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                             allyesconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a016
i386                          randconfig-a002
x86_64                        randconfig-a005
i386                          randconfig-a004
hexagon              randconfig-r041-20230119
i386                          randconfig-a013
i386                          randconfig-a015
s390                 randconfig-r044-20230119
hexagon              randconfig-r045-20230119
i386                          randconfig-a006
riscv                randconfig-r042-20230119
i386                          randconfig-a011

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
