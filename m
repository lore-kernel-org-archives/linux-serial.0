Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C939FC25B4E
	for <linux-serial@archiver.kernel.org>; Sun, 22 Jan 2023 19:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjAVTsm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 22 Jan 2023 14:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjAVTsl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 22 Jan 2023 14:48:41 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658AB1E1FE
        for <linux-serial@vger.kernel.org>; Sun, 22 Jan 2023 11:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674416920; x=1705952920;
  h=date:from:cc:subject:message-id:mime-version;
  bh=/QIcTYvaADcdUOM93vVg1N1vdEHTZkD0vM5bgA0IS9o=;
  b=iGLNjDIRChhfSnrIZYV1tE500SMwyF6tMwZu3p2jvAGOGKgJtlYksmej
   bTosHxglEbr1KpmqNFw3Wd3akKWE0X/PRMWUJk/ul9Xc35dXIzf8tknbG
   TGMRDpW+CtthXOvuQR+oTjeEr9QfdVnGtlhcv9NJ+NkEDv56NIZF9UI2h
   kxpV/Z+9FCgDuuir3StFWX1brfK5gmus8TlHKU8kmPucxu88hpvPrQgve
   +5Mf8PrcUIjQv71YBswWQtZiKTgtytVHTgI9vBdi7b25VOpXRwCsf9iB2
   V3y5IDcS+W2Ueq4537F9G3hRjyiL6gCutkbyc7yGWa8OydBKcBXu56bE6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="309507530"
X-IronPort-AV: E=Sophos;i="5.97,237,1669104000"; 
   d="scan'208";a="309507530"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 11:48:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="785368109"
X-IronPort-AV: E=Sophos;i="5.97,237,1669104000"; 
   d="scan'208";a="785368109"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Jan 2023 11:48:38 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJgKT-0005D0-0f;
        Sun, 22 Jan 2023 19:48:37 +0000
Date:   Mon, 23 Jan 2023 03:48:35 +0800
From:   kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 1/1] drivers/tty/serial/qcom_geni_serial.c:1058:12:
 error: no member named 'rx_fifo' in 'struct qcom_geni_serial_port'
Message-ID: <202301230337.8Ta23Xqp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   7a6aa989f2e844a22cfab5c8ff30e77d17dabb2f
commit: 7a6aa989f2e844a22cfab5c8ff30e77d17dabb2f [1/1] Merge 6.2-rc5 into tty-next
config: hexagon-randconfig-r041-20230122 (https://download.01.org/0day-ci/archive/20230123/202301230337.8Ta23Xqp-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?id=7a6aa989f2e844a22cfab5c8ff30e77d17dabb2f
        git remote add tty https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
        git fetch --no-tags tty tty-testing
        git checkout 7a6aa989f2e844a22cfab5c8ff30e77d17dabb2f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/tty/serial/qcom_geni_serial.c:9:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/tty/serial/qcom_geni_serial.c:9:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/tty/serial/qcom_geni_serial.c:9:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/tty/serial/qcom_geni_serial.c:1058:12: error: no member named 'rx_fifo' in 'struct qcom_geni_serial_port'
           if (port->rx_fifo && (old_rx_fifo_depth != port->rx_fifo_depth) && port->rx_fifo_depth) {
               ~~~~  ^
   drivers/tty/serial/qcom_geni_serial.c:1059:9: error: no member named 'rx_fifo' in 'struct qcom_geni_serial_port'
                   port->rx_fifo = devm_krealloc(uport->dev, port->rx_fifo,
                   ~~~~  ^
   drivers/tty/serial/qcom_geni_serial.c:1059:51: error: no member named 'rx_fifo' in 'struct qcom_geni_serial_port'
                   port->rx_fifo = devm_krealloc(uport->dev, port->rx_fifo,
                                                             ~~~~  ^
   drivers/tty/serial/qcom_geni_serial.c:1062:14: error: no member named 'rx_fifo' in 'struct qcom_geni_serial_port'
                   if (!port->rx_fifo)
                        ~~~~  ^
   6 warnings and 4 errors generated.


vim +1058 drivers/tty/serial/qcom_geni_serial.c

c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  1045  
b8caf69a6946e1 Krzysztof Kozlowski         2022-12-21  1046  static int setup_fifos(struct qcom_geni_serial_port *port)
c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  1047  {
c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  1048  	struct uart_port *uport;
b8caf69a6946e1 Krzysztof Kozlowski         2022-12-21  1049  	u32 old_rx_fifo_depth = port->rx_fifo_depth;
c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  1050  
c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  1051  	uport = &port->uport;
c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  1052  	port->tx_fifo_depth = geni_se_get_tx_fifo_depth(&port->se);
c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  1053  	port->tx_fifo_width = geni_se_get_tx_fifo_width(&port->se);
c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  1054  	port->rx_fifo_depth = geni_se_get_rx_fifo_depth(&port->se);
c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  1055  	uport->fifosize =
c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  1056  		(port->tx_fifo_depth * port->tx_fifo_width) / BITS_PER_BYTE;
b8caf69a6946e1 Krzysztof Kozlowski         2022-12-21  1057  
b8caf69a6946e1 Krzysztof Kozlowski         2022-12-21 @1058  	if (port->rx_fifo && (old_rx_fifo_depth != port->rx_fifo_depth) && port->rx_fifo_depth) {
b8caf69a6946e1 Krzysztof Kozlowski         2022-12-21  1059  		port->rx_fifo = devm_krealloc(uport->dev, port->rx_fifo,
b8caf69a6946e1 Krzysztof Kozlowski         2022-12-21  1060  					      port->rx_fifo_depth * sizeof(u32),
b8caf69a6946e1 Krzysztof Kozlowski         2022-12-21  1061  					      GFP_KERNEL);
b8caf69a6946e1 Krzysztof Kozlowski         2022-12-21  1062  		if (!port->rx_fifo)
b8caf69a6946e1 Krzysztof Kozlowski         2022-12-21  1063  			return -ENOMEM;
b8caf69a6946e1 Krzysztof Kozlowski         2022-12-21  1064  	}
b8caf69a6946e1 Krzysztof Kozlowski         2022-12-21  1065  
b8caf69a6946e1 Krzysztof Kozlowski         2022-12-21  1066  	return 0;
c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  1067  }
c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  1068  

:::::: The code at line 1058 was first introduced by commit
:::::: b8caf69a6946e18ffebad49847e258f5b6d52ac2 tty: serial: qcom-geni-serial: fix slab-out-of-bounds on RX FIFO buffer

:::::: TO: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
