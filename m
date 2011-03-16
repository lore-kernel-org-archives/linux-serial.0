From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 20/76] serial: ifx6x60: fixed call to tty_port_init
Date: Wed, 16 Mar 2011 14:11:50 -0700
Message-ID: <1300309966-5745-20-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:33047 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754784Ab1CPVNe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:13:34 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Russ Gorby <russ.gorby@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Russ Gorby <russ.gorby@intel.com>

The port ops must be set AFTER calling port init as that function
zeroes the structure

Signed-off-by: Russ Gorby <russ.gorby@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/ifx6x60.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index c42de71..972c04d 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -798,8 +798,8 @@ static int ifx_spi_create_port(struct ifx_spi_device *ifx_dev)
 		goto error_ret;
 	}
 
-	pport->ops = &ifx_tty_port_ops;
 	tty_port_init(pport);
+	pport->ops = &ifx_tty_port_ops;
 	ifx_dev->minor = IFX_SPI_TTY_ID;
 	ifx_dev->tty_dev = tty_register_device(tty_drv, ifx_dev->minor,
 					       &ifx_dev->spi_dev->dev);
-- 
1.7.4.1

