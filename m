Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ED1CCA47E
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jun 2022 10:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiFFKFw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Jun 2022 06:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbiFFKFl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Jun 2022 06:05:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D4DE15F0;
        Mon,  6 Jun 2022 03:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509936; x=1686045936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WndMwTVfuW00rnE/S6LgTXND/zSnSa30GDTQqWRCwI8=;
  b=hHE2W06YlK+ItNQYMWYHY0U+xNz3LDnMX5WbYI8mjpL6eIhrjOEFyE7u
   2l/m4ACY9Adl9GoUgt2qspaxuQuvYYBvFtl4OpsfvDmqiksEnNjUKKTCf
   CxcAgiKJPpw2+gsA3NWqzIeIrgo4vNeSAhu8iS6nDaTGJNaLgkNqi1sSS
   hbKGm/ZhN+Ic6u0WbsS1mBkMMvw3I94AFzjmzFEfm4jg1k8C1TDxR8D/4
   TEEkoq+bOajzQ75hWF+ljINpwTrlbfgq8e/ukFIX7wDPBWZ4qePkDystN
   D6F9WyJDbwJCZqL8vAh3zY0SGMYaqLhu2uuB3CmG91V7rmFy+uHU2mG3e
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987054"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987054"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523712"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:31 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 14/36] serial: atmel: Fill in rs485_supported
Date:   Mon,  6 Jun 2022 13:04:11 +0300
Message-Id: <20220606100433.13793-15-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
References: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add information on supported serial_rs485 features.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/atmel_serial.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index dd1c7e4bd1c9..74dd1d3ac46f 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2473,6 +2473,12 @@ static const struct uart_ops atmel_pops = {
 #endif
 };
 
+static const struct serial_rs485 atmel_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX,
+	.delay_rts_before_send = 1,
+	.delay_rts_after_send = 1,
+};
+
 /*
  * Configure the port from the platform device resource info.
  */
@@ -2494,6 +2500,7 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 	port->mapbase		= mpdev->resource[0].start;
 	port->irq		= platform_get_irq(mpdev, 0);
 	port->rs485_config	= atmel_config_rs485;
+	port->rs485_supported	= &atmel_rs485_supported;
 	port->iso7816_config	= atmel_config_iso7816;
 	port->membase		= NULL;
 
-- 
2.30.2

