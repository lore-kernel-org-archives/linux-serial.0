Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7247CC433F5
	for <linux-serial@archiver.kernel.org>; Mon,  4 Apr 2022 08:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbiDDIb7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Apr 2022 04:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbiDDIbz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Apr 2022 04:31:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F46417074
        for <linux-serial@vger.kernel.org>; Mon,  4 Apr 2022 01:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649060999; x=1680596999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5o3LEXeILoa4JLM7OW7RxK9qJcKIH2zr+YNp1daYRhM=;
  b=WPvhYuIjYBKtERCygFmqJf1Sx4VFPQhqkMOk/l815qdASUxjG6yD4mdA
   +s5JRaSvy1dBGgqvYjnvvbFgGsKz9cmPY+Zv9NTZifCdhESm49ZQvEZt8
   JJLtJXU1ukwoAGEDj84/2ePei9/Wgnbdt+LeVPoCVmb6iaFMdfTlKfO1e
   llsD+Cl2THePbi1Udz3Kjhwbdzpc3gmNhpG9dFhW3/+6WbzQSaM1PmTPU
   3g0gY5toAShkxOPen3vfhQLD7C/IqBJCMqtdIHSS7/8tT/CBnWseOG2gT
   xcd36R97AforSNJDEbm8J8BglYaNTm7PDzt/4MZzoblqzkZh0LB6XS7t2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="346904508"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="346904508"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 01:29:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="569293383"
Received: from rhamza-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.211.126])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 01:29:55 -0700
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
Subject: [PATCH v2 04/12] serial: 8250_dwlib: Implement SW half duplex support
Date:   Mon,  4 Apr 2022 11:29:04 +0300
Message-Id: <20220404082912.6885-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404082912.6885-1-ilpo.jarvinen@linux.intel.com>
References: <20220404082912.6885-1-ilpo.jarvinen@linux.intel.com>
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

