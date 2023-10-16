Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713F3CDB465
	for <linux-serial@archiver.kernel.org>; Mon, 16 Oct 2023 20:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjJPUhs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Oct 2023 16:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjJPUhh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Oct 2023 16:37:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FA0118
        for <linux-serial@vger.kernel.org>; Mon, 16 Oct 2023 13:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697488652; x=1729024652;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yGj+3lkIBOqCDfaaSNvak/4MD8/I6Yz9eAb3CNubFhc=;
  b=R+bP8gFFmWUQ075WUpCcKzDRuNNVG6T+ItEEz/RdHRhkmQmnGWZfw0XR
   SRu81j9rtucAPP+WOxSUxIwzePfZY0Q9SIgNsMYeenTqXHNiT9n4BJXGP
   Hhshj4prPnltKolSM8qRksEXlGwZAhl2UvHRtOuH+uZGETJc1Ra4LwuZ+
   ALQ2jeTZjqKfy1I+9H3YnND5z9U/NlzDzyajlqa84uRUoqpfFN5RsugaP
   KcZH+VNqUUEjs3Q4je2YiIFUQDD96jq94jpnaNqK+1llHfiu10zZAEHh/
   otYLq2teTAlIML8Cxz8Y1zaC8FZPzgd0opv/V0Bdkc+BdjbBMxMRyj0pP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="388494854"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="388494854"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 13:37:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="759526155"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="759526155"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 16 Oct 2023 13:37:30 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsULA-0008f3-1U;
        Mon, 16 Oct 2023 20:37:28 +0000
Date:   Tue, 17 Oct 2023 04:37:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brenda Streiff <brenda.streiff@ni.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 12/24] drivers/tty/serial/8250/8250_ni.c:446:41:
 warning: 'nic7a69' defined but not used
Message-ID: <202310170418.GCOnw1n1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   d7b7027a2dcfb08e3e592c81978551f53c3beb4f
commit: 59dbecf92fa66c454ba8011231212e3ca51aae28 [12/24] serial: 8250: add driver for NI UARTs
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231017/202310170418.GCOnw1n1-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310170418.GCOnw1n1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310170418.GCOnw1n1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/8250/8250_ni.c:446:41: warning: 'nic7a69' defined but not used [-Wunused-const-variable=]
     446 | static const struct ni16550_device_info nic7a69 = {
         |                                         ^~~~~~~
>> drivers/tty/serial/8250/8250_ni.c:439:41: warning: 'nic792b' defined but not used [-Wunused-const-variable=]
     439 | static const struct ni16550_device_info nic792b = {
         |                                         ^~~~~~~
>> drivers/tty/serial/8250/8250_ni.c:433:41: warning: 'nic7772' defined but not used [-Wunused-const-variable=]
     433 | static const struct ni16550_device_info nic7772 = {
         |                                         ^~~~~~~
>> drivers/tty/serial/8250/8250_ni.c:428:41: warning: 'nic7750' defined but not used [-Wunused-const-variable=]
     428 | static const struct ni16550_device_info nic7750 = {
         |                                         ^~~~~~~


vim +/nic7a69 +446 drivers/tty/serial/8250/8250_ni.c

   426	
   427	/* NI 16550 RS-485 Interface */
 > 428	static const struct ni16550_device_info nic7750 = {
   429		.uartclk = 33333333,
   430	};
   431	
   432	/* NI CVS-145x RS-485 Interface */
 > 433	static const struct ni16550_device_info nic7772 = {
   434		.uartclk = 1843200,
   435		.flags = NI_HAS_PMR,
   436	};
   437	
   438	/* NI cRIO-904x RS-485 Interface */
 > 439	static const struct ni16550_device_info nic792b = {
   440		/* Sets UART clock rate to 22.222 MHz with 1.125 prescale */
   441		.uartclk = 22222222,
   442		.prescaler = 0x09,
   443	};
   444	
   445	/* NI sbRIO 96x8 RS-232/485 Interfaces */
 > 446	static const struct ni16550_device_info nic7a69 = {
   447		/* Set UART clock rate to 29.629 MHz with 1.125 prescale */
   448		.uartclk = 29629629,
   449		.prescaler = 0x09,
   450	};
   451	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
