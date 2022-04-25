Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331BEC433FE
	for <linux-serial@archiver.kernel.org>; Mon, 25 Apr 2022 14:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242469AbiDYOid (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Apr 2022 10:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242509AbiDYOi3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Apr 2022 10:38:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8222B13EA1
        for <linux-serial@vger.kernel.org>; Mon, 25 Apr 2022 07:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650897324; x=1682433324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rCZmX0Kn0w1o6CElhcTujjwriEzH777EOr4ruZUBkPU=;
  b=fJuq/+WVo49zRX2wt95/T/dBx2FUyB03arla/bnRXQGEsskhLg/RESwi
   dO2OMUNUZmz5WfP1Gqi7JBKPFvufUjS2WmPkXRtyJGSOiI6Pk8X0kqdsK
   qwXnpiFBPEow3Ff+HLMCgP4uIMk8XpJxyMIh7kLQOYVkALIqYVJJ6BEed
   Jjd11ckCN8J7qTrmFcih0GxCvVjswyAgU1JbmVO9HjT6vJnn2/iLEEUk8
   n0YHkOY8j8QFR+lHEF5hxxRDOvP4cQkP5mUmjgPzGASZzAqp6SU/r9Yrl
   goRx/fQqHFZ7RIjbst1JnYcA+zjc421KnVW8GPrHjmRaGyZatEi5MK+I3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="252632930"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="252632930"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:35:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="579315817"
Received: from lpuglia-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.217.93])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:35:09 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vicente Bergas <vicencb@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Eric Tremblay <etremblay@distech-controls.com>
Subject: [PATCH v4 05/13] serial: 8250_dwlib: Implement SW half duplex support
Date:   Mon, 25 Apr 2022 17:34:02 +0300
Message-Id: <20220425143410.12703-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com>
References: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch enables support for SW half-duplex mode using em485.

Cc: Eric Tremblay <etremblay@distech-controls.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Tested-by: Vicente Bergas <vicencb@gmail.com>
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

