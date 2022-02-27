Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CA3C433EF
	for <linux-serial@archiver.kernel.org>; Sun, 27 Feb 2022 06:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiB0GTC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 27 Feb 2022 01:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiB0GTB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Feb 2022 01:19:01 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2A213D37
        for <linux-serial@vger.kernel.org>; Sat, 26 Feb 2022 22:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645942705; x=1677478705;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4sfhET7rmDSA35k4xkqA8n8vQEkpuhLa1sO9aJfY0L4=;
  b=ftCipqcBmmI6VuQphETQcnHZesbTgquXgH4/upACOsEj8nk0snA01s+V
   e+/0+Eqzqr2U0OZMXEFhRy+cznCZUJzOjmsIzp4KSfZzFR/hwbx6vR+eA
   wzEcd43YSJ2vCQttD08gAZOExANF207GQR9nK1wYoqnJsJZlbJQGZXeBx
   k9MVrRGzoyUR6AatWWzdnNb0XurCLHjWom0bfBx9gTmcD7nj20OpO3eDB
   giZRqGMKOM0+X4L/hLsM8WLyNWBmvth4a/fB25yiP5DDVwaboN/3I+wv9
   VVTH460DCEn7e7pssJTp4cHwBwdOYWe/UNmxKPzxEQMJdNou5irwwGEvg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="315923275"
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="315923275"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 22:18:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="640549305"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Feb 2022 22:18:23 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOCsx-0006Hp-1b; Sun, 27 Feb 2022 06:18:23 +0000
Date:   Sun, 27 Feb 2022 14:17:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hammer Hsieh <hammerh0314@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 36/42] drivers/tty/serial/sunplus-uart.c:574:12:
 error: use of undeclared identifier 'sunplus_uart_console'; did you mean
 'sunplus_uart_ops'?
Message-ID: <202202271439.QCMkeVQs-lkp@intel.com>
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
config: riscv-randconfig-r025-20220227 (https://download.01.org/0day-ci/archive/20220227/202202271439.QCMkeVQs-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?id=9e8d5470325f25bed7d33f9faaae6d5e4f313650
        git remote add tty https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
        git fetch --no-tags tty tty-testing
        git checkout 9e8d5470325f25bed7d33f9faaae6d5e4f313650
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/tty/serial/sunplus-uart.c:574:12: error: use of undeclared identifier 'sunplus_uart_console'; did you mean 'sunplus_uart_ops'?
           .cons           = &sunplus_uart_console,
                              ^~~~~~~~~~~~~~~~~~~~
                              sunplus_uart_ops
   drivers/tty/serial/sunplus-uart.c:479:30: note: 'sunplus_uart_ops' declared here
   static const struct uart_ops sunplus_uart_ops = {
                                ^
>> drivers/tty/serial/sunplus-uart.c:574:11: error: incompatible pointer types initializing 'struct console *' with an expression of type 'const struct uart_ops *' [-Werror,-Wincompatible-pointer-types]
           .cons           = &sunplus_uart_console,
                             ^~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


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
