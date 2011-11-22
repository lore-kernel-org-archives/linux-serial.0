From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 05/13] pch_uart: Change company name OKI SEMICONDUCTOR to LAPIS Semiconductor
Date: Mon, 21 Nov 2011 17:11:35 -0800
Message-ID: <1321924303-26475-5-git-send-email-gregkh@suse.de>
References: <20111122005917.GD25420@kroah.com>
 <1321924303-26475-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42074 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756555Ab1KVBNG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Nov 2011 20:13:06 -0500
In-Reply-To: <1321924303-26475-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com>

On October 1 in 2011,
OKI SEMICONDUCTOR Co., Ltd. changed the company name in to LAPIS Semiconductor Co., Ltd.

Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/pch_uart.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 2ef0e7d..ac852b5 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1,5 +1,5 @@
 /*
- *Copyright (C) 2010 OKI SEMICONDUCTOR CO., LTD.
+ *Copyright (C) 2011 LAPIS Semiconductor Co., Ltd.
  *
  *This program is free software; you can redistribute it and/or modify
  *it under the terms of the GNU General Public License as published by
@@ -46,8 +46,8 @@ enum {
 
 /* Set the max number of UART port
  * Intel EG20T PCH: 4 port
- * OKI SEMICONDUCTOR ML7213 IOH: 3 port
- * OKI SEMICONDUCTOR ML7223 IOH: 2 port
+ * LAPIS Semiconductor ML7213 IOH: 3 port
+ * LAPIS Semiconductor ML7223 IOH: 2 port
 */
 #define PCH_UART_NR	4
 
-- 
1.7.7.3

