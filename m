Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA0EC433EF
	for <linux-serial@archiver.kernel.org>; Sat, 26 Feb 2022 19:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbiBZTPo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 26 Feb 2022 14:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiBZTPm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 26 Feb 2022 14:15:42 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E5F5007E
        for <linux-serial@vger.kernel.org>; Sat, 26 Feb 2022 11:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645902908; x=1677438908;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YSje6jtuaaq57jhjEcOXySwLQjmc9dOSvsSfTi/qJLE=;
  b=cvW9Un9y3XXi3AnQVyu7KDwBcKC/WpzT5r9u8a1AtzO7xdjT69/ULFBi
   2vDkFhH/iGh92Xm/6GUoDpSZAzSN4rygbyzow2d623+ulDbhDJoYMUSlH
   R7+tcQ9jMTXJHSC0ASngQZ5jUZlhKSMtvG0F3Yf7vFFBDmNY5YLIq0K8/
   5vHsUiraTnbdynCUZ3HvVFeMFDsXNxMENK/KsiMqK0P1OflXpPeeTXaVl
   3CpIT/MNthxh7leiYGlgCA9igLWgnGx31bGPEgZ2NlvGMwM5eQxMUHXxz
   ic7R5uW955qZsb+1ii2wq5wZQxXHjjjeZRMPLaN3helZOatl5KHG2517z
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="339113959"
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="339113959"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 11:15:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="777705537"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 26 Feb 2022 11:15:06 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nO2X4-0005se-7w; Sat, 26 Feb 2022 19:15:06 +0000
Date:   Sun, 27 Feb 2022 03:14:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hammer Hsieh <hammerh0314@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 36/42] drivers/tty/serial/sunplus-uart.c:574:28:
 error: 'sunplus_uart_console' undeclared here (not in a function); did you
 mean 'sunplus_uart_ops'?
Message-ID: <202202270135.XFr12qec-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   71404f653cf7858fdbb81dd5419a8a4ac4ffa20c
commit: 9e8d5470325f25bed7d33f9faaae6d5e4f313650 [36/42] serial: sunplus-uart: Add Sunplus SoC UART Driver
config: parisc-buildonly-randconfig-r002-20220227 (https://download.01.org/0day-ci/archive/20220227/202202270135.XFr12qec-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?id=9e8d5470325f25bed7d33f9faaae6d5e4f313650
        git remote add tty https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
        git fetch --no-tags tty tty-testing
        git checkout 9e8d5470325f25bed7d33f9faaae6d5e4f313650
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc64 SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/tty/serial/sunplus-uart.c:574:28: error: 'sunplus_uart_console' undeclared here (not in a function); did you mean 'sunplus_uart_ops'?
     574 |         .cons           = &sunplus_uart_console,
         |                            ^~~~~~~~~~~~~~~~~~~~
         |                            sunplus_uart_ops


vim +574 drivers/tty/serial/sunplus-uart.c

   566	
   567	static struct uart_driver sunplus_uart_driver = {
   568		.owner		= THIS_MODULE,
   569		.driver_name	= "sunplus_uart",
   570		.dev_name	= "ttySUP",
   571		.major		= TTY_MAJOR,
   572		.minor		= 64,
   573		.nr		= SUP_UART_NR,
 > 574		.cons		= &sunplus_uart_console,
   575	};
   576	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
