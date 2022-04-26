Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FBBC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 26 Apr 2022 12:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245376AbiDZMaQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 Apr 2022 08:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346208AbiDZMaO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Apr 2022 08:30:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6353167D06
        for <linux-serial@vger.kernel.org>; Tue, 26 Apr 2022 05:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650976027; x=1682512027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SC57HaLJluMMzHu7BqtA8pvAKc4U6/gEYKXnBFWAGXA=;
  b=DhJ1fWiSKUGTVLpjkEIU9gLgwFoFo67BkJaQG5RVJTScOXnX+reGVye0
   d+JKjxiSIu+Vas+lCp5uUCtqEEYaKD0iwD3VuEkDlvvu83gTVXopjg+qu
   NlmI8azYHxX2OSIiVcLxuNgvPnD5aL9UcCgOkHIDrU5cO9Zk3AkwOv3GW
   K+dwQr+M1wTYaGtXKcZjmOSLzFWaU3LTnWfmOR0k/SexuY5ees5VmUCK0
   8OLFRLRGTSbLnEs3z6GplCnqgj+PV8+ievbov9g0Ls/rL52G2QDooYpsP
   ooYeoMN2k1upTo6jJbY+12lCxEwm4bmxFblJhol1zjjcoYb3n7cX1K8e0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="265724712"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="265724712"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 05:27:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="579864843"
Received: from mmilkovx-mobl.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.47.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 05:27:03 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Vicente Bergas <vicencb@gmail.com>,
        Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Eric Tremblay <etremblay@distech-controls.com>
Subject: [PATCH v5 02/10] serial: 8250_dwlib: Implement SW half duplex support
Date:   Tue, 26 Apr 2022 15:24:40 +0300
Message-Id: <20220426122448.38997-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426122448.38997-1-ilpo.jarvinen@linux.intel.com>
References: <20220426122448.38997-1-ilpo.jarvinen@linux.intel.com>
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
index 05b73c8e75bc..fbabfdd8c7b8 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -157,8 +157,14 @@ void dw8250_setup_port(struct uart_port *p)
 	u32 reg;
 
 	pd->hw_rs485_support = dw8250_detect_rs485_hw(p);
-	if (pd->hw_rs485_support)
+	if (pd->hw_rs485_support) {
 		p->rs485_config = dw8250_rs485_config;
+	} else {
+		p->rs485_config = serial8250_em485_config;
+		up->rs485_start_tx = serial8250_em485_start_tx;
+		up->rs485_stop_tx = serial8250_em485_stop_tx;
+	}
+	up->capabilities |= UART_CAP_NOTEMT;
 
 	/*
 	 * If the Component Version Register returns zero, we know that
@@ -194,7 +200,7 @@ void dw8250_setup_port(struct uart_port *p)
 		p->type = PORT_16550A;
 		p->flags |= UPF_FIXED_TYPE;
 		p->fifosize = DW_UART_CPR_FIFO_SIZE(reg);
-		up->capabilities = UART_CAP_FIFO;
+		up->capabilities = UART_CAP_FIFO | UART_CAP_NOTEMT;
 	}
 
 	if (reg & DW_UART_CPR_AFCE_MODE)
-- 
2.30.2

