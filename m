Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113CBC54EE9
	for <linux-serial@archiver.kernel.org>; Sun, 25 Sep 2022 19:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiIYTwM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 25 Sep 2022 15:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiIYTwL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 25 Sep 2022 15:52:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EC526112
        for <linux-serial@vger.kernel.org>; Sun, 25 Sep 2022 12:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664135530; x=1695671530;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=38dVI5/QwhfmPNA4W0MdRmyz8vLZP+rhGnlnLWofO4w=;
  b=KlfslBJUnsq0BMQyuk58uqoXFR2NPFdG+mwQKzXz0SDUohGVbKeYKVgw
   sW2kaU+XvL2+NIg+IKOSjhtiDhc/mI2AEFjCHSx/HOkhW0IDKVJ6T/Mpp
   Mk6Ptbd8n/zHPCtw1sxnmvRo779GoqT+V7awP84TsAHMZloCmYgOhOU7F
   I4lSQd1XBPFW9hj1ZFr6UqX/waLXlHNKnHu4DlqAQXuBv3y1DdcSODggL
   7bVtPsP54CLTMehBU3ko2rMkWLt1fi8MytCeXxxtMbAXiG1Qmf1c3n6A5
   uH4Urj69nVm0jVDTI4MeJtdewdkQ9h4OnnpgcIs68cMBTQ/eMBSCKNgSt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="327230767"
X-IronPort-AV: E=Sophos;i="5.93,344,1654585200"; 
   d="scan'208";a="327230767"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2022 12:52:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,344,1654585200"; 
   d="scan'208";a="796096760"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Sep 2022 12:52:08 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ocXfc-0008KA-0Q;
        Sun, 25 Sep 2022 19:52:08 +0000
Date:   Mon, 26 Sep 2022 03:51:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 379a33786d489ab81885ff0b3935cfeb36137fea
Message-ID: <6330b14e.ycfDbAwcCRieXJw2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: 379a33786d489ab81885ff0b3935cfeb36137fea  serial: 8250: Fix restoring termios speed after suspend

elapsed time: 722m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
x86_64                               rhel-8.3
um                             i386_defconfig
i386                                defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
arc                  randconfig-r043-20220925
powerpc                           allnoconfig
x86_64                        randconfig-a013
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a011
arc                                 defconfig
x86_64                        randconfig-a015
x86_64                           rhel-8.3-syz
alpha                               defconfig
arc                              allyesconfig
arm                                 defconfig
alpha                            allyesconfig
s390                             allmodconfig
arm                              allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
s390                                defconfig
riscv                randconfig-r042-20220925
m68k                             allyesconfig
i386                             allyesconfig
m68k                             allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a004
s390                 randconfig-r044-20220925
i386                          randconfig-a001
arm64                            allyesconfig
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a014
s390                             allyesconfig
sh                               allmodconfig
x86_64                        randconfig-a006
mips                             allyesconfig
i386                          randconfig-a012
powerpc                          allmodconfig
i386                          randconfig-a016
ia64                             allmodconfig

clang tested configs:
x86_64                        randconfig-a014
hexagon              randconfig-r045-20220925
x86_64                        randconfig-a016
x86_64                        randconfig-a012
hexagon              randconfig-r041-20220925
i386                          randconfig-a002
x86_64                        randconfig-a005
i386                          randconfig-a013
x86_64                        randconfig-a001
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a004
x86_64                        randconfig-a003
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
