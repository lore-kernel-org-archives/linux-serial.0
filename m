Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB4FCDB465
	for <linux-serial@archiver.kernel.org>; Tue, 17 Oct 2023 01:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjJQBp1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Oct 2023 21:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJQBp0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Oct 2023 21:45:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74880A7
        for <linux-serial@vger.kernel.org>; Mon, 16 Oct 2023 18:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697507123; x=1729043123;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0jxNKfbv8MpYZRNot52B9H7iEKiEbiW9SKVQXI9Q8b4=;
  b=Qqw3sD9jLmm71a1/syyHZ6DRNNCyR+dm4EUb6f3sIYX9tonE5WyqBGzX
   pF5PXdugFAsCn81vrlOE/Lj+aVyxxO7UZpuL0Fu3genzqq9QtJSptKdF/
   JgNLgZuqOZMwghIavvguSNQPwod4NN2vukqKLra8mGMlwbKbHyjzbQjeB
   K+WYe5VIlR9nNfOPfEemwHRVuSm4W6zC0kQ6Xs0YzJ6e+cbdDz4MbNu8B
   3GRpPo84CS24rEjpdlkHyJGHx9wKVcXUxxrBjS5Q0R5F5qL29X+wL11hn
   R7+190sln9JNlvty9K8vPXMzUticWfgkv6gePdxsRVTneCerzETCV8rH2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="388539515"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="388539515"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 18:45:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="749484642"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="749484642"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Oct 2023 18:45:20 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsZ94-0008pD-19;
        Tue, 17 Oct 2023 01:45:18 +0000
Date:   Tue, 17 Oct 2023 09:44:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [tty:tty-testing 22/24] earlycon.c:undefined reference to
 `screen_info'
Message-ID: <202310170938.xHIu2lFB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   6271f1e8c4cb9a46273ae01ff9cb86a022063f75
commit: 934d62223da320b3ec012c85b63a6c250f507096 [22/24] efi: move screen_info into efi init code
config: loongarch-randconfig-002-20231017 (https://download.01.org/0day-ci/archive/20231017/202310170938.xHIu2lFB-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310170938.xHIu2lFB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310170938.xHIu2lFB-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: arch/loongarch/kernel/efi.o: in function `efi_init':
   efi.c:(.init.text+0x158): undefined reference to `screen_info'
   loongarch64-linux-ld: efi.c:(.init.text+0x15c): undefined reference to `screen_info'
   loongarch64-linux-ld: drivers/firmware/efi/earlycon.o: in function `.L24':
>> earlycon.c:(.text+0x80): undefined reference to `screen_info'
>> loongarch64-linux-ld: earlycon.c:(.text+0x84): undefined reference to `screen_info'
   loongarch64-linux-ld: drivers/firmware/efi/earlycon.o: in function `efi_earlycon_write':
   earlycon.c:(.text+0x18c): undefined reference to `screen_info'
   loongarch64-linux-ld: drivers/firmware/efi/earlycon.o:earlycon.c:(.text+0x190): more undefined references to `screen_info' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
