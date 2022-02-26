Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC0EC433F5
	for <linux-serial@archiver.kernel.org>; Sat, 26 Feb 2022 19:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiBZTPo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 26 Feb 2022 14:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiBZTPn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 26 Feb 2022 14:15:43 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881C45044A
        for <linux-serial@vger.kernel.org>; Sat, 26 Feb 2022 11:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645902908; x=1677438908;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=44eMi8+wuHP6o5ArbFZhSNPujbtYw0zTgiL2INIbxOA=;
  b=fMqhMWu6kk8ydiTXQEQP23cTk9+dhO2zz0yAZ6nu5to/KWI3C/DXGLvc
   I5w1YX4IX6B/DrErpd1UM/b6F9QImTr2+f3LJHeOWi+bl7JJGgHR6PH+j
   NG8TMJoCmxqCxh/DCiCgudrerDZXObDI8fyMAMU/JuAVl54pyaXxDWueV
   W5ssYDE8B+KwiwpbEXGc+mYvEoFqfBsPHOrFebpVmz+xARe4o5udzQsPl
   OPKie4LZfXlAgsgOoZCaA5MAKY2U16v3nBYYNRSlElEUeZOOmSRGFHkAp
   vMd9QTQol7tXDEPq9K1RlJMV4tf+PV72ErxmmtFpclk6uLwobnbz2Igkz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="313396768"
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="313396768"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 11:15:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="640466973"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Feb 2022 11:15:06 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nO2X4-0005sY-6z; Sat, 26 Feb 2022 19:15:06 +0000
Date:   Sun, 27 Feb 2022 03:14:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yu Tu <yu.tu@amlogic.com>
Cc:     kbuild-all@lists.01.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 30/42] sh4-linux-ld: meson_uart.c:undefined
 reference to `devm_clk_hw_register_fixed_factor'
Message-ID: <202202262328.Ss3brmL4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   71404f653cf7858fdbb81dd5419a8a4ac4ffa20c
commit: 44023b8e1f14bc72bb773dd84dc3563fc912d210 [30/42] tty: serial: meson: Describes the calculation of the UART baud rate clock using a clock frame
config: sh-randconfig-r011-20220225 (https://download.01.org/0day-ci/archive/20220226/202202262328.Ss3brmL4-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?id=44023b8e1f14bc72bb773dd84dc3563fc912d210
        git remote add tty https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
        git fetch --no-tags tty tty-testing
        git checkout 44023b8e1f14bc72bb773dd84dc3563fc912d210
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sh4-linux-ld: drivers/tty/serial/meson_uart.o: in function `meson_uart_probe_clocks.constprop.0':
   meson_uart.c:(.text+0x744): undefined reference to `__clk_get_name'
>> sh4-linux-ld: meson_uart.c:(.text+0x748): undefined reference to `devm_clk_hw_register_fixed_factor'
>> sh4-linux-ld: meson_uart.c:(.text+0x754): undefined reference to `__devm_clk_hw_register_divider'
>> sh4-linux-ld: meson_uart.c:(.text+0x760): undefined reference to `__devm_clk_hw_register_mux'
>> sh4-linux-ld: meson_uart.c:(.text+0x764): undefined reference to `clk_hw_get_rate'
>> sh4-linux-ld: meson_uart.c:(.text+0x76c): undefined reference to `clk_hw_get_name'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
