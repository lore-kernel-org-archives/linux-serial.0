From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: omap-serial: Add minimal device tree support
Date: Wed, 6 Nov 2013 14:59:44 +0300
Message-ID: <20131106115944.GA12410@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:43577 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756221Ab3KFL7y (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Nov 2013 06:59:54 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rnayak@ti.com
Cc: linux-serial@vger.kernel.org

Hello Rajendra Nayak,

The patch d92b0dfc5078: "omap-serial: Add minimal device tree support"
from Dec 14, 2011, leads to the following Smatch warning:
	"drivers/tty/serial/omap-serial.c:1700 serial_omap_probe()
	 warn: unsigned 'up->port.line' is never less than zero."

drivers/tty/serial/omap-serial.c
  1695          if (pdev->dev.of_node)
  1696                  up->port.line = of_alias_get_id(pdev->dev.of_node, "serial");
  1697          else
  1698                  up->port.line = pdev->id;
  1699  
  1700          if (up->port.line < 0) {
                    ^^^^^^^^^^^^^^^^^
This condition is never true because "up->port.line" is unsigned.

  1701                  dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n",
  1702                                                                  up->port.line);
  1703                  ret = -ENODEV;
  1704                  goto err_port_line;
  1705          }

regards,
dan carpenter

