Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442A3C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 22 Nov 2021 13:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbhKVNij (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Nov 2021 08:38:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:33990 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239532AbhKVNid (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Nov 2021 08:38:33 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="215496545"
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="215496545"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 05:35:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="739211854"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 22 Nov 2021 05:35:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BA1A7348; Mon, 22 Nov 2021 15:35:14 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH v2 3/3] serial: 8250_pericom: Use serial_dl_write() instead of open coded
Date:   Mon, 22 Nov 2021 15:35:12 +0200
Message-Id: <20211122133512.8947-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211122133512.8947-1-andriy.shevchenko@linux.intel.com>
References: <20211122133512.8947-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It's better to stick with standard API to write and read DL value
when the hardware is compatible with it. In case any quirks are
needed it may be easily added in one place rather than modifying
code here and there.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pericom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pericom.c b/drivers/tty/serial/8250/8250_pericom.c
index f0d026325f17..025b055363c3 100644
--- a/drivers/tty/serial/8250/8250_pericom.c
+++ b/drivers/tty/serial/8250/8250_pericom.c
@@ -70,11 +70,11 @@ static void pericom_do_set_divisor(struct uart_port *port, unsigned int baud,
 		/* Update delta due to possible divisor change */
 		delta = maxrate / divisor - baud;
 		if (abs(delta) < baud / 50) {
+			struct uart_8250_port *up = up_to_u8250p(port);
 			int lcr = serial_port_in(port, UART_LCR);
 
 			serial_port_out(port, UART_LCR, lcr | 0x80);
-			serial_port_out(port, UART_DLL, divisor & 0xff);
-			serial_port_out(port, UART_DLM, (divisor >> 8) & 0xff);
+			serial_dl_write(up, divisor);
 			serial_port_out(port, 2, 16 - scr);
 			serial_port_out(port, UART_LCR, lcr);
 			return;
-- 
2.33.0

