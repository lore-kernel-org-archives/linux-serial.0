From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: tty: serial: Add 8250-core based omap driver
Date: Wed, 12 Nov 2014 11:48:07 +0300
Message-ID: <20141112084807.GB13955@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:18102 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbaKLIs1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 03:48:27 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: bigeasy@linutronix.de
Cc: linux-serial@vger.kernel.org

Hello Sebastian Andrzej Siewior,

The patch 61929cf0169d: "tty: serial: Add 8250-core based omap
driver" from Sep 29, 2014, leads to the following static checker
warning:

	drivers/tty/serial/8250/8250_omap.c:1025 omap8250_probe()
	warn: unsigned 'up.port.line' is never less than zero.

drivers/tty/serial/8250/8250_omap.c
  1015  
  1016          if (pdev->dev.of_node) {
  1017                  up.port.line = of_alias_get_id(pdev->dev.of_node, "serial");
  1018                  of_property_read_u32(pdev->dev.of_node, "clock-frequency",
  1019                                       &up.port.uartclk);
  1020                  priv->wakeirq = irq_of_parse_and_map(pdev->dev.of_node, 1);
  1021          } else {
  1022                  up.port.line = pdev->id;
  1023          }
  1024  
  1025          if (up.port.line < 0) {
                    ^^^^^^^^^^^^^^^^
Impossible.

  1026                  dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n",
  1027                          up.port.line);
  1028                  return -ENODEV;
                        ^^^^^^^^^^^^^^
It's better to preserve the error code normally.

  1029          }

regards,
dan carpenter
