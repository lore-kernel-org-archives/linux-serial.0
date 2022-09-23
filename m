Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817EFC6FA82
	for <linux-serial@archiver.kernel.org>; Fri, 23 Sep 2022 16:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiIWQXF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Sep 2022 12:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiIWQXB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Sep 2022 12:23:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8C31A213
        for <linux-serial@vger.kernel.org>; Fri, 23 Sep 2022 09:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663950180; x=1695486180;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iZYX8NDE5KDq0ZvfjvTjTsJf4yUyQ17eF9cCBwZ8r8Y=;
  b=AOHnvZDvpvatMyhDcQv4JIKgktsPXWSB2JS1F0rq8dz3SCZ8wDSsnl6+
   tsGODW6ZKZshafCJmIXE/T4CIIFxJ+QfUVT15HEvAdjZ/R8keXb8jlOpb
   0EwD9aGGF73MbF0mkskdS60YkWpD4crFFH5IFniSn0wGIcIAqvk1QaiPC
   3nSeGywo12csfN5PDb6cFfCePtHvpVO7Rtdo8xNWe1WRa5R6knJTiD9zG
   nFc36KZpEyBx2ZrHcU1ehq7kFQdsSHr2Ae94GLAS6G+fJ33KTf14s4iW3
   Etvg27wCTzp8UjKQ6msTL419RN8bj6jmdVQcntcEoDMDRmiOoLnkAfhuF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="298226445"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="298226445"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 09:23:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="615661199"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 23 Sep 2022 09:22:59 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oblS6-0005oy-0q;
        Fri, 23 Sep 2022 16:22:58 +0000
Date:   Sat, 24 Sep 2022 00:22:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sergiu Moga <sergiu.moga@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-next 42/45] atmel_serial.c:undefined reference to
 `__clk_is_enabled'
Message-ID: <202209240013.GWFiVnCP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   adafbbf6895eb0ce41a313c6ee68870ab9aa93cd
commit: 5e3ce1f261296bfe4bb59a98c82f4959d214a4f7 [42/45] tty: serial: atmel: Make the driver aware of the existence of GCLK
config: m68k-randconfig-r003-20220922 (https://download.01.org/0day-ci/archive/20220924/202209240013.GWFiVnCP-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?id=5e3ce1f261296bfe4bb59a98c82f4959d214a4f7
        git remote add tty https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
        git fetch --no-tags tty tty-next
        git checkout 5e3ce1f261296bfe4bb59a98c82f4959d214a4f7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/tty/serial/atmel_serial.o: in function `atmel_set_termios':
>> atmel_serial.c:(.text+0xf88): undefined reference to `__clk_is_enabled'
   m68k-linux-ld: drivers/tty/serial/atmel_serial.o: in function `atmel_serial_pm':
   atmel_serial.c:(.text+0x14fc): undefined reference to `__clk_is_enabled'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
