From: Matthias Fuchs <mfuchs@ma-fu.de>
Subject: [PATCH] serial: Add 16850 uart type support to of uart driver
Date: Sun, 28 Dec 2008 18:47:35 +0100
Message-ID: <200812281847.35811.mfuchs@ma-fu.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:39900 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752774AbYL1Rrm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 28 Dec 2008 12:47:42 -0500
Received: from mail-in-20-z2.arcor-online.net (mail-in-20-z2.arcor-online.net [151.189.8.85])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 846F9302A21
	for <linux-serial@vger.kernel.org>; Sun, 28 Dec 2008 18:47:38 +0100 (CET)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-20-z2.arcor-online.net (Postfix) with ESMTP id 744A3107D8E
	for <linux-serial@vger.kernel.org>; Sun, 28 Dec 2008 18:47:37 +0100 (CET)
Received: from bunny.home (dslb-088-070-063-182.pools.arcor-ip.net [88.70.63.182])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id F2F732C29E3
	for <linux-serial@vger.kernel.org>; Sun, 28 Dec 2008 18:47:36 +0100 (CET)
Received: from fox.localnet (fox.home [192.168.2.13])
	by bunny.home (Postfix) with ESMTPS id 6EAE8251054B
	for <linux-serial@vger.kernel.org>; Sun, 28 Dec 2008 18:47:36 +0100 (CET)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

This patch adds support for "ns16850" as supported value
of the compatible node in flat device tree uart descriptions.

This is needed for example when you have a XR16C2850 uart
connected to a PPC405's external bus controller.

Signed-off-by: Matthias Fuchs <mfuchs@ma-fu.de>
---
 drivers/serial/of_serial.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
index 8fa0ff5..f71f94d 100644
--- a/drivers/serial/of_serial.c
+++ b/drivers/serial/of_serial.c
@@ -148,6 +148,7 @@ static struct of_device_id __devinitdata of_platform_serial_table[] = {
 	{ .type = "serial", .compatible = "ns16450",  .data = (void *)PORT_16450, },
 	{ .type = "serial", .compatible = "ns16550",  .data = (void *)PORT_16550, },
 	{ .type = "serial", .compatible = "ns16750",  .data = (void *)PORT_16750, },
+	{ .type = "serial", .compatible = "ns16850",  .data = (void *)PORT_16850, },
 	{ .type = "serial",			      .data = (void *)PORT_UNKNOWN, },
 	{ /* end of list */ },
 };
-- 
1.5.6.3


