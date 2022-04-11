Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7899C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 11 Apr 2022 08:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbiDKIgO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Apr 2022 04:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343863AbiDKIgF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Apr 2022 04:36:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C73A3E5FB
        for <linux-serial@vger.kernel.org>; Mon, 11 Apr 2022 01:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649666032; x=1681202032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5o3LEXeILoa4JLM7OW7RxK9qJcKIH2zr+YNp1daYRhM=;
  b=eOE6+O0X85DQCnEDGJ0pOkK7XSqZQlYCzDLK+AdTs9Zqy4vWbEH9kbHt
   019I9YcYaSf1A9UEjX8F40iMTOxMZEwZQUtjQNEwpI2c0VGlk55c5grH3
   XDjqXQrQbS1mrkufCmNb15lbzUijFu5Bm4jjrHa9vXeYA+AMt5FRtPzJl
   wqXAomxy3t+hLZYa6bKJ5ZujNzG3NoLFY7foNbSwsjE/IYSWXI8oM6kCS
   9lDw7gA8+kvWVBv0Qej9VPnDtrRXhJPJnKs8yqLk68tb/F+mq9WXy+hOl
   8AAHZWjChIB07tJB4BBEmjOj694bUHHLwrJtdPIPH8Lcax9Yvfqm/SDnX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="322511565"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="322511565"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:33:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="572028633"
Received: from azahoner-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:33:49 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Eric Tremblay <etremblay@distech-controls.com>
Subject: [PATCH v3 04/12] serial: 8250_dwlib: Implement SW half duplex support
Date:   Mon, 11 Apr 2022 11:33:13 +0300
Message-Id: <20220411083321.9131-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch enables support for SW half-duplex mode using em485.

Cc: Eric Tremblay <etremblay@distech-controls.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dwlib.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 08432e2fe511..04852af4c024 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -172,8 +172,14 @@ void dw8250_setup_port(struct uart_port *p)
 	u32 reg;
 
 	d->hw_rs485_support = dw8250_detect_rs485_hw(p);
-	if (d->hw_rs485_support)
+	if (d->hw_rs485_support) {
 		p->rs485_config = dw8250_rs485_config;
+	} else {
+		p->rs485_config = serial8250_em485_config;
+		up->rs485_start_tx = serial8250_em485_start_tx;
+		up->rs485_stop_tx = serial8250_em485_stop_tx;
+	}
+	up->capabilities |= UART_CAP_NOTEMT;
 
 	/*
 	 * If the Component Version Register returns zero, we know that
@@ -205,7 +211,7 @@ void dw8250_setup_port(struct uart_port *p)
 		p->type = PORT_16550A;
 		p->flags |= UPF_FIXED_TYPE;
 		p->fifosize = DW_UART_CPR_FIFO_SIZE(reg);
-		up->capabilities = UART_CAP_FIFO;
+		up->capabilities = UART_CAP_FIFO | UART_CAP_NOTEMT;
 	}
 
 	if (reg & DW_UART_CPR_AFCE_MODE)
-- 
2.30.2

