Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCD4C43334
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jun 2022 02:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbiF1COU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Jun 2022 22:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242833AbiF1COT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Jun 2022 22:14:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7721923159
        for <linux-serial@vger.kernel.org>; Mon, 27 Jun 2022 19:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656382458; x=1687918458;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hmvHHbCpjBVWFOyZz62ORfJqWab7d+RKxAY/YU+GKCM=;
  b=N6v9oA/cSBTaq1lswOfYdFiO0/RLd0Pyv/GtTnCdfmH60RrEOaimLNo0
   OW5Ssw4j23PQ+MJjrEsEyVG6DLnqf6z+5Lo61KCXUJ1XnP+j+pOLifofM
   hD3QGoXbeQnRMBfipiAeJPA/Gc3i+5JLQV3n62+iWZEF6XO2gDHYCD6DL
   84e/Jko+NETVpmy1ItVVW+6xw5Cc05JDFkPpbwo+/qpQRAPx7m6xVMwHL
   lR2g8hsHYIKlWOGJZXUONAx3zOfNG5VuK6Ef21xV23Z4//UjJ2Y8AXoVO
   Nz1gsOd5JuXgEZdlpbelB9rcwrT5CaqTuY87YsY6dpiD1bywr3wnNof87
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="282346597"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="282346597"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 19:14:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="540325016"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Jun 2022 19:14:17 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o60k4-0009O3-De;
        Tue, 28 Jun 2022 02:14:16 +0000
Date:   Tue, 28 Jun 2022 10:13:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Subject: [tty:tty-linus] BUILD SUCCESS
 ec5ad331680c96ef3dd30dc297b206988023b9e1
Message-ID: <62ba63d9.4kdT6eo75EHgqYyj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
branch HEAD: ec5ad331680c96ef3dd30dc297b206988023b9e1  tty: Add N_CAN327 line discipline ID for ELM327 based CAN driver

elapsed time: 727m

configs tested: 52
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
m68k                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64               randconfig-a012-20220627
x86_64               randconfig-a011-20220627
x86_64               randconfig-a013-20220627
x86_64               randconfig-a014-20220627
x86_64               randconfig-a015-20220627
x86_64               randconfig-a016-20220627
i386                 randconfig-a012-20220627
i386                 randconfig-a011-20220627
i386                 randconfig-a013-20220627
i386                 randconfig-a015-20220627
i386                 randconfig-a016-20220627
i386                 randconfig-a014-20220627
arc                  randconfig-r043-20220627
s390                 randconfig-r044-20220627
riscv                randconfig-r042-20220627
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
i386                 randconfig-a002-20220627
i386                 randconfig-a004-20220627
i386                 randconfig-a001-20220627
i386                 randconfig-a005-20220627
i386                 randconfig-a003-20220627
i386                 randconfig-a006-20220627
x86_64               randconfig-a002-20220627
x86_64               randconfig-a003-20220627
x86_64               randconfig-a001-20220627
x86_64               randconfig-a005-20220627
x86_64               randconfig-a006-20220627
x86_64               randconfig-a004-20220627
hexagon              randconfig-r041-20220627
hexagon              randconfig-r045-20220627

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
