Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF52C6FA82
	for <linux-serial@archiver.kernel.org>; Sat,  3 Sep 2022 08:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiICIfH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 3 Sep 2022 04:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiICIfG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 3 Sep 2022 04:35:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A3737FAF
        for <linux-serial@vger.kernel.org>; Sat,  3 Sep 2022 01:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662194104; x=1693730104;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jqSVC26FkuWGJtJJjP+bjRc5PsfF2LiVpt5UNKHLhEI=;
  b=S1HUKuc/TaGzCeLfVkVimxglVlaq1GFJ9jvj5gaEv8NpINtB1xR5hxD0
   CDiaopRm5h85qPQAf9NBy9+FQisnTzysQfbybi4Qhgiz1WHVn7TDbxG5u
   HQjdkwr/750j7IeKcShUKWvcRtPp1Ab965DnvZMOzgIYJZFjPrYE2Pga/
   tMD4gWn/wlso9Iyzi2F/hT50VWYl6s45d5bz/cASgiUgGIYlgWS1L+37+
   1QAQOy2qATQQm14Tuc4RsbAN/wdt+puCNrpGKfKNUd71F98LT4apCGc8I
   d1CilL6pYdsYcl3N2najiPZgjjd6lDpEYyEoVYgw3Rhs/tJ7PMzF8NCwB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="275886288"
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="275886288"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 01:35:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="564212126"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Sep 2022 01:35:02 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUOcH-0001In-2u;
        Sat, 03 Sep 2022 08:35:01 +0000
Date:   Sat, 03 Sep 2022 16:34:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-testing] BUILD SUCCESS
 e4cdd25cafac3f61c74c146db5de7a5c9bd7b6d0
Message-ID: <631311a7.dcxL6C0eIzmGKeX2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
branch HEAD: e4cdd25cafac3f61c74c146db5de7a5c9bd7b6d0  tty: mxser: remove redundant assignment to hwid

elapsed time: 2423m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                              defconfig
x86_64                        randconfig-a011
arc                  randconfig-r043-20220901
x86_64                               rhel-8.3
i386                          randconfig-a014
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                           allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                                defconfig
i386                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
x86_64                        randconfig-a012
i386                          randconfig-a015
riscv                randconfig-r042-20220901
i386                          randconfig-a011
hexagon              randconfig-r045-20220901
hexagon              randconfig-r041-20220901
x86_64                        randconfig-a014
s390                 randconfig-r044-20220901
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
