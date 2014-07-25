From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: serial: sc16is7xx
Date: Fri, 25 Jul 2014 15:20:47 +0300
Message-ID: <20140725122047.GB528@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:35713 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760134AbaGYMVL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Jul 2014 08:21:11 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: jringle@gridpoint.com
Cc: linux-serial@vger.kernel.org

Hello Jon Ringle,

The patch dfeae619d781: "serial: sc16is7xx" from Apr 24, 2014, leads
to the following static checker warning:

	drivers/tty/serial/sc16is7xx.c:1168 sc16is7xx_probe()
	warn: 's->clk' isn't an ERR_PTR

drivers/tty/serial/sc16is7xx.c
  1167  out_clk:
  1168          if (!IS_ERR(s->clk))
                     ^^^^^^^^^^^^^
This check isn't needed because we return directly but also I don't
think we ever set s->clk so it is leaked on the remove() path as well.

  1169                  clk_disable_unprepare(s->clk);
  1170  
  1171          return ret;
  1172  }

regards,
dan carpenter
