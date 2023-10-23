Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F189C25B46
	for <linux-serial@archiver.kernel.org>; Mon, 23 Oct 2023 20:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjJWUMi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Oct 2023 16:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjJWUMh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Oct 2023 16:12:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B74D7D
        for <linux-serial@vger.kernel.org>; Mon, 23 Oct 2023 13:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698091954; x=1729627954;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jLuHoN6gMVDaa5vbeBRP6Y6qiepJN/SKBJOYzIw8SvQ=;
  b=JsmTI1Y5ZfmaSQ3u4o9kOL1fQYh++1yT4LZp8uJ0nzkXrsc4K7Q3ijEN
   4+UpeGYN+ydV0sn/TlL/oHl8a/je41ufozDwq6jU+Fa0nfmkgptKInPYi
   +V1i/A9Ut3jq3Os7wMr3n9vbkdW1CNcZN95VKY1uF3Xpd418WC5Z7G6zT
   XZrjs8Cks6ebH2mCbgu3OmujXq6JXcErqmORdATuQSvnoNBh/mHoy58w/
   a3sbrohSSHfBoCY2AaOYnCCph07ao/TNnlfKatX2wPpQywTN7qhLdc/oq
   kMnwJbc0ZFl2XCwRsrTxUcuifOTTwzX0yLvc5taxLg69vB9yuO/2uwchS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="8475439"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="8475439"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 13:12:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="931802813"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="931802813"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Oct 2023 13:12:15 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qv1HY-0007FJ-02;
        Mon, 23 Oct 2023 20:12:12 +0000
Date:   Tue, 24 Oct 2023 04:12:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-next 17/49] arch/mips/sibyte/swarm/setup.c:146:9: error:
 implicit declaration of function 'vgacon_register_screen'
Message-ID: <202310240429.UqeQ2Cpr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   936323f8de4139c9f6ebc0d08e20f1fe200b78a8
commit: 555624c0d10bf09c62c45a86a47e752013f86fb5 [17/49] vgacon: clean up global screen_info instances
config: mips-randconfig-r004-20230118 (https://download.01.org/0day-ci/archive/20231024/202310240429.UqeQ2Cpr-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231024/202310240429.UqeQ2Cpr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310240429.UqeQ2Cpr-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/mips/sibyte/swarm/setup.c:58:5: warning: no previous prototype for 'swarm_be_handler' [-Wmissing-prototypes]
      58 | int swarm_be_handler(struct pt_regs *regs, int is_fixup)
         |     ^~~~~~~~~~~~~~~~
   arch/mips/sibyte/swarm/setup.c: In function 'plat_mem_setup':
>> arch/mips/sibyte/swarm/setup.c:146:9: error: implicit declaration of function 'vgacon_register_screen' [-Werror=implicit-function-declaration]
     146 |         vgacon_register_screen(&vgacon_screen_info);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/vgacon_register_screen +146 arch/mips/sibyte/swarm/setup.c

   137	
   138		mips_set_be_handler(swarm_be_handler);
   139	
   140		if (xicor_probe())
   141			swarm_rtc_type = RTC_XICOR;
   142		if (m41t81_probe())
   143			swarm_rtc_type = RTC_M41T81;
   144	
   145	#ifdef CONFIG_VGA_CONSOLE
 > 146		vgacon_register_screen(&vgacon_screen_info);
   147	       /* XXXKW for CFE, get lines/cols from environment */
   148	#endif
   149	}
   150	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
