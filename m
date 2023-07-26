Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F87BC0015E
	for <linux-serial@archiver.kernel.org>; Wed, 26 Jul 2023 07:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjGZHk7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Jul 2023 03:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjGZHka (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Jul 2023 03:40:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA524EDB
        for <linux-serial@vger.kernel.org>; Wed, 26 Jul 2023 00:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690357033; x=1721893033;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3cVodYChQNkec74pR43vdzgkn69r6PI0NlXyq0XjFw8=;
  b=G74nhDjVvI89ofybtTMmJD+iwHTDYPx7mH3TONhvUeF+JN4He8ERhuh8
   hbScE+kmSlldcRzzDZe0iQI2X+Dj1eUqs/2jvuDgivhEES1132FjfS7My
   BgwLfX1yKVhzTjFqfmhz/C2aB+OqYMwq48PMIP3w1bMqdw+J+5KoY/Hya
   NniFq+0CXBvzD3fXjH5rZ28MUhO942mfudsxF63H7MYzT4saYIuyHYfwC
   c3LDbhw7z1WiV+bKA42SchyC9Qu+UclwiPTNvIhs6HHRhzF7m1Jq8nOxY
   eKS2hge5//QKqUoOH70d3K6Ew2FhzjnsMR56uslieRXJ/CkJcEvHHudBg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="431744201"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="431744201"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 00:37:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="973005088"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="973005088"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jul 2023 00:37:04 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOZ4y-0000mS-0J;
        Wed, 26 Jul 2023 07:37:04 +0000
Date:   Wed, 26 Jul 2023 15:34:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9?= Javier 
        <JoseJavier.Rodriguez@duagon.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>,
        Javier Rodriguez <josejavier.rodriguez@duagon.com>
Subject: [tty:tty-testing 20/49]
 drivers/tty/serial/8250/8250_men_mcb.c:92:21: sparse: sparse: cast removes
 address space '__iomem' of expression
Message-ID: <202307261517.x1O9OAkd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   9b4e18f032db160a70d73d3cdf3a0bff229686b4
commit: 2554e6ba28a25f00cf1258d984a695e7ae391af2 [20/49] 8250_men_mcb: Read num ports from register data.
config: x86_64-randconfig-r093-20230725 (https://download.01.org/0day-ci/archive/20230726/202307261517.x1O9OAkd-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230726/202307261517.x1O9OAkd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307261517.x1O9OAkd-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/tty/serial/8250/8250_men_mcb.c:92:21: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/tty/serial/8250/8250_men_mcb.c:92:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/serial/8250/8250_men_mcb.c:92:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/serial/8250/8250_men_mcb.c:92:21: sparse:     got void *

vim +/__iomem +92 drivers/tty/serial/8250/8250_men_mcb.c

    83	
    84	static int read_uarts_available_from_register(void __iomem *membase,
    85						      u8 *uarts_available)
    86	{
    87		void __iomem *mem;
    88		int reg_value;
    89	
    90		mem = membase + MEN_Z025_REGISTER_OFFSET;
    91	
  > 92		reg_value = MEN_READ_REGISTER(membase);
    93	
    94		*uarts_available = reg_value >> 4;
    95	
    96		return 0;
    97	}
    98	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
